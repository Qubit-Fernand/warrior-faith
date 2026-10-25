#!/usr/bin/env python3
"""Read-only negated-comparison census and explicit local CFG witnesses.

Census is triage only. Selected witnesses retain operands and paths; no blanket
opcode inversion or declaration of whole-program equivalence is performed.
"""
from pathlib import Path
import collections,hashlib,json,re,math
from audit_decrement_semantics import method
ROOT=Path(__file__).resolve().parents[2]
OLD=ROOT/'reverse/build/ordered-comparison/original/scripts'
NEW=ROOT/'reverse/build/main-repeat-pcode/run-b062kbrm/scripts'
NEG={'ifngt','ifnlt','ifnge','ifnle'}
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def methods(t):
 return {m[1]:t[m.end():t.index('end ; code',m.end())] for m in re.finditer(r'function (\w+)\([^\n]*',t)}
def short(s):
 return re.sub(r'\[.*\]','[namespace-set retained in full slice]',s)
def witness(rows,opcode,ordinal=0):
 labels={r['code'][:-1]:i for i,r in enumerate(rows)if r['code'].endswith(':')}
 points=[i for i,r in enumerate(rows)if r['code'].startswith(opcode+' ')]
 i=points[ordinal];target=labels[rows[i]['code'].split()[-1]]
 def path(j):
  seen=set();out=[]
  while j<len(rows)and j not in seen and len(out)<90:
   seen.add(j);r=rows[j];s=r['code'];out.append(r)
   if s.startswith('jump '):j=labels[s.split()[-1]];continue
   if s.startswith(('if','return','throw')):break
   j+=1
  return out
 return {'branch':rows[i],'operand_context':rows[max(0,i-10):i], 'taken_path_to_next_branch_or_return':path(target),'fallthrough_path_to_next_branch_or_return':path(i+1)}
def main():
 census=[];totalmethods=0;allsites=0;files=list(OLD.rglob('*.pcode'))
 for p in sorted(files):
  rel=p.relative_to(OLD);a=methods(p.read_text());b=methods((NEW/rel).read_text())
  for n,s in a.items():
   x=re.findall(r'^\s+(if\w+) ',s,re.M);y=re.findall(r'^\s+(if\w+) ',b.get(n,''),re.M)
   k=sum(o in NEG for o in x)
   if k:
    totalmethods+=1;allsites+=k
    if x!=y:census.append({'file':str(rel),'method':n,'original_branch_sequence':x,'rebuilt_branch_sequence':y,'status':'triage_only_not_semantic_failure'})
 specs=[('com/hotpoint/braveManIII/models/player/PlayerData','addGold','ifngt','ifnle','original taken = rebuilt fallthrough = setValue(sum)','!(sum > cap)','sum <= cap','Number; NaN is representable')]
 for n in ('getAllHP','getAllMP','getAllAttack','getAllAttackIgnoreDefense','getAllDefense','getAllMoveSpeed','getAllCrit','getAllDuck','getAllHardValue','getAllMOKANG','getAllPOMO'):
  specs.append(('com/hotpoint/braveManIII/models/container/EquipSlot',n,'ifnle','ifngt','original taken = rebuilt fallthrough = add this equipment statistic','!(remainingTime <= 0)','remainingTime > 0','getRemainingTime returns Number; low-color VT NaN survives'))
 for n in ('delGemById','delOtherById'):
  specs.append(('com/hotpoint/braveManIII/models/container/Bag',n,'ifngt','ifnle','original taken = rebuilt fallthrough = stop outer deletion loop','!(requested > 0)','requested <= 0','requested parameter Number; NaN original exits, rebuilt enters body'))
 specs.append(('src/ChongWu','GoTo','ifngt','ifnle','original taken = rebuilt fallthrough = clear attack flags and return','!(skillType > 0)','skillType <= 0','Array element is untyped; NaN/undefined possible for malformed skill array, normal factory domain not shown malformed'))
 detailed=[];slices=ROOT/'reverse/experiments/ordered-comparison/method-slices';slices.mkdir(parents=True,exist_ok=True)
 for cls,n,oo,no,meaning,oldexpr,newexpr,domain in specs:
  item={'class':cls.replace('/','.'),'method':n,'manually_verified_local_edge_correspondence':meaning,'original_condition_for_effect':oldexpr,'rebuilt_condition_for_effect':newexpr,'domain':domain,'normal_ordered_numbers_same_condition':True,'unordered_condition_differs':True,'whole_method_equivalence_proven':False,'versions':{}}
  for v,base,opcode in [('original',OLD,oo),('rebuilt928e',NEW,no)]:
   p=base/(cls+'.pcode');rows=method(p,n);w=witness(rows,opcode)
   q=slices/(cls.replace('/','__')+'__'+n+'__'+v+'.pcode.txt');q.write_text('\n'.join(str(r['line'])+' '+r['code']for r in rows)+'\n')
   item['versions'][v]={'pcode':str(p.relative_to(ROOT)),'sha256':sha(p),'slice':str(q.relative_to(ROOT)),'slice_sha256':sha(q),'witness':w}
  detailed.append(item)
 vectors=[]
 for a,b in [(0,0),(1,0),(-1,0),(500000000,500000000),(500000001,500000000),(math.inf,500000000),(-math.inf,500000000),(math.nan,500000000),(1,math.nan),(math.nan,math.nan)]:
  vectors.append({'a':repr(a),'b':repr(b),'not_greater':not(a>b),'less_equal':a<=b,'not_less_equal':not(a<=b),'greater':a>b})
 report={'schema':'yzlr2-ordered-comparisons-v1','original_swf_sha256':sha(ROOT/'3_L4399Main_gamefile.swf'),'rebuilt_swf':'reverse/build/main-probe/run-b062kbrm/normalized.swf','rebuilt_swf_sha256':sha(ROOT/'reverse/build/main-probe/run-b062kbrm/normalized.swf'),'named_method_census':{'files':len(files),'methods_with_negated_comparison':totalmethods,'negated_sites':allsites,'different_branch_sequence_methods':len(census),'caveat':'Named methods only; anonymous initializers not counted; same opcode sequence is not a semantic pass.'},'triage':census,'verified_local_nan_differences':detailed,'host_truth_vectors_not_vm_execution':vectors,'no_ui_or_save_access':True}
 (ROOT/'reverse/manifests/ordered-comparisons.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
 print(json.dumps({'census':report['named_method_census'],'verified_local_nan_differences':len(detailed)},indent=2))
if __name__=='__main__':main()
