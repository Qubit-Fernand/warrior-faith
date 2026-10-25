#!/usr/bin/env python3
"""Preserve original resource root metadata/timeline without original bytecode.

Original resources have no document class. Remove compc's synthetic root binding
so the VM creates the native MovieClip root, then copy root controls with explicit
character-ID remapping. Unlinked Shape2 artwork is copied with bitmap dependencies.
"""
import hashlib,re,struct
from pathlib import Path
from swf_inventory import read_swf,walk_tags,Reader,CHARACTER_TAGS
from probe_normalize_swf import encode
from probe_source_repairs import packtag
ROOT_CONTROLS={1,4,5,15,18,19,26,28,43,45,61,70,89,94}
ROOT_METADATA={9,65,69,77,86}

def parts(path):
 raw,b,h=read_swf(path)
 return raw,b,h,[(t['code'],x) for t,x in walk_tags(b,h['tag_start']) if t['parent']=='root']
def bindings(ts,code=76):
 result={}
 for c,x in ts:
  if c==code:
   r=Reader(x)
   for _ in range(r.u16()):cid=r.u16();name=r.cstr();result[name]=cid
 return result

def prepare_buttons(original,staging):
 raw,body,header,ts=parts(original);syms=bindings(ts);recovered=[];defs={struct.unpack_from('<H',x)[0]:(c,x) for c,x in ts if c in CHARACTER_TAGS};changes=[]
 assets=staging/'_assets/assets.swf'
 asset_symbols=bindings(parts(assets)[3],56) if assets.exists() else {}
 for name,cid in syms.items():
  if cid and defs[cid][0]==34:
   p=staging/Path(*name.split('.')).with_suffix('.as');assert p.exists(),name
   text=p.read_text()
   if '[Embed(' in text:continue
   symbol='symbol'+str(cid);asset_file='assets.swf'
   if asset_symbols.get(symbol)!=cid:
    payload=defs[cid][1]
    assert len(payload)==6 and payload[3:]==bytes(3),('missing nonempty button asset',name,cid)
    recovered.append((cid,symbol,payload));asset_file='recovered-buttons.swf'
   text,n=re.subn(r'(\s+)(public (?:dynamic )?class )',r'\1[Embed(source="/_assets/'+asset_file+r'", symbol="'+symbol+r'")]\1\2',text,count=1)
   assert n==1;p.write_text(text);changes.append({'class':name,'character_id':cid,'asset_symbol':symbol,'asset_file':asset_file,'original_definition_sha256':hashlib.sha256(defs[cid][1]).hexdigest(),'repair':'Restore omitted FFDec SimpleButton Embed metadata using script-free artwork; absent empty buttons recovered directly from original non-code definition.'})
 if recovered:
  data=bytearray(body[:header['tag_start']])
  data+=b''.join(packtag(c,x)for c,x in ts if c==69)
  data+=b''.join(packtag(34,x)for _,_,x in recovered)
  data+=packtag(56,struct.pack('<H',len(recovered))+b''.join(struct.pack('<H',cid)+name.encode()+b'\0'for cid,name,_ in recovered))+packtag(1,b'')+packtag(0,b'')
  target=staging/'_assets/recovered-buttons.swf';target.parent.mkdir(exist_ok=True);target.write_bytes(encode(raw,data))
 return changes

class Bits:
 def __init__(self,b,pos):self.b=b;self.p=pos*8
 def take(self,n):
  v=0
  for _ in range(n):v=(v<<1)|((self.b[self.p//8]>>(7-self.p%8))&1);self.p+=1
  return v
 def aligned(self):return (self.p+7)//8
 def matrix(self):
  if self.take(1):self.take(self.take(5)*2)
  if self.take(1):self.take(self.take(5)*2)
  self.take(self.take(5)*2);self.p=self.aligned()*8

def restore_root(original,compiled,output):
 _,ob,oh,ot=parts(original);raw,b,h,nt=parts(compiled)
 os=bindings(ot);ns=bindings(nt);assert all(os.values()),'resource original has document class'
 missing=set(os)-set(ns);assert not missing,('missing original SymbolClass',missing)
 od={struct.unpack_from('<H',x)[0]:(c,x)for c,x in ot if c in CHARACTER_TAGS};nd={struct.unpack_from('<H',x)[0]:(c,x)for c,x in nt if c in CHARACTER_TAGS}
 for name,cid in os.items():assert od[cid][0]==nd[ns[name]][0],('linkage asset type changed',name)
 mapping={cid:ns[name]for name,cid in os.items()};copied=[];newdefs=[];nextid=max(nd,default=0)+1
 def remap(cid):
  nonlocal nextid
  if cid==65535:return cid
  if cid in mapping:return mapping[cid]
  c,x=od[cid];new=nextid;nextid+=1;mapping[cid]=new;v=bytearray(x);struct.pack_into('<H',v,0,new)
  if c==22:
   # Support the actually present unlinked Shape2 with bitmap-only fills. Fail
   # closed if another shape requires a new dependency parser.
   refs=[]
   def styles(pos):
    count=v[pos];pos+=1
    if count==255:count=struct.unpack_from('<H',v,pos)[0];pos+=2
    for _ in range(count):
     typ=v[pos];pos+=1;assert typ in(0x40,0x41,0x42,0x43),('unsupported root Shape2 fill',typ)
     dep=struct.unpack_from('<H',v,pos)[0];struct.pack_into('<H',v,pos,remap(dep));refs.append({'offset':pos,'from':dep,'to':mapping.get(dep,dep)});pos+=2
     mb=Bits(v,pos);mb.matrix();pos=mb.aligned()
    lines=v[pos];pos+=1
    if lines==255:lines=struct.unpack_from('<H',v,pos)[0];pos+=2
    assert lines==0,'unreviewed line styles in root shape'
    return Bits(v,pos)
   bits=Bits(v,2);bits.take(bits.take(5)*4);bits=styles(bits.aligned());fillbits=bits.take(4);linebits=bits.take(4)
   while True:
    edge=bits.take(1)
    if edge:
     straight=bits.take(1);nbits=bits.take(4)+2
     if not straight:bits.take(nbits*4)
     elif bits.take(1):bits.take(nbits*2)
     else:bits.take(1);bits.take(nbits)
    else:
     flags=bits.take(5)
     if not flags:break
     if flags&1:bits.take(bits.take(5)*2)
     if flags&2:bits.take(fillbits)
     if flags&4:bits.take(fillbits)
     if flags&8:bits.take(linebits)
     if flags&16:bits=styles(bits.aligned());fillbits=bits.take(4);linebits=bits.take(4)
   assert bits.aligned()==len(v),'unparsed shape data'
   copied.append({'original_id':cid,'new_id':new,'code':c,'bitmap_references':refs,'original_payload_sha256':hashlib.sha256(x).hexdigest()})
  elif c in(20,21,35,36,90):
   copied.append({'original_id':cid,'new_id':new,'code':c,'original_payload_sha256':hashlib.sha256(x).hexdigest()})
  else:raise ValueError(('unsupported unlinked root definition',cid,c))
  newdefs.append((c,bytes(v)));return new
 controls=[];placements=[]
 for c,x in ot:
  if c not in ROOT_CONTROLS:continue
  v=bytearray(x)
  if c==26:
   assert not v[0]&128,'root clip actions unsupported'
   if v[0]&2:
    old=struct.unpack_from('<H',v,3)[0];new=remap(old);struct.pack_into('<H',v,3,new);placements.append({'old_id':old,'new_id':new,'depth':struct.unpack_from('<H',v,1)[0]})
  elif c not in(1,18,19,43,45):raise ValueError(('unhandled root control',c))
  controls.append((c,bytes(v)))
 out=bytearray(ob[:oh['tag_start']])
 # Original FileAttributes and metadata are retained, including network policy.
 out+=b''.join(packtag(c,x)for c,x in ot if c in ROOT_METADATA)
 for c,x in nt:
  if c in ROOT_CONTROLS|ROOT_METADATA|{0}:continue
  if c==76:
   ss=bindings([(c,x)]);ss={n:i for n,i in ss.items()if i};x=struct.pack('<H',len(ss))+b''.join(struct.pack('<H',i)+n.encode()+b'\0' for n,i in ss.items())
  out+=packtag(c,x)
 out+=b''.join(packtag(c,x)for c,x in newdefs+controls)+packtag(0,b'')
 output.write_bytes(encode(raw,out));_,_,_,final=parts(output)
 assert set(bindings(final))==set(os)
 assert not any(i==0 for i in bindings(final).values())
 return {'verified':True,'schema':1,'scope':'Original root metadata/control tags preserved; placement IDs remapped; all original SymbolClass names and asset tag types retained; synthetic document binding removed. Nested asset frame semantics require separate validation.','original_document_class':None,'rebuilt_document_class':None,'native_root_type':'flash.display.MovieClip','original_linkages':len(os),'rebuilt_linkages':len(bindings(final)),'placements':placements,'copied_unlinked_definitions':copied,'controls':[c for c,_ in controls],'original_abc_reused':False,'unexecuted_audio_stream_headers':sum(c in(18,45)for c,_ in controls)}
