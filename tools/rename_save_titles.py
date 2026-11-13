#!/usr/bin/env python3
"""Rename occupied slot metadata from an explicit JSON plan; never edit role data.

Default is preview. --apply requires all Flash players closed, backs up each
original byte stream, checks the entire AMF graph except the named fields, and
atomically replaces each file. The private receipt records partial completion.
"""
import argparse
import copy
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
from sol import Arr, graph, loads, dumps

ALLOWED = {'yzlr2_saves', 'yzlr2_final', 'yzlr2_rebuild_probe',
           'yzlr2_rebuild_epilogue_v2'}


def closed():
    processes = subprocess.check_output(['ps', '-axo', 'comm='], text=True)
    if any(p.strip().endswith(('/Flash Player', '/Flash Player Debugger'))
           for p in processes.splitlines()):
        raise RuntimeError('Quit every Flash player before renaming saves')


def prepare(path, names):
    raw = path.read_bytes()
    name, fields = loads(raw)
    if name not in ALLOWED or path.name != name + '.sol':
        raise ValueError('Unsupported save store')
    if not isinstance(fields.get('slots'), Arr) or len(fields['slots'].dense) != 8:
        raise ValueError('Expected exactly eight slots')
    before = copy.deepcopy(fields)
    changes = []
    for key, label in names.items():
        index = int(key) - 1
        if not 0 <= index < 8 or not isinstance(label, str) or not 1 <= len(label) <= 22:
            raise ValueError('Invalid slot or label')
        slot = fields['slots'][index]
        if slot is None:
            raise ValueError('Cannot rename an empty slot')
        changes.append({'slot': index + 1, 'before': slot['title'], 'after': label})
        slot['title'] = label
        if name == 'yzlr2_rebuild_epilogue_v2':
            slot['displayName'] = label.split(' Lv', 1)[0]
    output = dumps(name, fields)
    decoded_name, decoded = loads(output)
    if decoded_name != name or graph(decoded) != graph(fields):
        raise ValueError('AMF round trip failed')
    # Restore only authorized metadata in a verification copy: everything else,
    # including role identities and shared/cyclic references, must match.
    check = copy.deepcopy(decoded)
    for key in names:
        index = int(key) - 1
        for field in ('title', 'displayName'):
            old = before['slots'][index].fields
            if field in old:
                check['slots'][index][field] = old[field]
            else:
                check['slots'][index].fields.pop(field, None)
    if graph(check) != graph(before):
        raise ValueError('Unexpected non-label change')
    return raw, output, changes


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('plan', type=Path)
    parser.add_argument('--backup-dir', type=Path, required=True)
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    closed()
    plan = json.loads(args.plan.read_text())
    prepared = []
    for row in plan:
        path = Path(row['path']).expanduser()
        if path.is_symlink() or path.stat().st_nlink != 1:
            raise ValueError('Refusing linked save file')
        raw, output, changes = prepare(path, row['names'])
        prepared.append((path, raw, output, changes))
    summary = [{'path': str(p), 'changes': c,
                'before_sha256': hashlib.sha256(r).hexdigest(),
                'after_sha256': hashlib.sha256(o).hexdigest(),
                'role_data_unchanged': True} for p, r, o, c in prepared]
    if args.apply:
        stamp = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S.%fZ')
        folder = args.backup_dir / stamp
        folder.mkdir(parents=True, exist_ok=False)
        for p, raw, output, changes in prepared:
            (folder / p.name).write_bytes(raw)
        receipt = {'authorized_change': 'user requested version and purpose labels',
                   'files': summary, 'installed': []}
        (folder / 'receipt.json').write_text(json.dumps(receipt, ensure_ascii=False, indent=2))
        for p, raw, output, changes in prepared:
            closed()
            if p.read_bytes() != raw:
                raise RuntimeError('Live save changed; aborting before replacement')
            tmp = p.with_name(p.name + '.rename-' + stamp)
            with tmp.open('xb') as stream:
                stream.write(output)
                stream.flush()
                os.fsync(stream.fileno())
            os.replace(tmp, p)
            if p.read_bytes() != output:
                raise RuntimeError('Readback mismatch')
            receipt['installed'].append(str(p))
            (folder / 'receipt.json').write_text(json.dumps(receipt, ensure_ascii=False, indent=2))
        print('Backup:', folder)
    print(json.dumps(summary, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
