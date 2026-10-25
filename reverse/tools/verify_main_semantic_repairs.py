#!/usr/bin/env python3
"""Verify24 repaired Main methods against a newly compiled SWF's fresh P-code.

Can export eight targeted classes with FFDec; never compiles or starts a player.
"""
from pathlib import Path
import argparse,json,hashlib,subprocess,math
from audit_decrement_semantics import method
from audit_ordered_comparisons import witness
from audit_nonstack_loops import SPECS
from nonstack_path_interpreter import execute
from audit_continue_loops import execute as execute_continue
ROOT=Path(__file__).resolve().parents[2]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--swf',required=True);ap.add_argument('--pcode-dir');ap.add_argument('--export',action='store_true');args=ap.parse_args();swf=Path(args.swf).resolve();sh=sha(swf)
 target=Path(args.pcode_dir).resolve()if args.pcode_dir else ROOT/'reverse/build/main-repair-verification'/sh[:12]
 receipt=json.loads((ROOT/'reverse/manifests/main-semantic-repairs.json').read_text());extra=json.loads((ROOT/'reverse/manifests/main-continue-repairs.json').read_text());classes=sorted({x['class']for x in receipt['methods']+extra['methods']});assert len(classes)==8
 for f in receipt['files']:assert sha(ROOT/f['path'])==f['after_sha256'],f['path']+' changed after repair receipt'
 for f in extra['methods']:assert sha(ROOT/f['source'])==f['after_source_sha256'],f['source']+' changed after extra repair receipt'
 if args.export:
  target.mkdir(parents=True,exist_ok=True)
  cmd=[str(ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'),'-Xmx2g','-Djava.awt.headless=true','-jar',str(ROOT/'.runtime/shared-tools/ffdec/ffdec.jar'),'-selectclass',','.join(classes),'-format','script:pcode','-export','script',str(target),str(swf)]
  p=subprocess.run(cmd,capture_output=True,text=True,timeout=120);(target/'export.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr
 specs=json.loads((ROOT/'reverse/manifests/ordered-comparisons.json').read_text())['verified_local_nan_differences'];guards=[]
 for x in specs:
  p=target/'scripts'/(x['class'].replace('.','/')+'.pcode');code=method(p,x['method']);compare='lessequals'if x['class'].endswith('EquipSlot')else'greaterthan'
  indexes=[i for i,r in enumerate(code)if r['code']==compare and i+1<len(code)and code[i+1]['code'].startswith('iftrue ')]
  assert len(indexes)==1,(x['class'],x['method'],indexes)
  i=indexes[0];ordinal=sum(r['code'].startswith('iftrue ')for r in code[:i+1]);w=witness(code,'iftrue',ordinal)
  # Record the two edges rather than only checking an opcode count.
  # Patched condition jumps on positive comparison to the bypass; fallthrough
  # executes the original negated-relation effect.
  expected='setValue'if x['method']=='addGold'else x['method'].replace('getAll','get',1)if x['class'].endswith('EquipSlot')else None
  if expected:
   token='"'+expected+'"'
   assert any(token in r['code']for r in w['fallthrough_path_to_next_branch_or_return'])
   assert not any(token in r['code']for r in w['taken_path_to_next_branch_or_return'])
  elif x['class'].endswith('Bag'):
   assert any(r['code']=='returnvalue'for r in w['fallthrough_path_to_next_branch_or_return'])
   assert any('getproperty MultinameL'in r['code']for r in w['taken_path_to_next_branch_or_return'])
  else:
   assert any('"gongJiYn1"'in r['code']for r in w['fallthrough_path_to_next_branch_or_return'])
   assert any(r['code']=='returnvoid'for r in w['fallthrough_path_to_next_branch_or_return'])
   assert any('pushstring "攻击"'==r['code']for r in w['taken_path_to_next_branch_or_return'])
  guards.append({'class':x['class'],'method':x['method'],'pcode_sha256':sha(p),'comparison':compare,'witness':w,'old_negated_condition_restored':True,'whole_method_equivalence_proven':False})
 loops=[]
 for cls,n,field,size,write in SPECS:
  p=target/'scripts/com/hotpoint/braveManIII/models/container'/(cls+'.pcode');code=method(p,n);cases=[]
  for hole in list(range(size))+[None]:
   r=execute(code,field,size,hole);assert r['termination']=='return'and r['value']==(hole is not None)
   assert r['written_indexes']==([hole]if hole is not None and write else[])
   r.pop('trace_tail');cases.append({'hole':hole,'result':r})
  loops.append({'class':cls,'method':n,'cases':cases,'pcode_sha256':sha(p)})
 more=[]
 for item in json.loads((ROOT/'reverse/manifests/continue-loops.json').read_text())['methods']:
  p=target/'scripts'/(item['class'].replace('.','/')+'.pcode');code=method(p,item['method']);cases=[]
  for fixture in item['fixtures']:
   r=execute_continue(code,fixture['fixture']);old=fixture['results']['original'];assert r['termination']=='return'and r['value']==old['value']and r['db_calls']==old['db_calls']
   r.pop('trace_tail');cases.append({'fixture':fixture['fixture'],'result':r})
  more.append({'class':item['class'],'method':item['method'],'pcode_sha256':sha(p),'cases':cases})
 p=target/'scripts/com/hotpoint/braveManIII/views/suppliesShopPanel/SuppliesShopPanel.pcode';code=method(p,'setDown');ops=[x['code'].split()[0]for x in code]
 assert sum(o in ('decrement_i','declocal_i')for o in ops)==1 and not any(o in ('decrement','declocal')for o in ops)
 report={'schema':1,'swf':str(swf.relative_to(ROOT)),'swf_sha256':sh,'source_receipt_sha256':sha(ROOT/'reverse/manifests/main-semantic-repairs.json'),'repaired_guard_count':len(guards),'guards':guards,'loop_methods':loops,'loop_fixture_count':sum(len(x['cases'])for x in loops),'shop_setDown':{'pcode_sha256':sha(p),'code':code,'signed_int32_decrement_restored':True},'continue_loop_methods':more,'extra_source_receipt_sha256':sha(ROOT/'reverse/manifests/main-continue-repairs.json'),'verified_methods':len(guards)+len(loops)+len(more)+1,'passed':True,'player_started':False,'save_accessed':False,'scope':'Repaired relational opcodes and immediate branch/effect paths,172 container plus18 continue-loop actual-P-code restricted fixtures, and int32 quantity decrement only; no whole-game equivalence assertion.'}
 out=ROOT/'reverse/manifests'/f'main-semantic-repairs-validation-{sh[:12]}.json';out.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print(json.dumps({k:v for k,v in report.items()if k not in ('guards','loop_methods','continue_loop_methods','shop_setDown')},indent=2))
if __name__=='__main__':main()
