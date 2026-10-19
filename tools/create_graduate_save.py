#!/usr/bin/env python3
"""Create a reversible local experience slot. Never replaces an occupied slot."""
import argparse, copy, datetime, hashlib, json, os, subprocess
from pathlib import Path
from sol import Arr, Obj, loads, dumps, graph
ROOT=Path(__file__).resolve().parent.parent

def obj(name, **fields):return Obj(name,tuple(fields),False,fields)
def vt(n):return obj('VT',value=Obj(fields={'random':0,'num':n}))
def attr(t,n,c=1):return obj('EquipBaseAttrib',colorType=vt(c),value=vt(n),attribType=vt(t))
def equip(template,identifier,db,multiplier):
    e=copy.deepcopy(template);d=db[str(identifier)];e['base']=vt(identifier);e['gemGrid']=vt(1)
    a=[]
    for k,t in [('生命',1),('魔法',2),('攻击',3),('防御',4),('魔抗',9),('破魔',10)]:
        x=d['固定属性'][k]
        if x!='null':a.append(attr(t,int(x)*multiplier))
    for k,t in [('附加攻击',3),('附加暴击',5)]:
        x=d['随机属性'][k]
        if x!='null':a.append(attr(t,int(x),3))
    e['baseAttrib']=Arr(a);e['skillAttrib']=vt(int(d['装备特性']))
    e['reinforceAttrib']=obj('EquipReinforce',level=vt(10),attribValues=vt(d['强化值']),attribType=vt({1:2,2:1,3:6,4:5,5:3,6:3,7:3}[int(d['部位'])]))
    e['gemSlot']=None;e['blessAttrib']=None;e['newSkill']=vt(0);e['remainingTime']=vt(1)
    return e

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('save',type=Path);ap.add_argument('--source-slot',type=int,default=8);ap.add_argument('--target-slot',type=int,default=1)
    ap.add_argument('--stat-multiplier',type=int,default=10,choices=[1,10],help='10 = custom experience stats; 1 = original item stats')
    ap.add_argument('--apply',action='store_true');args=ap.parse_args()
    if not(1<=args.source_slot<=8 and 1<=args.target_slot<=8):ap.error('slots must be 1..8')
    if args.apply and any(line.strip().endswith('/Flash Player') for line in subprocess.check_output(['ps','-axo','comm'],text=True).splitlines()):ap.error('Quit Flash Player before applying')
    raw=args.save.read_bytes();name,f=loads(raw);slots=f['slots'];source=args.source_slot-1;target=args.target_slot-1
    if slots[target] is not None:ap.error('Target slot is occupied; choose an empty slot')
    if slots[source] is None:ap.error('Source slot is empty')
    baseline=[graph(x) for x in slots.dense];s=copy.deepcopy(slots[source]);d=s['data'];p=d['p1']
    db=json.loads((ROOT/'tools/graduate-data.json').read_text())
    # Offline MD5contrast embeds the zero-based slot number at character 5.
    token=d['logNameSave']
    if len(token)==14:d['logNameSave']=token[:5]+str(target)+token[6:]
    else:raise ValueError('Unexpected offline slot token format')
    p['level']=vt(85);p['Exp']=vt(0);p['gold']=vt(9999999);p['killPoint']=vt(999999);p['points']=vt(999)
    p['rebirth']=p['_rebirth']=True
    p['transferArr']=p['_transferArr']=Arr([True,True,False])
    p['pickSkillArr']=p['_pickSkillArr']=Arr([True,True,False])
    for a in p['skillArr'].dense:
        if a[0][0] in 'abd':a[1]=db['skill_max'].get(a[0],a[1])
    template=p['equipSlot']['slot'][0]
    for i,k in enumerate([13526,13426,14113,13726,13626,14213]):p['equipSlot']['slot'][i]=equip(template,k,db['equipment'],args.stat_multiplier)
    assert p['equipSlot']['who'] is p
    for k in db['maps']:d['guanKa'][k]=3
    for q in d['questArr'].dense:q[0]=True
    d['Map0_YN']=d['Map0_YN2']=True
    s['index']=target;s['title']='P1:Lv85 毕业体验';s['datetime']=datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S');slots[target]=s
    output=dumps(name,f);_,checked=loads(output)
    assert graph(f)==graph(checked),'Roundtrip graph mismatch'
    assert all(graph(checked['slots'][i])==baseline[i] for i in range(8) if i!=target),'Other slot changed'
    directory=ROOT/'save-backups'/(datetime.datetime.now().strftime('%Y%m%d-%H%M%S')+'-graduate')
    directory.mkdir(parents=True,exist_ok=False)
    (directory/'before.sol').write_bytes(raw);(directory/'graduate.sol').write_bytes(output)
    receipt={'original_sha256':hashlib.sha256(raw).hexdigest(),'output_sha256':hashlib.sha256(output).hexdigest(),'source':str(args.save),'source_slot':source+1,'target_slot':target+1,'stat_multiplier':args.stat_multiplier,'applied':args.apply}
    (directory/'receipt.json').write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n')
    if args.apply:
        assert args.save.read_bytes()==raw,'Save changed while preparing'
        tmp=args.save.with_suffix('.sol.graduate-tmp');tmp.write_bytes(output);os.replace(tmp,args.save)
    print(json.dumps({'backup':str(directory),'applied':args.apply,'bytes':len(output)},ensure_ascii=False))
if __name__=='__main__':main()
