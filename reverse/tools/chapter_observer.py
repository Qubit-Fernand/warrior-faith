#!/usr/bin/env python3
"""Build/install passive chapter diagnostics; does not start a player."""
import argparse,hashlib,json,shutil,subprocess,sys
from pathlib import Path
from diagnostic_harness import validate_package
from build_main import preserve_original_swf_version
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools'))
from sol import loads
NAME='yzlr2_rebuild_epilogue_diag_v2'

def build():
    out=ROOT/'reverse/build/chapter-observer';out.mkdir(exist_ok=True)
    java=ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'
    flex=ROOT/'.runtime/shared-tools/flex/apache-flex-sdk-4.16.1-bin'
    player=ROOT/'.runtime/shared-tools/ffdec/flashlib/playerglobal32_0.swc'
    source=ROOT/'chapter/observer/Source.as';target=out/'ChapterObserver.swf'
    command=[str(java),'-Djava.awt.headless=true',f'-Dflexlib={flex}/frameworks','-jar',str(flex/'lib/mxmlc.jar'),
        '-load-config=','-compiler.theme=',f'-compiler.external-library-path={player}',
        f'-compiler.source-path={source.parent}','-target-player=32.0','-use-network=false','-debug=false',
        '-compiler.omit-trace-statements=false',f'-output={target}',str(source)]
    result=subprocess.run(command,capture_output=True,text=True,timeout=90)
    (out/'compile.log').write_text(result.stdout+result.stderr)
    assert result.returncode==0,result.stdout+result.stderr
    version_receipt=preserve_original_swf_version(target,ROOT/'3_L4399Main_gamefile.swf')
    receipt={'swf_version_compatibility':version_receipt,'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
        'output_sha256':hashlib.sha256(target.read_bytes()).hexdigest(),'command':command,
        'diagnostic_SO':NAME,'mode':'SWF9 passive observer wrapper; not direct game acceptance'}
    (out/'receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
    return target,receipt

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('action',choices=['build','install','read']);ap.add_argument('path',type=Path,nargs='?');a=ap.parse_args()
    if a.action=='read':
        assert a.path.name in (NAME+'.sol',NAME[3:]+'.sol') and a.path.stat().st_size<400000
        name,fields=loads(a.path.read_bytes());assert name==NAME
        report=json.loads(fields['payload']);samples=report['samples']
        print(json.dumps({'errors':report['errors'],'latest':samples[-1] if samples else None},ensure_ascii=False,indent=2))
    else:
        target,receipt=build()
        if a.action=='install':
            directory,_,save_name,assembly=validate_package(a.path);assert save_name=='yzlr2_rebuild_epilogue_v2'
            shutil.copy2(target,directory/target.name)
            (directory/'chapter-observer.json').write_text(json.dumps({**receipt,'assembly_sha256':assembly},indent=2)+'\n')
        print(json.dumps({'output':str(target),'installed':a.action=='install',**receipt},ensure_ascii=False,indent=2))
