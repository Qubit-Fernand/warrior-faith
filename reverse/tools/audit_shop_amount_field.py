#!/usr/bin/env python3
"""Read original authored quantity-field flags; never executes the SWF."""
from pathlib import Path
import json,struct
from swf_inventory import read_swf,walk_tags,sha
from probe_root_timeline import Bits
ROOT=Path(__file__).resolve().parents[2]
def placement(p):
 flags=p[0];pos=3;cid=None
 if flags&2:cid=struct.unpack_from('<H',p,pos)[0];pos+=2
 if flags&4:b=Bits(p,pos);b.matrix();pos=b.aligned()
 if flags&8:
  b=Bits(p,pos);add=b.take(1);mult=b.take(1);n=b.take(4);b.take(n*4*(add+mult));pos=b.aligned()
 if flags&16:pos+=2
 name=None
 if flags&32:end=p.index(0,pos);name=p[pos:end].decode('utf-8');pos=end+1
 return {'character_id':cid,'depth':struct.unpack_from('<H',p,1)[0],'name':name,'flags':flags}
def main():
 p=ROOT/'3_L4399Main_gamefile.swf';raw,body,h=read_swf(p);defs={};children={}
 for tag,x in walk_tags(body,h['tag_start']):
  if 'character_id'in tag:defs[tag['character_id']]=(tag,x)
  if tag['code']==26:children.setdefault(tag['parent'],[]).append(placement(x))
 parent=1813;menu=next(x for x in children[f'root/sprite:{parent}']if x['name']=='buyMenu');amount=next(x for x in children[f'root/sprite:{menu["character_id"]}']if x['name']=='amount');tag,x=defs[amount['character_id']];assert tag['code']==37
 b=Bits(x,2);n=b.take(5);b.take(n*4);pos=b.aligned();f1,f2=x[pos:pos+2];pos+=2
 if f1&1:pos+=2
 if f2&128:pos=x.index(0,pos)+1
 if f1&1:pos+=2
 if f1&4:pos+=4
 maxlen=struct.unpack_from('<H',x,pos)[0]if f1&2 else None
 report={'schema':1,'original_swf_sha256':sha(raw),'source_class':'SuppliesShopShow','class_embed_symbol':1813,'buyMenu_placement':menu,'amount_placement':amount,'edit_text_tag':tag,'edit_text_payload_hex':x.hex(),'read_only':bool(f1&8),'has_max_length':bool(f1&2),'max_length':maxlen,'password':bool(f1&16),'multiline':bool(f1&32),'input_field':not bool(f1&8),'scope':'Original authored static field flags only; later AS text/type/maxChars modifications require separate source review.','no_runtime':True}
 (ROOT/'reverse/manifests/shop-amount-field.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print(json.dumps(report,ensure_ascii=False,indent=2))
if __name__=='__main__':main()
