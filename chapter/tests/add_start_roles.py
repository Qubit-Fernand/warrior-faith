#!/usr/bin/env python3
"""Append three explicit start-only roles to empty slots of the isolated test SO.

Preserves every existing role. Never opens another save name, runs a player,
or writes new-chapter progress. The output is private test data, not acceptance.
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
from create_graduate_save import vt

NAME = 'yzlr2_rebuild_epilogue_v2'
FIXTURE_SHA = '7f21943d9c500e3c7636ef6aaa76f1de24789f7506d5be21b2b9789abbade4dd'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('target', type=Path)
    args = parser.parse_args()
    target = args.target.expanduser().resolve()
    if target.name != NAME + '.sol':
        raise ValueError('Only the isolated chapter store is allowed')
    players = subprocess.check_output(['ps', '-axo', 'comm='], text=True)
    if any(x.strip().endswith(('/Flash Player', '/Flash Player Debugger')) for x in players.splitlines()):
        raise ValueError('Quit every Flash player first')
    original = target.read_bytes()
    name, fields = loads(original)
    if name != NAME or len(fields['slots'].dense) != 8:
        raise ValueError('Unexpected save name or slot layout')
    slots = fields['slots'].dense
    if any(slots[index] is not None for index in (2, 3, 4)):
        raise ValueError('Slots 3, 4 and 5 must all be empty; nothing was written')
    preset = (ROOT / 'chapter/fixtures/归光之约-起点.sol').read_bytes()
    if hashlib.sha256(preset).hexdigest() != FIXTURE_SHA:
        raise ValueError('Start fixture differs from the previously recorded recipe')
    preset_name, start = loads(preset)
    if preset_name != NAME:
        raise ValueError('Unexpected start fixture name')
    existing = {i: graph(slot) for i, slot in enumerate(slots) if slot is not None}
    for index, source_index, label in ((2, 0, '6.0·普通验收'),
                                       (3, 1, '6.0·毕业上限'),
                                       (4, 0, '6.0·前置未交')):
        role = copy.deepcopy(start['slots'][source_index])
        data = role['data']
        if 'fanChapterReturnLight' in data.fields:
            raise ValueError('Start fixture must contain no chapter state')
        token = data['logNameSave']
        if len(token) != 14:
            raise ValueError('Unexpected role token')
        data['logNameSave'] = token[:5] + str(index) + token[6:]
        role['index'] = index
        role['title'] = label + ' Lv85'
        role['displayName'] = label
        role['datetime'] = '2026-10-26 explicit start-only acceptance fixture'
        if index == 3:
            # InitData.Money_max = 500000000. No reward/debt/completion is set.
            data['p1']['gold'] = vt(500000000)
        if index == 4:
            quests = data['RenWu']
            record = quests.dense[110117] if len(quests.dense) > 110117 else quests.assoc['110117']
            record[1] = 0  # TaskData.load maps this to getOldTime().
        slots[index] = role
    output = dumps(NAME, fields)
    decoded_name, decoded = loads(output)
    if decoded_name != NAME or graph(fields) != graph(decoded):
        raise ValueError('AMF round trip failed')
    for i, before in existing.items():
        if graph(decoded['slots'][i]) != before:
            raise ValueError('Existing slot changed')
    generation = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S.%fZ')
    evidence = ROOT / 'chapter/evidence/private/checkpoints' / ('start-roles-' + generation)
    evidence.mkdir(parents=True, exist_ok=False)
    (evidence / 'before.sol').write_bytes(original)
    (evidence / 'after.sol').write_bytes(output)
    temp = target.with_name(target.name + '.start-roles-' + generation)
    with temp.open('xb') as stream:
        stream.write(output)
        stream.flush()
        os.fsync(stream.fileno())
    if target.read_bytes() != original:
        raise ValueError('Live store changed while preparing; no replacement made')
    os.replace(temp, target)
    if target.read_bytes() != output:
        raise ValueError('Written store differs')
    receipt = {'generation': generation, 'before_sha256': hashlib.sha256(original).hexdigest(),
               'after_sha256': hashlib.sha256(output).hexdigest(), 'preserved_slots': list(existing),
               'added_slots': [3, 4, 5], 'new_chapter_state_written': False,
               'source_fixture_sha256': FIXTURE_SHA}
    (evidence / 'receipt.json').write_text(json.dumps(receipt, indent=2) + '\n')
    print(json.dumps({'evidence': str(evidence), **receipt}, indent=2))


if __name__ == '__main__':
    main()
