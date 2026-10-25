#!/usr/bin/env python3
"""Read an explicitly supplied dedicated diagnostic SOL, never enumerate save stores."""
import argparse,json,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(ROOT/'tools'))
from sol import loads,Obj,Arr,Date,Special
NAMES=('yzlr2_timeline_helper_probe_v1','yzlr2_timeline_tracked_probe_v1')

def plain(value,active=None):
    if active is None:active=set()
    if isinstance(value,(Obj,Arr,dict,list,tuple)):
        key=id(value)
        if key in active:raise ValueError('Unexpected cycle in diagnostic report')
        active.add(key)
        try:
            if isinstance(value,Obj):return {k:plain(v,active) for k,v in value.fields.items()}
            if isinstance(value,Arr):
                dense=[plain(v,active) for v in value.dense]
                return {'dense':dense,'assoc':{k:plain(v,active) for k,v in value.assoc.items()}} if value.assoc else dense
            if isinstance(value,dict):return {k:plain(v,active) for k,v in value.items()}
            return [plain(v,active) for v in value]
        finally:active.remove(key)
    if isinstance(value,Date):return {'dateMilliseconds':value.milliseconds}
    if value is Special.UNDEFINED:return {'undefined':True}
    return value

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('path',type=Path);a=p.parse_args()
    accepted=[name for name in NAMES if a.path.name in (name+'.sol',name[3:]+'.sol') or (a.path.parent.name.endswith('#') and a.path.parent.name[:-1]+a.path.stem==name)]
    assert accepted,'Only the dedicated test reports are accepted'
    assert a.path.stat().st_size<300000
    name,fields=loads(a.path.read_bytes());assert name in accepted
    print(json.dumps(plain(fields['report']),ensure_ascii=False,indent=2))
