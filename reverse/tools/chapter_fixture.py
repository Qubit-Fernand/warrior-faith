#!/usr/bin/env python3
"""Prepare explicit start-only test roles from the deliberate repository preset.

Never reads or rewrites original/final/reconstruction live saves. Installation
requires the exact new chapter SOL to exist with only empty title-screen slots.
"""
import argparse
import copy
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import xml.etree.ElementTree as ET

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools'))
from sol import Arr,Obj,loads,dumps,graph
from create_graduate_save import vt,equip

SAVE='yzlr2_rebuild_epilogue_v2'
OUT=ROOT/'chapter/fixtures'

def build():
    original=ROOT/'presets/毕业体验档.sol'
    raw=original.read_bytes();_,fields=loads(raw)
    source=next(s for s in fields['slots'].dense if s is not None)
    db=json.loads((ROOT/'tools/graduate-data.json').read_text())
    tasks=ET.fromstring((ROOT/'chapter/content/main-tasks.xml').read_bytes())
    main=[t for t in tasks.findall('任务') if '【主线' in t.findtext('名称','')]
    assert len(main)==70
    slots=[]
    for index,multiplier in enumerate([1,10]):
        role=copy.deepcopy(source);data=role['data'];player=data['p1']
        token=data['logNameSave'];assert len(token)==14
        data['logNameSave']=token[:5]+str(index)+token[6:]
        data['P1P2']=False;data['p2']=None;data['TaskDataBoXX5']=True
        data.fields.pop('fanChapterReturnLight',None)
        player['gold']=vt(10000)
        template=player['equipSlot']['slot'][0]
        for i,item in enumerate([13526,13426,14113,13726,13626,14213]):
            player['equipSlot']['slot'][i]=equip(template,item,db['equipment'],multiplier)
        # Legitimate declared *starting* checkpoint: old main story submitted.
        # No new chapter acceptance, victory, ending, reward or progress is set.
        quest=data['RenWu']
        for task in main:
            taskid=task.findtext('ID')
            goods=len(task.findtext('完成条件/物品ID','-1').split(','))
            enemies=len(task.findtext('完成条件/怪物ID','-1').split(','))
            record=Arr([0,1,Arr([vt(0) for _ in range(goods)]),Arr([vt(0) for _ in range(enemies)]),0])
            if len(quest.dense)>int(taskid):quest.dense[int(taskid)]=record
            else:quest.assoc[taskid]=record
        role['index']=index
        role['title']='P1:Lv85 归光起点 · '+('正常属性' if multiplier==1 else '毕业体验')
        role['datetime']='2026-10-25 explicit chapter start fixture'
        assert player['equipSlot']['who'] is player
        slots.append(role)
    fields['slots']=Arr(slots+[None]*6)
    output=dumps(SAVE,fields);decoded_name,decoded=loads(output)
    assert decoded_name==SAVE and graph(fields)==graph(decoded)
    OUT.mkdir(parents=True,exist_ok=True)
    path=OUT/'归光之约-起点.sol'
    if path.exists():assert path.read_bytes()==output,'Existing fixture differs; preserve it before changing recipe'
    else:path.write_bytes(output)
    receipt={'source_preset_sha256':hashlib.sha256(raw).hexdigest(),
        'fixture_sha256':hashlib.sha256(output).hexdigest(),'shared_object':SAVE,
        'starting_condition':'70 original main quests submitted; zero new chapter progress',
        'roles':[{'slot':1,'level':85,'item_base_multiplier':1},{'slot':2,'level':85,'item_base_multiplier':10}],
        'new_chapter_completion_set':False}
    (OUT/'receipt.json').write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n')
    return path,output,receipt

def install(path,output,target):
    assert target.name==SAVE+'.sol'
    assert target.is_file(),'First launch isolated title screen to create the test SO'
    players=subprocess.check_output(['ps','-axo','comm='],text=True)
    assert not any(x.strip().endswith(('/Flash Player','/Flash Player Debugger')) for x in players.splitlines()),'Quit all Flash players first'
    old=target.read_bytes();name,fields=loads(old)
    assert name==SAVE and all(s is None for s in fields['slots'].dense),'Only an empty title-screen test store can be seeded'
    backup=OUT/'empty-title-before-install.sol'
    assert not backup.exists(),'Already installed once; do not overwrite progress'
    backup.write_bytes(old)
    temp=target.with_suffix('.sol.fixture-tmp');assert not temp.exists()
    temp.write_bytes(output);os.replace(temp,target)
    assert target.read_bytes()==path.read_bytes()

if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--install',type=Path)
    args=parser.parse_args();path,output,receipt=build()
    if args.install:install(path,output,args.install)
    print(json.dumps({'fixture':str(path),'installed':bool(args.install),**receipt},ensure_ascii=False,indent=2))
