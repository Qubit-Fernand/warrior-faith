#!/usr/bin/env python3
"""Read-only whole-ABC provenance check; not method equivalence or gameplay proof."""
from pathlib import Path
import collections,datetime,hashlib,json,time
from swf_inventory import read_swf,walk_tags
ROOT=Path(__file__).resolve().parents[2]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def scan(p):
 raw,body,h=read_swf(p);abcs=[]
 for tag,data in walk_tags(body,h['tag_start']):
  if tag['code']not in (72,82):continue
  abc=data[data.index(b'\0',4)+1:]if tag['code']==82 else data
  abcs.append(hashlib.sha256(abc).hexdigest())
 return hashlib.sha256(raw).hexdigest(),abcs

def main():
 originals={};all_abc=set()
 for p in sorted(ROOT.glob('*.swf')):
  digest,abcs=scan(p);originals[p.stem]={'sha256':digest,'abc_sha256':abcs};all_abc.update(abcs)
 assert len(originals)==164,len(originals)
 records=[]
 for module in sorted(originals):
  if module=='3_L4399Main_gamefile':receipt=ROOT/'reverse/build/main-probe/build-all.json'
  elif module=='DataX_v76':receipt=ROOT/'reverse/experiments/datax-recovery/build-full.json'
  else:receipt=ROOT/'reverse/experiments/module-probe'/module/'result.json'
  for attempt in range(3):
   before=sha(receipt);d=json.loads(receipt.read_text());p=ROOT/d.get('normalized_output',d['output']);digest,abcs=scan(p)
   if before==sha(receipt)and digest==d['output_sha256']:break
   time.sleep(1)
  else:raise AssertionError((module,'output changing during audit'))
  matches=sorted(set(abcs)&all_abc);assert not matches,(module,matches)
  assert digest!=originals[module]['sha256']
  if module!='3_L4399Main_gamefile':assert d['original_abc_reused']is False
  records.append({'module':module,'output':str(p.relative_to(ROOT)),'output_sha256':digest,'abc_count':len(abcs),'abc_sha256':abcs,'matches_any_original_abc':matches,'receipt':str(receipt.relative_to(ROOT)),'receipt_sha256':before,'generation':d['input_fingerprint']['generation']})
 artifacts=[]
 for p in sorted((ROOT/'reverse/build').glob('runtime-*/assembly.json')):
  d=json.loads(p.read_text());rows=d['modules'];counts=dict(collections.Counter(x['provenance']for x in rows));checked=[]
  for row in rows:
   digest,abcs=scan(p.parent/row['path']);assert digest==row['sha256'];matches=sorted(set(abcs)&all_abc)
   if row['provenance']=='source_rebuilt':assert not matches,(p,row['module'])
   checked.append({'module':row['module'],'sha256':digest,'provenance':row['provenance'],'matching_original_abc_blocks':len(matches)})
  artifacts.append({'assembly':str(p.relative_to(ROOT)),'assembly_sha256':sha(p),'partial_allowed':d['partial_allowed'],'provenance_counts':counts,'modules':checked})
 report={'schema':1,'checked_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'scope':'Snapshot of latest build receipts and preserved runtime-* assemblies. Whole ABC payload hash comparison against all 164 original SWFs, excluding DoABC flags/name. Zero matches rules out intact original ABC blocks, not arbitrary bytecode fragments; compiler/source and script-free asset evidence supplies the separate reconstruction basis. Does not assert all current recipes finished or gameplay equivalence.','originals':originals,'current_candidates':records,'current_candidate_count':len(records),'current_whole_original_abc_matches':0,'assemblies':artifacts,'historical_partial_excluded_from_rebuilt_claim':True,'player_started':False,'save_accessed':False,'passed':True}
 out=ROOT/'reverse/manifests/output-abc-origin-snapshot.json';out.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print('Current candidates:',len(records),'original ABC matches: 0; assemblies:',[(x['assembly'],x['provenance_counts'])for x in artifacts])
if __name__=='__main__':main()
