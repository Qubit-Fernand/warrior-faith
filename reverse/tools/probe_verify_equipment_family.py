#!/usr/bin/env python3
"""Render every frame of every linked equipment sprite, compare original/rebuilt."""
import argparse,hashlib,json,sys,time,re,collections
from pathlib import Path
from PIL import Image
from probe_rebuild_module import ROOT,BUILD,LOGS,SOURCES,JAVA,FFDEC,run
from swf_inventory import read_swf,walk_tags,Reader,abc_inventory

def structures(path):
 _,b,h=read_swf(path);names={};sprites={};classes=[]
 for t,x in walk_tags(b,h['tag_start']):
  if t['code']==76:
   r=Reader(x)
   for _ in range(r.u16()): cid=r.u16();names[r.cstr()]=cid
  if t['code']==39:
   r=Reader(x);cid=r.u16();sprites[cid]=r.u16()
  if t['code']==82:
   r=Reader(x);r.take(4);r.cstr();classes.extend(abc_inventory(r.take(len(x)-r.p))['classes'])
 return {n:(cid,sprites[cid]) for n,cid in names.items() if cid in sprites},classes

def verify(module):
 p=ROOT/(module+'.swf');b=BUILD/module;new=b/(module+'-rebuilt.swf')
 left,lc=structures(p);right,rc=structures(new);assert set(left)==set(right),(left,right)
 # Compare class/super/interfaces and member declarations, ignoring IDs and compiler document helper.
 def members(classes):
  out=[]
  for c in classes:
   if c['name'].startswith('_') and c['name'].endswith('_flash_display_Sprite'):continue
   owner=c['name'].rsplit('.',1);scope=(':'.join(owner) if len(owner)==2 else owner[0])+'.'
   def norm(name):
    if name.startswith(scope):name=name[len(scope):]
    return re.sub(r'(?:[\w]+\.as\$\d+\.)?PrivateClass','PrivateClass',name)
   row={'name':norm(c['name']),'super':norm(c['super']),'interfaces':list(map(norm,c['interfaces'])),'members':sorted((norm(t['name']),t['kind'],norm(t.get('type',''))) for t in c['traits']),'static_members':sorted((norm(t['name']),t['kind'],norm(t.get('type',''))) for t in c['static_traits'])}
   out.append(json.dumps(row,sort_keys=True))
  return collections.Counter(out)
 assert members(lc)==members(rc),'public/member structure changed'
 results=[]
 for name,(cid,count) in left.items():
  newcid,newcount=right[name];assert count==newcount
  dirs=[]
  for label,file,id in [('original',p,cid),('rebuilt',new,newcid)]:
   target=b/f'family-frames-{label}-{id}-{time.time_ns()}';dirs.append(target)
   run([JAVA,'-jar',FFDEC,'-selectid',str(id),'-select',f'{id}:1-{count}','-export','sprite',target,file],f'{module}-family-frames-{label}-{id}')
  a={f.name:f for f in dirs[0].rglob('*.png')};c={f.name:f for f in dirs[1].rglob('*.png')};assert len(a)==count and set(a)==set(c)
  mismatches=[];digest=hashlib.sha256()
  for f in sorted(a,key=lambda n:int(Path(n).stem)):
   ia=Image.open(a[f]).convert('RGBA');ib=Image.open(c[f]).convert('RGBA')
   if ia.size!=ib.size or ia.tobytes()!=ib.tobytes():mismatches.append(f)
   digest.update(str(ia.size).encode());digest.update(ia.tobytes())
  results.append({'linkage':name,'original_id':cid,'rebuilt_id':newcid,'frames_compared':count,'mismatches':mismatches,'combined_rgba_sha256':digest.hexdigest(),'render_directories':[str(d.relative_to(ROOT)) for d in dirs]})
 return {'module':module,'class_members_equal':True,'sprites':results,'pass':all(not s['mismatches'] for s in results)}
def main():
 ap=argparse.ArgumentParser();ap.add_argument('modules',nargs='*');ap.add_argument('--resume',action='store_true');a=ap.parse_args();files=a.modules or [p.stem for p in sorted(ROOT.glob('equip*.swf'))];report_path=SOURCES/'equipment-family-validation.json'
 rows=json.loads(report_path.read_text())['results'] if a.resume and report_path.exists() else []
 done={r['module'] for r in rows if r.get('pass')}
 for module in files:
  if module in done:continue
  start=time.time()
  try:row=verify(module)
  except Exception as e:row={'module':module,'pass':False,'error':repr(e)}
  row['seconds']=round(time.time()-start,3);rows.append(row)
  report_path.write_text(json.dumps({'scope':'Offline all parent timeline frames, class/member signatures; not runtime gameplay','results':rows},ensure_ascii=False,indent=2)+'\n')
  print(module,'PASS' if row['pass'] else 'FAIL',row.get('error',''),flush=True)
 if any(not r['pass'] for r in rows):raise SystemExit(1)
if __name__=='__main__':main()
