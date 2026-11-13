#!/usr/bin/env python3
"""Install one declared start-only future-version compatibility fixture in empty slot7.

No new chapter completion is assigned; only version99 and an opaque preservation
sentinel are added. Exact new SO only, players must be quit, all occupied slots
are compared by AMF graph after round-trip, before/after backups retained.
"""
from datetime import datetime, timezone
import copy
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools'))
from sol import loads,dumps,graph,Obj,Arr
NAME='yzlr2_rebuild_epilogue_v2'

def main():
    import argparse
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--target',type=Path,required=True);a=ap.parse_args()
    target=a.target.expanduser().resolve()
    if target.name!=NAME+'.sol':raise ValueError('Unexpected target')
    if any(x.strip().endswith(('/Flash Player','/Flash Player Debugger')) for x in subprocess.check_output(['ps','-axo','comm='],text=True).splitlines()):raise ValueError('Quit every player first')
    source=(ROOT/'chapter/fixtures/归光之约-起点.sol').read_bytes()
    if hashlib.sha256(source).hexdigest()!='7f21943d9c500e3c7636ef6aaa76f1de24789f7506d5be21b2b9789abbade4dd':raise ValueError('Start fixture differs')
    sn,seed=loads(source);old=target.read_bytes();tn,current=loads(old)
    if sn!=NAME or tn!=NAME or current['slots'][6] is not None:raise ValueError('Unexpected store or occupied destination')
    before={i:graph(s) for i,s in enumerate(current['slots'].dense) if s is not None}
    role=copy.deepcopy(seed['slots'][0]);role['index']=6
    token=role['data']['logNameSave'];role['data']['logNameSave']=token[:5]+'6'+token[6:]
    role['title']='6.0·格式兼容 Lv85';role['displayName']='6.0·格式兼容';role['datetime']='2026-10-26 explicit version compatibility fixture'
    role['data']['fanChapterReturnLight']=Obj(fields={'version':99,'stage':0,'inChapter':False,'futureSentinel':Obj(fields={'text':'preserve-future-chapter-payload','values':Arr([17,'untouched',True])})})
    current['slots'][6]=role
    output=dumps(NAME,current);dn,decoded=loads(output)
    if dn!=NAME or graph(decoded)!=graph(current):raise ValueError('Round-trip differs')
    for i,g in before.items():
        if graph(decoded['slots'][i])!=g:raise ValueError('Existing role changed')
    stamp=datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S.%fZ')
    directory=ROOT/'chapter/evidence/private/checkpoints'/('future-role-'+stamp);directory.mkdir(exist_ok=False)
    (directory/'before.sol').write_bytes(old);(directory/'after.sol').write_bytes(output)
    temp=target.with_name(target.name+'.future-'+stamp)
    with temp.open('xb') as stream:stream.write(output);stream.flush();os.fsync(stream.fileno())
    if target.read_bytes()!=old:raise ValueError('Live store changed while preparing')
    os.replace(temp,target)
    if target.read_bytes()!=output:raise ValueError('Written store differs')
    receipt={'fixture':'future version99, zero completion','destination_slot':7,'preserved_slots':[i+1 for i in before],'after_sha256':hashlib.sha256(output).hexdigest()}
    (directory/'receipt.json').write_text(json.dumps(receipt,indent=2)+'\n');print(json.dumps({'directory':str(directory),**receipt},ensure_ascii=False))
if __name__=='__main__':main()
