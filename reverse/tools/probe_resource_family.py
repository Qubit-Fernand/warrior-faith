#!/usr/bin/env python3
"""Build independent resource modules with bounded parallelism and locked logs."""
import argparse,fcntl,hashlib,json,os,signal,subprocess,sys,time
from concurrent.futures import ThreadPoolExecutor,as_completed
from pathlib import Path
from probe_rebuild_module import ROOT,SOURCES,BUILD,LOGS
from build_inputs import verify

def resource_files():
    baseline = json.loads((ROOT / 'reverse/manifests/original-files.json').read_text())
    modules = [row for row in baseline if row['path'].endswith('.swf')]
    if len(modules) != 164 or len({row['path'] for row in modules}) != 164:
        raise ValueError('Expected exactly 164 unique baseline SWFs')
    resources = []
    for row in modules:
        module = ROOT / row['path']
        inventory = ROOT / 'reverse/exports' / module.stem / 'inventory/structure.json'
        structure = json.loads(inventory.read_text())
        if structure['sha256'] != row['sha256']:
            raise ValueError(f'Inventory does not match original baseline: {module.name}')
        if not structure['document_classes']:
            resources.append((module, structure))
    return resources

def build_one(pair):
 p,d=pair;receipt=SOURCES/p.stem/'result.json';existing=json.loads(receipt.read_text()) if receipt.exists() else {}
 out=ROOT/existing.get('output','NONEXISTENT')
 obsolete=any(x.get('repair','').startswith('Qualify ') for x in existing.get('source_repairs',{}).get('syntax_repairs',[]))
 source_root=existing.get('source_root',f'reverse/experiments/module-probe/{p.stem}/src')
 recorded={k.removeprefix(source_root+'/'):v for k,v in existing.get('source_files',{}).items()}
 canonical=ROOT/'reverse/source'/p.stem
 source_ok=True
 if canonical.exists():source_ok=recorded=={str(x.relative_to(canonical)):hashlib.sha256(x.read_bytes()).hexdigest() for x in canonical.rglob('*.as')}
 fingerprint_ok=existing.get('input_fingerprint',{}).get('post_build_verified') is True and not verify(existing.get('input_fingerprint'))
 if fingerprint_ok and existing.get('root_timeline',{}).get('verified') is True and not obsolete and source_ok and existing.get('original_sha256')==d['sha256'] and out.is_file() and hashlib.sha256(out.read_bytes()).hexdigest()==existing.get('output_sha256'):
  return {'module':p.stem,'status':'compiled_existing','result':str(receipt.relative_to(ROOT))}
 start=time.time()
 try:
  result=subprocess.Popen([sys.executable,str(ROOT/'reverse/tools/probe_rebuild_module.py'),p.stem,'--dynamic'],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,start_new_session=True)
  output=result.communicate(timeout=900)[0]
  log=LOGS/(p.stem+'-resource-family.txt');log.write_bytes(output)
  return {'module':p.stem,'status':'compiled' if result.returncode==0 else 'failed','exit':result.returncode,'seconds':round(time.time()-start,3),'log':str(log.relative_to(ROOT))}
 except subprocess.TimeoutExpired:
  # Kill this task's whole process group, including Java; never leave a compiler
  # writing after the per-module Python lock is released.
  os.killpg(result.pid,signal.SIGTERM)
  try:output=result.communicate(timeout=10)[0]
  except subprocess.TimeoutExpired:
   os.killpg(result.pid,signal.SIGKILL);output=result.communicate()[0]
  (LOGS/(p.stem+'-resource-family.txt')).write_bytes(output)
  return {'module':p.stem,'status':'timeout','seconds':round(time.time()-start,3)}

def main():
 ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--jobs',type=int,choices=range(1,4),default=1);a=ap.parse_args()
 SOURCES.mkdir(parents=True,exist_ok=True);LOGS.mkdir(parents=True,exist_ok=True);BUILD.mkdir(parents=True,exist_ok=True)
 with (BUILD/'resource-family.lock').open('a+') as guard:
  try:fcntl.flock(guard,fcntl.LOCK_EX|fcntl.LOCK_NB)
  except BlockingIOError:raise SystemExit('Another resource-family build is already running')
  rows=[];files=resource_files()
  # Only this parent thread writes the aggregate; each subprocess owns one module.
  with ThreadPoolExecutor(max_workers=a.jobs) as pool:
   futures={pool.submit(build_one,pair):pair[0].stem for pair in files}
   for future in as_completed(futures):
    try:row=future.result()
    except Exception as error:row={'module':futures[future],'status':'failed','error':str(error)}
    rows.append(row)
    report={'scope':'All original SWFs without document class; Main/DataX excluded','jobs':a.jobs,'results':sorted(rows,key=lambda x:x['module'])}
    temporary=SOURCES/'resource-family.json.tmp';temporary.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');temporary.replace(SOURCES/'resource-family.json')
    print(row['module'],row['status'],len(rows),flush=True)
  if any(x['status'] in ('failed','timeout') for x in rows):raise SystemExit(1)
if __name__=='__main__':main()
