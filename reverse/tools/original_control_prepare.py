#!/usr/bin/env python3
"""Make a gameplay-identical original control except its SharedObject name.

Rewrites one ABC string entry and enclosing lengths. No bytecode is recompiled.
Never launches Flash or reads/writes live SharedObjects.
"""
from pathlib import Path
import argparse
import hashlib
import json
import re
import shutil
import struct
import zlib
from swf_inventory import Reader, abc_inventory, read_swf, walk_tags

ROOT=Path(__file__).resolve().parents[2]
MAIN='3_L4399Main_gamefile.swf'
OLD_NAME='yzlr2_saves'


def sha(data):return hashlib.sha256(data).hexdigest()


def u30(value):
    assert 0<=value<0x40000000
    result=bytearray()
    while value>=0x80:result.append((value&0x7f)|0x80);value>>=7
    result.append(value)
    return bytes(result)


def rewrite_abc(data, old, new):
    r=Reader(data)
    assert (r.u16(),r.u16())==(16,46)
    for _ in range(2):
        for _ in range(1,r.var()):r.var()
    r.take(max(0,r.var()-1)*8)
    changes=[]
    for index in range(1,r.var()):
        start=r.p;length=r.var();content_start=r.p;value=r.take(length)
        if value==old.encode():changes.append((index,start,r.p,content_start))
    if not changes:return data,None
    assert len(changes)==1,'SharedObject string is not unique within ABC'
    index,start,end,content_start=changes[0]
    changed=data[:start]+u30(len(new.encode()))+new.encode()+data[end:]
    # The exact prefix and suffix proof excludes instruction or table edits.
    replacement_end=start+len(u30(len(new.encode())))+len(new.encode())
    assert changed[:start]==data[:start] and changed[replacement_end:]==data[end:]
    before=abc_inventory(data);after=abc_inventory(changed)
    assert before['classes']==after['classes'] and before['scripts']==after['scripts'] and before['methods']==after['methods']
    assert len(before['strings'])==len(after['strings'])
    assert [i for i,(a,b) in enumerate(zip(before['strings'],after['strings'])) if a!=b]==[index]
    delta=len(changed)-len(data)
    assert len(before['method_bodies'])==len(after['method_bodies'])
    for oldbody,newbody in zip(before['method_bodies'],after['method_bodies']):
        expected=dict(oldbody);expected['offset']+=delta
        assert expected==newbody,'Method body metadata/content changed'
    return changed,{'string_index':index,'abc_string_length_offset':start,'abc_string_bytes_offset':content_start,
        'old_string':old,'new_string':new,'byte_delta':delta,'abc_before_sha256':sha(data),'abc_after_sha256':sha(changed),
        'method_body_count':len(before['method_bodies']),'all_method_body_hashes_unchanged':True,
        'classes_scripts_method_signatures_unchanged':True,'all_bytes_outside_one_string_entry_unchanged':True}


def rewrite_main(path,name):
    raw,body,header=read_swf(path)
    edits=[];proofs=[]
    for tag,payload in walk_tags(body,header['tag_start']):
        if tag['code']!=82:continue
        offset=payload.index(b'\0',4)+1
        changed,proof=rewrite_abc(payload[offset:],OLD_NAME,name)
        if proof is None:continue
        assert tag['parent']=='root','Nested ABC requires enclosing Sprite length repair'
        newpayload=payload[:offset]+changed
        start=tag['body_offset'];end=tag['payload_offset']+tag['length']
        old_header=struct.unpack_from('<H',body,start)[0]
        if old_header&63==63 or len(newpayload)>=63:
            replacement=struct.pack('<HI',(82<<6)|63,len(newpayload))+newpayload
        else:replacement=struct.pack('<H',(82<<6)|len(newpayload))+newpayload
        edits.append((start,end,replacement));proofs.append(proof)
    assert len(edits)==1,'Expected exactly one SharedObject name in one ABC'
    changed=bytearray(body)
    for start,end,replacement in reversed(edits):changed[start:end]=replacement
    encoded=raw[:4]+struct.pack('<I',len(changed)+8)+(zlib.compress(changed) if raw[:3]==b'CWS' else changed)
    # All other tags, including resources, remain byte-exact payloads.
    after_tags=list(walk_tags(bytes(changed),header['tag_start']))
    before_tags=list(walk_tags(body,header['tag_start']))
    assert len(before_tags)==len(after_tags)
    differing=[i for i,((t,p),(u,q)) in enumerate(zip(before_tags,after_tags)) if t['code']!=u['code'] or p!=q]
    assert len(differing)==1 and before_tags[differing[0]][0]['code']==82
    return bytes(encoded),{'source_header':header,'abc_edit':proofs[0],
        'tag_count':len(before_tags),'differing_tag_count':1,'all_other_tag_payloads_unchanged':True,
        'source_sha256':sha(raw),'output_sha256':sha(encoded)}


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--name',default='yzlr2_original_probe')
    parser.add_argument('--output',type=Path,default=ROOT/'reverse/build/runtime-original-control')
    args=parser.parse_args()
    assert re.fullmatch(r'yzlr2_[A-Za-z0-9_]+',args.name)
    assert args.name not in ('yzlr2_saves','yzlr2_final','yzlr2_epilogue')
    out=args.output.resolve()
    assert out.is_relative_to(ROOT/'reverse/build'),'Control outputs must remain inside ignored reverse/build'
    manifest=json.loads((ROOT/'reverse/manifests/original-files.json').read_text())
    # Rechecking every original prevents stale inventory from blessing changed input.
    for row in manifest:
        path=ROOT/row['path'];assert path.is_file() and sha(path.read_bytes())==row['sha256'],f'Baseline changed: {path}'
    payload,proof=rewrite_main(ROOT/MAIN,args.name)
    out.mkdir(parents=True,exist_ok=True)
    receipts=[]
    for row in manifest:
        path=ROOT/row['path'];destination=out/row['path']
        expected=proof['output_sha256'] if row['path']==MAIN else row['sha256']
        if destination.exists():
            assert destination.is_file() and sha(destination.read_bytes())==expected,f'Refuse to overwrite changed control file: {destination}'
        elif row['path']==MAIN:destination.write_bytes(payload)
        else:shutil.copy2(path,destination)
        actual=sha(destination.read_bytes());assert actual==expected
        receipts.append({'path':row['path'],'original_sha256':row['sha256'],'control_sha256':actual,'unchanged':actual==row['sha256']})
    receipt={'purpose':'original control with isolated SharedObject name; NOT source reconstruction',
        'shared_object_name':args.name,'output':str(out.relative_to(ROOT)),'patch':proof,'files':receipts,
        'swf_count':sum(r['path'].endswith('.swf') for r in receipts),'unchanged_files':sum(r['unchanged'] for r in receipts),
        'game_executed':False,'live_save_accessed':False,'fixture_seeded':False}
    (out/'control-manifest.json').write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:v for k,v in receipt.items() if k not in ('files','patch')},ensure_ascii=False))


if __name__=='__main__':main()
