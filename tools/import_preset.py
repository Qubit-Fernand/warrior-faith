#!/usr/bin/env python3
"""Restore a preset into one local slot, backing up the whole save first."""
import argparse,copy,datetime,os,subprocess
from pathlib import Path
from sol import loads,dumps,graph
ROOT=Path(__file__).resolve().parent.parent
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('save',type=Path);p.add_argument('--slot',type=int,default=1);p.add_argument('--replace',action='store_true')
a=p.parse_args()
if not 1<=a.slot<=8:p.error('slot must be 1..8')
if any(s.strip().endswith('/Flash Player') for s in subprocess.check_output(['ps','-axo','comm'],text=True).splitlines()):p.error('Quit Flash Player before importing')
raw=a.save.read_bytes();name,data=loads(raw);_,preset=loads((ROOT/'presets/毕业体验档.sol').read_bytes());i=a.slot-1
if data['slots'][i] is not None and not a.replace:p.error('Occupied slot: --replace explicitly restores that slot; other slots remain intact')
original=[graph(x) for x in data['slots'].dense]
s=copy.deepcopy(preset['slots'][0]);s['index']=i;s['title']='P1:Lv85 毕业体验';s['datetime']=datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
token=s['data']['logNameSave'];s['data']['logNameSave']=token[:5]+str(i)+token[6:];data['slots'][i]=s
out=dumps(name,data);_,check=loads(out)
assert graph(check)==graph(data)
assert all(graph(check['slots'][j])==original[j] for j in range(8) if j!=i)
b=ROOT/'save-backups'/(datetime.datetime.now().strftime('%Y%m%d-%H%M%S')+'-preset-restore');b.mkdir(parents=True,exist_ok=False);(b/'before.sol').write_bytes(raw)
assert a.save.read_bytes()==raw,'Save changed while preparing'
tmp=a.save.with_suffix('.sol.preset-tmp');tmp.write_bytes(out);os.replace(tmp,a.save)
print(f'Restored slot {a.slot}; previous full save: {b / "before.sol"}')
