#!/usr/bin/env python3
"""Strict structural, audio payload and every-parent-frame render comparison."""
from pathlib import Path
import hashlib,json,struct,time
from PIL import Image
from probe_rebuild_module import ROOT,BUILD,LOGS,SOURCES,JAVA,FFDEC,run
from probe_normalize_swf import symbols_and_sounds
from swf_inventory import read_swf,walk_tags,Reader

def linked_sprite(path,name):
 _,b,h=read_swf(path);symbols={};sprites={};classes=[]
 for t,x in walk_tags(b,h['tag_start']):
  if t['code']==76:
   r=Reader(x)
   for _ in range(r.u16()): cid=r.u16();symbols[r.cstr()]=cid
  if t['code']==39:sprites[struct.unpack_from('<H',x)[0]]=struct.unpack_from('<H',x,2)[0]
 return symbols[name],sprites[symbols[name]]
def main():
 report={'scope':'All340 parent frames of equipment S2;15 linked Sound resources. Offline, no runtime claims.'}
 mod='equip_1_18';b=BUILD/mod;original=ROOT/(mod+'.swf');rebuilt=b/(mod+'-rebuilt.swf');dirs=[]
 for label,path in [('original',original),('rebuilt',rebuilt)]:
  cid,count=linked_sprite(path,'S2');out=b/('frames-'+label+'-'+str(time.time_ns()));dirs.append(out)
  assert count==340
  run([JAVA,'-jar',FFDEC,'-selectid',str(cid),'-select',f'{cid}:1-{count}','-export','sprite',out,path],f'equip-allframes-{label}')
 a={p.name:p for p in dirs[0].rglob('*.png')};c={p.name:p for p in dirs[1].rglob('*.png')}
 assert len(a)==340 and set(a)==set(c)
 frames=[]
 for name,p in sorted(a.items(),key=lambda kv:int(Path(kv[0]).stem)):
  ia=Image.open(p).convert('RGBA');ib=Image.open(c[name]).convert('RGBA')
  equal=ia.size==ib.size and ia.tobytes()==ib.tobytes()
  frames.append({'frame':int(p.stem),'size':ia.size,'equal':equal,'rgba_sha256':hashlib.sha256(ia.tobytes()).hexdigest()})
 report['equipment']={'frames_compared':len(frames),'frames_equal':sum(f['equal'] for f in frames),'frames':frames}
 source=ROOT/'Music_v3.swf';target=BUILD/'Music_v3/Music_v3-rebuilt.swf';maps=[]
 for path in [source,target]:
  _,data,header=read_swf(path);maps.append(symbols_and_sounds(data,header['tag_start']))
 assert set(maps[0])==set(maps[1])
 report['sounds']=[{'class':name,'header_and_mpeg_equal':a[1][2:]==maps[1][name][1][2:],'sound_payload_sha256':hashlib.sha256(a[1][2:]).hexdigest()} for name,a in sorted(maps[0].items())]
 report['pass']=all(f['equal'] for f in frames) and all(s['header_and_mpeg_equal'] for s in report['sounds'])
 (SOURCES/'validation.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
 print(json.dumps({k:v for k,v in report.items() if k not in ('equipment','sounds')},ensure_ascii=False))
 if not report['pass']:raise SystemExit(1)
if __name__=='__main__':main()
