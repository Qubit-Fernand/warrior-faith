"""Small graph-preserving AMF3 SOL codec for this game's local saves.
Unsupported AMF types fail closed; cyclic object/array references are preserved.
"""
from dataclasses import dataclass, field
from enum import Enum
import struct

class Special(Enum):
    UNDEFINED=0

@dataclass(eq=False)
class Date:
    milliseconds: float

@dataclass(eq=False)
class Obj:
    name: str = ''
    sealed: tuple = ()
    dynamic: bool = True
    fields: dict = field(default_factory=dict)
    def __getitem__(self,k): return self.fields[k]
    def __setitem__(self,k,v): self.fields[k]=v

@dataclass(eq=False)
class Arr:
    dense: list = field(default_factory=list)
    assoc: dict = field(default_factory=dict)
    def __getitem__(self,k): return self.dense[k]
    def __setitem__(self,k,v): self.dense[k]=v

class Reader:
    def __init__(self,b): self.b=b; self.p=0; self.strings=[]; self.objects=[]; self.traits=[]
    def take(self,n):
        if self.p+n>len(self.b): raise ValueError('Unexpected EOF')
        v=self.b[self.p:self.p+n];self.p+=n;return v
    def byte(self): return self.take(1)[0]
    def u29(self):
        v=0
        for i in range(4):
            b=self.byte()
            if i==3:return (v<<8)|b
            v=(v<<7)|(b&127)
            if b<128:return v
    def string(self):
        h=self.u29()
        if not h&1:return self.strings[h>>1]
        s=self.take(h>>1).decode('utf-8')
        if s:self.strings.append(s)
        return s
    def value(self):
        t=self.byte()
        if t==0:return Special.UNDEFINED
        if t==1:return None
        if t==2:return False
        if t==3:return True
        if t==4:
            x=self.u29();return x-0x20000000 if x&0x10000000 else x
        if t==5:return struct.unpack('>d',self.take(8))[0]
        if t==6:return self.string()
        if t not in (8,9,10):raise ValueError(f'Unsupported AMF3 type {t} at {self.p-1}')
        h=self.u29()
        if not h&1:return self.objects[h>>1]
        if t==8:
            d=Date(struct.unpack('>d',self.take(8))[0]);self.objects.append(d);return d
        if t==9:
            a=Arr();self.objects.append(a)
            while (k:=self.string()):a.assoc[k]=self.value()
            a.dense=[self.value() for _ in range(h>>1)]
            return a
        if not h&2:trait=self.traits[h>>2]
        else:
            if h&4:raise ValueError('Externalizable class unsupported')
            name=self.string();keys=tuple(self.string() for _ in range(h>>4))
            trait=(name,keys,bool(h&8));self.traits.append(trait)
        o=Obj(*trait);self.objects.append(o)
        for k in o.sealed:o[k]=self.value()
        if o.dynamic:
            while (k:=self.string()):o[k]=self.value()
        return o

class Writer:
    def __init__(self):self.b=bytearray();self.strings={};self.objects={};self.traits={}
    def u29(self,n):
        if not 0<=n<0x20000000:raise ValueError(n)
        if n<0x80:self.b.append(n)
        elif n<0x4000:self.b.extend([(n>>7)|128,n&127])
        elif n<0x200000:self.b.extend([(n>>14)|128,((n>>7)&127)|128,n&127])
        else:self.b.extend([(n>>22)|128,((n>>15)&127)|128,((n>>8)&127)|128,n&255])
    def string(self,s):
        if s and s in self.strings:self.u29(self.strings[s]<<1);return
        b=s.encode();self.u29(len(b)*2+1);self.b.extend(b)
        if s:self.strings[s]=len(self.strings)
    def value(self,v):
        if v is Special.UNDEFINED:self.b.append(0)
        elif v is None:self.b.append(1)
        elif isinstance(v,bool):self.b.append(3 if v else 2)
        elif isinstance(v,int) and -0x10000000<=v<0x10000000:self.b.append(4);self.u29(v&0x1fffffff)
        elif isinstance(v,(int,float)):self.b.append(5);self.b.extend(struct.pack('>d',v))
        elif isinstance(v,str):self.b.append(6);self.string(v)
        elif isinstance(v,(Arr,Obj,Date)):
            self.b.append(8 if isinstance(v,Date) else 9 if isinstance(v,Arr) else 10)
            if id(v) in self.objects:self.u29(self.objects[id(v)]<<1);return
            self.objects[id(v)]=len(self.objects)
            if isinstance(v,Date):self.u29(1);self.b.extend(struct.pack('>d',v.milliseconds))
            elif isinstance(v,Arr):
                self.u29(len(v.dense)*2+1)
                for k,x in v.assoc.items():self.string(k);self.value(x)
                self.string('')
                for x in v.dense:self.value(x)
            else:
                trait=(v.name,v.sealed,v.dynamic)
                if trait in self.traits:self.u29((self.traits[trait]<<2)|1)
                else:
                    self.traits[trait]=len(self.traits);self.u29((len(v.sealed)<<4)|(8 if v.dynamic else 0)|3)
                    self.string(v.name)
                    for k in v.sealed:self.string(k)
                for k in v.sealed:self.value(v[k])
                if v.dynamic:
                    for k,x in v.fields.items():
                        if k not in v.sealed:self.string(k);self.value(x)
                    self.string('')
        else:raise TypeError(type(v))

def loads(b):
    r=Reader(b)
    assert r.take(2)==b'\x00\xbf'
    assert int.from_bytes(r.take(4),'big')==len(b)-6
    assert r.take(10)==b'TCSO\x00\x04\x00\x00\x00\x00'
    name=r.take(int.from_bytes(r.take(2),'big')).decode()
    assert r.take(4)==b'\0\0\0\3'
    fields={}
    while r.p<len(b):
        key=r.string();fields[key]=r.value();assert r.byte()==0
    return name,fields

def dumps(name,fields):
    w=Writer();n=name.encode()
    for k,v in fields.items():w.string(k);w.value(v);w.b.append(0)
    body=b'TCSO\x00\x04\x00\x00\x00\x00'+struct.pack('>H',len(n))+n+b'\0\0\0\3'+w.b
    return b'\x00\xbf'+struct.pack('>I',len(body))+body

def graph(v,seen=None):
    if seen is None:seen={}
    if isinstance(v,(Obj,Arr,Date)):
        if id(v) in seen:return {'$ref':seen[id(v)]}
        i=len(seen);seen[id(v)]=i
        if isinstance(v,Date):return {'$id':i,'date':v.milliseconds}
        if isinstance(v,Arr):return {'$id':i,'array':[graph(x,seen) for x in v.dense],'assoc':{k:graph(x,seen) for k,x in v.assoc.items()}}
        return {'$id':i,'class':v.name,'sealed':list(v.sealed),'dynamic':v.dynamic,'fields':{k:graph(x,seen) for k,x in v.fields.items()}}
    if v is Special.UNDEFINED:return {'$undefined':True}
    if isinstance(v,dict):return {k:graph(x,seen) for k,x in v.items()}
    return v
