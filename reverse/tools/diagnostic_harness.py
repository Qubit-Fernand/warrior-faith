#!/usr/bin/env python3
"""Build/install a read-only game observer, or parse only its diagnostic SOL.

Never starts a player. Installation only accepts the ignored runtime directories
and a main SWF with a recognized probe save name, never yzlr2_saves.
"""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import uuid
import re
from datetime import datetime, timezone
from swf_inventory import abc_inventory, read_swf, walk_tags

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT/'reverse/experiments/diagnostic-harness'
BUILD = ROOT/'reverse/build/diagnostic-harness'
NAME = 'yzlr2_diagnostic_probe'
SWF = 'DiagnosticHarness.swf'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def inventories(path):
    _, body, header = read_swf(path)
    for tag, payload in walk_tags(body, header['tag_start']):
        if tag['code'] == 82:
            yield abc_inventory(payload[payload.index(b'\0', 4)+1:])
        elif tag['code'] == 72:
            yield abc_inventory(payload)


def build():
    BUILD.mkdir(parents=True, exist_ok=True)
    java = ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'
    flex = ROOT/'.runtime/shared-tools/flex/apache-flex-sdk-4.16.1-bin'
    player = ROOT/'.runtime/shared-tools/ffdec/flashlib/playerglobal32_0.swc'
    command = [str(java), '-Djava.awt.headless=true', f'-Dflexlib={flex}/frameworks',
        '-jar', str(flex/'lib/mxmlc.jar'), '-load-config=', '-compiler.theme=',
        f'-compiler.external-library-path={player}', '-compiler.library-path=',
        f'-compiler.source-path={SOURCE}', '-target-player=32.0', '-use-network=false',
        '-debug=false', f'-output={BUILD/SWF}', str(SOURCE/'Source.as')]
    result = subprocess.run(command, cwd=ROOT, capture_output=True, text=True, timeout=90)
    (BUILD/'compile.log').write_text(result.stdout+result.stderr)
    if result.returncode:
        raise RuntimeError(result.stdout+result.stderr)
    abc = list(inventories(BUILD/SWF))
    classes = [c['name'] for a in abc for c in a['classes']]
    assert classes == ['Source'], classes
    strings = {s for a in abc for s in a['strings']}
    assert NAME in strings and 'yzlr2_saves' not in strings
    report = {'createdUTC':datetime.now(timezone.utc).isoformat(), 'command':command,
        'source_sha256':sha(SOURCE/'Source.as'), 'swf_sha256':sha(BUILD/SWF),
        'bytes':(BUILD/SWF).stat().st_size, 'classes':classes,
        'diagnostic_shared_object':NAME, 'game_executed':False,
        'live_save_accessed':False, 'runtime_tested':False}
    (SOURCE/'build.json').write_text(json.dumps(report, ensure_ascii=False, indent=2)+'\n')
    print(json.dumps(report, ensure_ascii=False, indent=2))


def validate_package(directory):
    directory = directory.expanduser().resolve()
    assert directory.parent == ROOT/'reverse/build'
    assembly_sha = None
    if directory.name.startswith('runtime-all-rebuilt-'):
        manifest_path=directory/'assembly.json'; manifest=json.loads(manifest_path.read_text())
        assert manifest.get('schema')=='yzlr2-assembly-v1' and manifest.get('state')=='complete'
        assert manifest.get('partial_allowed') is False and manifest.get('rebuilt')==164 and manifest.get('original_fallback')==0
        baseline=json.loads((ROOT/'reverse/manifests/original-files.json').read_text())
        expected={r['path'] for r in baseline if r['path'].endswith('.swf')}
        rows=manifest.get('modules',[])
        assert len(rows)==164 and {r['path'] for r in rows}==expected
        for row in rows:
            assert row['provenance']=='source_rebuilt' and not row.get('fallback_reasons')
            assert sha(directory/row['path'])==row['sha256'], 'Assembly file changed: '+row['path']
            assert row.get('receipt') and re.fullmatch(r'[0-9a-f]{64}',row.get('receipt_sha256',''))
            snapshot_path=directory/'diagnostic-origin'/(row['receipt_sha256']+'.json')
            if row.get('receipt_snapshot'):
                snapshot_path=(directory/row['receipt_snapshot']).resolve()
                assert snapshot_path.is_relative_to(directory) and snapshot_path.is_file()
            receipt_path=snapshot_path if snapshot_path.is_file() else (ROOT/row['receipt']).resolve()
            assert receipt_path.is_relative_to(ROOT/'reverse') and receipt_path.is_file()
            assert sha(receipt_path)==row['receipt_sha256'], 'Assembly provenance receipt changed; reassemble: '+row['path']
        assembly_sha=sha(manifest_path)
    else:
        assert directory.name in ('runtime-original-control', 'runtime-rebuilt'), 'Only original control, isolated rebuilt, or strict all-rebuilt packages accepted'
    main = directory/'3_L4399Main_gamefile.swf'
    strings = {s for a in inventories(main) for s in a['strings']}
    names = sorted(s for s in strings if s.startswith('yzlr2_'))
    assert 'yzlr2_saves' not in names, 'Private original save name still present'
    assert len(names) == 1 and (names[0] in ('yzlr2_original_probe','yzlr2_reverse_probe') or re.fullmatch(r'yzlr2_rebuild_[A-Za-z0-9_]+',names[0])), names
    if assembly_sha:assert names[0].startswith('yzlr2_rebuild_')
    return directory,main,names[0],assembly_sha


def freeze_provenance(directory):
    """Preserve verified source receipts so later builds cannot invalidate this run."""
    directory,_,_,assembly_sha=validate_package(directory)
    if assembly_sha:
        origin=directory/'diagnostic-origin';origin.mkdir(exist_ok=True)
        for row in json.loads((directory/'assembly.json').read_text())['modules']:
            destination=origin/(row['receipt_sha256']+'.json')
            if not destination.exists():
                source=directory/row['receipt_snapshot'] if row.get('receipt_snapshot') else ROOT/row['receipt']
                assert sha(source)==row['receipt_sha256']
                shutil.copy2(source,destination)
            assert sha(destination)==row['receipt_sha256']
    return assembly_sha


def request_snapshot(directory,label,snapshot=True,resolve_class_identities=None):
    assert isinstance(label,str) and 0<len(label)<=64 and all(ord(c)>=32 for c in label)
    request={'schema':'yzlr2-diagnostic-request-v1','id':uuid.uuid4().hex,'label':label,'snapshot':snapshot}
    if resolve_class_identities is not None:request['resolveClassIdentities']=bool(resolve_class_identities)
    # Atomically replace only the wrapper's own request file; never touch game state or SOL.
    temporary=directory/('diagnostic-request-'+request['id']+'.tmp')
    temporary.write_text(json.dumps(request,ensure_ascii=False)+'\n')
    temporary.replace(directory/'diagnostic-request.json')
    return request


def install(directory,label,resolve_class_identities=False):
    assert isinstance(label,str) and 0<len(label)<=64 and all(ord(c)>=32 for c in label)
    directory,main,save_name,assembly_sha=validate_package(directory)
    freeze_provenance(directory)
    assert (BUILD/SWF).is_file(), 'Run build first'
    build_report=json.loads((SOURCE/'build.json').read_text())
    assert sha(BUILD/SWF)==build_report['swf_sha256'] and sha(SOURCE/'Source.as')==build_report['source_sha256'], 'Rebuild changed wrapper source first'
    destination = directory/SWF
    if destination.exists() and sha(destination)!=sha(BUILD/SWF):
        prior=json.loads((directory/'diagnostic-install.json').read_text())
        old_hash=sha(destination)
        assert old_hash==prior['wrapper_sha256'], 'Unknown/modified existing wrapper: refusing replacement'
        history=directory/'diagnostic-history';history.mkdir(exist_ok=True)
        shutil.copy2(destination,history/(old_hash+'.swf'))
        (history/(old_hash+'.json')).write_text(json.dumps(prior,indent=2)+'\n')
    shutil.copy2(BUILD/SWF,destination)
    receipt = {'main_sha256':sha(main), 'wrapper_sha256':sha(destination),
        'game_shared_object':save_name, 'diagnostic_shared_object':NAME,'assembly_sha256':assembly_sha,
        'wrapper_version':2,'label_request_supported':True,
        'initial_resolve_class_identities':resolve_class_identities,
        'game_executed':False, 'note':'Wrapper observes public fields; direct launch still required for acceptance.'}
    (directory/'diagnostic-install.json').write_text(json.dumps(receipt, indent=2)+'\n')
    request_snapshot(directory,label,False,resolve_class_identities)
    print(json.dumps({'directory':str(directory), **receipt}, indent=2))


def label_snapshot(directory,label,resolve_class_identities=None):
    directory,main,save_name,assembly_sha=validate_package(directory)
    installed=json.loads((directory/'diagnostic-install.json').read_text())
    assert installed.get('wrapper_version')==2 and installed.get('label_request_supported') is True, 'Install the v2 wrapper first'
    assert sha(directory/SWF)==installed['wrapper_sha256'] and sha(main)==installed['main_sha256']
    assert installed.get('assembly_sha256')==assembly_sha
    request=request_snapshot(directory,label,resolve_class_identities=resolve_class_identities)
    print(json.dumps({'request':request,'file':str(directory/'diagnostic-request.json'),
        'status':'requested; inspect diagnostic SOL for matching label/reason to confirm observation'},ensure_ascii=False,indent=2))


def parse_sol(path, full):
    # Header first: never deserialize another save's payload even if supplied by mistake.
    path = path.expanduser().resolve()
    assert path.name == NAME+'.sol', 'Only diagnostic SOL filename accepted'
    assert path.stat().st_size <= 100000, 'Unexpected diagnostic size'
    data = path.read_bytes()
    assert data[:2] == b'\0\xbf' and data[6:16] == b'TCSO\0\x04\0\0\0\0'
    size = int.from_bytes(data[16:18], 'big')
    assert data[18:18+size].decode() == NAME, 'Only diagnostic SOL internal name accepted'
    sys.path.insert(0, str(ROOT/'tools'))
    from sol import loads
    name, fields = loads(data)
    assert name == NAME and set(fields) == {'payload'}
    report = json.loads(fields['payload'])
    assert report['schema'] == 'yzlr2-diagnostic-v1'
    assert len(report['samples']) <= 24 and len(report['errors']) <= 8
    if full:
        print(json.dumps(report, ensure_ascii=False, indent=2))
        return
    print(json.dumps({k:v for k,v in report.items() if k != 'samples'}, ensure_ascii=False))
    for sample in report['samples']:
        p = sample.get('player1') or {}
        w = sample.get('world') or {}
        animation = p.get('animation') or {}
        print(json.dumps({'sequence':sample['sequence'], 'ms':sample['ms'], 'reason':sample['reason'],'label':sample.get('label'),
            'map':sample.get('map'), 'room':sample.get('room'), 'fps':sample.get('observedFPS'),
            'player1':{'hp':p.get('hp'), 'mp':p.get('mp'), 'x':p.get('x'), 'y':p.get('y'),
                'animation':animation.get('type'), 'frame':animation.get('frame')},
            'enemyCount':w.get('enemyChildren'), 'enemies':[{'identity':e['identity'], 'id':e['id'],
                'hp':e['hp'], 'x':e['x'], 'y':e['y']} for e in w.get('enemies',[])],
            'truncated':w.get('enemyChildrenTruncated'),'tasks':sample.get('tasks'),
            'inventory1':sample.get('inventory1'),'resources':sample.get('resources')}, ensure_ascii=False))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest='action', required=True)
    sub.add_parser('build')
    install_parser = sub.add_parser('install')
    install_parser.add_argument('directory', type=Path)
    install_parser.add_argument('--label',default='run')
    install_parser.add_argument('--resolve-class-identities',action='store_true',help='Opt in: resolving unused classes can run static initializers')
    label_parser=sub.add_parser('label')
    label_parser.add_argument('directory',type=Path)
    label_parser.add_argument('text')
    label_parser.add_argument('--resolve-class-identities',action=argparse.BooleanOptionalAction,default=None)
    read_parser = sub.add_parser('read-sol')
    read_parser.add_argument('path', type=Path)
    read_parser.add_argument('--full', action='store_true')
    args = parser.parse_args()
    if args.action == 'build': build()
    elif args.action == 'install': install(args.directory,args.label,args.resolve_class_identities)
    elif args.action == 'label': label_snapshot(args.directory,args.text,args.resolve_class_identities)
    else: parse_sol(args.path, args.full)


if __name__ == '__main__': main()
