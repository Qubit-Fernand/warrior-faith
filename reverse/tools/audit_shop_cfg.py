#!/usr/bin/env python3
"""Targeted CFG/call observations and finite shop models; never edits game source."""
from pathlib import Path
import collections,hashlib,json,re
from audit_decrement_semantics import method
ROOT=Path(__file__).resolve().parents[2]
BASE=ROOT/'reverse/build/shop-semantics'
TARGETS={
'com/hotpoint/braveManIII/views/suppliesShopPanel/SuppliesShopPanel':['setUp','setDown','buySuppliesByPlayerData','sellSupplies','sellSure'],
'com/hotpoint/braveManIII/views/equipShopPanel/EquipShopPanel':['buyEquipByPlayerData'],
'com/hotpoint/braveManIII/models/player/PlayerData':['payGold','addGold'],
'com/hotpoint/braveManIII/views/petPanel/PetPanel':['setFood','chuzhan','zhaohui'],
'com/hotpoint/braveManIII/models/pet/Pet':['setFood'],
'com/hotpoint/braveManIII/views/taskPanel/TaskData':['qzOk','isOldById'],
'src/Main':['JiaoYan','JiaoYan2']}
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def prop(line):
    m=re.search(r'Multiname\("([^"]+)"',line)or re.search(r'QName\(.*?,"([^"]+)"\)',line)
    return m[1]if m else '[runtime-name]'
def observations(rows):
    lines=[];labels={}
    for row in rows:
        s=row['code']
        if s.endswith(':'):labels[s[:-1]]=len(lines)
        else:lines.append(s)
    leaders={0}
    for i,s in enumerate(lines):
        if s.startswith(('if','jump ')):
            leaders.add(labels[s.split()[-1]])
            if i+1<len(lines):leaders.add(i+1)
        elif s.startswith(('return','throw'))and i+1<len(lines):leaders.add(i+1)
    leaders=sorted(leaders);blockof={i:n for n,start in enumerate(leaders)for i in range(start,leaders[n+1]if n+1<len(leaders)else len(lines))};blocks=[]
    for n,start in enumerate(leaders):
        part=lines[start:leaders[n+1]if n+1<len(leaders)else len(lines)];last=part[-1];op=last.split()[0]
        if op=='jump':edges=[blockof[labels[last.split()[-1]]]]
        elif op.startswith('if'):edges=[blockof[labels[last.split()[-1]]],n+1]
        elif op.startswith('return')or op=='throw':edges=[]
        else:edges=[n+1]if n+1<len(leaders)else[]
        calls=[]
        for s in part:
            if s.startswith(('callproperty ','callpropvoid ','constructprop ')):
                name=prop(s);argc=int(re.search(r',\s*(\d+)$',s)[1])
                if name not in ('int','Boolean','Number','String'):calls.append({'op':s.split()[0],'name':name,'argc':argc})
        blocks.append({'terminator':op if op.startswith(('if','jump','return'))or op=='throw'else'fallthrough','successors':edges,'non_conversion_calls':calls})
    return {'blocks':blocks,'opcode_counts':dict(collections.Counter(s.split()[0]for s in lines)),'first_line':rows[0]['line'],'last_line':rows[-1]['line']}
def buy(gold,request,space,unit,clamp):
    if gold<request*unit:return {'items':0,'cost':0,'message':'金币不足'}
    if space==0 or not clamp and space<request:return {'items':0,'cost':0,'message':'背包空间不足'}
    count=min(request,space)if clamp else request
    return {'items':max(count,0),'cost':max(count,0)*unit,'message':None}
def main():
    rows=[]
    for cls,names in TARGETS.items():
        paths={v:BASE/v/'scripts'/f'{cls}.pcode'for v in('original','rebuilt928e')}
        for name in names:
            o={v:observations(method(p,name))for v,p in paths.items()}
            rows.append({'class':cls.replace('/','.'),'method':name,'files':{v:{'path':str(p.relative_to(ROOT)),'sha256':sha(p)}for v,p in paths.items()},'observations':o,'branch_topology_equal':[{k:b[k]for k in('terminator','successors')}for b in o['original']['blocks']]==[{k:b[k]for k in('terminator','successors')}for b in o['rebuilt928e']['blocks']],'calls_by_block_equal':[b['non_conversion_calls']for b in o['original']['blocks']]==[b['non_conversion_calls']for b in o['rebuilt928e']['blocks']],'whole_method_equivalence_proven':False})
    # Independent bounded proof for the purchase-loop int32/Number divergence.
    loops=[]
    for initial in range(25):
        i=initial;f=float(initial);old=[];new=[]
        while i>0:old.append(i);i=((i-1+2**31)%2**32)-2**31
        while f>0:new.append(f);f-=1.0
        assert old==new;loops.append({'initial':initial,'iterations':len(old),'same_trace':True})
    examples=[{'gold':100,'request':2,'space':24,'unit':8,'clamp':True}, {'gold':16,'request':3,'space':2,'unit':8,'clamp':True}, {'gold':24,'request':3,'space':2,'unit':8,'clamp':True}, {'gold':24,'request':3,'space':0,'unit':8,'clamp':True}, {'gold':1000,'request':3,'space':2,'unit':9,'clamp':False}]
    report={'schema':'yzlr2-shop-cfg-v1','swfs':{'original':{'path':'3_L4399Main_gamefile.swf','sha256':sha(ROOT/'3_L4399Main_gamefile.swf')},'rebuilt':{'path':'reverse/build/main-probe/run-b062kbrm/normalized.swf','sha256':sha(ROOT/'reverse/build/main-probe/run-b062kbrm/normalized.swf')}},'methods':rows,'purchase_loop_bounded_cases':loops,'source_model_examples':[{'input':x,'expected':buy(**x)}for x in examples],'scope':'Exact branch topology and ordered non-builtin-conversion call names/arity per block only. Namespace identity, operands, aliasing and side effects not fully proven. Host numeric models are not AVM runtime results.','player_started':False,'save_accessed':False}
    (ROOT/'reverse/manifests/shop-cfg.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print(json.dumps([{'class':r['class'],'method':r['method'],'cfg':r['branch_topology_equal'],'calls':r['calls_by_block_equal']}for r in rows],ensure_ascii=False,indent=2))
if __name__=='__main__':main()
