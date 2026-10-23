#!/usr/bin/env python3
"""Rebuild every DataX class from recovered AS3 plus script-free resources."""
import hashlib
import argparse
import json
from pathlib import Path
import re
import shutil
import subprocess
import struct
import time
import tempfile
import zipfile
from datetime import datetime, timezone
from datax_recover import verify_compiled_indata
from datax_source import expected_for_source
from probe_rebuild_module import tags
from probe_normalize_swf import normalize, encode
from swf_inventory import abc_inventory, read_swf, walk_tags, Reader
from build_inputs import capture, finish

ROOT = Path(__file__).resolve().parents[2]
BUILD = ROOT/'reverse/build/datax-recovery'
LOGS = ROOT/'reverse/logs/datax-recovery'
REPORT = ROOT/'reverse/experiments/datax-recovery'


def sha(data): return hashlib.sha256(data).hexdigest()


def verify_xmlasset_bindings(swf,run,java):
    """Inspect fresh FFDec disassembly, never raw-byte-search instruction operands."""
    classes=['src._data.ShopFactory','src._data.XingLingFactory','src.Shop_LiBao','src.Shop_LiBao2']
    directory=run/'binding-pcode'
    command=[str(java),'-Djava.awt.headless=true','-jar',str(ROOT/'.runtime/shared-tools/ffdec/ffdec.jar'),
        '-selectclass',','.join(classes),'-format','script:pcode','-export','script',str(directory),str(swf)]
    result=subprocess.run(command,cwd=ROOT,capture_output=True,text=True,timeout=120)
    (run/'binding-pcode.log').write_text(result.stdout+result.stderr)
    assert result.returncode==0,'FFDec p-code export failed'
    evidence=[]
    for name in classes:
        path=directory/'scripts'/(name.replace('.','/')+'.pcode')
        content=path.read_text();bindings=[]
        for line_number,line in enumerate(content.splitlines(),1):
            line=line.strip()
            assert not re.search(r'^(?:getlex|findpropstrict) (?:Multiname\("com"|QName\([^)]*\),\s*"com"\))',line), f'Dynamic com lookup: {name}:{line_number}'
            if re.search(r'^(?:getlex|findpropstrict) Multiname\("XMLAsset"',line):
                assert 'PackageNamespace("com.hotpoint.braveManIII.Tool")' in line and 'PackageNamespace("src.tool")' not in line,line
                bindings.append({'line':line_number,'instruction':line})
        assert len(bindings)==(1 if name.endswith('Factory') else 2),(name,bindings)
        evidence.append({'class':name,'path':str(path.relative_to(ROOT)),'pcode_sha256':sha(path.read_bytes()),'bindings':bindings})
    return {'command':command,'fresh_export':True,'all_six_XMLAsset_bindings_resolved_to_Tool':True,
        'dynamic_com_lookup_absent_in_four_classes':True,'classes':evidence}


def restore_root(path, original):
    """Restore DataX's proven empty root timeline metadata and initialization class."""
    raw, body, header=read_swf(path)
    _, oldbody, oldheader=read_swf(original)
    oldtags=[(t,p) for t,p in walk_tags(oldbody,oldheader['tag_start']) if t['parent']=='root']
    assert oldheader['frame_count']==1
    assert not any(t['code'] in (4,5,26,28,70,12,59) for t,p in oldtags), 'Root timeline has placements or actions: needs reconstruction'
    root=None; extras={}
    for t,p in oldtags:
        if t['code']==76:
            r=Reader(p)
            for _ in range(r.u16()):
                cid=r.u16(); name=r.cstr()
                if cid==0: root=name
        if t['code'] in (9,43,86): extras[t['code']]=p
    assert root=='src.Data'
    def tag(code,payload): return struct.pack('<HI',(code<<6)|63,len(payload))+payload
    out=bytearray(oldbody[:oldheader['tag_start']]);root_replaced=False;seen=set()
    for t,p in walk_tags(body,header['tag_start']):
        if t['parent']!='root': continue
        code=t['code']
        if code==76:
            r=Reader(p); count=r.u16(); replacement=bytearray(struct.pack('<H',count))
            for _ in range(count):
                cid=r.u16();name=r.cstr()
                if cid==0: name=root;root_replaced=True
                replacement += struct.pack('<H',cid)+name.encode()+b'\0'
            p=bytes(replacement)
        if code in extras: p=extras[code];seen.add(code)
        if code==1:
            for key,value in extras.items():
                if key not in seen: out+=tag(key,value);seen.add(key)
        out+=tag(code,p)
    assert root_replaced
    path.write_bytes(encode(raw,out))
    _, checkbody, checkheader=read_swf(path)
    list(walk_tags(checkbody,checkheader['tag_start']))
    return {'document_class':root,'frame_rate':checkheader['frame_rate'],'rect_twips':checkheader['rect_twips'],
        'frame_count':checkheader['frame_count'],'restored_root_tag_codes':sorted(extras),'original_abc_copied':False,
        'reason':'src.Data constructor initializes data tables; compc generated library Sprite does not.'}


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source-dir',type=Path,default=ROOT/'reverse/source/DataX_v76')
    args=parser.parse_args()
    tools=ROOT/'reverse/tools'
    input_fingerprint=capture('DataX_v76',args.source_dir,
        extra_files=[ROOT/'reverse/experiments/datax-recovery/recovery.json',
            ROOT/'reverse/exports/DataX_v76/inventory/abc-0000.json',
            ROOT/'reverse/exports/DataX_v76/inventory/abc-0000.abc',
            ROOT/'reverse/exports/DataX_v76/scripts-receipt.json'],
        extra_trees=[ROOT/'reverse/exports/DataX_v76/scripts/_assets',
            ROOT/'reverse/source/DataX_v76-config'],
        recipe_files=[tools/name for name in ('datax_build.py','datax_source.py','datax_recover.py',
            'probe_rebuild_module.py','probe_source_repairs.py','probe_root_timeline.py',
            'probe_normalize_swf.py','swf_inventory.py')])
    BUILD.mkdir(parents=True,exist_ok=True)
    run=Path(tempfile.mkdtemp(prefix='run-',dir=BUILD))
    run_id = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S.%fZ')
    prior_report = json.loads((REPORT/'build-full.json').read_text()) if (REPORT/'build-full.json').exists() else None
    exported = ROOT/'reverse/exports/DataX_v76/scripts'
    source = BUILD/'full-source'
    if source.exists(): shutil.move(str(source),str(run/'prior-source'))
    shutil.copytree(args.source_dir, source)
    for asset in (exported/'_assets').rglob('*'):
        if asset.is_file():
            destination=source/asset.relative_to(exported)
            destination.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(asset,destination)
    canonical_hashes={str(p.relative_to(source)):sha(p.read_bytes()) for p in source.rglob('*.as')}
    recovery=expected_for_source(source/'src/InData.as')
    changes = []
    for path in source.rglob('*.as'):
        original = path.read_text()
        modified, count = re.subn(r'(?m)^(\s*)\{\};\s*$', r'\1;', original)
        if count:
            changes.append({'file':str(path.relative_to(source)), 'change':'isolated empty {}; becomes legal empty statement ;', 'count':count})
        if path.name in ('ShopFactory.as','XingLingFactory.as','Shop_LiBao2.as','Shop_LiBao.as'):
            modified = modified.replace('   import com.hotpoint.braveManIII.Tool.*;', '   import com.hotpoint.braveManIII.Tool.XMLAsset;')
            modified = modified.replace('   import src.tool.*;', '   import src.tool.TiaoShi;' if path.name.endswith('Factory.as') else '')
            assert 'com.hotpoint.braveManIII.Tool.XMLAsset.createXML' not in modified, 'Use an explicit import and short class lookup; qualified dynamic chains can fail at runtime'
            if modified != original:
                changes.append({'file':str(path.relative_to(source)), 'change':'explicit Tool.XMLAsset import; expand src.tool wildcard to only TiaoShi for factories, none for gift panels; keep short XMLAsset.createXML to avoid dynamic com lookup'})
        if modified != original: path.write_text(modified)
    assets = []
    for path in (source/'_assets').rglob('*'):
        if not path.is_file(): continue
        codes = [code for code, _ in tags(path)] if path.suffix == '.swf' else []
        assert not set(codes).intersection((12,59,72,82)), f'Original ABC/script in resource {path}'
        assets.append({'path':str(path.relative_to(source)), 'sha256':sha(path.read_bytes()), 'script_tags':0})
    classes = sorted('.'.join(path.relative_to(source).with_suffix('').parts) for path in source.rglob('*.as'))
    java = ROOT/'.runtime/shared-tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java'
    flex = ROOT/'.runtime/shared-tools/flex/apache-flex-sdk-4.16.1-bin'
    player = ROOT/'.runtime/shared-tools/ffdec/flashlib/playerglobal32_0.swc'
    output = run/'DataX-rebuilt.swc'
    assert not output.exists()
    command = [str(java), '-Xmx4g', '-Djava.awt.headless=true', f'-Dflexlib={flex}/frameworks', '-jar', str(flex/'lib/compc.jar'),
        '-load-config=', '-compiler.theme=', f'-compiler.external-library-path={player}', '-compiler.library-path=',
        f'-compiler.source-path={source}', '-compiler.strict=false', '-debug=false', '-use-network=false',
        '-target-player=32.0', '-include-classes', *classes, f'-output={output}']
    LOGS.mkdir(parents=True,exist_ok=True)
    start=time.monotonic()
    log_path=LOGS/f'compile-full-{run_id}.log'
    with log_path.open('w') as log:
        result=subprocess.run(command,cwd=ROOT,stdout=log,stderr=subprocess.STDOUT,timeout=360)
    success=result.returncode==0 and output.is_file() and 'Error:' not in log_path.read_text(errors='replace')
    report={'command':command, 'exit_code':result.returncode, 'success':success,'seconds':round(time.monotonic()-start,3),
        'run_id':run_id,'log':str(log_path.relative_to(ROOT)),
        'input_fingerprint':input_fingerprint,
        'xml_config_policy':'XML mirror is fingerprinted but only changes compiled AS after explicit datax_source.py import-xml; canonical InData.as is the build input.',
        'canonical_source':str(args.source_dir),'canonical_source_hashes':canonical_hashes,
        'source_class_count':len(classes),'source_repairs':changes,'assets':assets,
        'original_abc_reused':False,'runtime_tested':False,
        'input_source_hashes':{str(p.relative_to(source)):sha(p.read_bytes()) for p in source.rglob('*.as')}}
    if success:
        with zipfile.ZipFile(output) as bundle: swf=bundle.read('library.swf')
        raw=run/'DataX-rebuilt-raw.swf';raw.write_bytes(swf)
        normalized=run/'DataX_v76-rebuilt.swf'
        report['normalization']=normalize(raw,normalized,ROOT/'DataX_v76.swf')
        report['root_restoration']=restore_root(normalized,ROOT/'DataX_v76.swf')
        original_inv=json.loads((ROOT/'reverse/exports/DataX_v76/inventory/abc-0000.json').read_text())
        rebuilt=[];indata_abc=None
        for code,payload in tags(normalized):
            if code==82:
                abc=payload[payload.index(b'\0',4)+1:]
                parsed=abc_inventory(abc);rebuilt.append(parsed)
                if any(c['name']=='src.InData' for c in parsed['classes']):indata_abc=abc
        rebuilt_classes={c['name'] for item in rebuilt for c in item['classes']}
        original_classes={c['name'] for c in original_inv['classes']}
        original_rows=original_inv['classes']
        rebuilt_rows=[c for item in rebuilt for c in item['classes']]
        renamed_private=[]
        for name in ('ArrayTweenInfo','PrivateClass'):
            before=[c for c in original_rows if c['name']==name]
            after=[c for c in rebuilt_rows if re.search(r'\.as\$\d+\.'+name+'$',c['name'])]
            assert len(before)==len(after), f'Private class multiplicity changed: {name}'
            assert all(c['super']==before[0]['super'] and c['traits']==before[0]['traits'] and not c['static_traits'] for c in after)
            renamed_private.append({'original_name':name,'original_count':len(before),
                'rebuilt_names':[c['name'] for c in after],'check':'same multiplicity, superclass, instance/static traits; compiler-assigned file-private namespace'})
        unresolved=sorted((original_classes-rebuilt_classes)-{x['original_name'] for x in renamed_private})
        report['class_coverage']={'original':len(original_classes),'rebuilt':len(rebuilt_classes),
            'original_class_rows':len(original_rows),'rebuilt_class_rows':len(rebuilt_rows),
            'missing_exact_names':sorted(original_classes-rebuilt_classes),'added_exact_names':sorted(rebuilt_classes-original_classes),
            'file_private_renames':renamed_private,'unresolved_missing':unresolved}
        xml={sha(s.encode()) for item in rebuilt for s in item['strings']}
        assert indata_abc is not None
        report['indata_semantics']=verify_compiled_indata(indata_abc,recovery)
        report['all_11_xml_constants_byte_exact']=all(m['xml_sha256'] in xml for m in recovery['methods'])
        report['xml_constants_match_original_baseline']=all(m['xml_sha256']==m['original_xml_sha256'] for m in recovery['methods'])
        assert report['all_11_xml_constants_byte_exact']
        assert not unresolved
        report['xmlasset_bindings']=verify_xmlasset_bindings(normalized,run,java)
        report.update(output=str(normalized.relative_to(ROOT)),output_sha256=sha(normalized.read_bytes()),
            output_abc_count=len(rebuilt),output_class_count=len(rebuilt_classes))
        if prior_report and prior_report.get('output_sha256'):
            report['previous_output_sha256']=prior_report['output_sha256']
            report['repeat_normalized_output_byte_equal']=prior_report['output_sha256']==report['output_sha256']
        report['input_fingerprint']=finish(input_fingerprint)
        shutil.copy2(normalized,BUILD/'DataX_v76-rebuilt.swf')
    (REPORT/'build-full.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    (REPORT/f'build-{run_id}.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:v for k,v in report.items() if k not in ('command','normalization','input_source_hashes','canonical_source_hashes','assets','input_fingerprint')},ensure_ascii=False))
    if not success: raise SystemExit('DataX compilation failed; inspect fresh run log; stable output was not replaced')


if __name__=='__main__': main()
