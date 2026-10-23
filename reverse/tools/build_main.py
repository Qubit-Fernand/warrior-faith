#!/usr/bin/env python3
"""Recompile recovered main AS3, with explicit recorded decompiler repairs."""
import argparse,hashlib,json,shutil,subprocess,time,tempfile
from pathlib import Path
from probe_normalize_swf import normalize
ROOT=Path(__file__).resolve().parents[2]
JAVA=ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'
FLEX=ROOT/'.runtime/shared-tools/flex/apache-flex-sdk-4.16.1-bin'
PLAYER=ROOT/'.runtime/shared-tools/ffdec/flashlib/playerglobal32_0.swc'
RAW=ROOT/'reverse/exports/3_L4399Main_gamefile/scripts'
BUILD=ROOT/'reverse/build/main-probe'
def main():
    ap=argparse.ArgumentParser();ap.add_argument('--all-definitions',action='store_true')
    ap.add_argument('--source-dir',type=Path,default=ROOT/'reverse/source/3_L4399Main_gamefile')
    ap.add_argument('--save-name',default='yzlr2_rebuild_probe')
    a=ap.parse_args()
    if not a.save_name.startswith('yzlr2_rebuild_') or not a.save_name.replace('_','').isalnum():
        raise ValueError('Reconstruction test stores must use a safe yzlr2_rebuild_ prefix')
    BUILD.mkdir(parents=True,exist_ok=True)
    run=Path(tempfile.mkdtemp(prefix='run-',dir=BUILD));src=BUILD/'source'
    # Flex's private-name numbering/order depends on absolute source paths.
    # Keep a stable staging path, but archive its entire previous contents so
    # deleted source files cannot silently survive into the next compilation.
    if src.exists():shutil.move(str(src),str(run/'prior-source'))
    # The tracked source tree is editable; export-derived resources remain separate.
    shutil.copytree(a.source_dir,src);changes=[]
    for asset in RAW.rglob('*'):
        if asset.is_file() and asset.suffix!='.as':
            dest=src/asset.relative_to(RAW);dest.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(asset,dest)
    source_hashes={p.relative_to(src).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(src.rglob('*.as'))}
    def repair(file,before,after,reason):
        p=src/file;s=p.read_text();count=s.count(before)
        if not count:raise ValueError(f'Expected repair not found: {file}')
        p.write_text(s.replace(before,after));changes.append({'file':file,'occurrences':count,'before':before,'after':after,'reason':reason})
    repair('src/Player2.as','               {};','               ;','FFDec emits empty block followed by semicolon inside an empty else; replace with legal empty statement, no behavior removed.')
    for f in ['src/_data/ShopFactory.as','src/_data/XingLingFactory.as','src/Shop_LiBao2.as']:
        repair(f,'   import com.hotpoint.braveManIII.Tool.*;','   import com.hotpoint.braveManIII.Tool.XMLAsset;','Original bytecode resolves XMLAsset in Tool for the first two factories. Shop_LiBao2 includes both XMLAsset namespaces, whose implementation bodies are identical; runtime test required.')
        replacement='   import src.tool.TiaoShi;' if f!='src/Shop_LiBao2.as' else ''
        repair(f,'   import src.tool.*;',replacement,'Expand src.tool wildcard to actual non-XMLAsset references, eliminating conflicting src.tool.XMLAsset candidate without changing resolved TiaoShi class.')
    # Runtime tests MUST use their own save store; never write yzlr2_saves/final.
    repair('src/LocalSaveManager.as','"yzlr2_saves"',json.dumps(a.save_name),'Test-only isolation of SharedObject; original source and player saves untouched.')
    out=run/'raw.swf'
    cmd=[str(JAVA),'-Xmx5g','-Djava.awt.headless=true',f'-Dflexlib={FLEX}/frameworks','-jar',str(FLEX/'lib/mxmlc.jar'),'-load-config=','-compiler.theme=',f'-compiler.external-library-path={PLAYER}',f'-compiler.source-path={src}','-compiler.strict=false','-target-player=32.0','-use-network=false','-debug=false',f'-output={out}']
    if a.all_definitions:
        classes=sorted('.'.join(p.relative_to(src).with_suffix('').parts) for p in src.rglob('*.as') if p.relative_to(src).as_posix()!='src/Main.as')
        cmd+=['-includes='+','.join(classes)]
    cmd+=[str(src/'src/Main.as')]
    log=ROOT/'reverse/logs/main-probe'/('compile-all.log' if a.all_definitions else 'compile-reachable.log');log.parent.mkdir(parents=True,exist_ok=True)
    start=time.time()
    with log.open('w') as f:cp=subprocess.run(cmd,cwd=ROOT,stdout=f,stderr=subprocess.STDOUT,timeout=600)
    log_text=log.read_text(errors='replace')
    success=cp.returncode==0 and out.is_file() and 'Error:' not in log_text
    row={'command':cmd,'exit':cp.returncode,'success':success,'elapsed_seconds':time.time()-start,'source_root':str(a.source_dir),'source_sha256':source_hashes,'source_repairs':changes,'save_store':a.save_name,'compiler_mode':'strict=false preserves dynamic/unresolved references and runtime coercions rather than inventing declarations to satisfy strict checking','output':str(out.relative_to(ROOT)),'runtime_validated':False}
    if success:
        normalized=run/'normalized.swf'
        row['normalization']=normalize(out,normalized,ROOT/'3_L4399Main_gamefile.swf')
        row['output_sha256']=hashlib.sha256(normalized.read_bytes()).hexdigest()
        row['normalized_output']=str(normalized.relative_to(ROOT))
        shutil.copy2(out,BUILD/('main-all-raw.swf' if a.all_definitions else 'main-reachable-raw.swf'))
        shutil.copy2(normalized,BUILD/('main-normalized.swf' if a.all_definitions else 'main-reachable-normalized.swf'))
    shutil.copy2(log,run/'compile.log')
    (run/'receipt.json').write_text(json.dumps(row,ensure_ascii=False,indent=2)+'\n')
    (BUILD/('build-all.json' if a.all_definitions else 'build-reachable.json')).write_text(json.dumps(row,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:v for k,v in row.items() if k not in ('command','source_repairs','source_sha256','normalization')},ensure_ascii=False,indent=2))
    raise SystemExit(0 if success else 1)
if __name__=='__main__':main()
