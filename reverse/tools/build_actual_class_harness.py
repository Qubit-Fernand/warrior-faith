#!/usr/bin/env python3
"""Create isolated real-class probes; no game execution or save access."""
from pathlib import Path
import argparse,hashlib,json,struct,subprocess,shutil,datetime
from probe_root_timeline import parts,bindings,ROOT_CONTROLS
from probe_normalize_swf import encode
from probe_source_repairs import packtag
from swf_inventory import Reader
ROOT=Path(__file__).resolve().parents[2]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def library(subject,target):
 raw,b,h,ts=parts(subject);symbols=bindings(ts);assert symbols.get('src.Main')==0
 controls=[c for c,x in ts if c in ROOT_CONTROLS];assert all(c in(1,43,45)for c in controls),controls
 out=[];removed=[]
 for c,x in ts:
  if c==76:
   r=Reader(x);entries=[]
   for _ in range(r.u16()):
    cid=r.u16();name=r.cstr()
    if cid==0:removed.append(name)
    else:entries.append((cid,name))
   x=struct.pack('<H',len(entries))+b''.join(struct.pack('<H',cid)+name.encode()+b'\0'for cid,name in entries)
  out.append((c,x))
 assert removed==['src.Main']
 target.write_bytes(encode(raw,b[:h['tag_start']]+b''.join(packtag(c,x)for c,x in out)))
 _,nb,nh,nt=parts(target);assert [x for c,x in ts if c in(72,82)]==[x for c,x in nt if c in(72,82)]
 assert all(cid!=0 for cid in bindings(nt).values())
 assert [(c,x)for c,x in ts if c!=76]==[(c,x)for c,x in nt if c!=76]
 return {'removed_document_binding':removed,'all_abc_payloads_byte_identical':True,'all_non_symbolclass_tags_byte_identical':True,'original_root_control_codes':controls,'library_sha256':sha(target),'source_sha256':sha(subject)}
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--rebuilt',help='Immutable normalized SWF; default is latest successful main build receipt');ap.add_argument('--reuse-wrapper',action='store_true');a=ap.parse_args();latest=json.loads((ROOT/'reverse/build/main-probe/build-all.json').read_text())if not a.rebuilt else None
 if latest is not None:assert latest.get('success')and latest.get('exit')==0
 rebuilt=(ROOT/(a.rebuilt or latest['normalized_output'])).resolve();h=sha(rebuilt)
 validation=ROOT/f'reverse/manifests/main-semantic-repairs-validation-{h[:12]}.json';v=json.loads(validation.read_text());assert v['passed']and v['swf_sha256']==h and v['verified_methods']==24
 source=ROOT/'reverse/experiments/actual-class-harness';build=ROOT/'reverse/build/actual-class-harness';build.mkdir(parents=True,exist_ok=True)
 java=ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java';flex=ROOT/'.runtime/shared-tools/flex/apache-flex-sdk-4.16.1-bin';swf=build/'ActualClassHarness.swf'
 cmd=[str(java),'-Djava.awt.headless=true',f'-Dflexlib={flex}/frameworks','-jar',str(flex/'lib/mxmlc.jar'),'-load-config=','-compiler.theme=',f'-compiler.external-library-path={ROOT}/.runtime/shared-tools/ffdec/flashlib/playerglobal32_0.swc','-compiler.library-path=',f'-compiler.source-path={source}','-target-player=32.0','-use-network=false','-debug=true',f'-output={swf}',str(source/'ActualClassHarness.as')]
 if a.reuse_wrapper:
  previous=json.loads((source/'build.json').read_text());assert previous['source_sha256']==sha(source/'ActualClassHarness.as')and previous['wrapper_sha256']==sha(swf),'Wrapper/source changed'
 else:
  r=subprocess.run(cmd,capture_output=True,text=True,timeout=90);(build/'compile.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout+r.stderr
 packages=[]
 for mode,subject in [('original',ROOT/'3_L4399Main_gamefile.swf'),('rebuilt',rebuilt)]:
  subject_hash=sha(subject);dest=build/(mode+'-'+subject_hash[:12]+'-'+sha(swf)[:8]);dest.mkdir(exist_ok=True)
  transform=library(subject,dest/'subject-library.swf');shutil.copy2(swf,dest/'ActualClassHarness.swf')
  config={'schema':'yzlr2-actual-class-v1','mode':mode,'subjectSHA256':subject_hash,'librarySHA256':sha(dest/'subject-library.swf'),'wrapperSHA256':sha(swf),'probeFormat':'json-v3','expectedCases':183,'expectedContainerCases':172,'expectedAchievementCases':11,'scope':'Unmodified actual game ABC in root-binding-stripped library; fresh domain, synthetic repository records and actual item/container/achievement instances. No game Main constructor.'}
  (dest/'fixture.json').write_text(json.dumps(config,ensure_ascii=False,indent=2)+'\n')
  packages.append({'mode':mode,'package':str(dest.relative_to(ROOT)),'subject':str(subject.relative_to(ROOT)),'fixture_sha256':sha(dest/'fixture.json'),'transformation':transform,'probe_result_so_name':'yzlr2_actual_class_'+mode+'_'+subject_hash[:12]+'_'+sha(swf)[:8]})
 receipt={'schema':1,'created_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'compiled':True,'wrapper_reused_without_recompiling':a.reuse_wrapper,'runtime_tested':False,'source_sha256':sha(source/'ActualClassHarness.as'),'wrapper_sha256':sha(swf),'command':cmd,'fresh_rebuilt_validation':str(validation.relative_to(ROOT)),'packages':packages,'excluded':'SetKeyPanel.closeOk is private; no access bypass or allClosePanel/UI setup attempted.'}
 (source/('build-'+sha(swf)[:12]+'-'+h[:12]+'.json')).write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n');(source/'build.json').write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n');print(json.dumps(receipt,ensure_ascii=False,indent=2))
if __name__=='__main__':main()
