#!/usr/bin/env python3
"""Verify each original ordered guard's operands/effects before minimal repair."""
from pathlib import Path
import argparse,hashlib,json,re,time
from apply_main_semantic_repairs import method_bytes
from audit_ordered_comparisons import method,witness
ROOT=Path(__file__).resolve().parents[2];OUT=ROOT/'reverse/build/nonmain-semantic-originals'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
NAMES=('getAllHP','getAllMP','getAllAttack','getAllAttackIgnoreDefense','getAllDefense','getAllMoveSpeed','getAllCrit','getAllDuck','getAllHardValue','getAllMOKANG','getAllPOMO')
def verify(module,cls,name,path):
 pcode=OUT/module/'scripts'/(cls+'.pcode');assert pcode.exists(),pcode
 rows=method(pcode,name);source=method_bytes(path.read_bytes(),name).decode()
 if cls.endswith('EquipSlot'):
  # Direct getRemainingTime() and zero are the two actual comparison operands.
  matches=[i for i,r in enumerate(rows)if r['code'].startswith('ifnle ')and i>=2 and rows[i-1]['code']=='pushbyte 0'and '"getRemainingTime"'in rows[i-2]['code']]
  pattern=r'if\((\((?:this\.)?_slot\[\w+\] as Equip\)\.getRemainingTime\(\)) > 0\)';m=re.search(pattern,source)
  if not m:return None
  replacement='if(!('+m[1]+' <= 0))';effect='"'+name.replace('getAll','get',1)+'"'
 elif cls.endswith('Bag'):
  matches=[i for i,r in enumerate(rows)if r['code'].startswith('ifngt ')and i>=2 and rows[i-1]['code']=='pushbyte 0'and rows[i-2]['code'] in ('getlocal2','getlocal 2')]
  parameter=re.search(r'function '+name+r'\([^,]+, (\w+):Number',source)[1];m=re.search(r'if\('+parameter+r' <= 0\)',source)
  if not m:return None
  replacement='if(!('+parameter+' > 0))';effect=None
 else:
  matches=[i for i,r in enumerate(rows)if r['code'].startswith('ifngt ')and i>=2 and rows[i-1]['code']=='pushbyte 0'and rows[i-2]['code'].startswith('getproperty MultinameL')]
  m=re.search(r'if\((\w+\[\w+\]) <= 0\)',source)
  if not m:return None
  replacement='if(!('+m[1]+' > 0))';effect='"gongJiYn1"'
 assert len(matches)==1,(module,cls,name,matches)
 i=matches[0];opcode=rows[i]['code'].split()[0];ordinal=sum(r['code'].startswith(opcode+' ')for r in rows[:i]);w=witness(rows,opcode,ordinal)
 taken=w['taken_path_to_next_branch_or_return'];fall=w['fallthrough_path_to_next_branch_or_return']
 if cls.endswith('EquipSlot'):
  assert any(effect in r['code']for r in taken)and not any(effect in r['code']for r in fall),(module,name,w)
 elif cls.endswith('Bag'):
  assert any(r['code']=='returnvalue'for r in taken),(module,name,w)
  assert any('getproperty MultinameL'in r['code']for r in fall),(module,name,w)
 else:
  assert any(effect in r['code']for r in taken)and any(r['code']=='returnvoid'for r in taken),(module,name,w)
  assert any(r['code']=='pushstring "攻击"'for r in fall),(module,name,w)
 after=source[:m.start()]+replacement+source[m.end():]
 return {'module':module,'class':cls,'method':name,'source':str(path.relative_to(ROOT)),'original_swf_sha256':sha(ROOT/(module+'.swf')),'pcode_sha256':sha(pcode),'source_before_sha256':sha(path),'before_method':source,'after_method':after,'witness':w,'whole_method_equivalence_proven':False}
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--apply',action='store_true');args=ap.parse_args()
 # Original export producer also verifies and repairs the six independent loop methods.
 marker=ROOT/'reverse/manifests/nonstack-copy-repair-applied.json'
 while not marker.exists():time.sleep(10)
 rows=[];missing=[]
 specs=[('com/hotpoint/braveManIII/models/container/EquipSlot',n)for n in NAMES]+[('com/hotpoint/braveManIII/models/container/Bag',n)for n in ('delGemById','delOtherById')]+[('src/ChongWu','GoTo')]
 for folder in sorted((ROOT/'reverse/source').iterdir()):
  if folder.name=='3_L4399Main_gamefile':continue
  for cls,name in specs:
   path=folder/(cls+'.as')
   if not path.exists():continue
   try:method_bytes(path.read_bytes(),name)
   except AssertionError:continue
   if not (OUT/folder.name/'scripts'/(cls+'.pcode')).exists():missing.append({'module':folder.name,'class':cls,'method':name});continue
   r=verify(folder.name,cls,name,path)
   if r:rows.append(r)
 report={'schema':1,'scope':'Per-original-SWF guard operands and local taken/fallthrough effects checked with full namespaces retained. Only proven relational guard text replaced; no whole-method equivalence claim.','methods':rows,'method_count':len(rows),'not_exported':missing,'applied':False}
 p=ROOT/'reverse/manifests/ordered-copy-original-proof.json';assert not p.exists();p.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
 if args.apply:
  groups={}
  for r in rows:groups.setdefault(r['source'],[]).append(r)
  edits=[]
  for name,rs in groups.items():
   target=ROOT/name;raw=target.read_bytes();assert sha(target)==rs[0]['source_before_sha256'];new=raw
   for r in rs:
    before=r['before_method'].encode();assert new.count(before)==1;new=new.replace(before,r['after_method'].encode(),1)
   assert b'\n'not in new.replace(b'\r\n',b'');edits.append((target,new,{'path':name,'before_sha256':sha(target),'after_sha256':hashlib.sha256(new).hexdigest(),'methods':[r['method']for r in rs]}))
  for target,new,_ in edits:target.write_bytes(new)
  applied={'schema':1,'proof_sha256':sha(p),'files':[r for _,_,r in edits],'method_count':len(rows),'applied':True,'recompiled':False,'runtime_tested':False};(ROOT/'reverse/manifests/ordered-copy-repair-applied.json').write_text(json.dumps(applied,ensure_ascii=False,indent=2)+'\n')
 print(json.dumps({k:v for k,v in report.items()if k!='methods'},indent=2))
if __name__=='__main__':main()
