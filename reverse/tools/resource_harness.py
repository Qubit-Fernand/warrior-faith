#!/usr/bin/env python3
"""Build/package a standalone resource import probe; never starts a player.

Only the explicitly named diagnostic SOL is read. Original/rebuilt modules are
copied into separate fresh directories; main and DataX are never packaged.
"""
from pathlib import Path
import argparse,datetime,hashlib,json,re,shutil,subprocess,sys,uuid
from swf_inventory import abc_inventory,read_swf,walk_tags
ROOT=Path(__file__).resolve().parents[2]
SOURCE=ROOT/'reverse/experiments/resource-harness'
BUILD=ROOT/'reverse/build/resource-harness'
SWF='ResourceHarness.swf'
NAME='yzlr2_resource_probe'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def build():
 BUILD.mkdir(parents=True,exist_ok=True)
 java=ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java';flex=ROOT/'.runtime/shared-tools/flex/apache-flex-sdk-4.16.1-bin';player=ROOT/'.runtime/shared-tools/ffdec/flashlib/playerglobal32_0.swc'
 command=[str(java),'-Djava.awt.headless=true',f'-Dflexlib={flex}/frameworks','-jar',str(flex/'lib/mxmlc.jar'),'-load-config=','-compiler.theme=',f'-compiler.external-library-path={player}','-compiler.library-path=',f'-compiler.source-path={SOURCE}','-target-player=32.0','-use-network=false','-debug=false',f'-output={BUILD/SWF}',str(SOURCE/'ResourceHarness.as')]
 r=subprocess.run(command,cwd=ROOT,capture_output=True,text=True,timeout=90);(BUILD/'compile.log').write_text(r.stdout+r.stderr)
 if r.returncode:raise RuntimeError(r.stdout+r.stderr)
 _,body,h=read_swf(BUILD/SWF);abcs=[]
 for t,p in walk_tags(body,h['tag_start']):
  if t['code']==82:abcs.append(abc_inventory(p[p.index(b'\0',4)+1:]))
 classes=[c['name']for a in abcs for c in a['classes']];strings={s for a in abcs for s in a['strings']}
 assert classes==['ResourceHarness'],classes
 assert NAME in strings and not any(s in strings for s in('yzlr2_saves','yzlr2_diagnostic_probe','3_L4399Main_gamefile.swf','DataX_v76.swf'))
 report={'schema':'yzlr2-resource-wrapper-build-v1','utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'source_sha256':sha(SOURCE/'ResourceHarness.as'),'swf_sha256':sha(BUILD/SWF),'classes':classes,'shared_object':NAME,'shared_object_path':'default path; macOS projector observed localhost shared across packages; export results sequentially','command':command,'player_started':False,'game_save_accessed':False,'runtime_tested':False}
 (SOURCE/'build.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print(json.dumps(report,ensure_ascii=False,indent=2))
def prepare_pair():
 receipt=json.loads((SOURCE/'build.json').read_text());assert sha(BUILD/SWF)==receipt['swf_sha256']and sha(SOURCE/'ResourceHarness.as')==receipt['source_sha256'],'Wrapper changed; rebuild first'
 audit=json.loads((ROOT/'reverse/manifests/module-roots.json').read_text());assert len(audit['modules'])==162 and all(r['rebuilt_status']=='current'for r in audit['modules'])
 assert all(not r['comparison']['missing_linkage_classes']and not r['comparison']['extra_linkage_classes']and not r['comparison']['linkage_type_changes']and r['root_restoration_audit']['root_controls_and_reviewed_dependencies_match']and r['root_restoration_audit']['metadata_payloads_equal']for r in audit['modules']),'Static audit must pass first'
 run=datetime.datetime.now(datetime.timezone.utc).strftime('%Y%m%dT%H%M%SZ')+'-'+uuid.uuid4().hex[:8];outputs=[]
 for mode in('original','rebuilt'):
  directory=ROOT/'reverse/build'/('resource-probe-'+run+'-'+mode);directory.mkdir();(directory/'modules').mkdir();shutil.copyfile(BUILD/SWF,directory/SWF);files=[]
  for row in audit['modules']:
   spec=row['original'if mode=='original'else'rebuilt'];source=(ROOT/spec['path']).resolve();assert source.is_relative_to(ROOT.resolve());assert sha(source)==spec['sha256'],'Resource changed after audit: '+row['module']
   filename=row['module']+'.swf';dest=directory/'modules'/filename;shutil.copyfile(source,dest);assert sha(dest)==spec['sha256']
   symbols=sorted(n for n,i in row['original']['symbol_classes'].items()if i)
   keys={'Map0_v26':['src.npc.村长','src.npc.装备','src.npc.药品','src.npc.仓库'],'Enemy5_v2':['src.HitXX'],'Enemy16':['src.HitXX']}.get(row['module'],[])
   files.append({'module':row['module'],'file':filename,'sha256':spec['sha256'],'symbols':symbols,'keys':keys})
  manifest={'schema':'yzlr2-resource-manifest-v1','runId':run,'manifestId':uuid.uuid4().hex,'mode':mode,'wrapperBuild':receipt['swf_sha256'],'files':files}
  (directory/'probe-manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
  package={'schema':'yzlr2-resource-package-v1','directory':str(directory.relative_to(ROOT)),'runId':run,'mode':mode,'manifestId':manifest['manifestId'],'manifest_sha256':sha(directory/'probe-manifest.json'),'wrapper_sha256':sha(directory/SWF),'audit_sha256':sha(ROOT/'reverse/manifests/module-roots.json'),'resource_count':len(files),'source_mode':mode,'shared_object':NAME,'main_and_datax_excluded':True,'player_started':False}
  (directory/'package-receipt.json').write_text(json.dumps(package,ensure_ascii=False,indent=2)+'\n');outputs.append(package)
 (SOURCE/'latest-pair.json').write_text(json.dumps({'runId':run,'packages':outputs},ensure_ascii=False,indent=2)+'\n');print(json.dumps(outputs,ensure_ascii=False,indent=2))
def read_sol(path,package,full=False):
 path=path.expanduser().resolve();package=package.expanduser().resolve();assert path.name==NAME+'.sol','Only resource probe SOL filename accepted';assert package.parent==ROOT/'reverse/build'and package.name.startswith('resource-probe-')
 receipt=json.loads((package/'package-receipt.json').read_text());assert sha(package/'probe-manifest.json')==receipt['manifest_sha256'];assert sha(package/SWF)==receipt['wrapper_sha256'];data=path.read_bytes();assert len(data)<=100000
 assert data[:2]==b'\0\xbf'and data[6:16]==b'TCSO\0\x04\0\0\0\0';n=int.from_bytes(data[16:18],'big');assert data[18:18+n].decode()==NAME,'Unexpected internal SOL name'
 sys.path.insert(0,str(ROOT/'tools'));from sol import loads
 name,fields=loads(data);assert name==NAME and set(fields)=={'json'};report=json.loads(fields['json']);assert report['schema']=='yzlr2-resource-probe-v1'and report['runId']==receipt['runId']and report['mode']==receipt['mode']and report['manifestId']==receipt['manifestId']
 manifest=json.loads((package/'probe-manifest.json').read_text());expected=[x['module']for x in manifest['files']];rows=report['rows'];assert len(rows)<=162 and [r['m']for r in rows]==expected[:len(rows)]
 summary={'runId':report['runId'],'mode':report['mode'],'complete':report['complete'],'observed':len(rows),'clean_complete':sum(r['s']=='complete'and r.get('errorCount',0)==0 and r.get('missingCount',1)==0 for r in rows),'issues':[r for r in rows if r['s']!='complete'or r.get('errorCount',0)or r.get('missingCount',1)],'fatal':report['fatal'],'persistError':report['persistError'],'package':str(package.relative_to(ROOT)),'source_sol_sha256':hashlib.sha256(data).hexdigest()}
 result={'summary':summary,'report':report,'package_receipt':receipt};out=SOURCE/'results';out.mkdir(exist_ok=True);target=out/(report['runId']+'-'+report['mode']+'.json');target.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n');print(json.dumps(result if full else summary,ensure_ascii=False,indent=2));print('Saved',target)
def compare(original,rebuilt):
 a=json.loads(original.read_text());b=json.loads(rebuilt.read_text());assert a['summary']['mode']=='original'and b['summary']['mode']=='rebuilt'and a['summary']['runId']==b['summary']['runId'];aa=a['report']['rows'];bb=b['report']['rows'];assert len(aa)==len(bb)==162 and a['report']['complete']and b['report']['complete'];changes=[]
 for x,y in zip(aa,bb):
  assert x['m']==y['m'];keys=('s','t','n','f','expected','missingCount','errors','errorCount','completeEvent','initEvent','tree','keyVisible');diff={k:{'original':x.get(k),'rebuilt':y.get(k)}for k in keys if x.get(k)!=y.get(k)}
  if diff:changes.append({'module':x['m'],'differences':diff})
 result={'schema':'yzlr2-resource-runtime-comparison-v1','runId':a['summary']['runId'],'original_clean':a['summary']['clean_complete'],'rebuilt_clean':b['summary']['clean_complete'],'differences':changes,'scope':'Same standalone harness import/visible-definition/root observations only; no arbitrary instance creation or game behavior equivalence claim.'};out=SOURCE/'results'/(result['runId']+'-comparison.json');out.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n');print(json.dumps(result,ensure_ascii=False,indent=2))
def main():
 p=argparse.ArgumentParser(description=__doc__);sub=p.add_subparsers(dest='action',required=True);sub.add_parser('build');sub.add_parser('prepare-pair');r=sub.add_parser('read-sol');r.add_argument('path',type=Path);r.add_argument('--package',type=Path,required=True);r.add_argument('--full',action='store_true');c=sub.add_parser('compare');c.add_argument('original',type=Path);c.add_argument('rebuilt',type=Path);args=p.parse_args()
 if args.action=='build':build()
 elif args.action=='prepare-pair':prepare_pair()
 elif args.action=='read-sol':read_sol(args.path,args.package,args.full)
 else:compare(args.original,args.rebuilt)
if __name__=='__main__':main()
