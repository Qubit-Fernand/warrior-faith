"""Compile unmodified canonical state/scenery into an isolated SWF9 probe."""
from pathlib import Path
from datetime import datetime, timezone
import json, subprocess, hashlib, shutil
ROOT=Path(__file__).resolve().parents[3]
out=ROOT/'reverse/build/homecoming-contract'/datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ')
source=out/'source';source.mkdir(parents=True)
shutil.copy2(Path(__file__).with_name('HomecomingHarness.as'),source/'HomecomingHarness.as')
canonical=ROOT/'reverse/source/3_L4399Main_gamefile'
names=['src/epilogue/ChapterState.as','src/epilogue/scene/ChapterScenery.as','src/epilogue/scene/LanternCrossing.as']
hashes={}
for name in names:
 p=source/name;p.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(canonical/name,p)
 hashes[name]=hashlib.sha256(p.read_bytes()).hexdigest()
java=ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'
flex=ROOT/'.runtime/shared-tools/flex/apache-flex-sdk-4.16.1-bin'
player=ROOT/'.runtime/shared-tools/ffdec/flashlib/playerglobal32_0.swc'
cmd=[str(java),'-Djava.awt.headless=true',f'-Dflexlib={flex}/frameworks','-jar',str(flex/'lib/mxmlc.jar'),'-load-config=','-compiler.theme=',f'-compiler.external-library-path={player}',f'-compiler.source-path={source}','-compiler.strict=true','-target-player=32.0','-swf-version=9','-use-network=false',f'-output={out}/HomecomingHarness.swf',str(source/'HomecomingHarness.as')]
r=subprocess.run(cmd,capture_output=True,text=True);(out/'compile.log').write_text(r.stdout+r.stderr)
(out/'receipt.json').write_text(json.dumps({'canonical_hashes':hashes,'exit':r.returncode,'output':str(out/'HomecomingHarness.swf')},indent=2))
print(r.stdout+r.stderr);print(out)
raise SystemExit(r.returncode)
