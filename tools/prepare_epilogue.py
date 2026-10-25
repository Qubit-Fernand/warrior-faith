#!/usr/bin/env python3
"""Build an isolated game core and seed its saves only on first launch."""
from pathlib import Path
import hashlib,struct,zlib,shutil,datetime
from sol import loads,dumps
ROOT=Path(__file__).resolve().parent.parent
source=ROOT/'3_L4399Main_gamefile.swf'
expected=next(x.split()[0] for x in (ROOT/'SHA256SUMS').read_text().splitlines() if x.endswith('  3_L4399Main_gamefile.swf'))
b=source.read_bytes();assert hashlib.sha256(b).hexdigest()==expected,'Original game changed; review patch before continuing'
assert b[:3] in (b'CWS',b'FWS')
body=zlib.decompress(b[8:]) if b[:3]==b'CWS' else b[8:]
assert body.count(b'yzlr2_saves')==1
body=body.replace(b'yzlr2_saves',b'yzlr2_final');core=b'CWS'+b[3:8]+zlib.compress(body)
assert struct.unpack('<I',core[4:8])[0]==len(body)+8
out=ROOT/'终章核心.swf'
if not out.exists() or out.read_bytes()!=core:out.write_bytes(core)
base=Path.home()/'Library/Preferences/Macromedia/Flash Player/#SharedObjects'
sources=list(base.glob('*/localhost/yzlr2_saves.sol'))
if len(sources)==1:
 original=sources[0];target=original.with_name('yzlr2_final.sol')
 if not target.exists():
  _,data=loads(original.read_bytes());target.write_bytes(dumps('yzlr2_final',data));print('Seeded separate final-chapter save:',target)
else: print('No unique original save found; game will create an independent save.')
backup=ROOT/'save-backups'/(datetime.datetime.now().strftime('%Y%m%d-%H%M%S-%f')+'-epilogue')
for pat in ['*/localhost/yzlr2_final.sol','*/localhost/yzlr2_epilogue.sol']:
 for f in base.glob(pat):
  backup.mkdir(parents=True,exist_ok=True);shutil.copy2(f,backup/f.name)
print('Core ready:',out)
