#!/usr/bin/env python3
"""Check resource build generations against current inputs and prior stable bytes.
No build or player execution. Historical summary is left intact.
"""
import json,hashlib
from pathlib import Path
from datetime import datetime,timezone
from build_inputs import verify
ROOT=Path(__file__).resolve().parents[2];PROBE=ROOT/'reverse/experiments/module-probe'
def main():
 old=json.loads((PROBE/'resource-final-validation.json').read_text());rows=[]
 for before in old['modules']:
  path=ROOT/before['receipt'];d=json.loads(path.read_text());fp=d.get('input_fingerprint');issues=verify(fp)
  if not fp or fp.get('post_build_verified')is not True:issues.append('missing post-build verification')
  output=ROOT/d['output'];digest=hashlib.sha256(output.read_bytes()).hexdigest()
  if digest!=d['output_sha256']:issues.append('output receipt SHA mismatch')
  if d.get('original_abc_reused')is not False:issues.append('original ABC reuse not excluded')
  if d.get('root_timeline',{}).get('verified')is not True:issues.append('root timeline not verified')
  if d.get('compile_twice_exact_equal')is not True:issues.append('two output builds differ')
  row={'module':before['module'],'receipt':before['receipt'],'receipt_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),'generation':fp.get('generation')if fp else None,'input_digest':fp.get('digest')if fp else None,'input_files':len(fp.get('files',{}))if fp else 0,'toolchain_manifest':fp.get('toolchain_manifest')if fp else None,'captured_before_build_utc':fp.get('captured_before_build_utc')if fp else None,'verified_after_build_utc':fp.get('verified_after_build_utc')if fp else None,'output':d['output'],'output_sha256':digest,'identical_to_prior_stable_output':digest==before['output_sha256'],'issues':issues}
  rows.append(row)
  if len(rows)%30==0:print('verified',len(rows),flush=True)
 result={'schema':1,'generated_utc':datetime.now(timezone.utc).isoformat(),'scope':'162 resource modules, actual new builds with pre/post input fingerprints; no runtime claims','prior_summary':'reverse/experiments/module-probe/resource-final-validation.json','modules':rows,'module_count':len(rows),'verified_count':sum(not r['issues']for r in rows),'identical_to_prior_stable_count':sum(r['identical_to_prior_stable_output']for r in rows),'unique_generations':len({r['generation']for r in rows}),'issues':[{'module':r['module'],'issues':r['issues']}for r in rows if r['issues']]}
 (PROBE/'resource-fingerprint-validation.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n');print(json.dumps({k:v for k,v in result.items()if k!='modules'},ensure_ascii=False,indent=2))
 if result['verified_count']!=162 or result['unique_generations']!=162:raise SystemExit(1)
if __name__=='__main__':main()
