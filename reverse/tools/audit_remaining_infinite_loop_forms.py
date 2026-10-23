#!/usr/bin/env python3
"""Retain bounded manual CFG observations for the remaining while(true) forms."""
from pathlib import Path
import json,hashlib
from audit_decrement_semantics import method
from audit_shop_cfg import observations
ROOT=Path(__file__).resolve().parents[2]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 specs=[('JSONDecoders','parseArray','Array iteration calls parseValue then nextToken; ] returns, comma advances next token; other token calls parseError (throws). Only block10 return becomes jump to common return block18.',19,19,[10]),('JSONDecoders','parseObject','Each successful member consumes key/colon/value via nextToken/parseValue; } returns, comma advances. Invalid key/colon/separator calls parseError (throws). Only block12 return becomes jump to common return block24.',25,25,[12]),('JSONTokenizers','readString','Quote indexOf is int and >=0 or parseError throws; odd-backslash quote increments search index; even parity exits. Reverse charAt scan decrements until non-backslash, including negative index empty-string sentinel. Empty loop-entry block removed; successful token-construction/unescape/nextChar chain preserved.',12,11,None),('JSONTokenizers','skipComments','Line comments repeatedly nextChar until newline/end. Block comments advance at least once each iteration, */ exits, end-string parseError throws. nextChar moves from matched-delimiter exit block11 to common loop exit17; other exits to17 are excluded by throwing parseError.',28,28,[11,17]),('JSONTokenizers','parseError','Both construct JSONParseError(message,loc,jsonString) then throw; callers cannot return normally from this helper.',1,1,[]),('JSONTokenizers','nextChar','Same charAt/get-position increment path; no branch topology or non-conversion call change.',1,1,[]),('JSONDecoders','nextToken','Same tokenizer.getNextToken call and token assignment; no branch topology or non-conversion call change.',1,1,[])]
 out=[]
 for cls,n,note,oldn,newn,expected in specs:
  vals={};codes={}
  for v,b in [('original','reverse/build/ordered-comparison/original/scripts'),('rebuilt928e','reverse/build/main-repeat-pcode/run-b062kbrm/scripts')]:
   p=ROOT/b/'com/adobe/serialization/json'/(cls+'.pcode');codes[v]=method(p,n);vals[v]={'file':str(p.relative_to(ROOT)),'sha256':sha(p),'observations':observations(codes[v]),'code':codes[v]}
  a=vals['original']['observations']['blocks'];b=vals['rebuilt928e']['observations']['blocks'];assert(len(a),len(b))==(oldn,newn)
  delta=[i for i,(x,y)in enumerate(zip(a,b))if x!=y]
  if expected is not None:assert delta==expected,(n,delta)
  out.append({'class':cls,'method':n,'review':note,'observed_changed_block_indexes':delta,'versions':vals,'whole_parser_equivalence_proven':False,'repair_warranted_by_reviewed_loop':False})
 report={'schema':1,'scope':'Manual CFG/token-progress review of4 remaining JSON while(true) loops plus3 helpers, original versus immutable928e. Coarse block comparison is evidence only; no parser execution or full JSON semantic equivalence claim. Existing EquipSlot.testAllEquip and Achievement.getNumByType loops were separately checked for explicit bounded exits. Two other remaining while(true) forms are confirmed defective and repaired in main-continue-repairs.json.','json_methods':out,'no_source_changes':True,'no_player_or_save_access':True}
 (ROOT/'reverse/manifests/remaining-while-loop-review.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print('4 JSON loops + 3 helpers reviewed; no additional loop repair identified')
if __name__=='__main__':main()
