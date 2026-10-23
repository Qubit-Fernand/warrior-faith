#!/usr/bin/env python3
"""Isolated source-label experiment. Never launches Flash or accesses SOL."""
import argparse, hashlib, json, shutil, subprocess, sys
from datetime import datetime, timezone
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def ledger(p):return {str(f.relative_to(p)):sha(f) for f in sorted(p.rglob('*')) if f.is_file() and '__pycache__' not in f.parts}
def dump(p,x):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def run(project,script,*args):
 command=[sys.executable,str(project/'reverse/tools'/script),*args]
 result=subprocess.run(command,cwd=project,capture_output=True,text=True,timeout=600)
 log=project.parent/(script+'-'+datetime.now(timezone.utc).strftime('%H%M%S')+'.log')
 log.write_text(result.stdout+result.stderr)
 if result.returncode:raise RuntimeError(f'{script}: exit {result.returncode}, see {log}')
 return {'command':command,'exit_code':result.returncode,'log':str(log),'log_sha256':sha(log)}
def main():
 parser=argparse.ArgumentParser();parser.add_argument('--baseline',type=Path,required=True);a=parser.parse_args()
 baseline=a.baseline.resolve();assert baseline.parent==ROOT/'reverse/build'
 stamp=datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S.%fZ')
 exp=ROOT/'reverse/build'/('source-edit-proof-'+stamp); project=exp/'project';project.mkdir(parents=True)
 inputs=['reverse/source/DataX_v76','reverse/source/DataX_v76-config','reverse/tools','reverse/exports/DataX_v76/inventory','reverse/exports/DataX_v76/scripts/_assets']
 parent_before={x:ledger(ROOT/x) for x in inputs[:2]}
 for rel in inputs:
  shutil.copytree(ROOT/rel,project/rel,ignore=shutil.ignore_patterns('__pycache__'))
 for rel in ['DataX_v76.swf','reverse/exports/DataX_v76/scripts-receipt.json','reverse/experiments/datax-recovery/recovery.json']:
  dst=project/rel;dst.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(ROOT/rel,dst)
 (project/'.runtime').mkdir();(project/'.runtime/shared-tools').symlink_to(ROOT/'.runtime/shared-tools',target_is_directory=True)
 receipt={'schema':'yzlr2-source-editability-v1','state':'prepared','root':str(exp),'project':str(project),
  'baseline_runtime':str(baseline),'parent_source_before':parent_before,'source_ledger_before':ledger(project/'reverse/source'),
  'source_change':{'xml_method':'SuppliesXML','item_id':'21110','old_name':'低级体力药水','new_name':'源码测试药水'},
  'game_executed':False,'sol_accessed':False,'launch_eligible_via_standard_launcher':False,'commands':[]}
 dump(exp/'experiment.json',receipt);print(str(exp),flush=True)
 receipt['commands'].append(run(project,'datax_build.py'))
 report=project/'reverse/experiments/datax-recovery/build-full.json'
 before=json.loads(report.read_text());assert before['success'] and before['input_fingerprint']['post_build_verified']
 shutil.copy2(report,exp/'unmodified-build.json');receipt['unmodified_output_sha256']=before['output_sha256']
 config=project/'reverse/source/DataX_v76-config/SuppliesXML.xml';raw=config.read_bytes()
 old='<名称>低级体力药水</名称>'.encode();new='<名称>源码测试药水</名称>'.encode();assert raw.count(old)==1
 config.write_bytes(raw.replace(old,new,1))
 receipt['commands'].append(run(project,'datax_source.py','import-xml'))
 afterledger=ledger(project/'reverse/source');beforeledger=receipt['source_ledger_before']
 assert set(beforeledger)==set(afterledger)
 changed=[k for k in beforeledger if beforeledger[k]!=afterledger[k]]
 assert sorted(changed)==['DataX_v76-config/SuppliesXML.xml','DataX_v76/src/InData.as'],changed
 receipt['source_ledger_after']=afterledger;receipt['changed_source_files']=changed
 receipt['commands'].append(run(project,'datax_build.py'))
 after=json.loads(report.read_text());assert after['success'] and after['input_fingerprint']['post_build_verified'] and not after['original_abc_reused']
 assert after['all_11_xml_constants_byte_exact'] and not after['xml_constants_match_original_baseline']
 shutil.copy2(report,exp/'modified-build.json')
 sys.path.insert(0,str(project/'reverse/tools'))
 from datax_source import literals
 from datax_recover import pool,verify_compiled_indata
 from swf_inventory import abc_inventory,read_swf,walk_tags,Reader
 import xml.etree.ElementTree as ET
 recovery=json.loads((project/'reverse/experiments/datax-recovery/recovery.json').read_text())
 source=literals((project/'reverse/source/DataX_v76/src/InData.as').read_text())
 output=project/after['output']; _,body,header=read_swf(output);assert header['version']==9
 extracted=None
 for tag,payload in walk_tags(body,header['tag_start']):
  if tag['code']!=82:continue
  abc=payload[payload.index(b'\0',4)+1:];inv=abc_inventory(abc)
  matches=[c for c in inv['classes'] if c['name']=='src.InData']
  if not matches:continue
  cls=matches[0];trait=next(t for t in cls['static_traits'] if t['name'].rsplit('.',1)[-1]=='SuppliesXML')
  method=next(b for b in inv['method_bodies'] if b['method']==trait['method']);r=Reader(abc[method['offset']:method['offset']+method['length']])
  assert r.take(3)==b'\xd0\x30\x5d';r.var();assert r.u8()==0x66;r.var();assert r.u8()==0x5d;r.var();assert r.u8()==0x2c
  strings,_,_=pool(abc,{m['factory'] for m in recovery['methods']}|{'src.InData'});extracted=strings[r.var()]
 assert extracted==source['SuppliesXML']['xml']
 entries=[e for e in ET.fromstring(extracted) if e.findtext('编号')=='21110'];assert len(entries)==1 and entries[0].findtext('名称')=='源码测试药水'
 original=literals((ROOT/'reverse/source/DataX_v76/src/InData.as').read_text())
 assert set(original)==set(source)
 for key in original:
  expected=original[key]['xml'].replace(old.decode(),new.decode(),1) if key=='SuppliesXML' else original[key]['xml']
  assert expected==source[key]['xml'],key
 receipt['abc_method_readback']={'class':'src.InData','method':'SuppliesXML','item_id':'21110','name':entries[0].findtext('名称'),
  'xml_sha256':hashlib.sha256(extracted.encode()).hexdigest(),'all_11_method_templates_verified':after['indata_semantics'],
  'all_other_xml_bytes_unchanged':True,'version':header['version']}
 # Copy only the 164 game SWFs: no stale assembly claims, wrappers, requests or save data.
 runtime=ROOT/'reverse/build'/('runtime-source-label-probe-'+stamp);runtime.mkdir()
 baseline_files=sorted(baseline.glob('*.swf'));baseline_files=[p for p in baseline_files if p.name!='DiagnosticHarness.swf'];assert len(baseline_files)==164
 files=[]
 for f in baseline_files:
  dst=runtime/f.name;shutil.copy2(output if f.name=='DataX_v76.swf' else f,dst)
  files.append({'path':f.name,'baseline_sha256':sha(f),'sha256':sha(dst),'provenance':'scratch_source_label_build' if f.name=='DataX_v76.swf' else 'unchanged_baseline_runtime'})
 assert sum(x['baseline_sha256']!=x['sha256'] for x in files)==1
 main=runtime/'3_L4399Main_gamefile.swf';_,body,header=read_swf(main);names=set()
 for tag,payload in walk_tags(body,header['tag_start']):
  if tag['code']==82:
   names.update(s for s in abc_inventory(payload[payload.index(b'\0',4)+1:])['strings'] if s.startswith('yzlr2_'))
 assert names=={'yzlr2_rebuild_probe'},names
 receipt.update(state='static_verified_runtime_unexecuted',output=str(output),output_sha256=sha(output),runtime=str(runtime),
  runtime_files=files,existing_test_shared_object=sorted(names),runtime_datax_diff_scope='Only DataX file replaced; current source may contain semantic repairs beyond the older baseline runtime. Source experiment itself changes one label only.')
 receipt['parent_source_after']={x:ledger(ROOT/x) for x in inputs[:2]};assert receipt['parent_source_after']==parent_before,'Parent source changed concurrently; inspect before judging experiment isolation'
 receipt['parent_canonical_unchanged']=True
 dump(exp/'experiment.json',receipt)
 manifest={'schema':receipt['schema'],'state':receipt['state'],'experiment':str(exp/'experiment.json'),'experiment_sha256':sha(exp/'experiment.json'),
  'baseline_runtime':str(baseline),'baseline_receipts':{p.name:sha(p) for p in baseline.glob('*.json')},'files':files,
  'shared_object':sorted(names),'sol_accessed':False,'game_executed':False,'standard_strict_assembly':False}
 dump(runtime/'source-editability-experiment.json',manifest)
 (runtime/'README.txt').write_text('源码名称修改实验。仅药水21110名称改为源码测试药水。不是正式strict组装包。\n继承现有隔离测试SO yzlr2_rebuild_probe；没有复制/读取SO。\n静态验证通过，尚未运行。请直接打开3_L4399Main_gamefile.swf进入药水商店截图。\n')
 print(json.dumps({'runtime':str(runtime),'experiment':str(exp/'experiment.json'),'output_sha256':sha(output),'name':'源码测试药水','parent_canonical_unchanged':True},ensure_ascii=False),flush=True)
if __name__=='__main__':main()
