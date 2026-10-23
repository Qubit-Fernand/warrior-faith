#!/usr/bin/env python3
"""Read SWF/ABC structure without executing it; preserve binary provenance."""
import argparse, collections, hashlib, json, struct, zlib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
TAG_NAMES = {0:'End',1:'ShowFrame',2:'DefineShape',4:'PlaceObject',5:'RemoveObject',6:'DefineBits',7:'DefineButton',8:'JPEGTables',9:'SetBackgroundColor',10:'DefineFont',11:'DefineText',12:'DoAction',13:'DefineFontInfo',14:'DefineSound',15:'StartSound',18:'SoundStreamHead',19:'SoundStreamBlock',20:'DefineBitsLossless',21:'DefineBitsJPEG2',22:'DefineShape2',26:'PlaceObject2',28:'RemoveObject2',32:'DefineShape3',33:'DefineText2',34:'DefineButton2',35:'DefineBitsJPEG3',36:'DefineBitsLossless2',37:'DefineEditText',39:'DefineSprite',43:'FrameLabel',45:'SoundStreamHead2',46:'DefineMorphShape',48:'DefineFont2',56:'ExportAssets',57:'ImportAssets',58:'EnableDebugger',59:'DoInitAction',60:'DefineVideoStream',61:'VideoFrame',64:'EnableDebugger2',65:'ScriptLimits',69:'FileAttributes',70:'PlaceObject3',72:'DoABC',73:'DefineFontAlignZones',74:'CSMTextSettings',75:'DefineFont3',76:'SymbolClass',77:'Metadata',78:'DefineScalingGrid',82:'DoABC',83:'DefineShape4',84:'DefineMorphShape2',86:'DefineSceneAndFrameLabelData',87:'DefineBinaryData',88:'DefineFontName',89:'StartSound2',90:'DefineBitsJPEG4',91:'DefineFont4',93:'EnableTelemetry'}
CHARACTER_TAGS = {2,6,7,10,11,14,20,21,22,32,33,34,35,36,37,39,46,48,60,75,83,84,87,90,91}

def sha(b): return hashlib.sha256(b).hexdigest()
class Reader:
    def __init__(self,b): self.b=b; self.p=0
    def take(self,n):
        if self.p+n>len(self.b): raise ValueError(f'truncated at {self.p}, need {n}')
        v=self.b[self.p:self.p+n];self.p+=n;return v
    def u8(self): return self.take(1)[0]
    def u16(self): return struct.unpack('<H',self.take(2))[0]
    def var(self):
        v=0
        for i in range(5):
            x=self.u8();v|=(x&127)<<(i*7)
            if not x&128:return v
        return v
    def cstr(self):
        end=self.b.index(b'\0',self.p);v=self.b[self.p:end].decode('utf-8',errors='replace');self.p=end+1;return v

def abc_inventory(b):
    r=Reader(b);minor=r.u16();major=r.u16()
    if (minor,major)!=(16,46): raise ValueError(f'unsupported ABC version {major}.{minor}')
    for _ in range(2):
        for i in range(1,r.var()):r.var()
    r.take(max(0,r.var()-1)*8)
    strings=['']
    for i in range(1,r.var()):strings.append(r.take(r.var()).decode('utf-8',errors='replace'))
    ns=[None]
    for i in range(1,r.var()): ns.append((r.u8(),r.var()))
    sets=[[]]
    for i in range(1,r.var()): sets.append([r.var() for _ in range(r.var())])
    names=[None]
    for i in range(1,r.var()):
        k=r.u8()
        if k in (7,13): v=[r.var(),r.var()]
        elif k in (15,16):v=[r.var()]
        elif k in (17,18):v=[]
        elif k in (9,14):v=[r.var(),r.var()]
        elif k in (27,28):v=[r.var()]
        elif k==29:v=[r.var()];v += [r.var() for _ in range(r.var())]
        else:raise ValueError(f'unknown multiname kind {k} at {r.p}')
        names.append((k,v))
    def name(i):
        if not i:return '*'
        k,v=names[i]
        if k in (7,13):
            space=strings[ns[v[0]][1]] if v[0] else ''
            return (space+'.' if space else '')+strings[v[1]]
        if k in (9,14,15,16):return strings[v[0]]
        if k==29:return name(v[0])+'<'+','.join(name(x) for x in v[1:])+'>'
        return f'<multiname:{i}>'
    methods=[]
    for i in range(r.var()):
        n=r.var();ret=r.var();params=[r.var() for _ in range(n)];mn=r.var();flags=r.u8()
        if flags&8:
            for _ in range(r.var()):r.var();r.u8()
        if flags&128:
            for _ in range(n):r.var()
        methods.append({'index':i,'name':strings[mn],'return_type':name(ret),'parameter_types':[name(x) for x in params],'flags':flags})
    for _ in range(r.var()):
        r.var();count=r.var()
        for _ in range(2*count):r.var()
    def traits():
        result=[]
        for _ in range(r.var()):
            tn=r.var();attr=r.u8();kind=attr&15;detail={}
            if kind in (0,6):
                detail={'slot':r.var(),'type':name(r.var())};value=r.var()
                if value:r.u8()
            elif kind in (1,2,3):detail={'dispatch':r.var(),'method':r.var()}
            elif kind==4:detail={'slot':r.var(),'class':r.var()}
            elif kind==5:detail={'slot':r.var(),'function':r.var()}
            else:raise ValueError(f'unknown trait kind {kind}')
            if attr&64:
                for _ in range(r.var()):r.var()
            result.append({'name':name(tn),'kind':kind,**detail})
        return result
    count=r.var();classes=[]
    for i in range(count):
        cn=r.var();supern=r.var();flags=r.u8()
        if flags&8:r.var()
        interfaces=[name(r.var()) for _ in range(r.var())];init=r.var()
        classes.append({'index':i,'name':name(cn),'super':name(supern),'flags':flags,'interfaces':interfaces,'initializer':init,'traits':traits()})
    for c in classes:c['static_initializer']=r.var();c['static_traits']=traits()
    scripts=[]
    for i in range(r.var()):scripts.append({'index':i,'initializer':r.var(),'traits':traits()})
    bodies=[]
    for _ in range(r.var()):
        mi=r.var();stack=r.var();locals_=r.var();init_scope=r.var();max_scope=r.var();length=r.var();offset=r.p;code=r.take(length)
        for _ in range(r.var()):
            for j in range(5):r.var()
        tr=traits();bodies.append({'method':mi,'offset':offset,'length':length,'sha256':sha(code),'max_stack':stack,'local_count':locals_,'init_scope':init_scope,'max_scope':max_scope,'traits':tr})
    if r.p!=len(b):raise ValueError(f'unparsed ABC bytes: {len(b)-r.p}')
    return {'minor':minor,'major':major,'string_count':len(strings),'classes':classes,'scripts':scripts,'methods':methods,'method_bodies':bodies,'strings':strings}

def read_swf(path):
    b=Path(path).read_bytes();signature=b[:3].decode('ascii');declared=struct.unpack('<I',b[4:8])[0]
    if signature=='CWS':body=zlib.decompress(b[8:])
    elif signature=='FWS':body=b[8:]
    else:raise ValueError(f'unsupported signature {signature}')
    if len(body)+8!=declared:raise ValueError('SWF length mismatch')
    nbits=body[0]>>3;rect_bytes=(5+4*nbits+7)//8
    bits=''.join(f'{x:08b}' for x in body[:rect_bytes]);rect=[]
    for i in range(4):
        v=int(bits[5+i*nbits:5+(i+1)*nbits],2)
        if v&(1<<(nbits-1)):v-=1<<nbits
        rect.append(v)
    rate,frames=struct.unpack('<HH',body[rect_bytes:rect_bytes+4]);start=rect_bytes+4
    return b,body,{'signature':signature,'version':b[3],'uncompressed_size':declared,'rect_twips':rect,'frame_rate':rate/256,'frame_count':frames,'tag_start':start}

def walk_tags(body,start,end=None,parent='root'):
    pos=start;end=len(body) if end is None else end
    while pos<end:
        offset=pos;h=struct.unpack_from('<H',body,pos)[0];pos+=2;code=h>>6;size=h&63
        if size==63:size=struct.unpack_from('<I',body,pos)[0];pos+=4
        stop=pos+size
        if stop>end:raise ValueError(f'tag {code} crosses container end')
        payload=body[pos:stop]
        row={'offset':offset+8,'body_offset':offset,'payload_offset':pos,'code':code,'name':TAG_NAMES.get(code,f'Tag{code}'),'length':size,'parent':parent,'sha256':sha(payload)}
        if code in CHARACTER_TAGS and size>=2:row['character_id']=struct.unpack_from('<H',payload)[0]
        yield row,payload
        if code==39:
            yield from walk_tags(body,pos+4,stop,f'{parent}/sprite:{row["character_id"]}')
        pos=stop
        if code==0:break
    if pos!=end:raise ValueError(f'unparsed tag bytes: {end-pos} in {parent}')

def inventory(path,out):
    b,body,header=read_swf(path);tags=[];symbols=[];abcs=[];actions=[];exports=[]
    out.mkdir(parents=True,exist_ok=True)
    for t,payload in walk_tags(body,header['tag_start']):
        tags.append(t)
        if t['code'] in (76,56):
            r=Reader(payload)
            for _ in range(r.u16()):
                row={'id':r.u16(),'name':r.cstr()}
                (symbols if t['code']==76 else exports).append(row)
        if t['code'] in (72,82):
            r=Reader(payload);flags=struct.unpack('<I',r.take(4))[0] if t['code']==82 else None;label=r.cstr() if t['code']==82 else '';abc=r.take(len(payload)-r.p)
            idx=len(abcs);fn=f'abc-{idx:04d}.abc';(out/fn).write_bytes(abc)
            detail=abc_inventory(abc);(out/f'abc-{idx:04d}.json').write_text(json.dumps(detail,ensure_ascii=False,indent=2)+'\n')
            abcs.append({'index':idx,'name':label,'flags':flags,'sha256':sha(abc),'size':len(abc),'file':fn,'tag_offset':t['offset'],'classes':len(detail['classes']),'scripts':len(detail['scripts']),'methods':len(detail['methods']),'bodies':len(detail['method_bodies'])})
        if t['code'] in (12,59):actions.append(t['offset'])
    result={'path':path.name,'sha256':sha(b),'size':len(b),**header,'tag_counts':dict(collections.Counter(t['name'] for t in tags)),'tags':tags,'symbol_classes':symbols,'export_assets':exports,'abc':abcs,'as2_action_offsets':actions,'document_classes':[s['name'] for s in symbols if s['id']==0]}
    (out/'structure.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
    return {k:v for k,v in result.items() if k not in ('tags','symbol_classes','export_assets')}

def main():
    ap=argparse.ArgumentParser();ap.add_argument('files',nargs='*');args=ap.parse_args();result=[]
    for path in ([Path(x) for x in args.files] if args.files else sorted(ROOT.glob('*.swf'))):
        try:
            row=inventory(path,ROOT/'reverse/exports'/path.stem/'inventory');row['status']='ok'
        except Exception as e:row={'path':path.name,'status':'failed','error':repr(e)}
        result.append(row);print(path.name,row['status'],flush=True)
    (ROOT/'reverse/manifests/swf-inventory.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
    if any(r['status']!='ok' for r in result):raise SystemExit(1)
if __name__=='__main__':main()
