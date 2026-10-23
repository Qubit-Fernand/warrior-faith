#!/usr/bin/env python3
"""Execute the restricted, actual P-code nonstacking path with finite fixtures.

Not an AVM2 emulator: only whitelisted instructions on this path are supported;
unknown instructions/calls fail closed. No SWF is executed and no save is read.
"""
from pathlib import Path
import re,json,hashlib,difflib
from audit_decrement_semantics import method
from audit_shop_cfg import prop
ROOT=Path(__file__).resolve().parents[2]
SPECS=[('Bag','isGemBagEmpty','_gemBag',24,False),('Bag','addGemBag','_gemBag',24,True),('Bag','addOtherobjBag','_otherobjBag',24,True),('Bag','addQuestBag','_questBag',24,True),('Storage','addGemStorage','_gemStorage',35,True),('Storage','addOtherobjStorage','_otherobjStorage',35,True)]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def execute(rows,field,size,hole):
 bag=['occupied']*size
 if hole is not None:bag[hole]=None
 before=bag.copy();local={0:'this',1:'item'};stack=[];pc=0;seen=set();trace=[]
 labels={r['code'][:-1]:i for i,r in enumerate(rows)if r['code'].endswith(':')}
 while True:
  state=repr((pc,local,stack,bag))
  if state in seen:return {'termination':'cycle','steps':len(trace),'pc_line':rows[pc]['line'],'locals':local,'writes':bag!=before,'trace_tail':trace[-12:]}
  seen.add(state)
  if len(trace)>5000:raise RuntimeError('bound exceeded without repeated state')
  row=rows[pc];s=row['code'];op=s.split()[0];trace.append(row);pc+=1
  if s.endswith(':')or op=='label':continue
  if op.startswith('getlocal'):n=int(s.split()[-1])if op=='getlocal'else int(op[-1]);stack.append(local[n])
  elif op.startswith('setlocal'):n=int(s.split()[-1])if op=='setlocal'else int(op[-1]);local[n]=stack.pop()
  elif op=='pushscope':stack.pop()
  elif op in ('pushbyte','pushshort','pushint'):stack.append(int(s.split()[-1]))
  elif op=='pushfalse':stack.append(False)
  elif op=='pushtrue':stack.append(True)
  elif op=='pushnull':stack.append(None)
  elif op=='getlex':assert prop(s)==field,s;stack.append(bag)
  elif op=='getproperty':
   if 'MultinameL('in s:index=stack.pop();receiver=stack.pop();assert receiver is bag;stack.append(receiver[index])
   else:assert prop(s)==field and stack.pop()=='this',s;stack.append(bag)
  elif op=='setproperty':
   assert 'MultinameL('in s;saved=stack.pop();index=stack.pop();receiver=stack.pop();assert receiver is bag;receiver[index]=saved
  elif op=='callproperty':assert prop(s)in ('getIsPile','isMany')and stack.pop()=='item',s;stack.append(False)
  elif op=='inclocal_i':n=int(s.split()[-1]);local[n]=((local[n]+1+2**31)%2**32)-2**31
  elif op in ('ifeq','ifne','iflt','ifnlt'):
   b=stack.pop();a=stack.pop();take={'ifeq':lambda:a==b,'ifne':lambda:a!=b,'iflt':lambda:a<b,'ifnlt':lambda:not(a<b)}[op]()
   if take:pc=labels[s.split()[-1]]
  elif op=='jump':pc=labels[s.split()[-1]]
  elif op=='returnvalue':return {'termination':'return','value':stack.pop(),'steps':len(trace),'writes':bag!=before,'written_indexes':[i for i,(a,b)in enumerate(zip(before,bag))if a!=b],'trace_tail':trace[-12:]}
  else:raise RuntimeError('unsupported executed instruction: '+s)
def main():
 results=[];patches=[]
 for cls,name,field,size,write in SPECS:
  rel=f'com/hotpoint/braveManIII/models/container/{cls}.pcode';paths={'original':ROOT/'reverse/build/ordered-comparison/original/scripts'/rel,'rebuilt928e':ROOT/'reverse/build/main-repeat-pcode/run-b062kbrm/scripts'/rel};codes={v:method(p,name)for v,p in paths.items()};cases=[]
  for hole in list(range(size))+[None]:
   runs={v:execute(code,field,size,hole)for v,code in codes.items()}
   assert runs['original']['termination']=='return' and runs['original']['value']==(hole is not None)
   if hole is None:assert runs['rebuilt928e']['termination']=='cycle'and not runs['rebuilt928e']['writes']
   else:assert runs['rebuilt928e']['termination']=='return'and runs['rebuilt928e']['value']and runs['rebuilt928e']['written_indexes']==runs['original']['written_indexes']==([hole]if write else[])
   if hole is not None:
    for r in runs.values():r.pop('trace_tail')
   cases.append({'hole':hole,'versions':runs})
  slices=ROOT/'reverse/experiments/ordered-comparison/nonstack-slices';slices.mkdir(exist_ok=True)
  for v,code in codes.items():(slices/f'{cls}-{name}-{v}.json').write_text(json.dumps(code,ensure_ascii=False,indent=2)+'\n')
  results.append({'class':cls,'method':name,'field':field,'capacity':size,'mutates_on_success':write,'inputs':{v:{'path':str(p.relative_to(ROOT)),'sha256':sha(p)}for v,p in paths.items()},'cases':cases})
 report={'schema':1,'scope':'Restricted interpreter of actual P-code nonstacking path; calls stubbed only getIsPile/isMany=false. All executed opcodes whitelisted; repeated concrete machine state proves nontermination within this path model. Not AVM2 execution or whole method proof.','methods':results,'method_count':len(results),'case_count':sum(len(x['cases'])for x in results),'no_player_or_save_access':True}
 (ROOT/'reverse/manifests/nonstack-loops.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
 print(json.dumps({'method_count':len(results),'fixtures':report['case_count'],'full_cases_cycles':6,'canonical_changed':False},indent=2))
if __name__=='__main__':main()
