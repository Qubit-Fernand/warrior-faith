#!/usr/bin/env python3
"""Compile and inspect a no-save arithmetic probe; never starts a player."""
from pathlib import Path
import hashlib,json,subprocess
from audit_decrement_semantics import method,op
from swf_inventory import abc_inventory,read_swf,walk_tags
ROOT=Path(__file__).resolve().parents[2]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    source=ROOT/'reverse/experiments/decrement-harness';build=ROOT/'reverse/build/decrement-harness';build.mkdir(exist_ok=True)
    java=ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java';flex=ROOT/'.runtime/shared-tools/flex/apache-flex-sdk-4.16.1-bin';swf=build/'DecrementHarness.swf'
    compile=[str(java),'-Djava.awt.headless=true',f'-Dflexlib={flex}/frameworks','-jar',str(flex/'lib/mxmlc.jar'),'-load-config=','-compiler.theme=',f'-compiler.external-library-path={ROOT}/.runtime/shared-tools/ffdec/flashlib/playerglobal32_0.swc','-compiler.library-path=',f'-compiler.source-path={source}','-target-player=32.0','-use-network=false','-debug=false',f'-output={swf}',str(source/'DecrementHarness.as')]
    export=[str(java),'-Djava.awt.headless=true','-jar',str(ROOT/'.runtime/shared-tools/ffdec/ffdec.jar'),'-format','script:pcode','-export','script',str(build/'pcode'),str(swf)]
    for name,command in [('compile',compile),('pcode',export)]:
        r=subprocess.run(command,capture_output=True,text=True,timeout=90);(build/(name+'.log')).write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout+r.stderr
    _,body,header=read_swf(swf);abcs=[abc_inventory(p[p.index(b'\0',4)+1:])for t,p in walk_tags(body,header['tag_start'])if t['code']==82]
    assert [c['name']for a in abcs for c in a['classes']]==['DecrementHarness']
    strings={s for a in abcs for s in a['strings']};assert not strings.intersection({'SharedObject','getLocal','Loader','URLLoader','URLRequest'})
    pcode=build/'pcode/scripts/DecrementHarness.pcode';a=method(pcode,'subtractOne');b=method(pcode,'decrementOne')
    assert sum(op(x)=='subtract'for x in a)==1 and not any(op(x).startswith('decrement')for x in a)
    assert sum(op(x)=='decrement'for x in b)==1 and not any(op(x)in ('subtract','decrement_i')for x in b)
    report={'source_sha256':sha(source/'DecrementHarness.as'),'swf_sha256':sha(swf),'swf':str(swf.relative_to(ROOT)),'commands':[compile,export],'pcode_sha256':sha(pcode),'subtract_code':a,'decrement_code':b,'only_probe_class':True,'save_or_network_api_strings':False,'compiled':True,'runtime_tested':False}
    (source/'build.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print(json.dumps({k:v for k,v in report.items()if k not in ('commands','subtract_code','decrement_code')},indent=2))
if __name__=='__main__':main()
