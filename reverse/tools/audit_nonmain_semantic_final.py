#!/usr/bin/env python3
"""Finalize current-output non-Main semantic evidence, including actual trace flags."""
from pathlib import Path
import argparse,collections,datetime,hashlib,json,time
ROOT=Path(__file__).resolve().parents[2];sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--wait',action='store_true');args=ap.parse_args();progress=ROOT/'reverse/manifests/nonmain-semantic-validation-progress.json'
 while True:
  try:d=json.loads(progress.read_text())
  except (FileNotFoundError,json.JSONDecodeError):d={'pending':['not-yet-written']}
  if not d.get('pending') and len(d.get('results',[]))==84:break
  if not args.wait:raise SystemExit('Verification pending')
  time.sleep(10)
 assert d['failed_modules']==0,d
 from verify_nonmain_semantic_repairs import BY_MODULE,FROZEN,ready
 assert len(d['results'])==len(BY_MODULE)==84 and d['verified_method_count']==1363
 commands=[json.loads(l)for l in (ROOT/'reverse/logs/module-probe/commands.jsonl').read_text().splitlines()if l.strip()]
 rows=[];kinds=collections.Counter();fixture_count=0
 for row in d['results']:
  module=row['module'];p=ROOT/row['report'];r=json.loads(p.read_text());assert r['passed']
  current=ready(module);assert current,(module,'not current')
  receipt,build,output=current;assert sha(output)==r['output_sha256']==row['sha256'];assert build['input_fingerprint']['generation']==r['generation'];assert sha(receipt)==r['build_receipt_sha256']
  expected={(x['class'],x['method'])for x in BY_MODULE[module]};observed={(x['class'],x['method'])for x in r['results']};assert expected==observed and len(observed)==len(r['results'])
  assert all(sha(ROOT/path)==value for path,value in r['checker_inputs'].items()),(module,'checker changed')
  for x in r['results']:kinds[x['kind']]+=1;fixture_count+=len(x.get('cases',[]))
  if module=='DataX_v76':
   assert '-compiler.omit-trace-statements=false'in build['command'];executed=[{'command':build['command'],'exit':build['exit_code']}];assert build['exit_code']==0
  else:
   prefix='-output='+str(ROOT/'reverse/build/module-probe'/module/'compile-')
   matches=[c for c in commands if any(x.startswith(prefix)for x in c['command'])][-2:];assert len(matches)==2,module
   before=datetime.datetime.fromisoformat(build['input_fingerprint']['captured_before_build_utc']).timestamp()*1e9
   after=datetime.datetime.fromisoformat(build['input_fingerprint']['verified_after_build_utc']).timestamp()*1e9
   for c in matches:
    ns=int(c['log'].rsplit('-',1)[1].removesuffix('.txt'));assert before<=ns<=after,(module,'command outside generation')
    assert c['exit']==0 and '-compiler.omit-trace-statements=false'in c['command'],module
   executed=[{'command_sha256':hashlib.sha256(json.dumps(c['command'],ensure_ascii=False).encode()).hexdigest(),'log':c['log'],'exit':c['exit'],'keep_trace_argument':True}for c in matches]
  rows.append({'module':module,'output_sha256':r['output_sha256'],'generation':r['generation'],'verified_method_count':r['verified_method_count'],'report':row['report'],'report_sha256':sha(p),'actual_compile_commands':executed})
 assert all(sha(ROOT/p)==v for p,v in FROZEN.items())
 result={'schema':1,'scope':'All changed non-Main methods checked against current rebuilt outputs. Local branch witnesses and finite P-code path models; not full AVM2 or gameplay execution. Actual compiler invocations retained trace.','modules':rows,'module_count':84,'method_count':1363,'method_kinds':dict(kinds),'finite_path_fixture_count':fixture_count,'source_freeze_sha256':sha(ROOT/'reverse/manifests/nonmain-semantic-source-freeze.json'),'actual_keep_trace_command_check':True,'all_output_and_recipe_generations_current':True,'passed':True,'player_started':False,'save_accessed':False}
 out=ROOT/'reverse/manifests/nonmain-semantic-final-validation.json';out.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n');print(json.dumps({k:v for k,v in result.items()if k!='modules'},ensure_ascii=False,indent=2),flush=True)
if __name__=='__main__':main()
