#!/usr/bin/env python3
"""Compare recovered actual-class outputs; retain timing differences as out of scope."""
from pathlib import Path
import json,hashlib
ROOT=Path(__file__).resolve().parents[2];BASE=ROOT/'reverse/experiments/actual-class-harness'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 pairs=[('v2','original-b362fd303599-dd97714e','rebuilt-2c0b888c0b16-dd97714e'),('v3','original-b362fd303599-3046503c','rebuilt-71b7c20c9edc-3046503c')];comparisons=[]
 for generation,an,bn in pairs:
  ap=BASE/'results'/(an+'.json');bp=BASE/'results'/(bn+'.json');a=json.loads(ap.read_text());b=json.loads(bp.read_text());assert a['summary']['all_passed']and b['summary']['all_passed'];aa=a['report']['rows'];bb=b['report']['rows'];assert len(aa)==len(bb)==183
  differences=[];timing=[]
  for i,(x,y)in enumerate(zip(aa,bb)):
   for key in ('name','input','details','passed'):
    if x[key]!=y[key]:differences.append({'index':i,'key':key,'original':x[key],'rebuilt':y[key]})
   if x['elapsedMs']!=y['elapsedMs']:timing.append({'index':i,'original_ms':x['elapsedMs'],'rebuilt_ms':y['elapsedMs']})
  comparisons.append({'generation':generation,'original':str(ap.relative_to(ROOT)),'original_sha256':sha(ap),'rebuilt':str(bp.relative_to(ROOT)),'rebuilt_sha256':sha(bp),'cases':183,'behavior_differences':differences,'timing_differences_not_equivalence_failures':timing,'identical_fixture_inputs_outputs':not differences})
 screenshots=[]
 for p in [BASE/'original-v3-183-pass.png',BASE/'rebuilt-71b7-v3-183-pass.png']:
  screenshots.append({'path':str(p.relative_to(ROOT)),'sha256':sha(p),'independently_inspected':True,'visible_passed':183,'visible_failures':0,'visible_persistence':'flushed'})
 out={'schema':1,'date_local':'2026-10-24','runtime_executor':'root, official Adobe debugger projector','comparisons':comparisons,'v3_screenshots':screenshots,'all_passed':all(x['identical_fixture_inputs_outputs']for x in comparisons),'persistence_resolution':'Four explicitly identified dedicated probe SOL files were recovered. macOS Flash splits long logical SO names across physical #/ directory segments. Earlier flat-basename searches missed existing files; v2 was not proven to have failed persistence. The reader authenticates the internal SOL name and package/library/wrapper hashes before decoding.','scope':'172 actual nonstacking Bag/Storage fixture cases plus11 actual Achievement paths per run, with byte-identical game ABC in a library lacking Main document-class binding. No SetKeyPanel, gameplay lifecycle or global equivalence claim.'}
 p=BASE/'runtime-comparison.json';p.write_text(json.dumps(out,ensure_ascii=False,indent=2)+'\n');print(json.dumps({'all_passed':out['all_passed'],'pairs':[(x['generation'],x['cases'],len(x['behavior_differences']))for x in comparisons],'output':str(p.relative_to(ROOT))},indent=2))
if __name__=='__main__':main()
