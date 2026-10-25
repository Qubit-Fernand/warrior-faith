#!/usr/bin/env python3
"""Read original NPC panel placements without executing any SWF."""
from pathlib import Path
import json,struct,hashlib
from swf_inventory import read_swf,walk_tags
from audit_shop_amount_field import placement
from probe_root_timeline import Bits
ROOT=Path(__file__).resolve().parents[2]
def signed(v,n):return v-(1<<n) if n and v&(1<<(n-1)) else v
def main():
 p=ROOT/'3_L4399Main_gamefile.swf';raw,b,h=read_swf(p);rows=[]
 for t,x in walk_tags(b,h['tag_start']):
  if t['code']!=26 or t['parent']not in ('root/sprite:1772','root/sprite:1776'):continue
  d=placement(x)
  if d['name']not in ('buy_btn','temp_btn','temp2_btn'):continue
  pos=3+(2 if x[0]&2 else 0);assert x[0]&4;q=Bits(x,pos)
  if q.take(1):q.take(q.take(5)*2)
  if q.take(1):q.take(q.take(5)*2)
  n=q.take(5);d['translation_pixels']=[signed(q.take(n),n)/20,signed(q.take(n),n)/20]
  rows.append({'parent':t['parent'],'tag':t,'placement':d,'payload_hex':x.hex()})
 report={'schema':1,'original_swf_sha256':hashlib.sha256(raw).hexdigest(),'panels':{'1776':'src.npc.药水商人界面','1772':'src.npc.药水商人界面2'},'placements':rows,'interpretation':'Both classes bind buy_btn CLICK to SuppliesShopPanel.open. Panel2 authors buy_btn at y=1010.35, outside the 560-pixel stage at default Open(0,0); panel1 at y=529.35. Gift/reward handlers do not open the shop. Background appearance is insufficient to identify map or panel.','runtime':'Root reported cold-start fresh slot2 opened the normal smiling NPC with visible buy button and entered original shop; this tool does not run UI.','no_player_or_save_access':True}
 out=ROOT/'reverse/manifests/potion-npc-buttons.json';out.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print(out)
if __name__=='__main__':main()
