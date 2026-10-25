#!/usr/bin/env python3
"""Validate Flex library output; fix demonstrated Unicode DoABC length bug.

Optional original sound metadata restoration requires identical MPEG bytes.
This never copies original ABC. ProductInfo timestamp normalized to zero.
"""
import argparse,json,struct,zlib
from pathlib import Path
from swf_inventory import read_swf,walk_tags,Reader,abc_inventory

def encode(raw,body):return raw[:4]+struct.pack('<I',len(body)+8)+(zlib.compress(body) if raw[:3]==b'CWS' else bytes(body))
def symbols_and_sounds(body,start):
 symbols={};sounds={}
 for t,x in walk_tags(body,start):
  if t['code']==76:
   r=Reader(x)
   for _ in range(r.u16()): cid=r.u16();symbols[cid]=r.cstr()
  if t['code']==14:sounds[struct.unpack_from('<H',x)[0]]=(t,x)
 return {symbols[cid]:v for cid,v in sounds.items() if cid in symbols}

def normalize(source,output,original=None):
 raw,body,header=read_swf(source);b=bytearray(body);pos=header['tag_start'];fixes=[]
 while pos<len(b):
  off=pos;head=struct.unpack_from('<H',b,pos)[0];pos+=2;code=head>>6;size=head&63;long=size==63
  if long:size=struct.unpack_from('<I',b,pos)[0];pos+=4
  if code==82:
   end=b.index(0,pos+4);name=bytes(b[pos+4:end]).decode('utf-8')
   # First try declared tag. Only repair when ABC parser proves it is truncated.
   payload_start=end+1
   try: abc_inventory(bytes(b[payload_start:pos+size]))
   except (ValueError,IndexError,struct.error):
    delta=len(name.encode('utf-8'))-len(name.encode('utf-16-le'))//2
    if not delta or not long:raise
    abc_inventory(bytes(b[payload_start:pos+size+delta]))
    fixes.append({'name':name,'declared_size':size,'missing_utf8_bytes':delta});size+=delta;struct.pack_into('<I',b,off+2,size)
  if code==41:
   assert size==26
   b[pos+18:pos+26]=bytes(8)
  pos+=size
  if code==0:break
 assert pos==len(b),f'unparsed trailing bytes {len(b)-pos}'
 # Strict recursive parse after header correction.
 list(walk_tags(bytes(b),header['tag_start']))
 restored=[]
 if original:
  _,ob,oh=read_swf(original);original_sounds=symbols_and_sounds(ob,oh['tag_start'])
  new_sounds=symbols_and_sounds(bytes(b),header['tag_start'])
  for name,(t,payload) in new_sounds.items():
   if name not in original_sounds:continue
   old=original_sounds[name][1]
   assert payload[2]>>4==2 and old[2]>>4==2,'metadata repair supports MP3 only'
   assert payload[9:]==old[9:],f'MPEG payload changed: {name}'
   start=t['payload_offset'];b[start+2:start+9]=old[2:9]
   restored.append({'class':name,'old_compiled_header':payload[2:9].hex(),'restored_original_header':old[2:9].hex()})
 classes=[]
 for t,x in walk_tags(bytes(b),header['tag_start']):
  if t['code'] in (72,82):
   r=Reader(x)
   if t['code']==82:r.take(4);r.cstr()
   classes.extend(c['name'] for c in abc_inventory(r.take(len(x)-r.p))['classes'])
 output.write_bytes(encode(raw,b))
 return {'unicode_doabc_repairs':fixes,'sound_metadata_restored':restored,'validated_classes':classes,'timestamp_normalized':True}
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('source',type=Path);p.add_argument('output',type=Path);p.add_argument('--original',type=Path);a=p.parse_args();print(json.dumps(normalize(a.source,a.output,a.original),ensure_ascii=False,indent=2))
