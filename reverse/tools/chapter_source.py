#!/usr/bin/env python3
"""Explicit canonical chapter import. Never edits FFDec exports or old saves."""
import argparse
import csv
import hashlib
import json
import re
import shutil
import struct
import xml.etree.ElementTree as ET
from pathlib import Path, PurePosixPath

ROOT = Path(__file__).resolve().parents[2]
CONTENT = ROOT / 'chapter/content'
GENERATED = ROOT / 'chapter/generated'
SOURCE = ROOT / 'reverse/source/3_L4399Main_gamefile'
RAW = ROOT / 'reverse/exports/3_L4399Main_gamefile/scripts'
EXTENSIONS = CONTENT / 'extensions.json'
BASELINE_LEDGER = ROOT / 'reverse/manifests/recovered-sources.json'
TASK_ASSET = '_assets/8632_src.Data2_taskData.bin'
BACKGROUNDS = ROOT / 'chapter/assets/backgrounds'
BACKGROUND_SCENES = ('dock', 'warden', 'regent')

def sha(data):
    return hashlib.sha256(data).hexdigest()


def require(condition, message):
    """Manifest boundaries remain enforced even when Python is invoked with -O."""
    if not condition:
        raise ValueError(message)


def safe_relative(root, label):
    """A normalized POSIX child path; never absolute, traversal, aliases or escapes."""
    require(isinstance(label, str) and bool(label), 'Expected a non-empty relative path')
    require('\\' not in label and '\x00' not in label and ':' not in label,
            'Unsafe relative path: ' + repr(label))
    path = PurePosixPath(label)
    require(not path.is_absolute() and all(part not in ('', '.', '..') for part in label.split('/'))
            and path.as_posix() == label, 'Unsafe relative path: ' + label)
    destination = root / label
    require(destination.resolve().is_relative_to(root.resolve()), 'Path escapes allowed root: ' + label)
    return destination


def tree_files(root, suffix=None):
    """Reject linked directory aliases that copytree could follow outside the audited set."""
    require(root.is_dir(), 'Missing source/input directory: ' + str(root))
    result = {}
    for path in sorted(root.rglob('*')):
        relative = path.relative_to(root).as_posix()
        safe_relative(root, relative)
        require(not path.is_symlink(), 'Linked source/input entry is not permitted: ' + str(path))
        if path.is_file() and (suffix is None or path.suffix == suffix):
            result[relative] = path
    return result


def declared_class(path):
    source = path.read_text(encoding='utf-8')
    # String/comment contents must not masquerade as package or class declarations.
    source = re.sub(r'//[^\n]*|/\*.*?\*/|"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'',
                    ' ', source, flags=re.S)
    package = re.search(r'\bpackage\s+([\w$.]+)\s*\{', source)
    name = re.search(r'\bpublic\s+(?:(?:dynamic|final)\s+)*class\s+([\w$]+)\b', source)
    require(package is not None and name is not None, 'Missing public class/package: ' + str(path))
    return package.group(1) + '.' + name.group(1)


def validate_extensions(outputs=None, require_generated=True, manifest=None):
    """Read-only exact extension audit. Import may recreate only declared generated files."""
    manifest = json.loads(EXTENSIONS.read_text()) if manifest is None else manifest
    require(set(manifest) == {'schema','module','raw_source_root','canonical_source_root',
            'document_class','baseline_manifest','baseline_manifest_sha256','baseline_script_count',
            'classes','generated_assets'}, 'Unexpected extensions manifest fields')
    require(manifest['schema'] == 1 and manifest['module'] == '3_L4399Main_gamefile',
            'Unsupported extensions manifest schema/module')
    for key, expected_path in (
            ('raw_source_root', RAW.relative_to(ROOT).as_posix()),
            ('canonical_source_root', SOURCE.relative_to(ROOT).as_posix()),
            ('baseline_manifest', BASELINE_LEDGER.relative_to(ROOT).as_posix())):
        safe_relative(ROOT, manifest[key])
        require(manifest[key] == expected_path, 'Unexpected extension root: ' + key)
    require(manifest['document_class'] == 'src.Main', 'Main document class must remain src.Main')
    ledger_bytes = BASELINE_LEDGER.read_bytes()
    require(sha(ledger_bytes) == manifest['baseline_manifest_sha256'], 'Baseline source ledger SHA mismatch')
    rows = [row for row in json.loads(ledger_bytes) if row['swf'] == '3_L4399Main_gamefile.swf']
    require(len(rows) == 1, 'Expected one Main baseline source ledger')
    baseline = rows[0]
    require(baseline['source_root'] == manifest['canonical_source_root'] and
            baseline['asset_export_root'] == manifest['raw_source_root'], 'Baseline source roots differ')
    require(sha((ROOT / baseline['swf']).read_bytes()) == baseline['swf_sha256'], 'Original Main SWF SHA mismatch')
    recovered = {row['path']:row['sha256'] for row in baseline['sources']}
    require(len(recovered) == len(baseline['sources']) == manifest['baseline_script_count'],
            'Duplicate or changed baseline script count')
    original = tree_files(RAW, '.as')
    require(set(original) == set(recovered), 'RAW scripts differ from recovered-source ledger')
    for label, digest in recovered.items():
        path = safe_relative(RAW, label)
        require(sha(path.read_bytes()) == digest, 'RAW script SHA mismatch: ' + label)
    # The original task source must not drift along with a modified chapter task XML.
    tasks = [row for row in baseline['assets'] if row['path'] == TASK_ASSET]
    require(len(tasks) == 1 and sha(safe_relative(RAW, TASK_ASSET).read_bytes()) == tasks[0]['sha256'],
            'Original task asset SHA mismatch')
    canonical = tree_files(SOURCE, '.as')
    missing = set(original) - set(canonical)
    require(not missing, 'Original canonical scripts missing: ' + repr(sorted(missing)))
    require(declared_class(safe_relative(SOURCE, 'src/Main.as')) == 'src.Main', 'Canonical Main class changed')
    symbols = ROOT / 'reverse/exports/3_L4399Main_gamefile/symbolClass/symbols.csv'
    roots = [row[1] for row in csv.reader(symbols.read_text().splitlines(), delimiter=';') if row[0] == '0']
    require(roots == ['src.Main'], 'Original document class binding differs')

    declared = {}
    generated_classes = set()
    for row in manifest['classes']:
        require(set(row) == {'path','qualified_name','kind','purpose'}, 'Unexpected extension class fields')
        path = safe_relative(SOURCE, row['path'])
        require(path.suffix == '.as', 'Extension class must be AS: ' + row['path'])
        require(row['path'] not in declared, 'Duplicate extension class: ' + row['path'])
        require(row['path'] not in original, 'Baseline class incorrectly listed as extension: ' + row['path'])
        require(row['kind'] in ('authored','compatibility','generated') and bool(row['purpose']), 'Invalid extension class kind/purpose')
        require(row['qualified_name'] == row['path'][:-3].replace('/', '.'), 'Class path/name mismatch: ' + row['path'])
        declared[row['path']] = row
        if row['kind'] == 'generated':
            generated_classes.add(row['path'])
        if path.exists():
            require(declared_class(path) == row['qualified_name'], 'AS declaration differs from extension manifest: ' + row['path'])
    generated_expected = {'src/epilogue/ChapterContent.as', 'src/epilogue/scene/ChapterBackdrop.as'}
    require(generated_classes == generated_expected, 'Unexpected generated AS class set')
    actual = set(canonical) - set(original)
    projected = actual if require_generated else actual | generated_classes
    require(projected == set(declared), 'Extension AS set mismatch; undeclared=' + repr(sorted(actual-set(declared)))
            + '; missing=' + repr(sorted(set(declared)-projected)))

    background_inputs()  # Keep image/prompt SHA, PNG dimensions and scene checks intact.
    assets = {}
    for row in manifest['generated_assets']:
        require(set(row) == {'scene','source','path','sha256'}, 'Unexpected generated asset fields')
        scene = row['scene']
        require(scene in BACKGROUND_SCENES and scene not in assets, 'Unexpected or duplicate generated background scene')
        safe_relative(ROOT, row['source'])
        safe_relative(GENERATED/'overlay', row['path'])
        require(row['source'] == 'chapter/assets/backgrounds/' + scene + '-v1.png', 'Unexpected background source')
        require(row['path'] == '_assets/chapter/' + scene + '.png', 'Unexpected background overlay path')
        require(sha((ROOT/row['source']).read_bytes()) == row['sha256'], 'Extension background SHA mismatch: ' + scene)
        assets[scene] = row
    require(set(assets) == set(BACKGROUND_SCENES), 'Missing generated background declaration')
    expected_overlay = {TASK_ASSET} | {row['path'] for row in assets.values()}
    actual_overlay = set(tree_files(GENERATED/'overlay')) if (GENERATED/'overlay').exists() else set()
    require(actual_overlay <= expected_overlay, 'Undeclared overlay assets: ' + repr(sorted(actual_overlay-expected_overlay)))
    if require_generated:
        require(actual_overlay == expected_overlay, 'Declared generated overlay assets missing: ' + repr(sorted(expected_overlay-actual_overlay)))
        for row in assets.values():
            path = safe_relative(GENERATED/'overlay', row['path'])
            require(sha(path.read_bytes()) == row['sha256'], 'Generated background overlay SHA mismatch: ' + row['scene'])
    if outputs is not None:
        expected_paths = {SOURCE/label for label in generated_classes} | {GENERATED/'overlay'/label for label in expected_overlay}
        require(set(outputs) == expected_paths, 'Importer output set differs from declared extensions')
        for row in assets.values():
            require(sha(outputs[GENERATED/'overlay'/row['path']]) == row['sha256'], 'Generated background bytes differ: ' + row['scene'])
    return {'schema':1,'manifest_sha256':sha(EXTENSIONS.read_bytes()),'baseline_script_count':len(original),
            'document_class':'src.Main','added_classes':sorted(declared),
            'generated_classes':sorted(generated_classes),'generated_assets':sorted(row['path'] for row in assets.values())}

def background_inputs():
    """Validate exactly three declared PNGs and their generation prompts."""
    manifest_path = BACKGROUNDS / 'manifest.json'
    raw_manifest = manifest_path.read_bytes()
    manifest = json.loads(raw_manifest)
    assert manifest['version'] == 1, 'Unsupported background manifest'
    assert manifest['logical_world'] == {'width':1600,'height':580,'floor_y':450}
    rows = manifest['assets']
    assert len(rows) == len(BACKGROUND_SCENES), 'Expected three background assets'
    assert {row['scene'] for row in rows} == set(BACKGROUND_SCENES), 'Unexpected or duplicate scene'
    inputs = {manifest_path:raw_manifest}
    for row in rows:
        scene = row['scene']
        # Exact filenames prevent manifest path traversal and hidden extra assets.
        assert row['file'] == scene + '-v1.png', 'Unexpected background filename'
        assert row['prompt'] == 'prompts/' + scene + '-v1.txt', 'Unexpected prompt filename'
        image_path = BACKGROUNDS / row['file']
        prompt_path = BACKGROUNDS / row['prompt']
        assert image_path.resolve().is_relative_to(BACKGROUNDS.resolve())
        assert prompt_path.resolve().is_relative_to(BACKGROUNDS.resolve())
        image = image_path.read_bytes()
        prompt = prompt_path.read_bytes()
        assert sha(image) == row['sha256'], 'Background SHA mismatch: ' + scene
        assert sha(prompt) == row['prompt_sha256'], 'Background prompt SHA mismatch: ' + scene
        assert len(image) == row['bytes'], 'Background byte count mismatch: ' + scene
        assert image[:8] == b'\x89PNG\r\n\x1a\n' and image[12:16] == b'IHDR', 'Expected PNG: ' + scene
        width, height = struct.unpack('>II', image[16:24])
        assert (width,height) == (row['width'],row['height']), 'Background size mismatch: ' + scene
        assert width >= 1600 and height >= 580 and abs(width / height - 1600 / 580) < .01
        assert row['transparent_background'] is False
        inputs[image_path] = image
        inputs[prompt_path] = prompt
    declared_paths = {path.relative_to(BACKGROUNDS).as_posix() for path in inputs}
    actual_paths = {label for label in tree_files(BACKGROUNDS) if not label.endswith('.md')}
    require(actual_paths == declared_paths, 'Undeclared or missing background input files')
    return inputs


def background_outputs():
    inputs = background_inputs()
    declarations = []
    for scene in BACKGROUND_SCENES:
        declarations.append('        [Embed(source="/_assets/chapter/' + scene + '.png", mimeType="image/png")]\n'
                            '        private static var ' + scene.capitalize() + 'Image:Class;')
    code = ('// Generated by chapter_source.py import; assets and hashes: chapter/assets/backgrounds/manifest.json.\n'
            'package src.epilogue.scene\n{\n'
            '    import flash.display.Bitmap;\n'
            '    import flash.display.Sprite;\n\n'
            '    /** Painted scenery only; world placement and collision belong to the controller. */\n'
            '    public class ChapterBackdrop extends Sprite\n    {\n'
            + '\n'.join(declarations) + '\n'
            '        private var image:Bitmap;\n\n'
            '        public function ChapterBackdrop(scene:String)\n        {\n'
            '            super();\n'
            '            mouseEnabled=false;mouseChildren=false;\n'
            '            var asset:Class;\n'
            '            if(scene=="dock")asset=DockImage;\n'
            '            else if(scene=="warden")asset=WardenImage;\n'
            '            else if(scene=="regent")asset=RegentImage;\n'
            '            else throw new ArgumentError("Unknown chapter backdrop: "+scene);\n'
            '            image=new asset() as Bitmap;\n'
            '            image.smoothing=true;image.width=1600;image.height=580;\n'
            '            addChild(image);name="chapterBackdrop_"+scene;\n'
            '        }\n\n'
            '        public function dispose():void\n        {\n'
            '            if(image){if(image.parent)image.parent.removeChild(image);image.bitmapData=null;image=null;}\n'
            '            if(parent)parent.removeChild(this);\n'
            '        }\n'
            '    }\n}\n').encode()
    outputs = {SOURCE/'src/epilogue/scene/ChapterBackdrop.as':code}
    for scene in BACKGROUND_SCENES:
        outputs[GENERATED/'overlay/_assets/chapter'/(scene+'.png')] = inputs[BACKGROUNDS/(scene+'-v1.png')]
    return outputs


def canonical_inputs():
    paths = {p:p.read_bytes() for p in sorted(CONTENT.rglob('*')) if p.is_file()}
    paths.update(background_inputs())
    return {str(p.relative_to(ROOT)):sha(data) for p,data in sorted(paths.items())}

def expected():
    story = json.loads((CONTENT / 'story.json').read_text())
    assert story['version'] == 1 and story['dialogues'] and story['journal']
    for name, pages in story['dialogues'].items():
        assert pages and all(p.get('speaker') and p.get('text') for p in pages), name
    tasks = (CONTENT / 'main-tasks.xml').read_bytes()
    xml = ET.fromstring(tasks)
    ids = [int(t.findtext('ID')) for t in xml.findall('任务')]
    assert len(ids) == len(set(ids)), 'Duplicate task ID'
    assert {110117,190001,190002,190003} <= set(ids)
    base = ET.fromstring((ROOT / 'reverse/exports/3_L4399Main_gamefile/scripts' / TASK_ASSET).read_bytes())
    old = {int(t.findtext('ID')): ET.tostring(t,encoding='unicode').strip() for t in base.findall('任务')}
    changed = [int(t.findtext('ID')) for t in xml.findall('任务')
               if int(t.findtext('ID')) in old and ET.tostring(t,encoding='unicode').strip() != old[int(t.findtext('ID'))]]
    assert not changed, 'Original tasks changed: ' + str(changed)
    assert set(old) <= set(ids), 'Original tasks missing: ' + str(sorted(set(old)-set(ids)))
    extra = set(ids) - set(old)
    assert extra == {190001,190002,190003}, extra
    # These narrative task records have a reserved type and are driven by the
    # chapter controller, not legacy kill-count or reward UI assumptions.
    for t in xml.findall('任务'):
        if int(t.findtext('ID')) in extra:
            assert t.findtext('大类型') == '3'
            assert t.findtext('奖励/金币') == '0'
            assert t.findtext('奖励/经验') == '0'
    literal = json.dumps(story,ensure_ascii=False,indent=4)
    code = ('// Generated by chapter_source.py import; edit chapter/content/story.json.\n'
            'package src.epilogue { public class ChapterContent {\n'
            'public static const DATA:Object = ' + literal + ';\n}}\n').encode()
    outputs = {SOURCE/'src/epilogue/ChapterContent.as':code,
               GENERATED/'overlay'/TASK_ASSET:tasks}
    outputs.update(background_outputs())
    validate_extensions(outputs, require_generated=False)
    return outputs

def import_content():
    outputs = expected()
    for path,data in outputs.items():
        path.parent.mkdir(parents=True,exist_ok=True)
        path.write_bytes(data)
    receipt = {'schema':1,'canonical':canonical_inputs(),
               'outputs':{str(p.relative_to(ROOT)):sha(data) for p,data in outputs.items()},
               'original_tasks_preserved':167,'added_scripted_tasks':[190001,190002,190003],
               'extensions':validate_extensions(outputs)}
    (GENERATED/'import.json').write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n')
    return receipt

def verify():
    receipt = json.loads((GENERATED/'import.json').read_text())
    current = canonical_inputs()
    assert current == receipt['canonical'], 'Content changed: run chapter_source.py import'
    outputs = expected()
    extension_receipt = validate_extensions(outputs)
    assert receipt.get('extensions') == extension_receipt, 'Extension receipt changed: re-import'
    assert set(receipt['outputs']) == {str(p.relative_to(ROOT)) for p in outputs}, 'Generated output list changed: re-import'
    for path,data in outputs.items():
        assert path.read_bytes() == data, 'Stale generated input: '+str(path)
        assert receipt['outputs'][str(path.relative_to(ROOT))] == sha(data)
    return receipt

def overlay(staging):
    receipt=verify()
    overlay_root = GENERATED/'overlay'
    # Copy only outputs attested by the import receipt, never stray overlay files.
    for label in receipt['outputs']:
        path = ROOT/label
        if path.is_relative_to(overlay_root):
            dest=staging/path.relative_to(overlay_root)
            dest.parent.mkdir(parents=True,exist_ok=True)
            shutil.copy2(path,dest)
    return receipt

if __name__ == '__main__':
    parser=argparse.ArgumentParser()
    parser.add_argument('command',choices=['import','verify','validate-extensions'])
    args=parser.parse_args()
    if args.command == 'validate-extensions':
        result = validate_extensions(expected())
    else:
        result = import_content() if args.command == 'import' else verify()
    print(json.dumps(result,ensure_ascii=False,indent=2))
