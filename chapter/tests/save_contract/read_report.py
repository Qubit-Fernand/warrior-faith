#!/usr/bin/env python3
"""Read only an explicitly supplied save-contract diagnostic SOL, never game slots."""
import argparse
import json
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(ROOT/'tools'))
from sol import loads
NAME='yzlr2_rebuild_save_contract_diag_v1'
parser=argparse.ArgumentParser()
parser.add_argument('path',type=Path)
args=parser.parse_args()
plain_name = args.path.name in (NAME+'.sol',NAME[3:]+'.sol')
# Flash on macOS can split a long SO name at a '#/' directory boundary.
split_name = (args.path.parent.name == 'yzlr2_re#' and
              args.path.name == 'build_save_contract_diag_v1.sol')
assert plain_name or split_name, 'Only the dedicated test report is accepted'
assert args.path.stat().st_size<300000
name,fields=loads(args.path.read_bytes())
assert name==NAME
report=json.loads(fields['payload'])
assert report['mode']=='real-manager-with-in-memory-storage-adapter'
print(json.dumps(report,ensure_ascii=False,indent=2))
