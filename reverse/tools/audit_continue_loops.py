#!/usr/bin/env python3
"""Restricted actual-P-code fixtures for two misplaced-continue recoveries."""
from pathlib import Path
import json,hashlib,re,difflib
from audit_decrement_semantics import method
from audit_shop_cfg import prop
ROOT=Path(__file__).resolve().parents[2]
SPECS=[('com/hotpoint/braveManIII/views/setKeyPanel/SetKeyPanel','closeOk'),('com/hotpoint/braveManIII/models/achievement/Achievement','getIddo')]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def execute(rows,fixture):
 kind=fixture['kind'];keys=fixture.get('keys');state={'keyNum':16,'_map':('VT',fixture.get('map',1)),'_star':('VT',fixture.get('star',1)),'_tg':fixture.get('tg',True)}
 main={'player1':{'_keyArr':keys[0]},'player2':{'_keyArr':keys[1]}if keys[1]is not None else None}if kind=='keys'else{}
 local={0:state,1:0,2:1};stack=[];seen=set();pc=0;trace=[];calls=[];labels={r['code'][:-1]:i for i,r in enumerate(rows)if r['code'].endswith(':')}
 def get(o,n):
  if n=='length':assert type(o)is list;return len(o)
  return o[n]
 while True:
  signature=repr((pc,local,stack,calls))
  if signature in seen:return {'termination':'cycle','steps':len(trace),'db_calls':len(calls),'trace_tail':trace[-10:]}
  seen.add(signature);assert len(trace)<10000,'unsupported nonrepeating long path'
  r=rows[pc];s=r['code'];op=s.split()[0];trace.append(r);pc+=1
  if s.endswith(':')or op=='label':continue
  if op.startswith('getlocal'):n=int(s.split()[-1])if op=='getlocal'else int(op[-1]);stack.append(local[n])
  elif op.startswith('setlocal'):n=int(s.split()[-1])if op=='setlocal'else int(op[-1]);local[n]=stack.pop()
  elif op=='pushscope':stack.pop()
  elif op in ('pushbyte','pushshort','pushint'):stack.append(int(s.split()[-1]))
  elif op=='pushtrue':stack.append(True)
  elif op=='pushfalse':stack.append(False)
  elif op=='pushnull':stack.append(None)
  elif op=='getlex':
   n=prop(s);stack.append(main if n=='Main'else'Array'if n=='Array'else state[n])
  elif op=='findpropstrict':assert prop(s)in ('getGoodsId','getTs','isRy','dbNum');stack.append(state)
  elif op=='getproperty':
   if 'MultinameL('in s:n=stack.pop();o=stack.pop();stack.append(o[n])
   else:stack.append(get(stack.pop(),prop(s)))
  elif op=='callproperty':
   n=prop(s);argc=int(re.search(r',\s*(\d+)$',s)[1]);args=[stack.pop()for _ in range(argc)][::-1];receiver=stack.pop()
   if n=='getValue':assert isinstance(receiver,tuple)and receiver[0]=='VT';value=receiver[1]
   elif n=='getGoodsId':assert receiver is state;value=[('VT',n)for n in fixture['goods']]
   elif n=='getTs':assert receiver is state;value=fixture.get('ts',1)
   elif n=='isRy':assert receiver is state;value=fixture.get('ry',False)
   elif n=='dbNum':assert receiver is state;calls.append(args);value=fixture.get('db_result',True)
   else:raise AssertionError(s)
   stack.append(value)
  elif op=='astypelate':assert stack.pop()=='Array'and type(stack[-1])is list
  elif op=='coerce':assert prop(s)=='Array'and type(stack[-1])is list,s
  elif op=='convert_u':a=stack.pop();assert type(a)in(int,float)and a>=0 and int(a)==a;stack.append(int(a)%2**32)
  elif op=='convert_d':assert type(stack[-1])in(int,float);stack[-1]=float(stack[-1])
  elif op=='increment':a=stack.pop();assert type(a)in(int,float);stack.append(a+1)
  elif op=='inclocal':n=int(s.split()[-1]);assert type(local[n])in(int,float);local[n]+=1
  elif op=='dup':stack.append(stack[-1])
  elif op=='pop':stack.pop()
  elif op=='equals':b=stack.pop();a=stack.pop();stack.append(a==b)
  elif op in ('ifeq','ifne','iflt','ifnlt'):
   b=stack.pop();a=stack.pop();take={'ifeq':lambda:a==b,'ifne':lambda:a!=b,'iflt':lambda:a<b,'ifnlt':lambda:not(a<b)}[op]()
   if take:pc=labels[s.split()[-1]]
  elif op in ('iftrue','iffalse'):
   a=stack.pop();assert type(a)is bool
   if a==(op=='iftrue'):pc=labels[s.split()[-1]]
  elif op=='jump':pc=labels[s.split()[-1]]
  elif op=='returnvalue':return {'termination':'return','value':stack.pop(),'steps':len(trace),'db_calls':len(calls),'trace_tail':trace[-10:]}
  else:raise AssertionError('unsupported executed instruction '+s)
def main():
 cases=[]
 for p2 in (False,True):
  for missing in (None,0,15):
   for who in ((0,1)if p2 else(0,)):
    keys=[[65]*16,[66]*16 if p2 else None]
    if missing is not None:keys[who][missing]=-1
    cases.append({'kind':'keys','keys':keys,'expected':missing is None})
 achievements=[{'kind':'achievement','goods':[1,2],'map':m,'ry':r,'tg':t,'expected':m in(1,2)and(r or t)}for m in(1,2,3)for r,t in((True,False),(False,True),(False,False))]
 results=[]
 for cls,name in SPECS:
  paths={v:ROOT/base/(cls+'.pcode')for v,base in [('original','reverse/build/ordered-comparison/original/scripts'),('rebuilt928e','reverse/build/main-repeat-pcode/run-b062kbrm/scripts')]};code={v:method(p,name)for v,p in paths.items()};fixtures=[]
  for fixture in cases if name=='closeOk'else achievements:
   out={v:execute(rows,fixture)for v,rows in code.items()};assert out['original']['termination']=='return'and out['original']['value']==fixture['expected']
   fixtures.append({'fixture':fixture,'results':out})
  results.append({'class':cls.replace('/','.'),'method':name,'inputs':{v:{'path':str(p.relative_to(ROOT)),'sha256':sha(p)}for v,p in paths.items()},'method_code':code,'fixtures':fixtures})
 report={'schema':1,'scope':'Restricted interpreter over actual method P-code; only whitelisted opcodes and explicit fixture getters/dbNum stub supported. No whole-method or runtime equivalence claim.','methods':results,'no_ui_or_save_access':True}
 (ROOT/'reverse/manifests/continue-loops.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print([(x['method'],len(x['fixtures']),sum(r['results']['rebuilt928e']['termination']=='cycle'for r in x['fixtures']))for x in results])
if __name__=='__main__':main()
