#!/usr/bin/env python3
"""Build only isolated SWF9/SWF14 timeline probes; never executes Flash."""
from datetime import datetime, timezone
from pathlib import Path
import hashlib, json, shutil, struct, subprocess, zlib

ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent

def sha(b):return hashlib.sha256(b).hexdigest()
def tag(code,payload=b''):
    size=len(payload)
    return struct.pack('<H',(code<<6)|(size if size<63 else 63))+(b'' if size<63 else struct.pack('<I',size))+payload

def raw_swf(path):
    raw=path.read_bytes()
    assert raw[:3] in (b'FWS',b'CWS')
    body=zlib.decompress(raw[8:]) if raw[:3]==b'CWS' else raw[8:]
    assert len(body)+8==struct.unpack_from('<I',raw,4)[0]
    return raw,body

def author_probe_timeline(path):
    raw,body=raw_swf(path)
    rect_bytes=(5+4*(body[0]>>3)+7)//8
    start=rect_bytes+4
    pos=start;insert=None;used=[]
    while pos<len(body):
        at=pos;h=struct.unpack_from('<H',body,pos)[0];pos+=2
        code=h>>6;size=h&63
        if size==63:size=struct.unpack_from('<I',body,pos)[0];pos+=4
        payload=body[pos:pos+size];pos+=size
        if code==39:used.append(struct.unpack_from('<H',payload)[0])
        if code==1 and insert is None:insert=at
        if code==0:break
    assert insert is not None and 60000 not in used
    timeline=tag(43,b'known\0')+tag(1)+tag(1)+tag(1)+tag(1)+tag(0)
    sprite=tag(39,struct.pack('<HH',60000,4)+timeline)
    symbol=tag(76,struct.pack('<HH',1,60000)+b'timelineprobe.ProbeClip\0')
    body=body[:insert]+sprite+symbol+body[insert:]
    output=b'FWS'+bytes([9])+struct.pack('<I',len(body)+8)+body
    path.write_bytes(output)
    return {'method':'new hand-authored DefineSprite, not copied game assets','character_id':60000,
            'class':'timelineprobe.ProbeClip','frames':4,'frame1_label':'known',
            'compiled_input_sha256':sha(raw),'authored_sprite_sha256':sha(sprite),
            'symbol_class_sha256':sha(symbol),'final_sha256':sha(output)}

def build():
    generation=datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S.%fZ')
    out=ROOT/'reverse/build/chapter-timeline-pause'/('run-'+generation)
    source=out/'source';shutil.copytree(HERE/'src',source)
    (source/'timelineprobe/BuildInfo.as').write_text('package timelineprobe {public class BuildInfo {public static const GENERATION:String='+json.dumps(generation)+';}}\n')
    java=ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'
    flex=ROOT/'.runtime/shared-tools/flex/apache-flex-sdk-4.16.1-bin'
    player=ROOT/'.runtime/shared-tools/ffdec/flashlib/playerglobal32_0.swc'
    commands=[];results=[]
    for name,version,entry in [('TimelineHelper14',14,'TimelineHelper'),('TimelinePauseHost9',9,'TimelinePauseHost')]:
        target=out/(name+'.swf')
        command=[str(java),'-Djava.awt.headless=true',f'-Dflexlib={flex}/frameworks','-jar',str(flex/'lib/mxmlc.jar'),
            '-load-config=','-compiler.theme=',f'-compiler.external-library-path={player}',f'-compiler.source-path={source}',
            '-compiler.strict=true','-target-player=32.0',f'-swf-version={version}','-use-network=false','-debug=false',
            '-default-size=940,580','-default-frame-rate=27','-compiler.omit-trace-statements=false',f'-output={target}',str(source/(entry+'.as'))]
        r=subprocess.run(command,capture_output=True,text=True,timeout=90)
        (out/(name+'.compile.log')).write_text(r.stdout+r.stderr)
        commands.append(command);results.append({'name':name,'exit':r.returncode})
        if r.returncode:raise RuntimeError(r.stdout+r.stderr)
        assert target.read_bytes()[3]==version,('wrong SWF version',name,target.read_bytes()[3])
    fixture=author_probe_timeline(out/'TimelinePauseHost9.swf')
    receipt={'schema':1,'generation':generation,'runtime_executed':False,'compiled':True,'commands':commands,'compiler_results':results,
        'host_version':9,'helper_version':14,'loading':'child ApplicationDomain(parent=currentDomain)',
        'diagnostic_SO':'yzlr2_timeline_helper_probe_v1','game_SO_access':False,'game_source_modified':False,
        'fixture':fixture,'outputs':{p.name:sha(p.read_bytes()) for p in out.glob('*.swf')},
        'sources':{str(p.relative_to(source)):sha(p.read_bytes()) for p in source.rglob('*.as')},'build_script_sha256':sha(Path(__file__).read_bytes())}
    (out/'receipt.json').write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({'compiled':True,'runtime_executed':False,'entry':str(out/'TimelinePauseHost9.swf'),'helper':str(out/'TimelineHelper14.swf'),'receipt':str(out/'receipt.json')},indent=2))
if __name__=='__main__':build()
