#!/usr/bin/env python3
"""Per-original-module restricted nonstack path proof and narrow repair candidates."""
from pathlib import Path
import argparse,concurrent.futures,hashlib,json,re,subprocess
from nonstack_path_interpreter import SPECS,execute,method
from apply_main_semantic_repairs import method_bytes
ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'reverse/build/nonmain-semantic-originals'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
def candidates():
 rows=[]
 for folder in sorted((ROOT/'reverse/source').iterdir()):
  if folder.name=='3_L4399Main_gamefile':continue
  specs=[]
  for cls,name,field,size,write in SPECS:
   path=folder/'com/hotpoint/braveManIII/models/container'/(cls+'.as')
   if not path.exists():continue
   raw=path.read_bytes()
   try:body=method_bytes(raw,name)
   except AssertionError:continue
   if b'while(true)'in body:specs.append((cls,name,field,size,write))
  if specs:rows.append((folder.name,specs))
 return rows

def one(item):
 module,specs=item;out=OUT/module;swf=ROOT/(module+'.swf');receipt=out/'export.json'
 classes=['com.hotpoint.braveManIII.models.container.'+s for s in ['Bag','Storage','EquipSlot']]
 if (ROOT/'reverse/source'/module/'src/ChongWu.as').exists():classes.append('src.ChongWu')
 if not receipt.exists():
  out.mkdir(parents=True,exist_ok=True)
  cmd=[str(ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'),'-Xmx2g','-Djava.awt.headless=true','-jar',str(ROOT/'.runtime/shared-tools/ffdec/ffdec.jar'),'-selectclass',','.join(classes),'-format','script:pcode','-export','script',str(out),str(swf)]
  r=subprocess.run(cmd,capture_output=True,text=True,timeout=150);(out/'export.log').write_text(r.stdout+r.stderr);assert r.returncode==0,(module,r.returncode)
  receipt.write_text(json.dumps({'swf_sha256':sha(swf),'command':cmd,'exit':r.returncode},ensure_ascii=False,indent=2)+'\n')
 else:assert json.loads(receipt.read_text())['swf_sha256']==sha(swf)
 rows=[]
 for cls,name,field,size,write in specs:
  pcode=out/'scripts/com/hotpoint/braveManIII/models/container'/(cls+'.pcode');source=ROOT/'reverse/source'/module/'com/hotpoint/braveManIII/models/container'/(cls+'.as');code=method(pcode,name);cases=[]
  for hole in list(range(size))+[None]:
   result=execute(code,field,size,hole)
   assert result['termination']=='return'and result['value']==(hole is not None),(module,name,hole,result)
   assert result['written_indexes']==([hole]if hole is not None and write else[]),(module,name,hole,result)
   result.pop('trace_tail',None);cases.append({'hole':hole,'result':result})
  before=method_bytes(source.read_bytes(),name).decode();s=before.replace('\r\n','\n');start=s.index('            while(true)');stop=s.index('            return true;',start)+len('            return true;');old=s[start:stop]
  loop=re.search(r'if\((\w+) < '+str(size)+r'\)',old);assert loop,(module,name);index=loop[1];param=re.search(r'function '+name+r'\((\w+):',s)[1]
  field_match=re.search(r'if\(((?:this\.)?'+re.escape(field)+r')\['+re.escape(index)+r'\] == null\)',old);assert field_match and old.count('continue;')==1,(module,name,old);field=field_match[1]
  if write:assert f'{field}[{index}] = {param};'in old,(module,name,old)
  replacement=f'            while({index} < {size})\n            {{\n               if({field}[{index}] == null)\n               {{\n'+(f'                  {field}[{index}] = {param};\n'if write else'')+f'                  return true;\n               }}\n               {index}++;\n            }}\n            return false;'
  after=(s[:start]+replacement+s[stop:]).replace('\n','\r\n');assert before!=after
  rows.append({'module':module,'class':cls,'method':name,'field':field,'size':size,'source':str(source.relative_to(ROOT)),'source_before_sha256':sha(source),'before_method':before,'after_method':after,'original_swf_sha256':sha(swf),'pcode_sha256':sha(pcode),'original_instructions':code,'cases':cases})
 result={'module':module,'methods':rows,'passed':True};(out/'nonstack.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n');print(module,len(rows),'verified',flush=True);return result

def checked_one(item):
 try:return one(item)
 except (AssertionError,RuntimeError) as e:
  result={'module':item[0],'methods':[],'passed':False,'error':str(e)};print(item[0],'needs independent review',str(e)[:160],flush=True);return result

def main():
 ap=argparse.ArgumentParser();ap.add_argument('--apply',action='store_true');args=ap.parse_args();items=candidates()
 with concurrent.futures.ThreadPoolExecutor(max_workers=2)as pool:results=list(pool.map(checked_one,items))
 report={'schema':1,'scope':'Each original SWF exported independently. All nonstack finite hole positions plus full bag checked against actual P-code. Repairs touch only malformed while(true) block; stackable behavior preserved textually. Not whole-method or runtime proof.','modules':results,'module_count':len(results),'unverified_modules':[x for x in results if not x['passed']],'method_count':sum(len(x['methods'])for x in results),'fixture_count':sum(len(r['cases'])for x in results for r in x['methods']),'applied':False}
 path=ROOT/'reverse/manifests/nonstack-copy-original-proof.json';assert not path.exists(),'receipt already exists';path.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
 if args.apply:
  grouped={}
  for result in results:
   for row in result['methods']:grouped.setdefault(row['source'],[]).append(row)
  edits=[]
  for name,rows in grouped.items():
   p=ROOT/name;raw=p.read_bytes();assert sha(p)==rows[0]['source_before_sha256'];new=raw
   for row in rows:
    before=row['before_method'].encode();after=row['after_method'].encode();assert new.count(before)==1;new=new.replace(before,after,1)
   assert b'\n'not in new.replace(b'\r\n',b'');edits.append((p,new,{'path':name,'before_sha256':sha(p),'after_sha256':hashlib.sha256(new).hexdigest(),'methods':[r['method']for r in rows]}))
  for p,new,_ in edits:p.write_bytes(new)
  applied={'schema':1,'proof_sha256':sha(path),'files':[r for _,_,r in edits],'module_count':len(results),'method_count':report['method_count'],'recompiled':False,'runtime_tested':False,'applied':True};(ROOT/'reverse/manifests/nonstack-copy-repair-applied.json').write_text(json.dumps(applied,ensure_ascii=False,indent=2)+'\n')
 print(json.dumps({k:v for k,v in report.items()if k!='modules'},indent=2),flush=True)
if __name__=='__main__':main()
