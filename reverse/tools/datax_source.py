#!/usr/bin/env python3
"""Explicit canonical InData migration and XML import; normal builds never recover it."""
import argparse
import copy
import hashlib
import json
from pathlib import Path
import re
import shutil
import tempfile
import xml.etree.ElementTree as ET
from datax_recover import main as recover

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT/'reverse/source/DataX_v76/src/InData.as'
CONFIG = ROOT/'reverse/source/DataX_v76-config'
REPORT = ROOT/'reverse/experiments/datax-recovery'
BUILD = ROOT/'reverse/build/datax-recovery'


def sha(data): return hashlib.sha256(data).hexdigest()


def literals(text):
    """Locate only JSON-compatible XML string literals, preserving all other AS."""
    functions = list(re.finditer(r'(?:private|public)\s+static\s+function\s+(\w+)\s*\(', text))
    result = {}
    for i, match in enumerate(functions):
        end = functions[i+1].start() if i+1 < len(functions) else len(text)
        region = text[match.end():end]
        positions = list(re.finditer(r'new\s+XML\s*\(\s*', region))
        if match[1] == 'Loading':
            assert not positions
            continue
        assert len(positions) == 1, f'Expected one XML literal in {match[1]}'
        start = match.end()+positions[0].end()
        value, consumed = json.JSONDecoder().raw_decode(text[start:])
        assert isinstance(value, str) and text[start+consumed:].lstrip().startswith(')')
        ET.fromstring(value)
        result[match[1]] = {'start':start, 'end':start+consumed, 'xml':value}
    assert len(result) == 11
    return result


def expected_for_source(path):
    expected = copy.deepcopy(json.loads((REPORT/'recovery.json').read_text()))
    content = literals(path.read_text())
    assert set(content) == {m['name'] for m in expected['methods']}
    for method in expected['methods']:
        xml = content[method['name']]['xml']
        method['original_xml_sha256'] = method['xml_sha256']
        method['xml_sha256'] = sha(xml.encode())
        method['xml_utf8_bytes'] = len(xml.encode())
        method['xml_child_count'] = len(ET.fromstring(xml))
    return expected


def bootstrap():
    recover()  # Explicit command only, never invoked from the normal build.
    recovered = BUILD/'source/src/InData.as'
    baseline = ROOT/'reverse/exports/DataX_v76/scripts/src/InData.as'
    assert SOURCE.read_bytes() in (baseline.read_bytes(), recovered.read_bytes()), 'Canonical source has custom edits; migration refused'
    BUILD.mkdir(parents=True, exist_ok=True)
    archive = Path(tempfile.mkdtemp(prefix='canonical-migration-', dir=BUILD))
    shutil.copy2(SOURCE, archive/'InData-before.as')
    content = literals(recovered.read_text())
    CONFIG.mkdir(parents=True, exist_ok=True)
    for name, row in content.items():
        path = CONFIG/(name+'.xml'); data = row['xml'].encode()
        if path.exists(): assert path.read_bytes() == data, f'Existing edited config: {path}'
        else: path.write_bytes(data)
    SOURCE.write_bytes(recovered.read_bytes())
    receipt = {'canonical':str(SOURCE.relative_to(ROOT)), 'before_sha256':sha((archive/'InData-before.as').read_bytes()),
        'after_sha256':sha(SOURCE.read_bytes()), 'archive':str(archive.relative_to(ROOT)),
        'xml_files':{name:sha(row['xml'].encode()) for name,row in content.items()},
        'mode':'one-time explicit migration; later builds read canonical AS unchanged'}
    (REPORT/'canonical-migration.json').write_text(json.dumps(receipt, indent=2)+'\n')
    print(json.dumps(receipt, indent=2))


def import_xml():
    original = SOURCE.read_bytes().decode('utf-8'); content = literals(original)
    modified = original; changes = []
    for name, row in sorted(content.items(), key=lambda pair:pair[1]['start'], reverse=True):
        raw = (CONFIG/(name+'.xml')).read_bytes(); xml = raw.decode('utf-8'); ET.fromstring(xml)
        if xml == row['xml']: continue
        literal = json.dumps(xml, ensure_ascii=False).replace('\u2028','\\u2028').replace('\u2029','\\u2029')
        modified = modified[:row['start']]+literal+modified[row['end']:]
        changes.append({'method':name, 'old_xml_sha256':sha(row['xml'].encode()), 'new_xml_sha256':sha(raw)})
    # The method bodies outside the 11 string spans must be exactly preserved.
    def skeleton(text):
        for row in sorted(literals(text).values(),key=lambda row:row['start'],reverse=True):
            text = text[:row['start']]+'"XML_CONFIG"'+text[row['end']:]
        return text
    assert skeleton(original) == skeleton(modified)
    archive = None
    if changes:
        BUILD.mkdir(parents=True,exist_ok=True)
        archive = Path(tempfile.mkdtemp(prefix='xml-import-',dir=BUILD))
        shutil.copy2(SOURCE, archive/'InData-before.as'); SOURCE.write_bytes(modified.encode('utf-8'))
    print(json.dumps({'changes':changes, 'all_other_AS_text_preserved':True,
        'archive':str(archive.relative_to(ROOT)) if archive else None}, indent=2))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=['bootstrap', 'import-xml'])
    args = parser.parse_args()
    bootstrap() if args.action == 'bootstrap' else import_xml()
