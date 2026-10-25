#!/usr/bin/env python3
"""Read-only task graph/configuration/event-call audit. No player or save access."""
from pathlib import Path
from collections import Counter
import datetime, hashlib, json, re, xml.etree.ElementTree as ET
from swf_inventory import read_swf, walk_tags

ROOT = Path(__file__).resolve().parents[2]
MAIN = ROOT/'reverse/source/3_L4399Main_gamefile'
TASK = MAIN/'com/hotpoint/braveManIII/views/taskPanel/TaskData.as'
XML = ROOT/'reverse/exports/3_L4399Main_gamefile/scripts/_assets/8632_src.Data2_taskData.bin'
DATA = MAIN/'src/_data/Data2_data.as'

def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest()
def locate(path, text, needle):
    offset = text.index(needle)
    return {'path':str(path.relative_to(ROOT)), 'line':text.count('\n',0,offset)+1}
def ints(node, key): return [int(x.strip()) for x in node.findtext(key).split(',')]
def main():
    data = DATA.read_text(); task_text = TASK.read_text(); xml_text = XML.read_text()
    original=ROOT/'3_L4399Main_gamefile.swf'
    _,body,header=read_swf(original)
    task_payloads=[payload[6:] for tag,payload in walk_tags(body,header['tag_start']) if tag['code']==87 and int.from_bytes(payload[:2],'little')==8632]
    assert len(task_payloads)==1 and task_payloads[0]==XML.read_bytes(), 'Task asset must match original DefineBinaryData 8632'
    tasks = ET.fromstring(xml_text).findall('任务')
    ids = [int(t.findtext('ID')) for t in tasks]; table = dict(zip(ids,tasks))
    arrays = {}
    for match in re.finditer(r'(GameData\.GameDataXmlArr|Enemy\.EnemyXmlArr)\[(\d+)\]\s*=\s*(<root>.*?</root>)\s*;', data, re.S):
        key = match[1].split('.')[1]
        arrays.setdefault(key,{})[int(match[2])] = ET.fromstring(match[3])
    assert set(arrays)=={'GameDataXmlArr','EnemyXmlArr'}
    assert all(set(v)=={1,2,3,4} for v in arrays.values())
    enemies = {level:{int(x.findtext('ID')) for x in tree.findall('怪物')} for level,tree in arrays['EnemyXmlArr'].items()}
    maps = {level:{int(x.findtext('大关')) for x in tree.findall('关卡')} for level,tree in arrays['GameDataXmlArr'].items()}
    issues=[]; edges={}; rows=[]
    for identity,t in zip(ids,tasks):
        before=int(t.findtext('出现任务条件/前置任务ID')); edges[identity]=before
        condition=t.find('完成条件'); enemy=ints(condition,'怪物ID'); counts=ints(condition,'怪物数量')
        goods=ints(condition,'物品ID'); goods_counts=ints(condition,'物品数量')
        awards=[ints(t,'奖励/'+k) for k in ('奖励类型','奖励id','奖励数量','奖励概率')]
        row={'id':identity,'name':t.findtext('名称'),'prerequisite':before,'type':[int(t.findtext(k)) for k in ('大类型','小类型')], 'map':int(condition.findtext('地图ID')),'star':int(condition.findtext('地图星级')),'enemy':enemy,'goods':goods, 'provenance':locate(XML,xml_text,'<ID>'+str(identity)+'</ID>')}
        rows.append(row)
        if before!=-1 and before not in table:issues.append({'kind':'missing_prerequisite','id':identity,'target':before})
        for kind,values in [('enemy_parallel_lengths',[enemy,counts]),('goods_parallel_lengths',[goods,goods_counts]),('award_parallel_lengths',awards)]:
            if len(set(map(len,values)))!=1:issues.append({'kind':kind,'id':identity,'lengths':list(map(len,values))})
        applicable=[row['star']] if row['star'] in enemies else list(enemies)
        for enemy_id in enemy:
            if enemy_id!=-1 and not any(enemy_id in enemies[level] for level in applicable):issues.append({'kind':'enemy_missing_in_applicable_config','id':identity,'enemy':enemy_id,'stars':applicable})
        if row['map']!=-1 and not any(row['map'] in maps[level] for level in applicable):issues.append({'kind':'map_missing_in_applicable_config','id':identity,'map':row['map'],'stars':applicable})
    cycles=set()
    for start in ids:
        chain=[];at=start
        while at in edges and at not in chain:chain.append(at);at=edges[at]
        if at in chain:
            cycle=chain[chain.index(at):];first=cycle.index(min(cycle));cycles.add(tuple(cycle[first:]+cycle[:first]))
    methods=set(re.findall(r'(?:public|private) static function (\w+)\(',task_text))
    calls=[]; inputs={str(p.relative_to(ROOT)):sha(p) for p in (XML,DATA,TASK)}
    for path in sorted(MAIN.rglob('*.as')):
        source=path.read_text()
        for match in re.finditer(r'\bTaskData\.(\w+)\s*\(',source):
            calls.append({'method':match[1],'path':str(path.relative_to(ROOT)),'line':source.count('\n',0,match.start())+1,'declared':match[1] in methods});inputs[str(path.relative_to(ROOT))]=sha(path)
    missing_calls=[r for r in calls if not r['declared']]
    report={'schema':'yzlr2-task-integrity-v1','utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'inputs':inputs,'original_task_asset':{'swf_sha256':sha(original),'character_id':8632,'payload_sha256':sha(XML),'exact_payload_match':True},'task_count':len(tasks),'duplicate_ids':[i for i,n in Counter(ids).items() if n>1],'prerequisite_cycles':[list(c) for c in sorted(cycles)],'configuration_issues':issues,'taskdata_call_count':len(calls),'missing_taskdata_methods':missing_calls,'calls':calls,'tasks':rows,'config_ids':{'enemies':{str(k):sorted(v) for k,v in enemies.items()},'maps':{str(k):sorted(v) for k,v in maps.items()}},'scope':['Checks main-module direct literal TaskData calls, not dynamic dispatch or resource-module copies.','Checks task references against parsed embedded map/enemy XML; presence does not establish playability or reachability.','Does not infer reward item types, runtime completion, save compatibility, or all conditions semantically effective.','Baseline issues are reported, never silently repaired.'], 'player_started':False,'save_accessed':False}
    out=ROOT/'reverse/manifests/task-integrity.json';out.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:report[k] for k in ('task_count','duplicate_ids','prerequisite_cycles','configuration_issues','taskdata_call_count','missing_taskdata_methods')},ensure_ascii=False,indent=2))
if __name__=='__main__': main()
