#!/usr/bin/env python3
"""Compare namespace-aware ABC declarations, method signatures and script groups.
Only reads original/built inventory ABCs. No player execution. Namespace indexes
are per ABC; private namespaces remain distinct even when URI strings match.
"""
from pathlib import Path
import collections, hashlib, inspect, json, struct
from swf_inventory import Reader, abc_inventory, sha, inventory
ROOT=Path(__file__).resolve().parents[2]
# Augment the shared parser locally; preserve its complete byte-consumption check.
# This does not edit swf_inventory.py or any game resource.
code=inspect.getsource(abc_inventory).replace('def abc_inventory(b):','def audit_abc(b):')
code=code.replace("'name':name(cn),'super':name(supern)","'name':name(cn),'name_index':cn,'super':name(supern)")
code=code.replace("{'name':name(tn),'kind':kind,**detail}","{'name':name(tn),'name_index':tn,'attributes':attr,'kind':kind,**detail}")
code=code.replace("'strings':strings}","'strings':strings,'namespaces':ns,'multinames':names,'namespace_sets':sets}")
code=code.replace("    for _ in range(2):\n        for i in range(1,r.var()):r.var()\n    r.take(max(0,r.var()-1)*8)", "    ints=[0]+[r.var() for _ in range(1,r.var())]\n    uints=[0]+[r.var() for _ in range(1,r.var())]\n    doubles=[0]+[struct.unpack('<d',r.take(8))[0] for _ in range(1,r.var())]")
code=code.replace("    methods=[]", "    def constant(kind,index):\n        if kind==1:return strings[index]\n        if kind==3:return ints[index]\n        if kind==4:return uints[index]\n        if kind==6:return str(doubles[index])\n        if kind in (10,11,12,0):return {10:'false',11:'true',12:'null',0:'undefined'}[kind]\n        return ['kind',kind,index]\n    methods=[]")
code=code.replace("        if flags&8:\n            for _ in range(r.var()):r.var();r.u8()", "        optional=[]\n        if flags&8:\n            for _ in range(r.var()):\n                oi=r.var();ok=r.u8();optional.append({'kind':ok,'value':constant(ok,oi)})")
code=code.replace("'flags':flags})", "'flags':flags,'optional':optional})")
code=code.replace("                if value:r.u8()", "                if value:\n                    vk=r.u8();detail['initial_constant']={'kind':vk,'value':constant(vk,value)}")
ns={};exec(code,globals(),ns);parse=ns['audit_abc']
def load(path):
 d=parse(path.read_bytes());d['sha256']=sha(path.read_bytes());return d
current_swf=ROOT/'reverse/build/main-probe/main-normalized.swf'
current_inventory=ROOT/'reverse/build/main-audit/current-inventory'
current_receipt=inventory(current_swf,current_inventory)
paths={'original':ROOT/'reverse/exports/3_L4399Main_gamefile/inventory/abc-0000.abc','rebuilt':current_inventory/'abc-0000.abc'}
data={k:load(p) for k,p in paths.items()}
def qname(d,index,normalize_private=True):
 if not index:return '*'
 kind,args=d['multinames'][index]
 if kind in (7,13):
  ni,si=args; nk,uri=d['namespaces'][ni] if ni else (0,0)
  return {'multiname_kind':kind,'namespace_kind':nk,'namespace_uri':d['strings'][uri],'name':d['strings'][si],**({'private_identity_index':ni} if nk==5 and not normalize_private else {})}
 return {'multiname_kind':kind,'raw':args}
def sig(d,mid):
 m=d['methods'][mid];return {k:v for k,v in m.items() if k not in ('index','name')}
def traits(d,rows):
 out=[]
 for r in rows:
  v={'qname':qname(d,r['name_index']),'kind':r['kind'],'attributes':r['attributes']}
  if 'method' in r:v['signature']=sig(d,r['method'])
  if 'function' in r:v['signature']=sig(d,r['function'])
  if 'type' in r:v['type']=r['type']
  if 'initial_constant'in r:v['initial_constant']=r['initial_constant']
  if 'class' in r:v['class_name']=d['classes'][r['class']]['name']
  out.append(v)
 return sorted(out,key=lambda x:json.dumps(x,sort_keys=True))
def classkey(d,c):return json.dumps(qname(d,c['name_index']),sort_keys=True)
def classes(d):
 out=collections.defaultdict(list)
 for c in d['classes']:
  out[classkey(d,c)].append({'name':c['name'],'qname':qname(d,c['name_index'],False),'super':c['super'],'flags':c['flags'],'interfaces':c['interfaces'],'initializer_signature':sig(d,c['initializer']),'traits':traits(d,c['traits']),'static_traits':traits(d,c['static_traits']),'original_index':c['index']})
 return out
groups={k:classes(d) for k,d in data.items()};a,b=groups.values();missing=[];extra=[];changes=[]
for key in sorted(a.keys()|b.keys()):
 if key not in a:extra.extend(b[key]);continue
 if key not in b:missing.extend(a[key]);continue
 def normalized(v):
  def scrub(x):
   if isinstance(x,dict):return {k:('<private-uri>' if k=='namespace_uri' and x.get('namespace_kind')==5 else scrub(y)) for k,y in x.items()}
   if isinstance(x,list):return sorted((scrub(y) for y in x),key=lambda z:json.dumps(z,sort_keys=True))
   return x
  return scrub({k:x for k,x in v.items() if k not in ('original_index','qname')})
 if [normalized(v)for v in a[key]] != [normalized(v)for v in b[key]]:changes.append({'class_key':json.loads(key),'original':a[key],'rebuilt':b[key]})
duplicates={}
for which,d in data.items():
 names=collections.defaultdict(list)
 for c in d['classes']:names[c['name']].append(c)
 rows=[]
 for name,cs in names.items():
  if len(cs)<2:continue
  for c in cs:
   owners=[{'script':s['index'],'class_traits':[t['name']for t in s['traits'] if t['kind']==4]}for s in d['scripts'] if any(t.get('class')==c['index'] for t in s['traits'])]
   rows.append({'class_name':name,'class_index':c['index'],'qname':qname(d,c['name_index'],False),'owning_scripts':owners})
 duplicates[which]=rows
scripts={which:[{'index':s['index'],'class_names':[d['classes'][t['class']]['name'] for t in s['traits'] if 'class'in t],'initializer_signature':sig(d,s['initializer'])}for s in d['scripts']]for which,d in data.items()}
# Compare groups rather than raw order: lazy scripts may reorder legally.
group_sets={which:collections.Counter(tuple(sorted(s['class_names']))for s in ss)for which,ss in scripts.items()}
script_group_changes={which:[{'classes':list(group),'count':n}for group,n in (counter-group_sets['rebuilt' if which=='original' else 'original']).items()]for which,counter in group_sets.items()}
private_groups={}
for which,d in data.items():
 owners=collections.defaultdict(set)
 for c in d['classes']:
  for tr in c['traits']+c['static_traits']:
   kind,args=d['multinames'][tr['name_index']]
   if kind in (7,13) and d['namespaces'][args[0]][0]==5:owners[args[0]].add(c['name'])
 private_groups[which]=sorted([{'namespace_index':i,'owners':sorted(v)}for i,v in owners.items()],key=lambda v:v['owners'])
private_owner_partition_equal=sorted(x['owners'] for x in private_groups['original'])==sorted(x['owners']for x in private_groups['rebuilt'])
ambiguous_class_names={}
for which,d in data.items():
 defs=collections.defaultdict(list)
 for c in d['classes']:
  q=qname(d,c['name_index'],False)
  if q.get('namespace_kind')!=5:defs[q.get('name')].append(q)
 hits=[]
 for mi,m in enumerate(d['multinames']):
  if not m or m[0] not in (9,14):continue
  si,nsi=m[1];name=d['strings'][si]
  choices={(d['namespaces'][n][0],d['strings'][d['namespaces'][n][1]]) for n in d['namespace_sets'][nsi]}
  candidates=[q for q in defs.get(name,[]) if (q['namespace_kind'],q['namespace_uri']) in choices]
  if len(candidates)>1:hits.append({'multiname_index':mi,'name':name,'candidates':candidates})
 ambiguous_class_names[which]=hits
result={'schema':1,'scope':'Namespace-aware declarations/method signatures/class script groups only; no method-body semantic equivalence claim','rebuilt_swf':{'path':str(current_swf.relative_to(ROOT)),'sha256':current_receipt['sha256']},'inputs':{k:{'path':str(paths[k].relative_to(ROOT)),'sha256':d['sha256'],'classes':len(d['classes']),'methods':len(d['methods']),'scripts':len(d['scripts']),'method_bodies':len(d['method_bodies'])}for k,d in data.items()},'missing_classes':missing,'extra_classes':extra,'declaration_changes':changes,'duplicate_plain_names':duplicates,'private_uri_normalization':'Private namespace URI text ignored for declaration comparison; identity indexes retained in duplicate class report, distinct private namespaces must not be merged.','script_group_changes':script_group_changes,'script_orders':scripts,'ambiguous_class_name_multinames':ambiguous_class_names,'private_member_namespace_groups':private_groups,'private_owner_partition_equal':private_owner_partition_equal,'summary':{'missing_classes':len(missing),'extra_classes':len(extra),'declaration_changes':len(changes),'script_group_changes':sum(len(v)for v in script_group_changes.values())}}
p=ROOT/'reverse/manifests/main-audit-namespaces.json';p.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n');print(json.dumps(result['summary'],indent=2));print(json.dumps(duplicates,ensure_ascii=False,indent=2))
