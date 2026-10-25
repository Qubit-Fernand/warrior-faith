#!/usr/bin/env python3
"""Copy a hash-pinned, legitimately earned checkpoint role into an empty test slot.

Only identity/index/title change. Chapter flags, inventory and all progression
remain the checkpoint's exact AMF graph; this cannot fabricate a victory.
"""
import argparse
import copy
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
from sol import loads, dumps, graph
NAME = 'yzlr2_rebuild_epilogue_v2'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('checkpoint', type=Path)
    parser.add_argument('--sha256', required=True)
    parser.add_argument('--source-slot', type=int, required=True)
    parser.add_argument('--destination-slot', type=int, required=True)
    parser.add_argument('--target', type=Path, required=True)
    args = parser.parse_args()
    source = args.checkpoint.resolve()
    target = args.target.expanduser().resolve()
    if not source.is_relative_to((ROOT/'chapter/evidence/private/checkpoints').resolve()):
        raise ValueError('Source must be a recorded private checkpoint')
    if target.name != NAME+'.sol' or not all(1 <= i <= 8 for i in (args.source_slot,args.destination_slot)):
        raise ValueError('Unexpected target or slot')
    if any(x.strip().endswith(('/Flash Player','/Flash Player Debugger')) for x in subprocess.check_output(['ps','-axo','comm='],text=True).splitlines()):
        raise ValueError('Quit every player first')
    raw = source.read_bytes()
    if hashlib.sha256(raw).hexdigest() != args.sha256:
        raise ValueError('Checkpoint hash differs')
    name, checkpoint = loads(raw)
    old = target.read_bytes()
    target_name, current = loads(old)
    if name != NAME or target_name != NAME:
        raise ValueError('Unexpected internal store name')
    destination = args.destination_slot-1
    if current['slots'][destination] is not None:
        raise ValueError('Destination occupied; no changes made')
    role = copy.deepcopy(checkpoint['slots'][args.source_slot-1])
    chapter_before = graph(role['data']['fanChapterReturnLight'])
    preserved = {i:graph(slot) for i,slot in enumerate(current['slots'].dense) if slot is not None}
    role['index'] = destination
    token = role['data']['logNameSave']
    if len(token) != 14:
        raise ValueError('Unexpected identity token')
    role['data']['logNameSave'] = token[:5]+str(destination)+token[6:]
    role['title'] = 'P1:Lv85 合法实战分歧检查点'
    role['datetime'] = '2026-10-26 copied earned checkpoint; no progress edits'
    current['slots'][destination] = role
    output = dumps(NAME,current)
    decoded_name, decoded = loads(output)
    if decoded_name != NAME or graph(current) != graph(decoded):
        raise ValueError('AMF round trip failed')
    if graph(decoded['slots'][destination]['data']['fanChapterReturnLight']) != chapter_before:
        raise ValueError('Checkpoint progress changed')
    for i,before in preserved.items():
        if graph(decoded['slots'][i]) != before:
            raise ValueError('Existing slot changed')
    generation = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S.%fZ')
    directory = ROOT/'chapter/evidence/private/checkpoints'/('earned-copy-'+generation)
    directory.mkdir(exist_ok=False)
    (directory/'before.sol').write_bytes(old)
    (directory/'after.sol').write_bytes(output)
    temp = target.with_name(target.name+'.earned-copy-'+generation)
    with temp.open('xb') as stream:
        stream.write(output);stream.flush();os.fsync(stream.fileno())
    if target.read_bytes() != old:
        raise ValueError('Live save changed while preparing')
    os.replace(temp,target)
    if target.read_bytes() != output:
        raise ValueError('Written store differs')
    receipt = {'checkpoint':str(source.relative_to(ROOT)),'checkpoint_sha256':args.sha256,
               'source_slot':args.source_slot,'destination_slot':args.destination_slot,
               'chapter_graph_unchanged':True,'preserved_slots':[i+1 for i in preserved],
               'after_sha256':hashlib.sha256(output).hexdigest()}
    (directory/'receipt.json').write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({'evidence':str(directory),**receipt},ensure_ascii=False,indent=2))


if __name__ == '__main__':
    main()
