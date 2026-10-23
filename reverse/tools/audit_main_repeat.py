#!/usr/bin/env python3
"""Read-only resolved P-code/ABC comparison of two real main builds."""
from pathlib import Path
import collections,difflib,inspect,json,re
from swf_inventory import Reader,abc_inventory,read_swf,walk_tags,sha
ROOT=Path(__file__).resolve().parents[2]
RUNS=['run-lx5icqis','run-b062kbrm']
parser=inspect.getsource(abc_inventory).replace("'strings':strings}","'strings':strings,'namespaces':ns,'multinames':names,'namespace_sets':sets}")
env={'Reader':Reader,'sha':sha};exec(parser,env)
def private(s):return re.sub(r'\.as\$\d+:','.as$N:',s)
def load(run):
 p=ROOT/'reverse/build/main-probe'/run/'normalized.swf';raw,body,h=read_swf(p)
 abcs=[payload[payload.index(b'\0',4)+1:] for tag,payload in walk_tags(body,h['tag_start']) if tag['code']==82]
 assert len(abcs)==1
 d=env['abc_inventory'](abcs[0]);d['swf_sha256']=sha(raw);d['abc_sha256']=sha(abcs[0]);return d
A,B=map(load,RUNS)
def ns(d,i):
 if not i:return None
 kind,si=d['namespaces'][i]
 return (kind,private(d['strings'][si]),i if kind==5 else None)
def mn(d,i):
 if not i:return None
 k,v=d['multinames'][i]
 if k in (7,13):return (k,ns(d,v[0]),private(d['strings'][v[1]]))
 if k in (9,14):return (k,private(d['strings'][v[0]]),tuple(ns(d,n) for n in d['namespace_sets'][v[1]]))
 if k in (15,16):return(k,private(d['strings'][v[0]]))
 if k in (17,18):return(k,)
 if k in (27,28):return(k,tuple(ns(d,n)for n in d['namespace_sets'][v[0]]))
 if k==29:return(k,tuple(mn(d,n)for n in v))
 raise ValueError(k)
def canonical_code(text):
 # Only rename offset labels to their instruction position, within each code body.
 # Private namespace identity indexes are deliberately retained.
 text=private(text)
 def body(match):
  lines=match.group(1).splitlines(True);mapping={};instruction=0
  for line in lines:
   s=line.strip()
   if re.fullmatch(r'ofs[0-9a-f]+:',s):mapping[s[:-1]]=f'insn{instruction}'
   elif s and not s.startswith(';'):instruction+=1
  return 'code\n'+''.join(re.sub(r'\bofs[0-9a-f]+\b',lambda m:mapping.get(m[0],m[0]),line)for line in lines)+'end ; code'
 return re.sub(r'code\n(.*?)end ; code',body,text,flags=re.S)
changes=[];total=0
for p in sorted((ROOT/'reverse/build/main-repeat-pcode'/RUNS[0]/'scripts').rglob('*.pcode')):
 rel=p.relative_to(ROOT/'reverse/build/main-repeat-pcode'/RUNS[0]/'scripts');q=ROOT/'reverse/build/main-repeat-pcode'/RUNS[1]/'scripts'/rel
 a,b=canonical_code(p.read_text()),canonical_code(q.read_text());total+=1
 if a!=b:changes.append({'file':str(rel),'diff':''.join(difflib.unified_diff(a.splitlines(True),b.splitlines(True)))})
counters=[collections.Counter(mn(d,i)for i in range(1,len(d['multinames'])))for d in (A,B)]
result={'schema':1,'runs':[{ 'run':r,'swf_sha256':d['swf_sha256'],'abc_sha256':d['abc_sha256']}for r,d in zip(RUNS,(A,B))],
 'pcode_files':total,'normalization':'Only .as$compilerOrdinal: strings and branch labels to per-body instruction index. Private namespace identity indexes retained.',
 'pcode_changes':changes,'script_changes':[{'before':a,'after':b}for a,b in zip(A['scripts'],B['scripts'])if a!=b],
 'classes_equal':A['classes']==B['classes'],'method_metadata_equal':A['methods']==B['methods'],
 'namespaces_equal_after_private_uri_ordinal_normalization':[ns(A,i)for i in range(1,len(A['namespaces']))]==[ns(B,i)for i in range(1,len(B['namespaces']))],
 'namespace_set_pool_raw_equal':A['namespace_sets']==B['namespace_sets'],
 'namespace_set_resolved_multiset_equal':collections.Counter(tuple(ns(A,i)for i in row)for row in A['namespace_sets'])==collections.Counter(tuple(ns(B,i)for i in row)for row in B['namespace_sets']),
 'multiname_only_in_first':list((counters[0]-counters[1]).items()),'multiname_only_in_second':list((counters[1]-counters[0]).items()),
 'interpretation':'All normalized P-code differences are the six single-class script initialization target lookups. This is strong static evidence, not a proof of runtime equivalence. No business method instruction changes found. Compiler nondeterminism is unresolved; this audit does not alter output bytes.'}
out=ROOT/'reverse/experiments/module-probe/main-repeat-resolved-audit.json';out.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({k:v for k,v in result.items()if k not in ('pcode_changes','script_changes')},ensure_ascii=False,indent=2));print('changed P-code files',len(changes));print([c['file']for c in changes])
