#!/usr/bin/env python3
"""Create an explicitly named SOL fixture without changing its AMF payload.

Not run during control preparation. Default destination is ignored build output.
Use --directory explicitly if installing a fixture later; existing files fail.
"""
from pathlib import Path
import argparse
import hashlib
import json
import re
import struct

ROOT=Path(__file__).resolve().parents[2]


def renamed_sol(raw,name):
    assert raw[:2]==b'\0\xbf' and struct.unpack_from('>I',raw,2)[0]==len(raw)-6
    assert raw[6:16]==b'TCSO\0\x04\0\0\0\0'
    length=struct.unpack_from('>H',raw,16)[0];end=18+length
    assert raw[end:end+4]==b'\0\0\0\3','Only AMF3 SOL fixtures supported'
    old_name=raw[18:end].decode('utf-8')
    encoded=name.encode('utf-8');assert len(encoded)<65536
    body=raw[6:16]+struct.pack('>H',len(encoded))+encoded+raw[end:]
    result=raw[:2]+struct.pack('>I',len(body))+body
    assert result[18+len(encoded):]==raw[end:],'AMF payload must be byte-exact'
    return result,old_name,hashlib.sha256(raw[end:]).hexdigest()


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source',type=Path,default=ROOT/'presets/毕业体验档.sol')
    parser.add_argument('--name',default='yzlr2_original_probe')
    parser.add_argument('--directory',type=Path,default=ROOT/'reverse/build/runtime-original-control/fixtures')
    args=parser.parse_args()
    assert re.fullmatch(r'yzlr2_[A-Za-z0-9_]+',args.name)
    assert args.name not in ('yzlr2_saves','yzlr2_final','yzlr2_epilogue'),'Protected user save name'
    raw=args.source.read_bytes();patched,old_name,payload_sha=renamed_sol(raw,args.name)
    directory=args.directory.expanduser().resolve();directory.mkdir(parents=True,exist_ok=True)
    destination=directory/(args.name+'.sol')
    with destination.open('xb') as output:output.write(patched)
    print(json.dumps({'output':str(destination),'old_name':old_name,'name':args.name,
        'source_sha256':hashlib.sha256(raw).hexdigest(),'output_sha256':hashlib.sha256(patched).hexdigest(),
        'unchanged_amf_payload_sha256':payload_sha,'amf_payload_byte_exact':True},ensure_ascii=False,indent=2))


if __name__=='__main__':main()
