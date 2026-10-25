#!/usr/bin/env python3
"""Read-only full FFDec export audit. Coverage is structural, never equivalence.
Checks original ABC script/class coverage, error markers, Embed resolution,
recursive script-free SWFs, and literal addFrameScript indices/methods.
"""
from pathlib import Path
import collections,hashlib,inspect,json,re,struct,time
from swf_inventory import Reader,read_swf,walk_tags,abc_inventory,sha
ROOT=Path(__file__).resolve().parents[2];EXP=ROOT/'reverse/exports'
CLASS=re.compile(r'^\s*(?:(?:public|private|internal|dynamic|final)\s+)*(?:class|interface)\s+(§[^§]+§|[^\s{]+)',re.M)
EMBED=re.compile(r'\[Embed\((.*?)\)\]',re.S)
# Preserve private namespace kinds for helper-class normalization. URI text can
# contain source filename and compiler counter; it is not an AS package name.
parser_code=inspect.getsource(abc_inventory).replace('def abc_inventory(b):','def quality_abc(b):')
parser_code=parser_code.replace("'name':name(cn),'super':name(supern)","'name':name(cn),'name_index':cn,'super':name(supern)")
parser_code=parser_code.replace("'strings':strings}","'strings':strings,'namespaces':ns,'multinames':names}")
parser_scope={};exec(parser_code,globals(),parser_scope);quality_abc=parser_scope['quality_abc']
def class_name(abc,c):
 kind,args=abc['multinames'][c['name_index']]
 if kind in (7,13) and abc['namespaces'][args[0]][0]==5:
  return abc['strings'][args[1]]
 return c['name']
cache={}
def asset_swf(path):
 key=str(path)
 if key in cache:return cache[key]
 b,body,h=read_swf(path);symbols={};frames={0:h['frame_count']};scripts=[]
 for t,pay in walk_tags(body,h['tag_start']):
  if t['code']in(72,82,12,59):scripts.append({'code':t['code'],'parent':t['parent'],'offset':t['offset']})
  if t['code']==39:frames[t['character_id']]=struct.unpack_from('<H',pay,2)[0]
  if t['code']in(56,76):
   r=Reader(pay)
   for _ in range(r.u16()):
    cid=r.u16();name=r.cstr();symbols[name]=cid
 out={'sha256':sha(b),'script_tags':scripts,'symbols':symbols,'frames':frames,'frame_count':h['frame_count']};cache[key]=out;return out
mods=[];errors=[];empty=[];escaped=[];embeds=[];framecalls=[];coverage=[];started=time.time()
for mp in sorted(ROOT.glob('*.swf')):
 stem=mp.stem;folder=EXP/stem;source=folder/'scripts';inv=folder/'inventory';structure=json.loads((inv/'structure.json').read_text());abcs=[quality_abc(p.read_bytes())for p in sorted(inv.glob('abc-*.abc'))]
 expected_scripts=sum(len(a['scripts'])for a in abcs);expected_classes=collections.Counter(class_name(a,c)for a in abcs for c in a['classes'])
 expected_groups=collections.Counter(tuple(sorted(class_name(a,a['classes'][t['class']])for t in s['traits']if t['kind']==4))for a in abcs for s in a['scripts']);actual_groups=collections.Counter()
 files=sorted(source.rglob('*.as'));actual=collections.Counter();main_names=[]
 for path in files:
  text=path.read_text();rel=str(path.relative_to(ROOT));decl=list(CLASS.finditer(text));pkg=re.search(r'^\s*package(?:\s+([^\s{]+))?\s*\{',text,re.M);pkgname=(pkg.group(1)or'')if pkg else''
  # FFDec one script/file: first class is its file/package class; helpers after
  # package close are source-file private definitions with unqualified names.
  file_names=[]
  for i,m in enumerate(decl):
   name=m.group(1).strip('§');fullname=(pkgname+'.'if pkgname and i==0 else'')+name;actual[fullname]+=1;file_names.append(fullname)
   if i==0:main_names.append(fullname)
  actual_groups[tuple(sorted(file_names))]+=1
  for n,line in enumerate(text.splitlines(),1):
   if re.search(r'not decompiled|decompilation|decompiler|unknown ?jump|§§|timed out|timeout exceeded',line,re.I):errors.append({'file':rel,'line':n,'text':line.strip()[:300]})
   if '§' in line:
    for ident in re.findall(r'§([^§\r\n]+)§',line):escaped.append({'file':rel,'line':n,'identifier':ident})
   if re.fullmatch(r'\s*\{\};\s*',line):empty.append({'file':rel,'line':n,'context':'FFDec empty block followed by semicolon; may require syntactic repair, not proven lost behavior'})
  bindings=[]
  for em in EMBED.finditer(text):
   attrs=dict(re.findall(r'(\w+)\s*=\s*"([^"]*)"',em.group(1)));src=attrs.get('source')
   if not src:continue
   target=(source/src.lstrip('/'))if src.startswith('/')else(path.parent/src)
   row={'source_file':rel,'line':text[:em.start()].count('\n')+1,'embed_source':src,'resolved':str(target.relative_to(ROOT)),'exists':target.exists(),'symbol':attrs.get('symbol')}
   if target.exists()and target.suffix.lower()=='.swf':
    info=asset_swf(target);row['script_free']=not info['script_tags'];name=attrs.get('symbol');cid=info['symbols'].get(name)
    row['symbol_present']=cid is not None if name else None;row['character_id']=cid;row['frame_count']=info['frames'].get(cid)
   embeds.append(row);bindings.append(row)
  # Avoid strings/XML describing source: match calls beginning a line only.
  methodnames=set(re.findall(r'\bfunction\s+(?:get\s+|set\s+)?([^\s(]+)\(',text))
  for fm in re.finditer(r'^\s*(?:this\.)?addFrameScript\((.*?)\);',text,re.M|re.S):
   args=[v.strip()for v in fm.group(1).split(',')];binding=next((x for x in bindings if x.get('frame_count')is not None),None)
   pairs=[]
   for i in range(0,len(args)-1,2):
    ix=int(args[i])if re.fullmatch(r'\d+',args[i])else None;fn=args[i+1].removeprefix('this.');pairs.append({'index':ix,'raw_index':args[i],'method':fn,'method_declared_in_file':fn in methodnames,'within_bound_timeline':(ix<binding['frame_count'])if binding and ix is not None else None})
   framecalls.append({'file':rel,'line':text[:fm.start()].count('\n')+1,'bound_frame_count':binding.get('frame_count')if binding else None,'pairs':pairs})
 missing=list((expected_classes-actual).elements());extra=list((actual-expected_classes).elements())
 row={'module':mp.name,'source_sha256':hashlib.sha256(mp.read_bytes()).hexdigest(),'inventory_hash_matches':structure['sha256']==hashlib.sha256(mp.read_bytes()).hexdigest(),'expected_abc_scripts':expected_scripts,'exported_as_files':len(files),'expected_class_records':sum(expected_classes.values()),'exported_class_declarations':sum(actual.values()),'missing_class_names':missing,'extra_class_names':extra,'script_class_group_differences':{'original_only':[{'classes':list(k),'count':v}for k,v in (expected_groups-actual_groups).items()],'export_only':[{'classes':list(k),'count':v}for k,v in (actual_groups-expected_groups).items()]},'normalized_private_helper_classes':[c['name']for a in abcs for c in a['classes']if c['name']!=class_name(a,c)]}
 mods.append(row)
 if len(files)!=expected_scripts or missing or extra or expected_groups!=actual_groups:coverage.append(row)
 print(stem,len(files),'coverage_ok'if row not in coverage else'coverage_difference',flush=True)
assetrows=[{'path':str(Path(p).relative_to(ROOT)),'sha256':v['sha256'],'script_tags':v['script_tags'],'exported_symbols':len(v['symbols']),'sprite_frame_records':len(v['frames'])}for p,v in cache.items()]
frameissues=[r for r in framecalls if any(p['within_bound_timeline']is False or not p['method_declared_in_file']for p in r['pairs'])]
embedissues=[r for r in embeds if not r['exists']or r.get('script_free')is False or r.get('symbol_present')is False]
result={'schema':2,'private_class_normalization':'Only ABC namespace kind 5 is normalized to the short AS helper name. Per-script class multisets also compared, preserving helper ownership grouping. This is not a full private namespace identity proof.','scope':'All original root SWFs and fresh FFDec export scripts/assets. Structural coverage and static frame binding only; no all-method or all-frame semantic equivalence claim.','elapsed_seconds':time.time()-started,'modules':mods,'coverage_differences':coverage,'decompiler_error_markers':errors,'empty_block_semicolon_occurrences':empty,'escaped_identifier_occurrences':escaped,'embed_references':embeds,'embed_issues':embedissues,'asset_containers':assetrows,'addFrameScript_calls':framecalls,'frame_binding_issues':frameissues,'summary':{'modules':len(mods),'as_files':sum(r['exported_as_files']for r in mods),'expected_scripts':sum(r['expected_abc_scripts']for r in mods),'class_declarations':sum(r['exported_class_declarations']for r in mods),'expected_class_records':sum(r['expected_class_records']for r in mods),'coverage_difference_modules':len(coverage),'decompiler_error_markers':len(errors),'empty_block_semicolon_occurrences':len(empty),'escaped_identifier_occurrences':len(escaped),'escaped_identifier_files':len({x['file']for x in escaped}),'embed_references':len(embeds),'embed_issues':len(embedissues),'asset_containers':len(assetrows),'containers_with_script_tags':sum(bool(r['script_tags'])for r in assetrows),'addFrameScript_calls':len(framecalls),'frame_binding_issues':len(frameissues),'frame_calls_without_bound_frame_count':sum(x['bound_frame_count']is None for x in framecalls)}}
out=ROOT/'reverse/manifests/export-quality.json';out.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n');print(json.dumps(result['summary'],indent=2))
