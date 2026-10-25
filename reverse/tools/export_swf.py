#!/usr/bin/env python3
"""Resume FFDec exports; log failures and audit sources for decompiler stubs."""
import argparse, concurrent.futures, datetime, hashlib, json, re, subprocess, time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
JAVA=ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'
JAR=ROOT/'.runtime/shared-tools/ffdec/ffdec.jar'
MARKERS=re.compile(r'(?im)^.*(?:Decompilation error|Decompilation timeout|method body.*not found|decompilation failed|UnsupportedOperationException).*$')
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def export(path,mode,force=False):
    folder=ROOT/'reverse/exports'/path.stem;folder.mkdir(parents=True,exist_ok=True)
    receipt=folder/f'{mode}-receipt.json';sha=digest(path)
    if receipt.exists() and not force:
        old=json.loads(receipt.read_text())
        if old.get('source_sha256')==sha and old.get('status')=='ok':return old
    log=ROOT/'reverse/logs'/f'{path.stem}-{mode}.log';log.parent.mkdir(parents=True,exist_ok=True)
    types='script,symbolClass,binaryData' if mode=='scripts' else 'image,shape,morphshape,sound,font,font4,text'
    cmd=[str(JAVA),'-Xmx3g','-Djava.awt.headless=true','-jar',str(JAR),'-config','parallelSpeedUpThreadCount=2','-onerror','abort','-timeout','240','-exportFileTimeout','600','-exportTimeout','1800']
    if mode=='scripts':cmd+=['-exportembed']
    cmd+=['-export',types,str(folder),str(path)]
    start=time.time();row={'source':path.name,'source_sha256':sha,'mode':mode,'started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'command':cmd,'log':str(log.relative_to(ROOT))}
    try:
        with log.open('w') as out:cp=subprocess.run(cmd,stdout=out,stderr=subprocess.STDOUT,timeout=1860)
        row['returncode']=cp.returncode;row['status']='ok' if cp.returncode==0 else 'failed'
    except subprocess.TimeoutExpired:row['status']='timeout'
    except Exception as e:row.update(status='failed',error=repr(e))
    row['elapsed_seconds']=round(time.time()-start,3)
    if mode=='scripts':
        files=sorted((folder/'scripts').rglob('*.as'));row['source_file_count']=len(files);issues=[]
        for p in files:
            text=p.read_text(errors='replace')
            for hit in MARKERS.finditer(text):issues.append({'file':str(p.relative_to(ROOT)),'line':text[:hit.start()].count('\n')+1,'marker':hit.group()[:250]})
        row['decompiler_issues']=issues
        if issues and row['status']=='ok':row['status']='partial'
        inv=folder/'inventory/abc-0000.json'
        if inv.exists():row['expected_abc_script_count']=len(json.loads(inv.read_text())['scripts'])
        row['embedded_asset_containers']=[str(p.relative_to(ROOT)) for p in (folder/'scripts').rglob('*.swf')]
    row['output_files']=sum(1 for p in folder.rglob('*') if p.is_file())
    receipt.write_text(json.dumps(row,ensure_ascii=False,indent=2)+'\n')
    print(path.name,mode,row['status'],row.get('source_file_count',''),flush=True)
    return row
def main():
    ap=argparse.ArgumentParser();ap.add_argument('files',nargs='*');ap.add_argument('--mode',choices=['scripts','assets'],default='scripts');ap.add_argument('--jobs',type=int,default=2);ap.add_argument('--force',action='store_true');a=ap.parse_args()
    paths=[ROOT/p for p in a.files] if a.files else sorted(ROOT.glob('*.swf'),key=lambda p:(p.name!='3_L4399Main_gamefile.swf',p.name!='DataX_v76.swf',p.name))
    with concurrent.futures.ThreadPoolExecutor(max_workers=a.jobs) as ex:
        results=list(ex.map(lambda p:export(p,a.mode,a.force),paths))
    out=ROOT/'reverse/manifests'/f'{a.mode}-exports.json';out.write_text(json.dumps(results,ensure_ascii=False,indent=2)+'\n')
    print('SUMMARY',a.mode,{s:sum(r['status']==s for r in results) for s in sorted({r['status'] for r in results})},flush=True)
if __name__=='__main__':main()
