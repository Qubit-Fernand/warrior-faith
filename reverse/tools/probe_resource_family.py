#!/usr/bin/env python3
"""Build every resource SWF lacking a document class, record each outcome."""
import hashlib,json,subprocess,sys,time
from pathlib import Path
from probe_rebuild_module import ROOT,SOURCES,BUILD,LOGS
from build_inputs import verify

def main():
 rows=[];files=sorted(ROOT.glob('*.swf'))
 for p in files:
  inv=ROOT/'reverse/exports'/p.stem/'inventory/structure.json';d=json.loads(inv.read_text())
  if d['document_classes']:continue # Main and DataX require their original document class.
  receipt=SOURCES/p.stem/'result.json';existing=json.loads(receipt.read_text()) if receipt.exists() else {}
  out=ROOT/existing.get('output','NONEXISTENT')
  obsolete=any(x.get('repair','').startswith('Qualify ') for x in existing.get('source_repairs',{}).get('syntax_repairs',[]))
  source_root=existing.get('source_root',f'reverse/experiments/module-probe/{p.stem}/src')
  recorded={k.removeprefix(source_root+'/'):v for k,v in existing.get('source_files',{}).items()}
  canonical=ROOT/'reverse/source'/p.stem
  source_ok=True
  if canonical.exists():source_ok=recorded=={str(x.relative_to(canonical)):hashlib.sha256(x.read_bytes()).hexdigest() for x in canonical.rglob('*.as')}
  if obsolete:
   existing['invalidated']='Fully-qualified dynamic class references may compile as getlex com; rebuild with explicit import/temporary JSON-name restoration.';receipt.write_text(json.dumps(existing,ensure_ascii=False,indent=2)+'\n')
  fingerprint_ok=existing.get('input_fingerprint',{}).get('post_build_verified') is True and not verify(existing.get('input_fingerprint'))
  if fingerprint_ok and existing.get('root_timeline',{}).get('verified') is True and not obsolete and source_ok and existing.get('original_sha256')==d['sha256'] and out.is_file() and hashlib.sha256(out.read_bytes()).hexdigest()==existing.get('output_sha256'):
   row={'module':p.stem,'status':'compiled_existing','result':str(receipt.relative_to(ROOT))};rows.append(row)
  else:
   start=time.time()
   try:
    r=subprocess.run([sys.executable,str(ROOT/'reverse/tools/probe_rebuild_module.py'),p.stem,'--dynamic'],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,timeout=600)
    log=LOGS/(p.stem+'-resource-family.txt');log.write_bytes(r.stdout);row={'module':p.stem,'status':'compiled' if r.returncode==0 else 'failed','exit':r.returncode,'seconds':round(time.time()-start,3),'log':str(log.relative_to(ROOT))}
   except subprocess.TimeoutExpired as e:
    row={'module':p.stem,'status':'timeout','seconds':round(time.time()-start,3)}
   rows.append(row)
  (SOURCES/'resource-family.json').write_text(json.dumps({'scope':'All original SWFs without document class; Main/DataX excluded','results':rows},ensure_ascii=False,indent=2)+'\n')
  print(row['module'],row['status'],len(rows),flush=True)
 if any(r['status'] in ('failed','timeout') for r in rows):raise SystemExit(1)
if __name__=='__main__':main()
