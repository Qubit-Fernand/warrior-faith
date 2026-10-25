#!/usr/bin/env python3
"""Create a new header-only compatibility experiment, never a strict assembly."""
import hashlib,json,shutil
from pathlib import Path
from datetime import datetime,timezone
from swf_inventory import read_swf,walk_tags,abc_inventory
ROOT=Path(__file__).resolve().parents[2]
BASE=ROOT/'reverse/build/runtime-all-rebuilt-20261023T175702.006475Z'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def abcs(path):
 _,b,h=read_swf(path);rows=[]
 for t,p in walk_tags(b,h['tag_start']):
  if t['code']==82:
   a=p[p.index(b'\0',4)+1:];inv=abc_inventory(a)
   rows.append({'sha256':hashlib.sha256(a).hexdigest(),'major':inv['major'],'minor':inv['minor'],'methods':len(inv['method_bodies'])})
 return rows
stamp=datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S.%fZ')
out=ROOT/'reverse/build'/('runtime-header9-probe-'+stamp);out.mkdir()
manifest=json.loads((BASE/'assembly.json').read_text());assert manifest['rebuilt']==164 and manifest['original_fallback']==0
rows=[]
for row in manifest['modules']:
 name=row['path'];src=BASE/name;assert sha(src)==row['sha256'];dst=out/name;dst.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(src,dst)
 before=src.read_bytes();old=read_swf(ROOT/name)[2];patched=name in ('3_L4399Main_gamefile.swf','DataX_v76.swf')
 if patched:
  assert old['version']==9
  dst.write_bytes(before[:3]+bytes([old['version']])+before[4:])
 after=dst.read_bytes();offsets=[i for i,(a,b) in enumerate(zip(before,after))if a!=b]
 assert len(before)==len(after) and offsets==([3]if patched and before[3]!=9 else [])
 a,b=abcs(src),abcs(dst);assert a==b
 _,oldbody,oldh=read_swf(src);_,newbody,newh=read_swf(dst);assert oldbody==newbody
 rows.append({'path':name,'before_sha256':sha(src),'after_sha256':sha(dst),'changed_offsets':offsets,'header_version_before':oldh['version'],'header_version_after':newh['version'],'original_header_version':old['version'],'signature':before[:3].decode(),'decompressed_body_identical':True,'abc_identical':True,'abc':a if patched else None})
report={'schema':'yzlr2-header-compatibility-probe-v1','state':'experiment_unverified','createdUTC':stamp,'base_package':str(BASE.relative_to(ROOT)),'base_assembly_sha256':sha(BASE/'assembly.json'),'modules':rows,'files':len(rows),'changed_files':[x['path']for x in rows if x['changed_offsets']],'method':'Change raw byte offset3 only; preserve CWS compressed stream/FWS body and all other bytes. No recompression.','game_shared_object':'yzlr2_rebuild_probe','save_scope':'Same isolated test namespace as base. No SOL copied/read/written; do not run concurrently with base.','strict_assembly':False,'player_started':False,'abc_version_does_not_certify_api_compatibility':True}
(out/'compatibility-probe.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
(out/'README.txt').write_text('EXPERIMENT ONLY: Main/DataX header byte changed to original SWF9. Not strict assembly or validated release. Uses existing isolated yzlr2_rebuild_probe store. See compatibility-probe.json.\n')
assert not (out/'assembly.json').exists()
print(json.dumps({'directory':str(out),'changed_files':report['changed_files'],'files':len(rows),'state':report['state']},ensure_ascii=False,indent=2))
