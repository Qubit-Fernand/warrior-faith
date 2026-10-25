#!/usr/bin/env python3
"""Original-P-code per-copy fixtures for two misplaced continue loops."""
from pathlib import Path
import concurrent.futures,hashlib,json,re,subprocess,argparse
from audit_continue_loops import execute,SPECS,method
from apply_main_semantic_repairs import method_bytes
ROOT=Path(__file__).resolve().parents[2];OUT=ROOT/'reverse/build/nonmain-continue-originals'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
fixtures_by_name={r['method']:[v['fixture']for v in r['fixtures']]for r in json.loads((ROOT/'reverse/manifests/continue-loops.json').read_text())['methods']}
def one(item):
 module,specs=item;folder=OUT/module;folder.mkdir(parents=True,exist_ok=True);swf=ROOT/(module+'.swf');export=folder/'export.json'
 if not export.exists():
  cmd=[str(ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'),'-Xmx2g','-Djava.awt.headless=true','-jar',str(ROOT/'.runtime/shared-tools/ffdec/ffdec.jar'),'-selectclass',','.join(c.replace('/','.')for c,n in specs),'-format','script:pcode','-export','script',str(folder),str(swf)]
  r=subprocess.run(cmd,capture_output=True,text=True,timeout=120);(folder/'export.log').write_text(r.stdout+r.stderr);assert r.returncode==0;export.write_text(json.dumps({'swf_sha256':sha(swf),'command':cmd},ensure_ascii=False)+'\n')
 else:assert json.loads(export.read_text())['swf_sha256']==sha(swf)
 rows=[]
 for cls,name in specs:
  pcode=folder/'scripts'/(cls+'.pcode');code=method(pcode,name);cases=[]
  for f in fixtures_by_name[name]:
   result=execute(code,f);assert result['termination']=='return'and result['value']==f['expected'],(module,name,f,result);result.pop('trace_tail',None);cases.append({'fixture':f,'result':result})
  source=ROOT/'reverse/source'/module/(cls+'.as');before=method_bytes(source.read_bytes(),name).decode();s=before.replace('\r\n','\n')
  pattern=r'            while\(true\)\n            \{\n               if\(([^\n]+)\)\n               \{\n(.*?)\n               \}\n               (\w+)\+\+;\n            \}\n            (return [^;]+;)'
  m=re.search(pattern,s,re.S);assert m,(module,name,s)
  condition,inner,index,oldret=m.groups();assert condition.startswith(index+' < ');assert inner.count('continue;')==1 and inner.count('break;')==1,(module,name,inner)
  if name=='closeOk':assert oldret=='return false;'and 'player1._keyArr'in inner and 'player2._keyArr'in inner;endret='return true;'
  else:assert oldret.startswith('return ')and'dbNum('in oldret and 'getValue()'in inner;endret='return false;'
  inner=inner.replace('break;',oldret);inner='\n'.join(line[3:] for line in inner.splitlines()if line.strip()!='continue;')
  replacement=f'            while({condition})\n            {{\n'+inner+f'\n               {index}++;\n            }}\n            '+endret
  after=(s[:m.start()]+replacement+s[m.end():]).replace('\n','\r\n')
  rows.append({'module':module,'class':cls,'method':name,'source':str(source.relative_to(ROOT)),'source_before_sha256':sha(source),'before_method':before,'after_method':after,'original_swf_sha256':sha(swf),'pcode_sha256':sha(pcode),'original_instructions':code,'fixtures':cases})
 print(module,len(rows),'verified',flush=True);return {'module':module,'methods':rows,'passed':True}
def checked(item):
 try:return one(item)
 except (AssertionError,RuntimeError,KeyError)as e:print(item[0],'needs review',str(e)[:120],flush=True);return {'module':item[0],'methods':[],'passed':False,'error':str(e)}
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--apply',action='store_true');args=ap.parse_args();items=[]
 for folder in sorted((ROOT/'reverse/source').iterdir()):
  if folder.name=='3_L4399Main_gamefile':continue
  specs=[]
  for cls,n in SPECS:
   p=folder/(cls+'.as')
   if not p.exists():continue
   try:body=method_bytes(p.read_bytes(),n)
   except AssertionError:continue
   if b'while(true)'in body:specs.append((cls,n))
  if specs:items.append((folder.name,specs))
 with concurrent.futures.ThreadPoolExecutor(max_workers=2)as pool:results=list(pool.map(checked,items))
 report={'schema':1,'scope':'Each original module actual P-code checked with explicit finite fixtures; unsupported paths fail closed. No runtime or whole-method equivalence claim.','modules':results,'module_count':len(results),'method_count':sum(len(x['methods'])for x in results),'unverified_modules':[x for x in results if not x['passed']]}
 path=ROOT/'reverse/manifests/continue-copy-original-proof.json';assert not path.exists();path.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
 if args.apply:
  edits=[]
  for mod in results:
   for r in mod['methods']:
    p=ROOT/r['source'];raw=p.read_bytes();assert sha(p)==r['source_before_sha256'];before=r['before_method'].encode();assert raw.count(before)==1;new=raw.replace(before,r['after_method'].encode(),1);assert b'\n'not in new.replace(b'\r\n',b'');edits.append((p,new,{'path':r['source'],'method':r['method'],'before_sha256':sha(p),'after_sha256':hashlib.sha256(new).hexdigest()}))
  for p,new,_ in edits:p.write_bytes(new)
  (ROOT/'reverse/manifests/continue-copy-repair-applied.json').write_text(json.dumps({'schema':1,'proof_sha256':sha(path),'files':[r for _,_,r in edits],'applied':True,'recompiled':False,'runtime_tested':False},ensure_ascii=False,indent=2)+'\n')
 print(json.dumps({k:v for k,v in report.items()if k!='modules'},ensure_ascii=False,indent=2))
if __name__=='__main__':main()
