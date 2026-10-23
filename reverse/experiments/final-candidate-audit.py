from pathlib import Path
import hashlib,json,sys,subprocess
from datetime import datetime,timezone
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'reverse/tools'))
from launch_rebuilt import validate_inputs
from swf_inventory import read_swf,walk_tags
RUN=ROOT/'reverse/build/runtime-all-rebuilt-20261023T191531.793191Z'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def abc_hashes(p):
 _,body,header=read_swf(p);result=[]
 for tag,payload in walk_tags(body,header['tag_start']):
  if tag['code'] in (72,82):
   abc=payload if tag['code']==72 else payload[payload.index(b'\0',4)+1:]
   result.append(hashlib.sha256(abc).hexdigest())
 return result
launch=validate_inputs(RUN)
a=json.loads((RUN/'assembly.json').read_text());rows={r['module']:r for r in a['modules']};assert len(rows)==164 and a['state']=='complete' and not a['partial_allowed'] and a['original_fallback']==0
receipts={};versions={};source_roots={};abc_checks=[]
for name,row in rows.items():
 receipt=json.loads((RUN/row['receipt_snapshot']).read_text());receipts[name]=receipt
 if name!='3_L4399Main_gamefile':assert receipt.get('original_abc_reused') is False
 assert row['sha256']==receipt['output_sha256']==sha(RUN/row['path'])
 original=ROOT/row['path'];rebuilt=RUN/row['path'];version=rebuilt.read_bytes()[3];assert version==original.read_bytes()[3]
 versions[str(version)]=versions.get(str(version),0)+1
 oldabc=abc_hashes(original);newabc=abc_hashes(rebuilt);assert oldabc and newabc and not set(oldabc)&set(newabc)
 abc_checks.append({'module':name,'original_abc_count':len(oldabc),'rebuilt_abc_count':len(newabc),'identical_original_block_reused':False})
 specs=receipt['input_fingerprint']['specs'];sources=[s for s in specs if s['role']=='canonical_source'];assert len(sources)==1
 expected='reverse/source/'+name;assert sources[0]['path']==expected,(name,sources);source_roots[name]=expected
 if name in ('3_L4399Main_gamefile','DataX_v76'):assert '-compiler.omit-trace-statements=false' in receipt['command']
 else:assert receipt['root_timeline']['verified'] is True
p=ROOT/'reverse/manifests/nonmain-semantic-final-validation.json';nonmain=json.loads(p.read_text());assert nonmain['passed'] and nonmain['module_count']==84 and nonmain['method_count']==1363
for m in nonmain['modules']:
 row=rows[m['module']];assert row['sha256']==m['output_sha256'] and row['input_generation']==m['generation']
 assert sha(ROOT/m['report'])==m['report_sha256'];assert all((c.get('keep_trace_argument') is True or '-compiler.omit-trace-statements=false' in c.get('command',[])) and c['exit']==0 for c in m['actual_compile_commands'])
mainpath=ROOT/'reverse/manifests/main-semantic-repairs-validation-71b7c20c9edc.json';main=json.loads(mainpath.read_text());assert main['passed'] and main['swf_sha256']==rows['3_L4399Main_gamefile']['sha256']
# Only explicitly protected baseline entries; never deserialize or enumerate live stores.
protected=[]
for item in json.loads((ROOT/'reverse/private/save-baseline.json').read_text()):
 p=Path(item['path']);actual=sha(p);protected.append({'name':p.name,'sha256':actual,'expected_sha256':item['sha256'],'size':p.stat().st_size,'unchanged':actual==item['sha256'] and p.stat().st_size==item['size']})
assert len(protected)==3 and all(p['unchanged'] for p in protected)
script=ROOT/'启动源码重建版.command';syntax=subprocess.run(['/bin/zsh','-n',str(script)],capture_output=True,text=True);assert syntax.returncode==0
report={'schema':'yzlr2-final-candidate-provenance-v1','checked_utc':datetime.now(timezone.utc).isoformat(),'audit_script':'reverse/experiments/final-candidate-audit.py','audit_script_sha256':sha(Path(__file__)),'package':str(RUN.relative_to(ROOT)),'assembly_sha256':sha(RUN/'assembly.json'),
 'state':'static_source_provenance_pass_runtime_acceptance_pending','modules':164,'original_fallback':0,'independent_generation_count':len({r['input_generation'] for r in rows.values()}),
 'receipt_snapshots_checked':164,'runtime_file_hashes_checked':164,'identical_original_abc_reuse_checked':abc_checks,'source_roots':source_roots,
 'input_verification':launch,'swf_versions_match_original':True,'swf_version_distribution':versions,
 'main':{'sha256':rows['3_L4399Main_gamefile']['sha256'],'semantic_report':str(mainpath.relative_to(ROOT)),'semantic_report_sha256':sha(mainpath),'verified_methods':main['verified_methods'],'scope':main['scope']},
 'datax':{'sha256':rows['DataX_v76']['sha256'],'all_11_xml_constants_byte_exact':receipts['DataX_v76']['all_11_xml_constants_byte_exact'],'canonical_unmodified_xml':receipts['DataX_v76']['xml_constants_match_original_baseline']},
 'nonmain_semantic_link':{'report':'reverse/manifests/nonmain-semantic-final-validation.json','sha256':sha(ROOT/'reverse/manifests/nonmain-semantic-final-validation.json'),'modules_linked_by_sha_and_generation':84,'verified_methods':1363,'finite_fixtures':nonmain['finite_path_fixture_count'],'all_proof_report_hashes_checked':True},
 'protected_save_baseline':{'mode':'byte SHA256 and size only; no deserialization, no writes','files':protected,'all_unchanged':True,'private_paths_redacted':True},
 'launcher_uncommitted_diff':{'path':script.name,'sha256':sha(script),'syntax_check':'zsh -n passed','origin':'Earlier work by rea_capability following root request for Finder failure logs','scope':['umask077','project-local timestamp/PID launch log','tee combined output','preserve Python exit status via pipestatus[1]'],'commit_suitable':True,'changes_game_or_save_behavior':False},
 'player_started_by_this_audit':False,'compiled_game_modified':False,'rebuild_performed':False,'private_saves_read_for_hash_only':True,'diagnostic_v5_install':'pending separate explicit tool invocation; no game SWF changes'}
p=ROOT/'reverse/manifests/final-candidate-provenance.json';p.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print(json.dumps({'report':str(p.relative_to(ROOT)),'all_input_sources_current':True,'protected_save_unchanged':True,'versions':versions},ensure_ascii=False))
