#!/usr/bin/env python3
"""Launch-only batched verification; build_inputs.py remains unchanged.

Deduplicate scans, not checks. Every snapshot digest and every per-module
path membership/hash/size/executable/role is still checked. Runtime launch
does not compile, so build-environment differences are reported by name only.
"""
import os,platform,sys,time
from build_inputs import SCHEMA,_scan,_expand,_digest


def environment_differences(snapshot):
    expected=snapshot.get('environment',{})
    names=[k for k,v in expected.get('environment',{}).items() if os.environ.get(k)!=v]
    if expected.get('python_version')!=sys.version:names.append('python_version')
    if expected.get('python_implementation')!=platform.python_implementation():names.append('python_implementation')
    return sorted(names)


def verify_batch(snapshots,progress=lambda message:None):
    started=time.monotonic();expanded=[];toolchains={};specs={};differences=set()
    required={'canonical_source','original_swf','build_recipe','toolchain','python_executable'}
    for snapshot in snapshots:
        if not isinstance(snapshot,dict) or snapshot.get('schema')!=SCHEMA:
            raise ValueError('missing or unsupported build input fingerprint')
        if snapshot.get('post_build_verified') is not True:
            raise ValueError('missing actual post-build verification')
        if not required.issubset({s.get('role') for s in snapshot.get('specs',[])}):
            raise ValueError('build input fingerprint lacks required categories')
        ref=snapshot['toolchain_manifest'];key=(ref['path'],ref['sha256'],ref['file_count'])
        if key not in toolchains:
            # _expand verifies content-addressed manifest SHA/schema/count.
            toolchains[key]=_expand({'files':{},'toolchain_manifest':ref})
        tools=toolchains[key]
        if set(tools)&set(snapshot['files']):raise ValueError('Duplicate toolchain/module input paths')
        old=dict(sorted({**tools,**snapshot['files']}.items()))
        if _digest(old,snapshot['environment'])!=snapshot['digest']:
            raise ValueError('build input fingerprint internally inconsistent: '+snapshot.get('module','?'))
        expanded.append(old);differences.update(environment_differences(snapshot))
        for spec in snapshot['specs']:
            specs[(spec['kind'],spec['path'],spec['role'])]=spec
    progress('来源凭据内部摘要已核验；批量扫描输入，共享工具链只扫描一次…')
    # Uses the same tree walker, SHA/stat cache, executable-bit tracking and
    # missing-tree/file handling as build_inputs.verify. No source is edited.
    current=_scan(list(specs.values()))
    # Build per-spec membership once, including newly added files. A module
    # must see precisely its own specs; a broad union alone would miss removals.
    membership={}
    for kind,path,role in specs:
        key=(kind,path)
        if key in membership:continue
        if kind=='file':membership[key]=[path] if path in current else []
        elif kind=='tree':membership[key]=[p for p in current if p.startswith(path.rstrip('/')+'/')]
        else:raise ValueError('Unknown input spec kind')
    issues={}
    for snapshot,old in zip(snapshots,expanded):
        files={}
        for spec in snapshot['specs']:
            for path in membership[(spec['kind'],spec['path'])]:
                item=files.setdefault(path,{k:v for k,v in current[path].items() if k!='roles'})
                roles=item.setdefault('roles',[])
                if spec['role'] not in roles:roles.append(spec['role']);roles.sort()
        added=sorted(set(files)-set(old));missing=sorted(set(old)-set(files))
        changed=sorted(p for p in set(old)&set(files) if files[p]!=old[p])
        messages=[]
        if added:messages.append('build inputs added: '+', '.join(added[:8]))
        if missing:messages.append('build inputs removed: '+', '.join(missing[:8]))
        if changed:messages.append('build inputs changed: '+', '.join(changed[:8]))
        if messages:issues[snapshot['module']]=messages
    progress(f'批量输入校验完成：{len(snapshots)} 个模块，{len(current)} 个不同文件。')
    return issues,{'build_environment_differences':sorted(differences),'batch_modules':len(snapshots),
        'unique_input_files':len(current),'unique_toolchain_manifests':len(toolchains),
        'input_verification_seconds':round(time.monotonic()-started,3)}
