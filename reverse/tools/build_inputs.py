#!/usr/bin/env python3
"""Build-time input fingerprints with add/delete/change and post-build checks.

SHA cache keys include device/inode/size/mtime/ctime and are protected by flock.
The cache avoids rereading unchanged 293 MB toolchains per module; it is an
optimization for a trusted local filesystem, not a tamper-proof signing scheme.
Snapshots are captured BEFORE staging/compilation, never retroactively inferred.
"""
from __future__ import annotations
import fcntl,hashlib,json,os,platform,stat,sys,tempfile,uuid
from datetime import datetime,timezone
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
CACHE=ROOT/'reverse/build/project/input-hash-cache.json'
SCHEMA='yzlr2-build-inputs-v1'
TOOLCHAINS=ROOT/'reverse/manifests/toolchains'
SKIP_NAMES={'.DS_Store','__pycache__'}
ENV_KEYS=('JAVA_TOOL_OPTIONS','_JAVA_OPTIONS','JDK_JAVA_OPTIONS','JAVA_HOME','FLEX_HOME','LANG','LC_ALL')

def _label(path):
 p=Path(os.path.abspath(path))
 return p.relative_to(ROOT).as_posix() if p.is_relative_to(ROOT) else str(p)
def _path(label):return ROOT/label

def _walk(root):
 root=Path(root)
 if not root.is_dir():raise ValueError('Missing input tree: '+str(root))
 seen=set()
 def recurse(p):
  resolved=p.resolve()
  if resolved in seen:raise ValueError('Repeated/symlink-cycle input directory: '+str(p))
  seen.add(resolved)
  for child in sorted(p.iterdir()):
   if child.name in SKIP_NAMES or child.name.startswith('._'):continue
   if child.is_dir():yield from recurse(child)
   elif child.is_file():yield child
   else:raise ValueError('Unsupported or broken input entry: '+str(child))
 yield from recurse(root)

def _stamp(path):
 s=path.stat();return [s.st_dev,s.st_ino,s.st_size,s.st_mtime_ns,s.st_ctime_ns,s.st_mode&0o111]

def _scan(specs):
 CACHE.parent.mkdir(parents=True,exist_ok=True)
 lock=CACHE.with_suffix('.lock')
 with lock.open('a+') as guard:
  fcntl.flock(guard,fcntl.LOCK_EX)
  try:cache=json.loads(CACHE.read_text()) if CACHE.exists() else {}
  except (OSError,json.JSONDecodeError):cache={}
  rows={}
  for spec in specs:
   base=_path(spec['path'])
   if spec['kind']=='tree':paths=_walk(base)
   elif spec['kind']=='file':
    if not base.is_file():raise ValueError('Missing input file: '+str(base))
    paths=[base]
   else:raise ValueError('Unknown input spec kind')
   for p in paths:
    key=_label(p);signature=_stamp(p);cached=cache.get(key,{})
    if cached.get('stat')!=signature:
     with p.open('rb') as f:
      h=hashlib.sha256()
      while chunk:=f.read(1024*1024):h.update(chunk)
     if signature!=_stamp(p):raise ValueError('Input changed while hashing: '+key)
     cached={'stat':signature,'sha256':h.hexdigest()};cache[key]=cached
    item=rows.setdefault(key,{'sha256':cached['sha256'],'bytes':signature[2],'executable':bool(signature[5]),'roles':[]})
    if item['sha256']!=cached['sha256']:raise ValueError('Input changed while collecting: '+key)
    if spec['role']not in item['roles']:item['roles'].append(spec['role']);item['roles'].sort()
  fd,name=tempfile.mkstemp(prefix='input-hash-cache-',suffix='.json',dir=CACHE.parent)
  with os.fdopen(fd,'w')as f:json.dump(cache,f,separators=(',',':'))
  os.replace(name,CACHE)
  fcntl.flock(guard,fcntl.LOCK_UN)
 return dict(sorted(rows.items()))

def _environment():
 return {'python_version':sys.version,'python_implementation':platform.python_implementation(),
         'environment':{k:os.environ.get(k)for k in ENV_KEYS}}

def _digest(files,environment):
 return hashlib.sha256(json.dumps({'files':files,'environment':environment},sort_keys=True,separators=(',',':')).encode()).hexdigest()

def _store_toolchain(files):
 tool_files={k:v for k,v in files.items()if 'toolchain'in v['roles']or 'python_executable'in v['roles']}
 payload=(json.dumps({'schema':'yzlr2-toolchain-files-v1','files':tool_files},sort_keys=True,indent=2)+'\n').encode()
 digest=hashlib.sha256(payload).hexdigest();path=TOOLCHAINS/(digest+'.json');path.parent.mkdir(parents=True,exist_ok=True)
 if path.exists():
  if path.read_bytes()!=payload:raise ValueError('Content-addressed toolchain manifest changed')
 else:
  # Each writer uses the same immutable content for this name.
  fd,temp=tempfile.mkstemp(prefix='toolchain-',suffix='.json',dir=path.parent)
  with os.fdopen(fd,'wb')as f:f.write(payload)
  os.replace(temp,path)
 return {k:v for k,v in files.items()if k not in tool_files},{'path':_label(path),'sha256':digest,'file_count':len(tool_files)}

def _expand(snapshot):
 ref=snapshot['toolchain_manifest'];path=_path(ref['path']);payload=path.read_bytes()
 if hashlib.sha256(payload).hexdigest()!=ref['sha256']:raise ValueError('Toolchain manifest hash mismatch')
 d=json.loads(payload)
 if d.get('schema')!='yzlr2-toolchain-files-v1' or len(d['files'])!=ref['file_count']:raise ValueError('Invalid toolchain manifest')
 if set(snapshot['files'])&set(d['files']):raise ValueError('Duplicate toolchain/module input paths')
 return dict(sorted({**snapshot['files'],**d['files']}.items()))

def capture(module,source_root,*,extra_files=(),extra_trees=(),recipe_files=()):
 """Capture real inputs before staging. Extra paths are required, never optional."""
 specs=[{'kind':'tree','path':_label(source_root),'role':'canonical_source'},
        {'kind':'file','path':_label(ROOT/(module+'.swf')),'role':'original_swf'},
        {'kind':'file','path':_label(Path(__file__)),'role':'build_recipe'},
        {'kind':'file','path':_label(Path(sys.executable)),'role':'python_executable'}]
 for folder in (ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home',ROOT/'.runtime/shared-tools/flex/apache-flex-sdk-4.16.1-bin',ROOT/'.runtime/shared-tools/ffdec'):
  specs.append({'kind':'tree','path':_label(folder),'role':'toolchain'})
 for kind,paths,role in [('file',extra_files,'supporting_metadata'),('tree',extra_trees,'asset_or_config_tree'),('file',recipe_files,'build_recipe')]:
  for path in paths:specs.append({'kind':kind,'path':_label(path),'role':role})
 specs=sorted({(x['kind'],x['path'],x['role']):x for x in specs}.values(),key=lambda x:(x['role'],x['path'],x['kind']))
 files=_scan(specs);environment=_environment();compact,toolchain=_store_toolchain(files)
 return {'schema':SCHEMA,'generation':str(uuid.uuid4()),'module':module,
         'captured_before_build_utc':datetime.now(timezone.utc).isoformat(),
         'specs':specs,'files':compact,'toolchain_manifest':toolchain,'environment':environment,'digest':_digest(files,environment),
         'hash_cache':'content SHA256 cached only while device/inode/size/mtime_ns/ctime_ns/executable bits are unchanged',
         'post_build_verified':False}

def verify(snapshot):
 """Return issues; missing/old fingerprints are invalid. Does not require postcheck."""
 if not isinstance(snapshot,dict)or snapshot.get('schema')!=SCHEMA:return ['missing or unsupported build input fingerprint']
 required={'canonical_source','original_swf','build_recipe','toolchain','python_executable'}
 if not required.issubset({s.get('role')for s in snapshot.get('specs',[])}):return ['build input fingerprint lacks required categories']
 try:
  files=_scan(snapshot['specs']);environment=_environment()
  old=_expand(snapshot)
  if _digest(old,snapshot['environment'])!=snapshot['digest']:return ['build input fingerprint internally inconsistent']
  issues=[]
  added=sorted(set(files)-set(old));missing=sorted(set(old)-set(files));changed=sorted(p for p in set(old)&set(files)if files[p]!=old[p])
  if added:issues.append('build inputs added: '+', '.join(added[:8]))
  if missing:issues.append('build inputs removed: '+', '.join(missing[:8]))
  if changed:issues.append('build inputs changed: '+', '.join(changed[:8]))
  if environment!=snapshot['environment']:issues.append('build input environment changed')
  return issues
 except (OSError,ValueError,KeyError,TypeError)as error:return ['build input fingerprint check failed: '+str(error)]

def finish(snapshot):
 """Fail if any input changed during the build, then attest the actual postcheck."""
 issues=verify(snapshot)
 if issues:raise ValueError('; '.join(issues))
 result=dict(snapshot);result.update(post_build_verified=True,verified_after_build_utc=datetime.now(timezone.utc).isoformat())
 return result
