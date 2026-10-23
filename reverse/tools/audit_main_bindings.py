#!/usr/bin/env python3
"""Capture selected FFDec p-code binding evidence; re-export p-code before use."""
from pathlib import Path
import hashlib,json,re
ROOT=Path(__file__).resolve().parents[2]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def rows(base,classes):
 out=[]
 for cls in classes:
  p=base/'scripts'/f'{cls}.pcode';text=p.read_text();found=[];chains=[]
  for n,line in enumerate(text.splitlines(),1):
   line=line.strip()
   if re.search(r'^(?:getlex|findpropstrict) Multiname\("(?:XMLAsset|JSON)"',line):found.append({'line':n,'instruction':line})
   if re.search(r'^(?:getlex|findpropstrict) Multiname\("com"',line):chains.append({'line':n,'instruction':line})
  out.append({'file':str(p.relative_to(ROOT)),'sha256':sha(p),'bindings':found,'dynamic_com_chains':chains,'temporary_legacy_json_name_present':'REA_LegacyJSON_'in text})
 return out
main=ROOT/'reverse/build/main-probe/main-normalized.swf'
m={'swf_sha256':sha(main),'bindings':rows(ROOT/'reverse/build/main-audit/rebuilt',['src/_data/ShopFactory','src/_data/XingLingFactory','src/Shop_LiBao2'])}
assert sum(len(x['bindings'])for x in m['bindings'])==4
assert all('PackageNamespace("com.hotpoint.braveManIII.Tool")'in b['instruction']and'PackageNamespace("src.tool")'not in b['instruction']for x in m['bindings']for b in x['bindings'])
assert not any(x['dynamic_com_chains']for x in m['bindings'])
(ROOT/'reverse/manifests/main-audit-xmlasset-bindings.json').write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n')
swf=ROOT/'reverse/build/module-probe/Enemy105/Enemy105-rebuilt.swf';base=ROOT/'reverse/build/export-quality/Enemy105'
e={'module':'Enemy105','rebuilt_swf_sha256':sha(swf),'original_swf_sha256':sha(ROOT/'Enemy105.swf'),'scope':'Selected XMLAsset/JSON class lookup instructions only; broad namespace sets remain, runtime behavior untested. P-code must be freshly exported before running this script.','original':rows(base/'original',['src/Shop_LiBao2','src/tool/TiaoShi']),'rebuilt':rows(base/'rebuilt',['src/Shop_LiBao','src/Shop_LiBao2','src/tool/TiaoShi','com/adobe/serialization/json/JSON'])}
assert not any(x['dynamic_com_chains']or x['temporary_legacy_json_name_present']for x in e['rebuilt'])
assert sum('"XMLAsset"'in b['instruction']for x in e['rebuilt']for b in x['bindings'])==4
assert sum('"JSON"'in b['instruction']for x in e['rebuilt']for b in x['bindings'])==2
(ROOT/'reverse/manifests/export-quality-binding-sample.json').write_text(json.dumps(e,ensure_ascii=False,indent=2)+'\n')
print('Main',m['swf_sha256'],'4 XMLAsset bindings; Enemy105',e['rebuilt_swf_sha256'],'4 XMLAsset, 1 JSON consumer, 1 JSON class binding')
