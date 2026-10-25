#!/usr/bin/env python3
"""Reversible compile-time name legalization and no-op syntax repair.

Original readable sources stay untouched; restored SWF retains original runtime
names, including identifiers illegal in AS source but legal in AVM2 QNames.
"""
import hashlib,json,re,struct,zlib
from pathlib import Path
from swf_inventory import read_swf,walk_tags,Reader,abc_inventory
from probe_normalize_swf import encode
TOKEN=re.compile(r'("(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\')|§([^§\r\n]+)§')

def prepare(source,destination):
 mapping={};changes=[]
 def token(match):
  if match.group(1):return match.group(1)
  old=match.group(2);safe='REA_Name_'+hashlib.sha256(old.encode()).hexdigest()[:20];mapping[safe]=old;return safe
 for p in source.rglob('*.as'):
  raw=p.read_text();text=TOKEN.sub(token,raw)
  relative_path=p.relative_to(source).as_posix()
  legacy_class=relative_path=='com/adobe/serialization/json/JSON.as'
  legacy_consumer=('import com.adobe.serialization.json.' in text and re.search(r'\bJSON\s*\.',text))
  if legacy_class or legacy_consumer:
   safe='REA_LegacyJSON_7f46b2';mapping[safe]='JSON'
   # Rename identifiers only, preserving quoted string literals.
   text=re.sub(r'("(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\')|\bJSON\b',lambda m:m.group(1) or safe,text)
   if legacy_consumer:
    text=text.replace('import com.adobe.serialization.json.*;', 'import com.adobe.serialization.json.'+safe+';')
   changes.append({'file':relative_path,'repair':'Temporary unique legacy JSON identifier avoids global playerglobal JSON; restore original JSON QName in newly compiled ABC.'})
  if 'import com.hotpoint.braveManIII.Tool.*;' in text and 'import src.tool.*;' in text and 'XMLAsset.createXML(' in text:
   one=source/'src/tool/XMLAsset.as';two=source/'com/hotpoint/braveManIII/Tool/XMLAsset.as'
   assert one.exists() and two.exists()
   assert one.read_text().split('{',1)[1]==two.read_text().split('{',1)[1], 'XMLAsset implementations differ; cannot auto-resolve'
   text=text.replace('import com.hotpoint.braveManIII.Tool.*;', 'import com.hotpoint.braveManIII.Tool.XMLAsset;')
   exact='\n   '.join('import src.tool.'+f.stem+';' for f in sorted((source/'src/tool').glob('*.as')) if f.stem!='XMLAsset')
   text=text.replace('import src.tool.*;',exact)
   changes.append({'file':str(p.relative_to(source)),'repair':'Explicit XMLAsset import and expand src.tool wildcard excluding duplicate XMLAsset; helper implementations verified identical.'})
  text,n=re.subn(r'(?m)^([ \t]*)\{\};[ \t]*$',r'\1;',text)
  if n:changes.append({'file':str(p.relative_to(source)),'repair':'standalone empty block plus semicolon to empty statement','occurrences':n})
  relative=str(p.relative_to(source))
  if legacy_class:relative=relative.replace('/JSON.as','/REA_LegacyJSON_7f46b2.as')
  for safe,old in mapping.items():relative=relative.replace('§'+old+'§',safe)
  target=destination/relative;target.parent.mkdir(parents=True,exist_ok=True);target.write_text(text)
 return {'safe_to_original_identifiers':mapping,'syntax_repairs':changes}

def varuint(n):
 out=bytearray()
 while n>=128:out.append((n&127)|128);n>>=7
 out.append(n);return bytes(out)

def rewrite_abc(data,mapping):
 r=Reader(data);r.take(4)
 for _ in range(2):
  for i in range(1,r.var()):r.var()
 r.take(max(0,r.var()-1)*8);count=r.var();start=r.p;out=bytearray(data[:start]);changed=0
 for _ in range(1,count):
  s=r.take(r.var()).decode('utf-8');new=s
  for safe,old in mapping.items():new=new.replace(safe,old)
  if s!=new:changed+=1
  b=new.encode();out+=varuint(len(b))+b
 out+=data[r.p:];abc_inventory(bytes(out));return bytes(out),changed

def packtag(code,payload):
 if len(payload)<63:return struct.pack('<H',(code<<6)|len(payload))+payload
 return struct.pack('<HI',(code<<6)|63,len(payload))+payload

def restore(source,output,mapping):
 raw,b,h=read_swf(source);out=bytearray(b[:h['tag_start']]);changed_strings=0;changed_bindings=[]
 for t,x in walk_tags(b,h['tag_start']):
  if t['parent']!='root':continue
  code=t['code']
  if code==82:
   r=Reader(x);flags=r.take(4);name=r.cstr()
   for safe,old in mapping.items():name=name.replace(safe,old)
   abc,n=rewrite_abc(r.take(len(x)-r.p),mapping);changed_strings+=n;x=flags+name.encode()+b'\0'+abc
  elif code in (76,56):
   r=Reader(x);count=r.u16();buf=bytearray(struct.pack('<H',count))
   for _ in range(count):
    cid=r.u16();name=r.cstr();new=name
    for safe,old in mapping.items():new=new.replace(safe,old)
    if new!=name:changed_bindings.append({'tag':code,'from':name,'to':new})
    buf+=struct.pack('<H',cid)+new.encode()+b'\0'
   x=bytes(buf)
  out+=packtag(code,x)
 output.write_bytes(encode(raw,out))
 list(walk_tags(bytes(out),h['tag_start']))
 return {'abc_strings_restored':changed_strings,'linkage_names_restored':changed_bindings}
