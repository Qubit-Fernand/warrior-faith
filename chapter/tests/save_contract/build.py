#!/usr/bin/env python3
"""Compile isolated AS3 tests of the current real manager; never starts Flash."""
import hashlib
import json
import shutil
import subprocess
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
TEST_ROOT = Path(__file__).resolve().parent
CANONICAL = ROOT / 'reverse/source/3_L4399Main_gamefile/src/LocalSaveManager.as'
REPORT_NAME = 'yzlr2_rebuild_save_contract_diag_v1'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def build():
    before = CANONICAL.read_bytes()
    replacements = [
        (b'import flash.net.SharedObject;', b'import chaptertest.FakeSharedObject;', 1),
        (b':SharedObject', b':FakeSharedObject', 2),
        (b'SharedObject.getLocal(SO_NAME)', b'FakeSharedObject.getLocal(SO_NAME)', 1),
    ]
    adapted = before
    changes = []
    for old, new, count in replacements:
        assert adapted.count(old) == count, ('unexpected adapter site count', old)
        adapted = adapted.replace(old, new)
        changes.append({'before':old.decode(), 'after':new.decode(), 'count':count})
    restored = adapted
    for old, new, count in reversed(replacements):
        restored = restored.replace(new, old)
    assert restored == before, 'Test adapter must not alter saving control flow'
    assert b'import flash.net.SharedObject;' not in adapted
    stamp = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S.%fZ')
    out = ROOT / 'reverse/build/chapter-save-contract' / ('run-' + stamp)
    stage = out / 'source'
    shutil.copytree(TEST_ROOT / 'src', stage)
    (stage / 'src').mkdir()
    (stage / 'src/LocalSaveManager.as').write_bytes(adapted)
    build_info = ('package chaptertest { public class BuildInfo {\n'
        'public static const CANONICAL_SHA:String=' + json.dumps(sha(before)) + ';\n'
        'public static const GENERATION:String=' + json.dumps(stamp) + ';\n}}\n')
    (stage/'chaptertest/BuildInfo.as').write_text(build_info)
    target = out / 'SaveContractHarness.swf'
    java = ROOT / '.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'
    flex = ROOT / '.runtime/shared-tools/flex/apache-flex-sdk-4.16.1-bin'
    player = ROOT / '.runtime/shared-tools/ffdec/flashlib/playerglobal32_0.swc'
    command = [str(java), '-Djava.awt.headless=true', f'-Dflexlib={flex}/frameworks', '-jar', str(flex/'lib/mxmlc.jar'),
        '-load-config=', '-compiler.theme=', f'-compiler.external-library-path={player}',
        f'-compiler.source-path={stage}', '-compiler.strict=false', '-target-player=32.0', '-use-network=false',
        '-debug=true', '-compiler.omit-trace-statements=false', f'-output={target}', str(stage/'SaveContractHarness.as')]
    result = subprocess.run(command, capture_output=True, text=True, timeout=90)
    (out/'compile.log').write_text(result.stdout+result.stderr)
    assert CANONICAL.read_bytes() == before, 'Canonical manager changed during test compilation'
    receipt = {'schema':1, 'compiled':result.returncode==0 and target.exists(), 'runtime_executed':False,
        'canonical_source':str(CANONICAL.relative_to(ROOT)), 'canonical_sha256':sha(before),
        'adapted_sha256':sha(adapted), 'reversible_adapter_only':True, 'adapter_replacements':changes,
        'test_sources':{str(p.relative_to(ROOT)):sha(p.read_bytes()) for p in sorted((TEST_ROOT/'src').rglob('*.as'))},
        'staged_sources':{str(p.relative_to(stage)):sha(p.read_bytes()) for p in sorted(stage.rglob('*.as'))},
        'build_script_sha256':sha(Path(__file__).read_bytes()), 'command':command,
        'compiler_mode':'strict=false matches the canonical Main build; manager control flow unchanged',
        'compiler_exit':result.returncode, 'diagnostic_SO':REPORT_NAME,
        'real_game_SO_opened':False, 'native_pending_permission_tested':False,
        'output':str(target.relative_to(ROOT)), 'output_sha256':sha(target.read_bytes()) if target.exists() else None}
    (out/'receipt.json').write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({'compiled':receipt['compiled'],'runtime_executed':False,'output':receipt['output'],
        'receipt':str((out/'receipt.json').relative_to(ROOT)),'diagnostic_SO':REPORT_NAME},indent=2))
    if not receipt['compiled']:
        raise RuntimeError(result.stdout+result.stderr)


if __name__ == '__main__':
    build()
