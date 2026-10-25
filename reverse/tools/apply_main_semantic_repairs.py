#!/usr/bin/env python3
"""Apply only the reviewed Main patches, with pre/post provenance. Explicit --apply.

Refuses to replace an existing receipt. Does not compile or run the game.
"""
from pathlib import Path
import argparse,hashlib,json,re,subprocess
ROOT=Path(__file__).resolve().parents[2]
def sha(b):return hashlib.sha256(b).hexdigest()
def method_bytes(raw,name):
 s=raw.decode();m=re.search(r'(?:public|private|protected) (?:static )?function '+re.escape(name)+r'\(',s);assert m,name
 start=s.index('{',m.end());level=1;i=start+1
 while level:
  if s[i]=='{':level+=1
  elif s[i]=='}':level-=1
  i+=1
 return s[m.start():i].encode()
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--apply',action='store_true');args=ap.parse_args()
 receipt=ROOT/'reverse/manifests/main-semantic-repairs.json';assert not receipt.exists(),'receipt exists; do not reapply'
 specs={}
 for row in json.loads((ROOT/'reverse/manifests/ordered-comparisons.json').read_text())['verified_local_nan_differences']:specs[(row['class'].replace('.','/'),row['method'])]='ordered-comparisons.json'
 for row in json.loads((ROOT/'reverse/manifests/nonstack-loops.json').read_text())['methods']:specs[('com/hotpoint/braveManIII/models/container/'+row['class'],row['method'])]='nonstack-loops.json'
 specs[('com/hotpoint/braveManIII/views/suppliesShopPanel/SuppliesShopPanel','setDown')]='shop-amount-field.json + experiments/ordered-comparison/shop-setDown-pcode.json'
 assert len(specs)==22
 paths={cls:ROOT/'reverse/source/3_L4399Main_gamefile'/(cls+'.as')for cls,n in specs};before={cls:p.read_bytes()for cls,p in paths.items()}
 patches=[ROOT/'reverse/experiments/ordered-comparison'/n for n in ('main-candidate.patch','nonstack-candidate.patch','shop-setDown-candidate.patch')]
 cmd=['git','apply','--check']+list(map(str,patches));subprocess.run(cmd,cwd=ROOT,check=True)
 if not args.apply:print('22 method candidates pass git apply --check; no source changed');return
 subprocess.run(['git','apply']+list(map(str,patches)),cwd=ROOT,check=True)
 after={cls:p.read_bytes()for cls,p in paths.items()}
 # All source files retain CRLF, including newly inserted lines.
 for raw in after.values():assert b'\n'not in raw.replace(b'\r\n',b''),'unexpected bare LF'
 abc=json.loads((ROOT/'reverse/exports/3_L4399Main_gamefile/inventory/abc-0000.json').read_text());classes={c['name']:c for c in abc['classes']};bodies={b['method']:b for b in abc['method_bodies']};changes=[]
 for (cls,n),evidence in specs.items():
  c=classes[cls.replace('/','.')];ts=[t for t in c['traits']+c['static_traits']if t['name'].split('.')[-1]==n and'method'in t];assert len(ts)==1,(cls,n)
  mid=ts[0]['method'];a=method_bytes(before[cls],n);b=method_bytes(after[cls],n);assert a!=b
  changes.append({'class':cls.replace('/','.'),'method':n,'source':str(paths[cls].relative_to(ROOT)),'before_method_sha256':sha(a),'after_method_sha256':sha(b),'before_method':a.decode(),'after_method':b.decode(),'original_abc_method_index':mid,'original_abc_method_code':bodies[mid],'evidence_manifest':evidence})
 report={'schema':1,'scope':'22 proven Main decompilation-loss repairs only; original game defects retained. Applied after root authorization. No game or compiler execution.','original_swf_sha256':sha((ROOT/'3_L4399Main_gamefile.swf').read_bytes()),'previous_runtime_build_sha256':'928e3d909992abb9b73e1820a45dd373d26171c460a72e296f605601df396248','patches':[{'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes())}for p in patches],'files':[{'path':str(p.relative_to(ROOT)),'before_sha256':sha(before[cls]),'after_sha256':sha(after[cls]),'crlf_preserved':True}for cls,p in paths.items()],'methods':changes,'method_count':len(changes),'git_apply_check_passed':True,'applied':True,'recompiled':False,'new_runtime_tested':False}
 receipt.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print(json.dumps({'methods':len(changes),'files':len(paths),'crlf_preserved':True,'receipt':str(receipt.relative_to(ROOT))},indent=2))
if __name__=='__main__':main()
