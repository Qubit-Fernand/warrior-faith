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
  elif op=='convert_i':assert type(stack[-1]) is int and -2**31<=stack[-1]<2**31,s
  elif op=='convert_b':assert type(stack[-1]) is bool,s
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
  elif op=='increment_i':
   a=stack.pop();assert type(a) is int and -2**31<=a<2**31,s;stack.append(((a+1+2**31)%2**32)-2**31)
  elif op=='inclocal_i':n=int(s.split()[-1]);local[n]=((local[n]+1+2**31)%2**32)-2**31
  elif op in ('ifeq','ifne','iflt','ifnlt'):
   b=stack.pop();a=stack.pop();take={'ifeq':lambda:a==b,'ifne':lambda:a!=b,'iflt':lambda:a<b,'ifnlt':lambda:not(a<b)}[op]()
   if take:pc=labels[s.split()[-1]]
  elif op in ('iftrue','iffalse'):
   a=stack.pop();assert type(a) is bool,s
   if a==(op=='iftrue'):pc=labels[s.split()[-1]]
  elif op=='jump':pc=labels[s.split()[-1]]
  elif op=='returnvalue':return {'termination':'return','value':stack.pop(),'steps':len(trace),'writes':bag!=before,'written_indexes':[i for i,(a,b)in enumerate(zip(before,bag))if a!=b],'trace_tail':trace[-12:]}
  else:raise RuntimeError('unsupported executed instruction: '+s)
