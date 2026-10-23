#!/usr/bin/env python3
"""Archive every recovered AS file with provenance; never overwrite edited sources."""
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

def sha(data):
    return hashlib.sha256(data).hexdigest()

def main():
    modules = []
    for row in json.loads((ROOT/'reverse/manifests/scripts-exports.json').read_text()):
        if row['status'] != 'ok':
            raise ValueError(f"Incomplete export: {row['source']}")
        stem = Path(row['source']).stem
        source = ROOT/'reverse/exports'/stem/'scripts'
        dest = ROOT/'reverse/source'/stem
        files = []
        for p in sorted(source.rglob('*.as')):
            relative = p.relative_to(source)
            data = p.read_bytes()
            q = dest/relative
            if q.exists() and q.read_bytes() != data:
                raise ValueError(f'Refusing to overwrite modified recovered source: {q}')
            if not q.exists():
                q.parent.mkdir(parents=True, exist_ok=True)
                q.write_bytes(data)
            files.append({'path':relative.as_posix(), 'sha256':sha(data), 'bytes':len(data)})
        if len(files) != row['expected_abc_script_count']:
            raise ValueError(f'Script count mismatch: {stem}')
        assets = []
        for p in sorted(source.rglob('*')):
            if p.is_file() and p.suffix != '.as':
                data = p.read_bytes()
                assets.append({'path':p.relative_to(source).as_posix(), 'sha256':sha(data), 'bytes':len(data)})
        modules.append({'swf':row['source'], 'swf_sha256':row['source_sha256'],
                        'source_root':dest.relative_to(ROOT).as_posix(), 'sources':files,
                        'asset_export_root':source.relative_to(ROOT).as_posix(), 'assets':assets})
    (ROOT/'reverse/manifests/recovered-sources.json').write_text(json.dumps(modules, ensure_ascii=False, indent=2)+'\n')
    print(json.dumps({'modules':len(modules), 'as_files':sum(len(x['sources']) for x in modules),
                      'as_bytes':sum(f['bytes'] for x in modules for f in x['sources']),
                      'asset_files':sum(len(x['assets']) for x in modules)}, indent=2))

if __name__ == '__main__':
    main()
