#!/usr/bin/env python3
"""Verify repaired non-Main methods on actual newly built ABC, never run Flash."""
from pathlib import Path
import argparse,collections,hashlib,inspect,json,re,subprocess,time
from audit_decrement_semantics import method
from audit_ordered_comparisons import witness
from audit_shop_cfg import prop
from nonstack_path_interpreter import execute as loop_execute
from audit_continue_loops import execute as continue_execute
ROOT=Path(__file__).resolve().parents[2];OUT=ROOT/'reverse/build/nonmain-repair-verification';MAN=ROOT/'reverse/manifests/nonmain-repair-verification'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
CHECKER_INPUTS={str(p.relative_to(ROOT)):sha(p)for p in [Path(__file__).resolve(),*[ROOT/'reverse/tools'/n for n in ('audit_decrement_semantics.py','audit_ordered_comparisons.py','audit_shop_cfg.py','nonstack_path_interpreter.py','audit_continue_loops.py')],*[ROOT/'reverse/manifests'/n for n in ('nonmain-semantic-source-freeze.json','addgold-copy-repair-applied.json','addgold-original-49-proof.json','addgold-copy-repair-candidates.json','nonstack-copy-original-proof.json','ordered-copy-original-proof.json','continue-copy-original-proof.json','enemy202-nonstack-proof.json','trace-continue-copies-proof.json')]]}
def load(n):return json.loads((ROOT/'reverse/manifests'/(n+'.json')).read_text())
def model(source):
 # Newly compiled unoptimized ABC may retain identity coercions; accept only
 # already-correct primitive types, retaining fail-closed behavior elsewhere.
 source=source.replace("  elif op=='pushtrue':", "  elif op=='convert_b':assert type(stack[-1])is bool\n  elif op=='convert_i':assert type(stack[-1])is int and -2**31<=stack[-1]<2**31\n  elif op=='pushtrue':")
 source=source.replace("  elif op=='getlex':","  elif op=='findpropstrict' and prop(s)in ('Main','Array'):\n   assert 'main'in locals();stack.append({'Main':main,'Array':'Array'})\n  elif op=='getlex':")
 source=source.replace("  elif op=='getlex':", "  elif op=='findpropstrict' and prop(s)=='CheckTest':stack.append({'CheckTest':'CheckTest'})\n  elif op=='getproperty' and prop(s)=='CheckTest':assert stack.pop()=={'CheckTest':'CheckTest'};stack.append('CheckTest')\n  elif op=='getlex':")
 source=source.replace("  elif op=='callproperty':", "  elif op=='callproperty' and prop(s)in ('Testing','TestingOther','setMD5','setMD5Other'):\n   assert s.endswith(', 0') and stack.pop()=='CheckTest' and rows[pc]['code']=='pop';opaque_calls.append(prop(s));stack.append(('opaque-return',))\n  elif op=='pop' and stack and stack[-1]==('opaque-return',):stack.pop()\n  elif op=='callproperty':")
 source=source.replace("  elif op=='callproperty':", "  elif op=='callproperty' and prop(s)=='trace':\n   argc=int(re.search(r',\\s*(\\d+)$',s)[1]);args=[stack.pop()for _ in range(argc)][::-1];assert stack.pop()=='trace' and rows[pc]['code']=='pop';log_calls.append(args);stack.append(('opaque-return',))\n  elif op=='callproperty':")
 env={'re':re,'json':json,'prop':prop};exec(source,env);return env['execute']
CONT=model(inspect.getsource(continue_execute));TRACE=model(load('trace-continue-copies-proof')['model_source']);OPAQUE=model(load('enemy202-nonstack-proof')['opaque_model_source'])
FREEZE=load('nonmain-semantic-source-freeze');BY_MODULE=collections.defaultdict(list)
def add(module,cls,name,kind,row):BY_MODULE[module].append({'class':cls.replace('.','/'),'method':name,'kind':kind,'proof':row})
for r in load('addgold-copy-repair-applied')['source_changes']:add(r['module'],'com.hotpoint.braveManIII.models.player.PlayerData','addGold','gold',r)
for m in load('nonstack-copy-original-proof')['modules']:
 for r in m['methods']:add(m['module'],'com/hotpoint/braveManIII/models/container/'+r['class'],r['method'],'loop',r)
for r in load('enemy202-nonstack-proof')['methods']:add('Enemy202','com/hotpoint/braveManIII/models/container/'+r['class'],r['method'],'opaque_loop',r)
for r in load('ordered-copy-original-proof')['methods']:add(r['module'],r['class'],r['method'],'guard',r)
for m in load('continue-copy-original-proof')['modules']:
 for r in m['methods']:add(m['module'],r['class'],r['method'],'continue',r)
for m in load('trace-continue-copies-proof')['modules']:
 for r in m['methods']:add(m['module'],r['class'],r['method'],'trace_continue',r)
assert sum(map(len,BY_MODULE.values()))==1363
FROZEN={x['path']:x['sha256']for x in FREEZE['files']}
def ready(module):
 path=ROOT/('reverse/experiments/datax-recovery/build-full.json'if module=='DataX_v76'else'reverse/experiments/module-probe/'+module+'/result.json')
 try:
  d=json.loads(path.read_text());fp=d['input_fingerprint'];assert fp['post_build_verified']is True
  for name,value in FROZEN.items():
   if name.startswith('reverse/source/'+module+'/'):assert fp['files'][name]['sha256']==value and sha(ROOT/name)==value
  for name,entry in fp['files'].items():
   if 'build_recipe'in entry.get('roles',[]):assert sha(ROOT/name)==entry['sha256']
  output=ROOT/d['output'];assert output.exists()and sha(output)==d['output_sha256'];return path,d,output
 except (FileNotFoundError,KeyError,AssertionError,json.JSONDecodeError):return None

def one(module,ready_tuple):
 receipt,d,swf=ready_tuple;output_hash=sha(swf);target=OUT/module/output_hash[:16];target.mkdir(parents=True,exist_ok=True);rows=BY_MODULE[module];classes=sorted({r['class'].replace('/','.')for r in rows})
 cmd=[str(ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'),'-Xmx2g','-Djava.awt.headless=true','-jar',str(ROOT/'.runtime/shared-tools/ffdec/ffdec.jar'),'-selectclass',','.join(classes),'-format','script:pcode','-export','script',str(target),str(swf)]
 export=target/'export.json'
 if not export.exists():
  p=subprocess.run(cmd,capture_output=True,text=True,timeout=150);(target/'export.log').write_text(p.stdout+p.stderr);assert p.returncode==0
  export.write_text(json.dumps({'output_sha256':output_hash,'command':cmd},ensure_ascii=False,indent=2)+'\n')
 else:assert json.loads(export.read_text())['output_sha256']==output_hash
 results=[]
 for r in rows:
  path=target/'scripts'/(r['class']+'.pcode');code=method(path,r['method']);kind=r['kind'];proof=r['proof'];result={'class':r['class'],'method':r['method'],'kind':kind,'pcode_sha256':sha(path),'method_instructions_sha256':hashlib.sha256(json.dumps([x['code']for x in code],ensure_ascii=False).encode()).hexdigest()}
  if kind in ('gold','guard'):
   compare='lessequals'if r['class'].endswith('EquipSlot')else'greaterthan';indexes=[]
   for i,x in enumerate(code):
    if x['code']!=compare:continue
    if code[i+1]['code'].startswith('iftrue '):indexes.append(i+1)
    elif code[i+1]['code']=='not' and code[i+2]['code'].startswith('iffalse '):indexes.append(i+2)
   assert len(indexes)==1,(module,r['method'],compare,indexes)
   i=indexes[0];branch=code[i]['code'].split()[0];ordinal=sum(x['code'].startswith(branch+' ')for x in code[:i]);w=witness(code,branch,ordinal);fall=w['fallthrough_path_to_next_branch_or_return'];taken=w['taken_path_to_next_branch_or_return']
   if kind=='gold':effect='setValue'
   elif r['class'].endswith('EquipSlot'):effect=r['method'].replace('getAll','get',1)
   else:effect=None
   if effect:assert any('"'+effect+'"'in x['code']for x in fall)and not any('"'+effect+'"'in x['code']for x in taken),(module,r['method'],w)
   elif r['class'].endswith('Bag'):assert any(x['code']=='returnvalue'for x in fall)and any('getproperty MultinameL'in x['code']for x in taken),(module,r['method'],w)
   else:assert any('"gongJiYn1"'in x['code']for x in fall)and any(x['code']=='returnvoid'for x in fall)and any(x['code']=='pushstring "攻击"'for x in taken),(module,r['method'],w)
   result['witness']=w
  elif kind in ('loop','opaque_loop'):
   cases=[];field=proof.get('field');size=proof.get('size');write=r['method']!='isGemBagEmpty'
   if kind=='opaque_loop':
    from nonstack_path_interpreter import SPECS
    _,_,field,size,write=next(x for x in SPECS if x[0]==proof['class']and x[1]==r['method'])
   field=field.removeprefix('this.');interpreter=OPAQUE if kind=='opaque_loop'else loop_execute
   for c in proof['cases']:
    hole=c['hole'];actual=interpreter(code,field,size,hole);assert actual['termination']=='return'and actual['value']==(hole is not None),(module,r['method'],hole,actual);assert actual['written_indexes']==([hole]if write and hole is not None else[])
    if kind=='opaque_loop':assert actual['opaque_calls']==c['result']['opaque_calls']
    actual.pop('trace_tail',None);cases.append({'hole':hole,'result':actual})
   result['cases']=cases
  else:
   cases=[];interpreter=TRACE if kind=='trace_continue'else CONT
   for c in proof['fixtures']:
    fixture=c['fixture'];actual=interpreter(code,fixture);assert actual['termination']=='return'and actual['value']==fixture['expected'],(module,r['method'],fixture,actual)
    assert actual['db_calls']==c['result']['db_calls']
    if kind=='trace_continue':assert actual['trace_calls']==c['result']['trace_calls']
    actual.pop('trace_tail',None);cases.append({'fixture':fixture,'result':actual})
   result['cases']=cases
  results.append(result)
 assert sha(swf)==output_hash and ready(module), 'Build changed during verification'
 assert all(sha(ROOT/path)==value for path,value in CHECKER_INPUTS.items()),'Checker inputs changed during verification'
 report={'schema':1,'module':module,'output_sha256':output_hash,'generation':d['input_fingerprint']['generation'],'build_receipt':str(receipt.relative_to(ROOT)),'build_receipt_sha256':sha(receipt),'source_freeze_sha256':sha(ROOT/'reverse/manifests/nonmain-semantic-source-freeze.json'),'verified_method_count':len(results),'checker_inputs':CHECKER_INPUTS,'results':results,'passed':True,'scope':'Repaired local guards and finite actual-P-code loop paths only, all namespaces retained. No whole-program/gameplay equivalence claim.','player_started':False,'save_accessed':False}
 MAN.mkdir(parents=True,exist_ok=True);out=MAN/(module+'-'+output_hash[:16]+'.json');out.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print(module,len(results),'passed',flush=True);return {'module':module,'sha256':output_hash,'report':str(out.relative_to(ROOT)),'verified_method_count':len(results),'passed':True}
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--module');ap.add_argument('--watch',action='store_true');args=ap.parse_args();pending=[args.module]if args.module else sorted(BY_MODULE);results=[]
 while pending:
  progress=False
  for module in pending[:]:
   x=ready(module)
   if not x:continue
   try:result=one(module,x)
   except Exception as e:
    import traceback;traceback.print_exc();result={'module':module,'passed':False,'error':repr(e)}
   results.append(result);pending.remove(module);progress=True
   out={'schema':1,'results':results,'pending':pending,'passed_modules':sum(r['passed']for r in results),'failed_modules':sum(not r['passed']for r in results),'verified_method_count':sum(r.get('verified_method_count',0)for r in results),'scope':'Current source-frozen, post-build-verified outputs only; pending means not yet eligible.'};(ROOT/'reverse/manifests/nonmain-semantic-validation-progress.json').write_text(json.dumps(out,ensure_ascii=False,indent=2)+'\n')
  if pending and args.watch:time.sleep(10)
  elif pending:print('Not yet ready:',pending);break
 if any(not x['passed']for x in results):raise SystemExit(1)
if __name__=='__main__':main()
