#!/usr/bin/env python3
"""Rebuild representative SWF libraries from FFDec AS source + script-free assets.

Uses no original ABC bytecode. Extracted art/timelines retain their original data.
No Flash execution or SharedObject access. Commands and result manifests retained.
"""
from __future__ import annotations
import argparse, hashlib, json, shutil, struct, subprocess, time, zipfile, zlib
from pathlib import Path
from probe_normalize_swf import normalize
from swf_inventory import read_swf
from probe_source_repairs import prepare,restore
from probe_root_timeline import prepare_buttons,restore_root
from build_inputs import capture,finish
ROOT=Path(__file__).resolve().parents[2]
JAVA=ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'
FFDEC=ROOT/'.runtime/shared-tools/ffdec/ffdec.jar'
FLEX=ROOT/'.runtime/shared-tools/flex/apache-flex-sdk-4.16.1-bin'
PLAYER=ROOT/'.runtime/shared-tools/ffdec/flashlib/playerglobal32_0.swc'
BUILD=ROOT/'reverse/build/module-probe'
LOGS=ROOT/'reverse/logs/module-probe'
SOURCES=ROOT/'reverse/experiments/module-probe'
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def tags(path):
 raw=path.read_bytes(); data=raw[8:] if raw[:3]==b'FWS' else zlib.decompress(raw[8:])
 assert raw[:3] in (b'FWS',b'CWS')
 n=data[0]>>3; start=(5+4*n+7)//8+4
 def walk(data,pos):
  while pos+2<=len(data):
   head=struct.unpack_from('<H',data,pos)[0];pos+=2;code=head>>6;size=head&63
   if size==63: size=struct.unpack_from('<I',data,pos)[0];pos+=4
   payload=data[pos:pos+size];pos+=size
   assert len(payload)==size
   yield code,payload
   if code==39: yield from walk(payload,4)
   if code==0: break
 return list(walk(data,start))
def run(args,name):
 LOGS.mkdir(parents=True,exist_ok=True)
 args=list(map(str,args)); start=time.time()
 p=subprocess.run(args,cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,timeout=300)
 logname=f'{name}-{time.time_ns()}.txt';(LOGS/logname).write_bytes(p.stdout)
 (LOGS/f'{name}.txt').write_bytes(p.stdout)
 with (LOGS/'commands.jsonl').open('a') as f: f.write(json.dumps({'command':args,'exit':p.returncode,'seconds':round(time.time()-start,3),'log':logname},ensure_ascii=False)+'\n')
 if p.returncode: raise RuntimeError(f'{name}: exit {p.returncode}; see log')
 return p.stdout

def main():
 ap=argparse.ArgumentParser();ap.add_argument('module',help='root SWF stem (path separators forbidden)');ap.add_argument('--refresh-source',action='store_true');ap.add_argument('--dynamic',action='store_true',help='Preserve dynamic AVM2 coercions with compiler.strict=false');a=ap.parse_args()
 assert Path(a.module).name==a.module and '/' not in a.module and '\\' not in a.module
 original=ROOT/f'{a.module}.swf';original_header=read_swf(original)[2];b=BUILD/a.module;b.mkdir(parents=True,exist_ok=True)
 exported=b/'ffdec';source=SOURCES/a.module/'src';canonical=ROOT/'reverse/source'/a.module
 if canonical.exists():source=canonical
 source.mkdir(parents=True,exist_ok=True)
 shared=ROOT/'reverse/exports'/a.module;receipt_path=shared/'scripts-receipt.json'
 receipt=json.loads(receipt_path.read_text()) if receipt_path.exists() else {}
 if receipt.get('status')=='ok' and receipt.get('source_sha256')==sha(original) and (shared/'scripts').exists():
  es=shared/'scripts';export_provenance=str(receipt_path.relative_to(ROOT))
 else:
  run([JAVA,'-jar',FFDEC,'-exportembed','-export','script',exported,original],a.module+'-export')
  es=exported/'scripts';export_provenance=str(exported.relative_to(ROOT))
 for f in es.rglob('*.as'):
  target=source/f.relative_to(es)
  if not canonical.exists() and (a.refresh_source or not target.exists()): target.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(f,target)
 input_snapshot=capture(a.module,source,extra_trees=[es/'_assets'],extra_files=[receipt_path] if export_provenance==str(receipt_path.relative_to(ROOT)) else [],recipe_files=[ROOT/'reverse/tools'/f for f in ['probe_rebuild_module.py','probe_normalize_swf.py','probe_source_repairs.py','probe_root_timeline.py','probe_resource_family.py','swf_inventory.py']])
 original_header=read_swf(original)[2]
 compile_src=b/'compile-source'
 if compile_src.exists():
  history=b/'source-history';history.mkdir(exist_ok=True);compile_src.rename(history/str(time.time_ns()))
 repairs=prepare(source,compile_src)
 assets=es/'_assets'
 if assets.exists(): shutil.copytree(assets,compile_src/'_assets',dirs_exist_ok=True)
 repairs['button_embed_repairs']=prepare_buttons(original,compile_src)
 asset_report=[]
 for f in (compile_src/'_assets').rglob('*'):
  if f.is_file():
   parsed_tags=tags(f) if f.suffix=='.swf' else []
   codes=[c for c,_ in parsed_tags]
   assert not any(c==7 or (c==34 and struct.unpack_from('<H',x,3)[0]) or (c in (26,70) and x[0]&128) for c,x in parsed_tags),f'Embedded AVM1 action candidate in asset {f}'
   assert not any(c in (12,59,72,82) for c in codes),f'Original script found in asset {f}'
   asset_report.append({'file':str(f.relative_to(compile_src)),'sha256':sha(f),'script_tags':0})
 classes=sorted('.'.join(p.relative_to(compile_src).with_suffix('').parts) for p in compile_src.rglob('*.as'))
 common=[JAVA,f'-Dflexlib={FLEX}/frameworks','-jar',FLEX/'lib/compc.jar','-load-config=','-compiler.theme=',f'-compiler.external-library-path={PLAYER}','-compiler.library-path=',f'-compiler.source-path={compile_src}',f'-compiler.strict={str(not a.dynamic).lower()}','-debug=false','-use-network=false',f'-swf-version={original_header["version"]}',f'-default-frame-rate={int(original_header["frame_rate"])}',f'-default-size={(original_header["rect_twips"][1]-original_header["rect_twips"][0])//20},{(original_header["rect_twips"][3]-original_header["rect_twips"][2])//20}','-include-classes',*classes]
 swfs=[];normalizations=[]
 for index in (1,2):
  swc=b/f'compile-{index}-{time.time_ns()}.swc';run([*common,f'-output={swc}'],f'{a.module}-compile-{index}')
  assert swc.exists(), 'Compiler did not emit SWC (may exit zero on configuration errors)'
  out=b/f'compile-{index}.swf'
  with zipfile.ZipFile(swc) as z: out.write_bytes(z.read('library.swf'))
  normalized=b/f'normalized-{index}.swf'
  if repairs['safe_to_original_identifiers']:
   valid=b/f'valid-{index}.swf';first=normalize(out,valid);restored=b/f'restored-{index}.swf';names=restore(valid,restored,repairs['safe_to_original_identifiers']);last=normalize(restored,normalized,original);last['unicode_doabc_repairs']=first['unicode_doabc_repairs'];last['name_restoration']=names
  else: last=normalize(out,normalized,original)
  root_fixed=b/f'root-fixed-{index}.swf'
  root_timeline=restore_root(original,normalized,root_fixed)
  normalizations.append(last);swfs.append(root_fixed)
 output=b/f'{a.module}-rebuilt.swf';shutil.copy2(swfs[0],output)
 rebuilt_header=read_swf(output)[2]
 for key in ('version','rect_twips','frame_rate','frame_count'): assert rebuilt_header[key]==original_header[key],f'header mismatch: {key}'
 # ProductInfo compilation timestamps can change without semantic bytecode differences.
 def semantic(p): return [(c,hashlib.sha256(v).hexdigest()) for c,v in tags(p) if c!=41]
 report={'module':a.module,'input_fingerprint':finish(input_snapshot),'root_timeline':root_timeline,'export_provenance':export_provenance,'compiler_strict':not a.dynamic,'original_header':original_header,'rebuilt_header':rebuilt_header,'original_sha256':sha(original),'classes':classes,'assets':asset_report,'output':str(output.relative_to(ROOT)),'output_sha256':sha(output),'compile_twice_exact_equal':sha(swfs[0])==sha(swfs[1]),'compile_twice_tags_except_productinfo_equal':semantic(swfs[0])==semantic(swfs[1]),'source_root':str(source.relative_to(ROOT)),'source_repairs':repairs,'normalization':normalizations[0],'original_abc_reused':False,'asset_timeline_reused':bool(asset_report),'runtime_test':'not performed by this probe','source_files':{str(p.relative_to(ROOT)):sha(p) for p in source.rglob('*.as')}}
 (SOURCES/a.module/'result.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
 print(json.dumps(report,ensure_ascii=False,indent=2))
if __name__=='__main__':main()
