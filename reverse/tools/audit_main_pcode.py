#!/usr/bin/env python3
"""Compare sampled original/rebuilt p-code; records differences, not equivalence."""
from pathlib import Path
import collections,hashlib,json,re
ROOT=Path(__file__).resolve().parents[2]
BASE=ROOT/'reverse/build/main-audit'
AUDITED=['src/ClassLoader','src/Main','src/Enemy','src/Player','src/NewLoad','com/hotpoint/braveManIII/models/equip/Equip','com/hotpoint/braveManIII/repository/equip/EquipFactory','com/hotpoint/braveManIII/repository/equip/EquipBaseData','PayMoneyVar']
def methods(text):
 out={}
 for m in re.finditer(r'(public|private|protected|internal)\s+(?:static\s+)?function\s+(?:(get|set)\s+)?([^\s(]+)\(',text):
  name=(m.group(2)+' 'if m.group(2)else '')+m.group(3)
  end=text.find('end ; code',m.end());section=text[m.start():end]
  c=section.find('\n',section.find('\n',section.find('code')))
  start=re.search(r'^\s*code\s*$',section,re.M)
  if not start:continue
  lines=[x.strip()for x in section[start.end():].splitlines()]
  lines=[x for x in lines if x and not x.startswith(('debug','ofs'))]
  out[name]={'line':text[:m.start()].count('\n')+1,'signature':section[:section.find('body')].strip(),'code':lines}
 return out
risk=re.compile(r'^(add|add_i|subtract|subtract_i|multiply|multiply_i|divide|modulo|bitand|bitor|bitxor|lshift|rshift|urshift|throw|lookupswitch|returnvalue|returnvoid)(?:\s|$)')
rows=[]
for cls in AUDITED:
 paths={w:BASE/w/'scripts'/f'{cls}.pcode'for w in ['original','rebuilt']}
 ds={w:methods(p.read_text())for w,p in paths.items()};changes=[]
 for name in sorted(ds['original'].keys()|ds['rebuilt'].keys()):
  a=ds['original'].get(name);b=ds['rebuilt'].get(name)
  if not a or not b:changes.append({'method':name,'missing_in':'original'if not a else 'rebuilt'});continue
  counts={w:dict(collections.Counter(l.split()[0]for l in d[name]['code'] if risk.match(l)))for w,d in ds.items()}
  if counts['original']!=counts['rebuilt']:changes.append({'method':name,'selected_opcode_counts':counts,'original_line':a['line'],'rebuilt_line':b['line']})
 rows.append({'class':cls.replace('/','.'),'source_files':{w:{'path':str(p.relative_to(ROOT)),'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}for w,p in paths.items()},'method_counts':{w:len(x)for w,x in ds.items()},'selected_opcode_differences':changes})
# Preserve exact small methods for an auditable coercion chain.
chain=[]
for cls,name in [('com/hotpoint/braveManIII/models/equip/Equip','getClassName4'),('com/hotpoint/braveManIII/repository/equip/EquipFactory','findClassName4'),('com/hotpoint/braveManIII/repository/equip/EquipBaseData','getClassName4'),('PayMoneyVar','PayMoneyVar')]:
 chain.append({'class':cls.replace('/','.'),'method':name,'versions':{w:methods((BASE/w/'scripts'/f'{cls}.pcode').read_text())[name]for w in ['original','rebuilt']}})
result={'scope':'Nine classes, named method inventory and selected arithmetic/return/throw opcode counts. This does not prove control-flow or runtime-binding equivalence. P-code inputs are separately hashed because the root may rebuild its current output.','classes':rows,'coercion_chain_and_constructor':chain}
p=ROOT/'reverse/manifests/main-audit-pcode.json';p.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
print(json.dumps([{'class':r['class'],'methods':r['method_counts'],'difference_methods':[x['method']for x in r['selected_opcode_differences']]}for r in rows],ensure_ascii=False,indent=2))
