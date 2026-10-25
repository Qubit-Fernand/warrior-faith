#!/usr/bin/env python3
"""Recover InData only after proving its entire method instruction templates.

This is not a generic decompiler. Unknown bytecode or unexpected structure fails.
It preserves original XML constant strings and factory calls exactly.
"""
import hashlib
import json
from pathlib import Path
import re
import sys
import xml.etree.ElementTree as ET
from swf_inventory import Reader, abc_inventory

ROOT = Path(__file__).resolve().parents[2]
BASE = ROOT / 'reverse/exports/DataX_v76/inventory'
BUILD = ROOT / 'reverse/build/datax-recovery'
REPORT = ROOT / 'reverse/experiments/datax-recovery'


def sha(b):
    return hashlib.sha256(b).hexdigest()


def pool(data, definitions):
    r = Reader(data)
    assert (r.u16(), r.u16()) == (16, 46)
    for _ in range(2):
        for _ in range(1, r.var()): r.var()
    r.take(max(0, r.var() - 1) * 8)
    strings = ['']
    for _ in range(1, r.var()): strings.append(r.take(r.var()).decode('utf-8'))
    namespaces = [None]
    for _ in range(1, r.var()): namespaces.append((r.u8(), r.var()))
    sets = [[]]
    for _ in range(1, r.var()):
        sets.append([r.var() for _ in range(r.var())])
    names = [None]
    for _ in range(1, r.var()):
        kind = r.u8()
        if kind in (7, 13): value = [r.var(), r.var()]
        elif kind in (15, 16): value = [r.var()]
        elif kind in (17, 18): value = []
        elif kind in (9, 14): value = [r.var(), r.var()]
        elif kind in (27, 28): value = [r.var()]
        elif kind == 29:
            value = [r.var()]
            value.extend(r.var() for _ in range(r.var()))
        else: raise ValueError(f'Unknown multiname {kind}')
        names.append((kind, value))
    def qualified(index):
        kind, value = names[index]
        if kind in (7, 13):
            ns = strings[namespaces[value[0]][1]]
            return (ns + '.' if ns else '') + strings[value[1]]
        assert kind in (9, 14), f'Expected static multiname at {index}: {kind}'
        candidates = []
        for ns_index in sets[value[1]]:
            ns = strings[namespaces[ns_index][1]]
            candidate = (ns + '.' if ns else '') + strings[value[0]]
            if candidate in definitions or candidate == 'XML': candidates.append(candidate)
        assert len(set(candidates)) == 1, f'Ambiguous multiname {index}: {candidates}'
        return candidates[0]
    def local(index):
        kind, value = names[index]
        assert kind in (7, 13, 9, 14), f'Unexpected property name {kind}'
        return strings[value[1] if kind in (7, 13) else value[0]]
    return strings, qualified, local


def verify_compiled_indata(data, expected):
    """Verify compc's alternate opcode forms retain every recovered operation."""
    inv = abc_inventory(data)
    cls = next(c for c in inv['classes'] if c['name'] == 'src.InData')
    strings, qualified, local = pool(data, {m['factory'] for m in expected['methods']} | {'src.InData'})
    bodies = {b['method']:b for b in inv['method_bodies']}
    expected_methods = {m['name']:m for m in expected['methods']}
    verified = []
    for trait in cls['static_traits']:
        name = trait['name'].rsplit('.',1)[-1]
        body = bodies[trait['method']]
        raw = data[body['offset']:body['offset']+body['length']]
        tail = Reader(data[body['offset']+body['length']:])
        assert tail.var() == 0 and tail.var() == 0
        r = Reader(raw); assert r.take(2) == b'\xd0\x30'
        if name == 'Loading':
            order = []
            while r.b[r.p] == 0x5d:
                r.u8(); index=r.var(); assert r.u8()==0x46 and r.var()==index and r.var()==0 and r.u8()==0x29
                order.append(local(index))
            assert order == expected['loading_order']
        else:
            want = expected_methods[name]
            assert r.u8()==0x5d
            factory=r.var(); assert qualified(factory)==want['factory']
            assert r.u8()==0x66 and r.var()==factory
            assert r.u8()==0x5d
            xml=r.var(); assert qualified(xml)=='XML'
            assert r.u8()==0x2c and sha(strings[r.var()].encode())==want['xml_sha256']
            assert r.u8()==0x4a and r.var()==xml and r.var()==1
            assert r.u8()==0x61 and local(r.var())==want['property']
            if want['callback']:
                assert r.u8()==0x5d and r.var()==factory and r.u8()==0x66 and r.var()==factory
                assert r.u8()==0x46 and local(r.var())==want['callback'] and r.var()==0 and r.u8()==0x29
            verified.append(name)
        assert r.u8()==0x47 and r.p==len(raw), f'Unexpected compiled operations: {name}'
    assert set(verified)==set(expected_methods)
    return {'verified_xml_methods':sorted(verified),'loading_order_verified':True,
            'checks':'Exact opcode templates: XML constant digest, factory QName, property, optional callback, arity, return, no extra instructions/handlers.'}


def main():
    data = (BASE / 'abc-0000.abc').read_bytes()
    inventory = abc_inventory(data)
    cached = json.loads((BASE / 'abc-0000.json').read_text())
    assert inventory == cached, 'ABC inventory differs from authoritative binary'
    strings, qualified, local = pool(data, {c['name'] for c in inventory['classes']})
    cls = next(c for c in inventory['classes'] if c['name'] == 'src.InData')
    assert cls['super'] == 'flash.display.MovieClip' and not cls['traits'] and not cls['interfaces']
    bodies = {b['method']: b for b in inventory['method_bodies']}
    def code(method):
        body = bodies[method]
        value = data[body['offset']:body['offset'] + body['length']]
        assert sha(value) == body['sha256']
        tail = Reader(data[body['offset'] + body['length']:])
        assert tail.var() == 0 and tail.var() == 0, 'Exception handler or activation trait in body'
        return value
    assert code(cls['initializer']) == bytes.fromhex('d030d0490047'), 'Unexpected constructor'
    assert code(cls['static_initializer']) == bytes.fromhex('d03047'), 'Unexpected class initializer'
    # Catch handlers and body traits could change meaning despite identical code.
    # The inventory parser reads all tables; individual proven templates contain no throw/jump.
    methods = []
    loading = []
    imports = {'flash.display.MovieClip'}
    export = ROOT / 'reverse/exports/DataX_v76/scripts/src/InData.as'
    exported = export.read_text() if export.exists() else ''
    exported_xml = re.findall(r'=\s*(<(?:info|root)>[\s\S]*?</(?:info|root)>);', exported)
    for trait in cls['static_traits']:
        assert trait['kind'] == 1 and 'method' in trait
        method = trait['method']
        raw = code(method)
        r = Reader(raw)
        assert r.take(2) == b'\xd0\x30'
        name = trait['name']
        if name == 'Loading':
            while r.b[r.p] == 0x5d:
                r.u8(); lookup = r.var()
                assert r.u8() == 0x4f and r.var() == lookup and r.var() == 0
                loading.append(local(lookup))
            assert r.take(1) == b'\x47' and r.p == len(raw)
            continue
        assert r.u8() == 0x60
        factory_index = r.var(); factory = qualified(factory_index)
        assert r.u8() == 0x60 and qualified(r.var()) == 'XML'
        assert r.u8() == 0x2c
        string_index = r.var(); xml = strings[string_index]
        assert r.u8() == 0x42 and r.var() == 1
        assert r.u8() == 0x61
        prop = local(r.var())
        callback = None
        if r.b[r.p] == 0x60:
            r.u8(); assert r.var() == factory_index
            assert r.u8() == 0x4f
            callback = local(r.var()); assert r.var() == 0
        assert r.take(1) == b'\x47' and r.p == len(raw), f'Unconsumed code for {name}'
        tree = ET.fromstring(xml)
        assert tree.tag in ('info', 'root')
        imports.add(factory)
        methods.append({'name': name, 'method_index': method,
            'return_type': inventory['methods'][method]['return_type'],
            'body_offset': bodies[method]['offset'], 'body_length': len(raw),
            'body_hex': raw.hex(), 'body_sha256': sha(raw),
            'string_index': string_index, 'xml_sha256': sha(xml.encode()),
            'xml_utf8_bytes': len(xml.encode()), 'xml_root': tree.tag, 'xml_child_count': len(tree),
            'factory': factory, 'property': prop, 'callback': callback,
            'export_literal_match_after_newline_normalization': any(
                item.replace('\r\n','\n').replace('\r','\n') == xml.replace('\r\n','\n').replace('\r','\n')
                for item in exported_xml)})
    assert len(methods) == 11 and set(loading) == {m['name'] for m in methods}
    output = BUILD / 'source/src/InData.as'
    output.parent.mkdir(parents=True, exist_ok=True)
    lines = ['package src', '{'] + ['    import ' + name + ';' for name in sorted(imports)]
    lines += ['    public class InData extends MovieClip', '    {',
              '        public function InData() { super(); }',
              '        public static function Loading():*', '        {']
    lines += ['            ' + name + '();' for name in loading]
    lines += ['        }']
    for method in methods:
        xml = strings[method['string_index']]
        literal = json.dumps(xml, ensure_ascii=False).replace('\u2028', '\\u2028').replace('\u2029', '\\u2029')
        factory = method['factory'].rsplit('.', 1)[1]
        lines += [f'        private static function {method["name"]}():{method["return_type"]}', '        {',
                  f'            {factory}.{method["property"]} = new XML({literal});']
        if method['callback']: lines += [f'            {factory}.{method["callback"]}();']
        lines += ['        }']
    lines += ['    }', '}']
    output.write_text('\n'.join(lines) + '\n')
    result = {'abc_sha256': sha(data), 'class': 'src.InData', 'loading_order': loading,
        'methods': methods, 'all_11_exported_literals_match': all(m['export_literal_match_after_newline_normalization'] for m in methods),
        'fresh_export_sha256': sha(export.read_bytes()) if export.exists() else None,
        'source': str(output.relative_to(ROOT)), 'source_sha256': sha(output.read_bytes()),
        'limitations': ['Instruction-template equivalence only; source compilation and actual runtime require separate validation.',
                        'Factory classes are dependencies and have not been rewritten or stubbed by this script.']}
    REPORT.mkdir(parents=True, exist_ok=True)
    (REPORT / 'recovery.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({'methods': len(methods), 'all_xml_match': result['all_11_exported_literals_match'], 'source': result['source']},ensure_ascii=False))


if __name__ == '__main__': main()
