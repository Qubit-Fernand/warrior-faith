#!/usr/bin/env python3
"""Unified source-rebuild audit/build/assembly. Never launches Flash or accesses saves."""
from __future__ import annotations
import argparse
from collections import Counter
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
from swf_inventory import read_swf, walk_tags, Reader
from build_inputs import verify as verify_inputs

ROOT = Path(__file__).resolve().parents[2]
TOOLS = ROOT/'reverse/tools'
STATE = ROOT/'reverse/build/project'
MAIN = '3_L4399Main_gamefile'
DATAX = 'DataX_v76'
BASELINE = ROOT/'reverse/manifests/original-files.json'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read_json(path):
    return json.loads(path.read_text())


def source_hashes(module):
    root = ROOT/'reverse/source'/module
    return {p.relative_to(root).as_posix():sha(p) for p in sorted(root.rglob('*.as'))}


def receipt_candidates(module):
    if module == MAIN:
        paths = [ROOT/'reverse/build/main-probe/build-all.json']
        paths += list((ROOT/'reverse/build/main-probe').glob('run-*/receipt.json'))
    elif module == DATAX:
        paths = list((ROOT/'reverse/experiments/datax-recovery').glob('build-*.json'))
    else:
        paths = [ROOT/'reverse/experiments/module-probe'/module/'result.json']
    return sorted((p for p in paths if p.is_file()), key=lambda p:p.stat().st_mtime_ns, reverse=True)


def decode_receipt(module, path):
    r = read_json(path)
    if module == MAIN:
        if not r.get('success') or r.get('exit') != 0:
            raise ValueError('unsuccessful compilation receipt')
        if not any(x.startswith('-includes=') for x in r.get('command',[])):
            raise ValueError('reachable-only main build is not a full rebuild')
        inputs = r.get('source_sha256',{})
        output = r.get('normalized_output')
        if not r.get('save_store','').startswith('yzlr2_rebuild_'):
            raise ValueError('main does not declare isolated probe save store')
        if any('com.hotpoint.braveManIII.Tool.XMLAsset.createXML' in x.get('after','') for x in r.get('source_repairs',[])):
            raise ValueError('obsolete main XMLAsset dynamic binding repair')
    elif module == DATAX:
        if not r.get('success') or r.get('exit_code') != 0 or r.get('original_abc_reused') is not False:
            raise ValueError('unsuccessful or obsolete DataX receipt')
        if not r.get('xmlasset_bindings',{}).get('all_six_XMLAsset_bindings_resolved_to_Tool'):
            raise ValueError('DataX lacks corrected XMLAsset binding proof')
        if r.get('root_restoration',{}).get('document_class') != 'src.Data':
            raise ValueError('DataX document initialization not restored')
        inputs = r.get('canonical_source_hashes',{})
        output = r.get('output')
    else:
        if r.get('invalidated') or r.get('original_abc_reused') is not False:
            raise ValueError('resource receipt invalidated or original ABC reused')
        if any(x.get('repair','').startswith('Qualify ') for x in r.get('source_repairs',{}).get('syntax_repairs',[])):
            raise ValueError('obsolete fully-qualified dynamic binding repair')
        if any(x.get('script_tags') != 0 for x in r.get('assets',[])):
            raise ValueError('resource asset contains scripts or lacks script audit')
        prefix = r.get('source_root',f'reverse/experiments/module-probe/{module}/src').rstrip('/')+'/'
        inputs = {k.removeprefix(prefix):v for k,v in r.get('source_files',{}).items()}
        output = r.get('output')
    if not inputs or not output:
        raise ValueError('missing canonical source hash ledger or output path')
    candidate = (ROOT/output).resolve()
    if not candidate.is_relative_to(ROOT/'reverse/build') or not candidate.is_file():
        raise ValueError('missing or out-of-build candidate')
    if sha(candidate) != r.get('output_sha256'):
        raise ValueError('candidate hash differs from receipt')
    return r,inputs,candidate


def swf_evidence(path):
    _,body,header = read_swf(path)
    abc=[]; actions=[]; document=[];save_names=set()
    for tag,payload in walk_tags(body,header['tag_start']):
        code=tag['code']
        if code in (72,82):
            binary=payload if code==72 else payload[payload.index(b'\0',4)+1:]
            abc.append(hashlib.sha256(binary).hexdigest())
            reader=Reader(binary)
            if (reader.u16(),reader.u16())!=(16,46):raise ValueError('Unsupported ABC version')
            for _ in range(2):
                for _ in range(1,reader.var()):reader.var()
            reader.take(max(0,reader.var()-1)*8)
            for _ in range(1,reader.var()):
                value=reader.take(reader.var())
                if value.startswith(b'yzlr2_'):save_names.add(value.decode('utf-8'))
        if code in (12,59): actions.append(code)
        if code==76 and tag['parent']=='root':
            reader=Reader(payload)
            for _ in range(reader.u16()):
                identity=reader.u16();name=reader.cstr()
                if identity==0:document.append(name)
    return {'abc':abc,'as2_actions':actions,'document':document,'header':header,'probe_save_names':sorted(save_names)}


def verify_assets(module,receipt):
    asset_root=ROOT/'reverse/exports'/module/'scripts'
    recorded={x.get('path',x.get('file')):x.get('sha256') for x in receipt.get('assets',[])}
    current={p.relative_to(asset_root).as_posix():sha(p) for p in (asset_root/'_assets').rglob('*') if p.is_file()}
    if any(recorded.get(name)!=digest for name,digest in current.items()):
        raise ValueError('exported asset hashes changed')
    extras=set(recorded)-set(current);generated=[]
    if extras:
        if module==DATAX or extras!={'_assets/recovered-buttons.swf'}:
            raise ValueError('unknown generated asset provenance')
        path=ROOT/'reverse/build/module-probe'/module/'compile-source/_assets/recovered-buttons.swf'
        if not path.is_file() or sha(path)!=recorded['_assets/recovered-buttons.swf']:
            raise ValueError('generated button asset missing or changed')
        evidence=swf_evidence(path)
        if evidence['abc'] or evidence['as2_actions']:
            raise ValueError('generated button asset contains scripts')
        _,body,header=read_swf(ROOT/(module+'.swf'))
        definitions={int.from_bytes(payload[:2],'little'):hashlib.sha256(payload).hexdigest()
            for tag,payload in walk_tags(body,header['tag_start']) if tag['code'] in (7,34)}
        repairs=[r for r in receipt.get('source_repairs',{}).get('button_embed_repairs',[])
            if r.get('asset_file')=='recovered-buttons.swf']
        if not repairs:raise ValueError('generated button asset lacks recovery provenance')
        for repair in repairs:
            if definitions.get(repair.get('character_id'))!=repair.get('original_definition_sha256'):
                raise ValueError('recovered button source definition digest differs')
        generated.append({'path':str(path.relative_to(ROOT)),'sha256':sha(path),
            'original_button_definitions_verified':len(repairs),'script_tags':0})
    return generated


def inspect_module(baseline, deep=False):
    module=Path(baseline['path']).stem
    row={'module':module,'compiled':False,'assembly_ready':False,'issues':[]}
    original=ROOT/baseline['path']
    if not original.is_file() or sha(original)!=baseline['sha256']:
        row['issues']=['original baseline missing or changed'];return row
    current=source_hashes(module)
    if not current:
        row['issues']=['canonical source absent'];return row
    rejected=[]
    for path in receipt_candidates(module):
        try:
            receipt,inputs,candidate=decode_receipt(module,path)
            if inputs != current: raise ValueError('canonical source hashes changed')
            if module != MAIN:
                generated=verify_assets(module,receipt)
                if generated:row['generated_assets']=generated
            if module not in (MAIN,DATAX) and receipt.get('original_sha256')!=baseline['sha256']:
                raise ValueError('receipt was built from another original')
            row.update(compiled=True,receipt=str(path.relative_to(ROOT)),receipt_sha256=sha(path),
                output=str(candidate.relative_to(ROOT)),output_sha256=receipt['output_sha256'],
                source_files=len(current),canonical_tree_sha256=hashlib.sha256(json.dumps(current,sort_keys=True).encode()).hexdigest())
            fingerprint=receipt.get('input_fingerprint')
            row['issues'].extend(verify_inputs(fingerprint))
            if fingerprint and fingerprint.get('module')!=module:
                row['issues'].append('build input fingerprint module differs')
            if not fingerprint or fingerprint.get('post_build_verified') is not True:
                row['issues'].append('build inputs were not verified before and after actual compilation')
            else:
                row['input_generation']=fingerprint['generation']
                row['input_digest']=fingerprint['digest']
            if module not in (MAIN,DATAX):
                timeline=receipt.get('root_timeline',{})
                if timeline.get('verified') is not True or timeline.get('schema')!=1 or timeline.get('original_abc_reused') is not False:
                    row['issues'].append('root timeline restoration not verified')
            if deep:
                old=swf_evidence(original);new=swf_evidence(candidate)
                if set(old['abc']).intersection(new['abc']):row['issues'].append('original ABC bytecode reused verbatim')
                if not new['abc']:row['issues'].append('rebuilt AS3 bytecode absent')
                if module==MAIN and new['probe_save_names']!=[receipt['save_store']]:
                    row['issues'].append('compiled main save names do not match isolated store')
                if new['as2_actions']:row['issues'].append('unexpected AS2 actions in rebuilt SWF')
                if old['document']!=new['document']:
                    row['issues'].append('document class differs from original')
                for field in ('rect_twips','frame_rate','frame_count'):
                    if old['header'][field]!=new['header'][field]:row['issues'].append('SWF header mismatch: '+field)
                assets=ROOT/'reverse/exports'/module/'scripts/_assets'
                for asset in assets.rglob('*.swf'):
                    info=swf_evidence(asset)
                    if info['abc'] or info['as2_actions']:row['issues'].append('exported asset contains scripts: '+asset.name)
                row['bytecode_audited']=True
                row['new_abc_blocks']=len(new['abc'])
            row['assembly_ready']=not row['issues']
            return row
        except (ValueError,KeyError,OSError,AssertionError,json.JSONDecodeError) as error:
            rejected.append(str(error))
    row['issues']=list(dict.fromkeys(rejected))[:4] or ['successful rebuild receipt absent']
    return row


def collect(deep=False):
    entries=[r for r in read_json(BASELINE) if r['path'].endswith('.swf')]
    if len(entries)!=164 or len({r['path'] for r in entries})!=164:
        raise ValueError('Expected exactly 164 unique baseline SWFs')
    rows=[inspect_module(row,deep) for row in entries]
    result={'schema':'yzlr2-project-status-v1','createdUTC':datetime.now(timezone.utc).isoformat(),
        'deep_audit':deep,'total':164,'compiled_current':sum(r['compiled'] for r in rows),
        'assembly_ready':sum(r['assembly_ready'] for r in rows),
        'all_rebuilt_ready':all(r['assembly_ready'] for r in rows),
        'issue_counts':dict(Counter(issue for row in rows for issue in row['issues'])),
        'runtime_validation':'separate; this command does not run the game','modules':rows}
    STATE.mkdir(parents=True,exist_ok=True)
    (STATE/('audit.json' if deep else 'status.json')).write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
    return result,entries


def summary(report):
    return {k:v for k,v in report.items() if k!='modules'}


def build(target, dry_run=False, jobs=1):
    commands=[]
    if target in ('all','main'):
        commands.append([sys.executable,str(TOOLS/'build_main.py'),'--all-definitions'])
    if target in ('all','datax'):
        commands.append([sys.executable,str(TOOLS/'datax_build.py')])
    if target in ('all','resources'):
        commands.append([sys.executable,str(TOOLS/'probe_resource_family.py'),'--jobs',str(jobs)])
    if target not in ('all','main','datax','resources'):
        modules={Path(r['path']).stem for r in read_json(BASELINE) if r['path'].endswith('.swf')}
        if target not in modules or target in (MAIN,DATAX):raise ValueError('Use main/datax aliases or an exact resource stem')
        commands.append([sys.executable,str(TOOLS/'probe_rebuild_module.py'),target,'--dynamic'])
    if dry_run:
        print(json.dumps({'commands':commands,'executed':False},ensure_ascii=False,indent=2));return
    STATE.mkdir(parents=True,exist_ok=True)
    run=Path(tempfile.mkdtemp(prefix='build-',dir=STATE));stages=[]
    for index,command in enumerate(commands):
        log=run/f'stage-{index}.log'
        with log.open('w') as stream:
            process=subprocess.run(command,cwd=ROOT,stdout=stream,stderr=subprocess.STDOUT)
        stages.append({'pipeline':Path(command[1]).name,'exit':process.returncode,'log':str(log.relative_to(ROOT))})
        (run/'stages.json').write_text(json.dumps(stages,indent=2)+'\n')
        print(json.dumps(stages[-1]),flush=True)
        if process.returncode:raise RuntimeError('Build stage failed; later stages were not run')
    report,_=collect(False)
    print(json.dumps(summary(report),ensure_ascii=False,indent=2))


def assemble(partial=False):
    report,baseline=collect(True)
    modules={row['module']:row for row in report['modules']}
    if not modules[MAIN]['assembly_ready']:
        raise ValueError('A valid rebuilt main with isolated save store is mandatory, including partial assemblies')
    if not partial and not report['all_rebuilt_ready']:
        missing=[r['module'] for r in report['modules'] if not r['assembly_ready']]
        raise ValueError(f'Strict assembly refused: {len(missing)} modules not ready; see reverse/build/project/audit.json. Use --partial explicitly for labelled original fallbacks.')
    label='runtime-partial-' if partial else 'runtime-all-rebuilt-'
    destination=ROOT/'reverse/build'/(label+datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S.%fZ'))
    destination.mkdir(exist_ok=False)
    manifest={'schema':'yzlr2-assembly-v1','state':'building','partial_allowed':partial,
        'createdUTC':datetime.now(timezone.utc).isoformat(),'modules':[],
        'save_files_written':False,'player_launched':False,'runtime_validated':False}
    manifest_path=destination/'assembly.json'
    manifest_path.write_text(json.dumps(manifest,indent=2)+'\n')
    try:
        for baseline_row in baseline:
            module=Path(baseline_row['path']).stem;row=modules[module]
            rebuilt=row['assembly_ready']
            source=ROOT/(row['output'] if rebuilt else baseline_row['path'])
            expected=row['output_sha256'] if rebuilt else baseline_row['sha256']
            if sha(source)!=expected:raise ValueError('Candidate changed during assembly: '+module)
            if rebuilt:
                now=hashlib.sha256(json.dumps(source_hashes(module),sort_keys=True).encode()).hexdigest()
                if now!=row['canonical_tree_sha256']:raise ValueError('Canonical source changed during assembly: '+module)
                receipt_path=ROOT/row['receipt']
                if sha(receipt_path)!=row['receipt_sha256']:raise ValueError('Receipt changed during assembly: '+module)
                issues=verify_inputs(read_json(receipt_path).get('input_fingerprint'))
                if issues:raise ValueError('Build inputs changed during assembly: '+module+': '+ '; '.join(issues))
                provenance=destination/'.provenance';provenance.mkdir(exist_ok=True)
                receipt_copy=provenance/(row['receipt_sha256']+'.json')
                shutil.copy2(receipt_path,receipt_copy)
                if sha(receipt_copy)!=row['receipt_sha256']:raise ValueError('Receipt snapshot hash mismatch: '+module)
            output=destination/baseline_row['path'];shutil.copy2(source,output)
            if sha(output)!=expected:raise ValueError('Copied file verification failed: '+module)
            manifest['modules'].append({'module':module,'path':baseline_row['path'],'sha256':expected,
                'provenance':'source_rebuilt' if rebuilt else 'original_fallback',
                'input':str(source.relative_to(ROOT)),
                'receipt':row.get('receipt') if rebuilt else None,
                'receipt_sha256':row.get('receipt_sha256') if rebuilt else None,
                'receipt_snapshot':str(receipt_copy.relative_to(destination)) if rebuilt else None,
                'input_generation':row.get('input_generation') if rebuilt else None,
                'input_digest':row.get('input_digest') if rebuilt else None,
                'fallback_reasons':[] if rebuilt else row['issues']})
        manifest.update(state='complete',rebuilt=sum(m['provenance']=='source_rebuilt' for m in manifest['modules']),
            original_fallback=sum(m['provenance']=='original_fallback' for m in manifest['modules']))
        if not partial and manifest['rebuilt']!=164:raise ValueError('Strict assembly invariant failed')
        manifest_path.write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
    except Exception as error:
        manifest.update(state='failed',error=str(error));manifest_path.write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n');raise
    print(json.dumps({'output':str(destination),'rebuilt':manifest['rebuilt'],'original_fallback':manifest['original_fallback'],
        'manifest':str(manifest_path),'player_launched':False},ensure_ascii=False,indent=2))


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    sub=parser.add_subparsers(dest='action',required=True)
    for action in ('status','audit'):
        command=sub.add_parser(action);command.add_argument('--details',action='store_true')
    command=sub.add_parser('build');command.add_argument('target',nargs='?',default='all');command.add_argument('--dry-run',action='store_true');command.add_argument('--jobs',type=int,choices=range(1,4),default=1,help='Parallel resource modules only; main/datax remain sequential')
    command=sub.add_parser('assemble');command.add_argument('--partial',action='store_true')
    args=parser.parse_args()
    try:
        if args.action in ('status','audit'):
            report,_=collect(args.action=='audit')
            print(json.dumps(report if args.details else summary(report),ensure_ascii=False,indent=2))
        elif args.action=='build':build(args.target,args.dry_run,args.jobs)
        else:assemble(args.partial)
    except (ValueError,RuntimeError,OSError,AssertionError) as error:
        print('ERROR: '+str(error),file=sys.stderr);raise SystemExit(1)


if __name__=='__main__':main()
