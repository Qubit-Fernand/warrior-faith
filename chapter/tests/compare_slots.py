#!/usr/bin/env python3
"""Read-only semantic comparison of SOL slots, independent of AMF field order.

Flash may reorder dynamic properties during ByteArray snapshotting. Comparing
graph export IDs would then report changes even when the graph is isomorphic.
This comparator checks values and bidirectional object identity/aliasing.
"""
import argparse
import json
import math
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / 'tools'))
from sol import Arr, Date, Obj, loads


def differences(left, right):
    forward, reverse, changes = {}, {}, []

    def visit(a, b, path):
        if type(a) is not type(b):
            changes.append({'path': path, 'kind': 'type'})
            return
        if isinstance(a, (Obj, Arr, Date)):
            if id(a) in forward or id(b) in reverse:
                if forward.get(id(a)) != id(b) or reverse.get(id(b)) != id(a):
                    changes.append({'path': path, 'kind': 'alias'})
                return
            forward[id(a)] = id(b)
            reverse[id(b)] = id(a)
        if isinstance(a, Obj):
            if (a.name, set(a.sealed), a.dynamic) != (b.name, set(b.sealed), b.dynamic):
                changes.append({'path': path, 'kind': 'object_schema'})
            visit_mapping(a.fields, b.fields, path)
        elif isinstance(a, Arr):
            if len(a.dense) != len(b.dense):
                changes.append({'path': path, 'kind': 'array_length'})
            for i, (x, y) in enumerate(zip(a.dense, b.dense)):
                visit(x, y, f'{path}[{i}]')
            visit_mapping(a.assoc, b.assoc, path + '.assoc')
        elif isinstance(a, Date):
            visit(a.milliseconds, b.milliseconds, path + '.milliseconds')
        elif a != b and not (isinstance(a, float) and math.isnan(a) and math.isnan(b)):
            changes.append({'path': path, 'kind': 'value', 'before': a, 'after': b})

    def visit_mapping(a, b, path):
        for key in sorted(set(a) | set(b)):
            if key not in a or key not in b:
                changes.append({'path': path + '.' + key, 'kind': 'field_membership'})
            else:
                visit(a[key], b[key], path + '.' + key)

    visit(left, right, '')
    return changes


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('before', type=Path)
    parser.add_argument('after', type=Path)
    args = parser.parse_args()
    name_a, a = loads(args.before.read_bytes())
    name_b, b = loads(args.after.read_bytes())
    if name_a != name_b or len(a['slots'].dense) != len(b['slots'].dense):
        raise ValueError('Save name or slot count differs')
    print(json.dumps({'name': name_a, 'slots': [
        {'slot': i + 1, 'differences': differences(x, y)}
        for i, (x, y) in enumerate(zip(a['slots'].dense, b['slots'].dense))
    ]}, ensure_ascii=False, indent=2))
