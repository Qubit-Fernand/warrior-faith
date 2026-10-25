#!/usr/bin/env python3
"""Serial source rebuild of all root equipment packages; explicit failure manifest."""
import json,subprocess,sys,time
from pathlib import Path
from probe_rebuild_module import ROOT,SOURCES,LOGS

def main():
 files=sorted(ROOT.glob('equip*.swf'));rows=[]
 for p in files:
  started=time.time();r=subprocess.run([sys.executable,str(ROOT/'reverse/tools/probe_rebuild_module.py'),p.stem],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,timeout=300)
  log=LOGS/f'{p.stem}-family.txt';log.write_bytes(r.stdout)
  row={'file':p.name,'status':'compiled' if r.returncode==0 else 'failed','exit_code':r.returncode,'seconds':round(time.time()-started,3),'log':str(log.relative_to(ROOT))}
  if r.returncode==0:
   d=json.loads((SOURCES/p.stem/'result.json').read_text());row.update({'classes':len(d['classes']),'repeat_equal':d['compile_twice_exact_equal'],'output':d['output']})
  rows.append(row);(SOURCES/'equipment-family.json').write_text(json.dumps({'expected':len(files),'results':rows},ensure_ascii=False,indent=2)+'\n')
  print(p.name,row['status'],len(rows),'/',len(files),flush=True)
 if any(r['status']=='failed' for r in rows):raise SystemExit(1)
if __name__=='__main__':main()
