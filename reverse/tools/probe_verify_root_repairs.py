#!/usr/bin/env python3
"""Offline image checks for restored SimpleButton states and root placements."""
import argparse,hashlib,json,time,struct
from pathlib import Path
from PIL import Image
from probe_rebuild_module import ROOT,BUILD,SOURCES,JAVA,FFDEC,run,sha
from probe_root_timeline import parts,bindings
MODULES=['Map0_v26','Map9_v2','Map14','Map17','PlayerMc_X0_v10','PlayerMc_X1_v10','PlayerMc_X2_v10','ShiZhuang_X1_v5','ShiZhuang_X2_v5','Enemy16','Enemy5_v2']
def pixels(p):
 im=Image.open(p).convert('RGBA');return im.size,hashlib.sha256(im.tobytes()).hexdigest()
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--modules',nargs='+',default=MODULES);ap.add_argument('--resume',action='store_true');args=ap.parse_args();report=SOURCES/'root-repair-validation.json'
 old=json.loads(report.read_text())['results']if report.exists()and args.resume else[];results={r['module']:r for r in old}
 for mod in args.modules:
  original=ROOT/(mod+'.swf');rebuilt=BUILD/mod/(mod+'-rebuilt.swf');receipt=json.loads((SOURCES/mod/'result.json').read_text());assert receipt['root_timeline']['verified'] and receipt['output_sha256']==sha(rebuilt)
  if mod in results and results[mod].get('rebuilt_sha256')==sha(rebuilt):continue
  ot=parts(original)[3];nt=parts(rebuilt)[3];os=bindings(ot);ns=bindings(nt);defs={struct.unpack_from('<H',x)[0]:c for c,x in ot if c in(34,39)};buttons={name:cid for name,cid in os.items()if defs.get(cid)==34};kind='button'if buttons else'frame';dirs=[]
  for label,path in [('original',original),('rebuilt',rebuilt)]:
   out=BUILD/mod/(kind+'-check-'+label+'-'+str(time.time_ns()));dirs.append(out);run([JAVA,'-jar',FFDEC,'-export',kind,out,path],mod+'-'+kind+'-check-'+label)
  frames=[]
  if buttons:
   for name,cid in buttons.items():
    folders=[next((d for d in out.iterdir()if d.is_dir()and d.name.startswith('DefineButton2_'+str(i)+'_')),None)for out,i in zip(dirs,[cid,ns[name]])]
    assert all(folders),(name,folders)
    left={p.name:p for p in folders[0].glob('*.png')};right={p.name:p for p in folders[1].glob('*.png')};assert set(left)==set(right),(name,left,right)
    assert len(left)==4,(name,len(left))
    for state,p in left.items():
     a=pixels(p);b=pixels(right[state]);frames.append({'class':name,'state':state,'equal':a==b,'size':a[0],'rgba_sha256':a[1]})
  else:
   left={p.name:p for p in dirs[0].rglob('*.png')};right={p.name:p for p in dirs[1].rglob('*.png')};assert len(left)==1 and set(left)==set(right)
   for state,p in left.items():
    a=pixels(p);b=pixels(right[state]);frames.append({'root_frame':state,'equal':a==b,'size':a[0],'rgba_sha256':a[1]})
  result={'module':mod,'original_sha256':sha(original),'rebuilt_sha256':sha(rebuilt),'kind':kind,'frames_compared':len(frames),'frames':frames,'pass':all(x['equal']for x in frames)};results[mod]=result
  report.write_text(json.dumps({'scope':'Offline FFDec rendered button states including hit-test; root frames. Does not execute constructor/click handler or timeline scripts.','results':list(results.values())},ensure_ascii=False,indent=2)+'\n');print(mod,result['pass'],len(frames),flush=True)
  assert result['pass'],mod
if __name__=='__main__':main()
