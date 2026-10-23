#!/usr/bin/env python3
"""Compile a pure numeric probe, retain P-code, never execute it."""
from pathlib import Path
import hashlib,json,subprocess
from audit_decrement_semantics import method
from swf_inventory import abc_inventory,read_swf,walk_tags
ROOT=Path(__file__).resolve().parents[2]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 source=ROOT/'reverse/experiments/ordered-comparison';build=ROOT/'reverse/build/ordered-comparison/harness';build.mkdir(exist_ok=True)
 java=ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java';flex=ROOT/'.runtime/shared-tools/flex/apache-flex-sdk-4.16.1-bin';swf=build/'OrderedComparisonHarness.swf'
 commands=[[str(java),'-Djava.awt.headless=true',f'-Dflexlib={flex}/frameworks','-jar',str(flex/'lib/mxmlc.jar'),'-load-config=','-compiler.theme=',f'-compiler.external-library-path={ROOT}/.runtime/shared-tools/ffdec/flashlib/playerglobal32_0.swc','-compiler.library-path=',f'-compiler.source-path={source}','-target-player=32.0','-use-network=false','-debug=false',f'-output={swf}',str(source/'OrderedComparisonHarness.as')],[str(java),'-Djava.awt.headless=true','-jar',str(ROOT/'.runtime/shared-tools/ffdec/ffdec.jar'),'-format','script:pcode','-export','script',str(build/'pcode'),str(swf)]]
 for label,cmd in zip(('compile','pcode'),commands):
  r=subprocess.run(cmd,capture_output=True,text=True,timeout=90);(build/(label+'.log')).write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout+r.stderr
 _,body,h=read_swf(swf);abcs=[abc_inventory(p[p.index(b'\0',4)+1:])for t,p in walk_tags(body,h['tag_start'])if t['code']==82]
 assert [c['name']for a in abcs for c in a['classes']]==['OrderedComparisonHarness']
 assert not {s for a in abcs for s in a['strings']}.intersection({'SharedObject','getLocal','Loader','URLLoader','URLRequest'})
 p=build/'pcode/scripts/OrderedComparisonHarness.pcode'
 methods={n:method(p,n)for n in ('originalGold','recoveredGold','originalActive','recoveredActive','originalStop','recoveredStop')}
 # Source !> must compile to an ordered > branch, not negated <=.
 assert any(r['code']=='greaterthan'for r in methods['originalGold']) and any(r['code'].startswith('iftrue ')for r in methods['originalGold'])
 assert not any(r['code'].startswith('ifnle ')for r in methods['originalGold'])
 assert any(r['code'].startswith('ifnle ')for r in methods['recoveredGold'])
 r={'schema':1,'source':str((source/'OrderedComparisonHarness.as').relative_to(ROOT)),'source_sha256':sha(source/'OrderedComparisonHarness.as'),'swf':str(swf.relative_to(ROOT)),'swf_sha256':sha(swf),'pcode_sha256':sha(p),'methods':methods,'commands':commands,'compiled':True,'runtime_tested':False,'no_save_or_network_api_strings':True,'expected_cases':15}
 (source/'harness-build.json').write_text(json.dumps(r,ensure_ascii=False,indent=2)+'\n');print(json.dumps({k:v for k,v in r.items()if k not in ('methods','commands')},indent=2))
if __name__=='__main__':main()
