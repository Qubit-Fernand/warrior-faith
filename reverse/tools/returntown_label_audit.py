#!/usr/bin/env python3
"""Read-only timeline evidence for return-town animation error; never runs game."""
import json,hashlib,struct,subprocess
from pathlib import Path
from swf_inventory import read_swf,walk_tags,Reader
ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'reverse/experiments/returntown-label-audit';OUT.mkdir(parents=True,exist_ok=True)
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def scan(path):
 _,body,header=read_swf(path);tags=list(walk_tags(body,header['tag_start']));symbols={};sprites={};scenes=[]
 for tag,data in tags:
  if tag['code']==76:
   r=Reader(data)
   for _ in range(r.u16()):
    cid=r.u16();name=r.cstr();symbols[name]=cid
  elif tag['code']==39:sprites[tag['character_id']]=(tag,data)
  elif tag['code']==86:
   r=Reader(data);ss=[];labels=[]
   for _ in range(r.var()):ss.append({'frame':r.var(),'name':r.cstr()})
   for _ in range(r.var()):labels.append({'frame':r.var(),'name':r.cstr()})
   scenes.append({'parent':tag['parent'],'scenes':ss,'labels':labels})
 result={}
 for name,cid in symbols.items():
  if 'Skin_player0' not in name:continue
  tag,data=sprites[cid];frame=1;labels=[];controls=[]
  for t,p in walk_tags(data,4,parent='sprite'):
   if t['parent']!='sprite':continue
   if t['code']==43:labels.append({'frame':frame,'label':Reader(p).cstr()})
   if t['code']==1:frame+=1
   controls.append({'code':t['code'],'sha256':hashlib.sha256(p).hexdigest()})
  result[name]={'character_id':cid,'frame_count':struct.unpack_from('<H',data,2)[0],'labels':labels,'definition_sha256':hashlib.sha256(data).hexdigest(),'controls':controls,'has_standing_label':any(x['label']=='站立' for x in labels)}
 return {'file':str(path.relative_to(ROOT)),'sha256':sha(path),'skins':result,'scene_tables':scenes}
package=ROOT/'reverse/build/runtime-all-rebuilt-20261023T175702.006475Z'
a=scan(ROOT/'PlayerMc_X0_v10.swf');b=scan(package/'PlayerMc_X0_v10.swf')
report={'original':a,'rebuilt':b,'compared_skins':{n:{'labels_equal':v['labels']==b['skins'][n]['labels'],'frame_count_equal':v['frame_count']==b['skins'][n]['frame_count'],'control_payloads_equal':v['controls']==b['skins'][n]['controls']} for n,v in a['skins'].items()},'game_executed':False}
(OUT/'timeline.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
java=ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'
for name,main in [('original',ROOT/'3_L4399Main_gamefile.swf'),('rebuilt',package/'3_L4399Main_gamefile.swf')]:
 dest=OUT/name
 cmd=[str(java),'-Djava.awt.headless=true','-jar',str(ROOT/'.runtime/shared-tools/ffdec/ffdec.jar'),'-selectclass','src.Player,src.Skin','-format','script:pcode','-export','script',str(dest),str(main)]
 proc=subprocess.run(cmd,cwd=ROOT,capture_output=True,text=True,timeout=100)
 (OUT/(name+'-pcode.log')).write_text(proc.stdout+proc.stderr)
 assert proc.returncode==0
 report[name]['main_sha256']=sha(main)
 report[name]['pcode']={p.name:sha(p) for p in (dest/'scripts/src').glob('*.pcode')}
(OUT/'timeline.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'skins':report['compared_skins'],'scenes_original':a['scene_tables'],'scenes_rebuilt':b['scene_tables'],'report':str(OUT/'timeline.json')},ensure_ascii=False,indent=2))
