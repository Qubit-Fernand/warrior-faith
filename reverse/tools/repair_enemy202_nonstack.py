#!/usr/bin/env python3
"""Preserve CheckTest call order while repairing proven Enemy202 scan loops."""
from pathlib import Path
import json,re,hashlib,inspect,time
from nonstack_path_interpreter import execute,SPECS,method
from audit_shop_cfg import prop
from apply_main_semantic_repairs import method_bytes
ROOT=Path(__file__).resolve().parents[2];sha=lambda b:hashlib.sha256(b).hexdigest()
# Explicit opaque call model, with no inference about CheckTest bodies. Incoming
# bag is the post-Testing state. Calls/effects are preserved at matching exits.
s=inspect.getsource(execute).replace("trace=[]", "trace=[];opaque_calls=[]")
s=s.replace("elif op=='getlex':assert prop(s)==field,s;stack.append(bag)","elif op=='getlex':\n   name=prop(s);assert name in (field,'CheckTest'),s;stack.append(bag if name==field else 'CheckTest')")
s=s.replace("  elif op=='callproperty':", "  elif op=='callpropvoid':\n   name=prop(s);assert name in ('Testing','TestingOther','setMD5','setMD5Other') and s.endswith(', 0') and stack.pop()=='CheckTest',s;opaque_calls.append(name)\n  elif op=='callproperty':")
s=s.replace("'termination':'return'", "'opaque_calls':opaque_calls,'termination':'return'")
env={'prop':prop};exec(s,env);model=env['execute']
rows=[]
for cls,name,field,size,write in SPECS:
 path=ROOT/'reverse/source/Enemy202/com/hotpoint/braveManIII/models/container'/(cls+'.as');pcode=ROOT/'reverse/build/nonmain-semantic-originals/Enemy202/scripts/com/hotpoint/braveManIII/models/container'/(cls+'.pcode');code=method(pcode,name);before=method_bytes(path.read_bytes(),name).decode();cases=[]
 setter='setMD5Other' if name in ('addOtherobjBag','addOtherobjStorage') else 'setMD5' if name in ('addGemBag','addGemStorage') else None;testing='TestingOther' if setter=='setMD5Other' else 'Testing'
 for hole in list(range(size))+[None]:
  r=model(code,field,size,hole);assert r['termination']=='return' and r['value']==(hole is not None);assert r['written_indexes']==([hole]if write and hole is not None else[])
  assert r['opaque_calls']==([testing,setter]if setter else[]),(name,hole,r)
  r.pop('trace_tail',None);cases.append({'hole':hole,'result':r})
 text=before.replace('\r\n','\n');start=text.index('            while(true)');stop=text.index('            return true;',start)+len('            return true;');old=text[start:stop]
 index=re.search(r'if\((\w+) < '+str(size)+r'\)',old)[1];param=re.search(r'function '+name+r'\((\w+):',text)[1];field_ref=re.search(r'if\(((?:this\.)?'+field+r')\['+index+r'\] == null\)',old)[1]
 assert old.count('continue;')==1 and old.count('break;')==1
 if setter:assert old.count('CheckTest.'+setter+'();')==1
 replacement=f'            while({index} < {size})\n            {{\n               if({field_ref}[{index}] == null)\n               {{\n'+(f'                  {field_ref}[{index}] = {param};\n'if write else'')+(f'                  CheckTest.{setter}();\n'if setter else'')+f'                  return true;\n               }}\n               {index}++;\n            }}\n'+(f'            CheckTest.{setter}();\n'if setter else'')+'            return false;'
 after=(text[:start]+replacement+text[stop:]).replace('\n','\r\n')
 rows.append({'class':cls,'method':name,'path':str(path.relative_to(ROOT)),'before_method':before,'after_method':after,'original_pcode_sha256':sha(pcode.read_bytes()),'instructions':code,'cases':cases})
# Serialize with the separate ordered guard updater touching the same Bag file.
while not (ROOT/'reverse/manifests/ordered-copy-repair-applied.json').exists():time.sleep(5)
proof={'schema':1,'scope':'Local scan/control proof with opaque CheckTest calls: post-Testing bag state arbitrary; zero-argument CheckTest call sequence preserved on each success/failure exit. Calls themselves not emulated, no whole-method/runtime proof.','original_swf_sha256':sha((ROOT/'Enemy202.swf').read_bytes()),'opaque_model_source':s,'methods':rows,'fixture_count':sum(len(r['cases'])for r in rows)}
out=ROOT/'reverse/manifests/enemy202-nonstack-proof.json';assert not out.exists();out.write_text(json.dumps(proof,ensure_ascii=False,indent=2)+'\n')
files=[]
for cls in ['Bag','Storage']:
 path=ROOT/'reverse/source/Enemy202/com/hotpoint/braveManIII/models/container'/(cls+'.as');raw=path.read_bytes();new=raw
 for r in rows:
  if r['class']!=cls:continue
  a=r['before_method'].encode();assert new.count(a)==1;new=new.replace(a,r['after_method'].encode(),1)
 assert b'\n'not in new.replace(b'\r\n',b'');path.write_bytes(new);files.append({'path':str(path.relative_to(ROOT)),'before_sha256':sha(raw),'after_sha256':sha(new)})
(ROOT/'reverse/manifests/enemy202-nonstack-applied.json').write_text(json.dumps({'schema':1,'proof_sha256':sha(out.read_bytes()),'files':files,'applied':True,'recompiled':False},ensure_ascii=False,indent=2)+'\n');print('Enemy202 six methods,172 fixtures,CheckTest calls preserved',flush=True)
