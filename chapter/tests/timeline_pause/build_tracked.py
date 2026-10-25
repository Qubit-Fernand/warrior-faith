#!/usr/bin/env python3
"""Compile the isolated SWF9 tracked native timeline fixture, never execute Flash."""
from datetime import datetime,timezone
from pathlib import Path
import hashlib,json,shutil,struct,subprocess
from build import ROOT,HERE,sha,tag,raw_swf

generation=datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S.%fZ')
out=ROOT/'reverse/build/chapter-timeline-pause'/('tracked-'+generation)
source=out/'source';shutil.copytree(HERE/'tracked-src',source)
(source/'timelineprobe/BuildInfo.as').write_text('package timelineprobe {public class BuildInfo {public static const GENERATION:String='+json.dumps(generation)+';}}\n')
java=ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'
flex=ROOT/'.runtime/shared-tools/flex/apache-flex-sdk-4.16.1-bin'
player=ROOT/'.runtime/shared-tools/ffdec/flashlib/playerglobal32_0.swc'
target=out/'TrackedHost9.swf'
a=[str(java),'-Djava.awt.headless=true',f'-Dflexlib={flex}/frameworks','-jar',str(flex/'lib/mxmlc.jar'),'-load-config=','-compiler.theme=',f'-compiler.external-library-path={player}',f'-compiler.source-path={source}','-compiler.strict=true','-target-player=32.0','-swf-version=9','-use-network=false','-debug=false','-default-size=940,580','-default-frame-rate=27',f'-output={target}',str(source/'TrackedHost.as')]
r=subprocess.run(a,capture_output=True,text=True,timeout=90);(out/'compile.log').write_text(r.stdout+r.stderr)
if r.returncode:raise RuntimeError(r.stdout+r.stderr)
raw,body=raw_swf(target);pos=(5+4*(body[0]>>3)+7)//8+4
while pos<len(body):
 at=pos;h=struct.unpack_from('<H',body,pos)[0];pos+=2;code=h>>6;size=h&63
 if size==63:size=struct.unpack_from('<I',body,pos)[0];pos+=4
 if code==1:break
 pos+=size
assert code==1
injected=b''
for n,cl in [(60000,'timelineprobe.TrackedProbe'),(60001,'timelineprobe.NativeProbe')]:
 timeline=tag(43,b'known\0')+tag(1)+tag(1)+tag(1)+tag(1)+tag(0)
 injected+=tag(39,struct.pack('<HH',n,4)+timeline)+tag(76,struct.pack('<HH',1,n)+cl.encode()+b'\0')
body=body[:at]+injected+body[at:];target.write_bytes(b'FWS'+bytes([9])+struct.pack('<I',len(body)+8)+body)
receipt={'generation':generation,'runtime_executed':False,'compiled':True,'host_version':9,'command':a,'output_sha256':sha(target.read_bytes()),'compiled_input_sha256':sha(raw),'fixture_sha256':sha(injected),'sources':{str(p.relative_to(source)):sha(p.read_bytes()) for p in source.rglob('*.as')},'diagnostic_SO':'yzlr2_timeline_tracked_probe_v1'}
(out/'receipt.json').write_text(json.dumps(receipt,indent=2)+'\n');print(json.dumps({'entry':str(target),'receipt':str(out/'receipt.json'),'sha256':receipt['output_sha256']},indent=2))
