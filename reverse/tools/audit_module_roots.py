#!/usr/bin/env python3
"""Read-only root-timeline/linkage audit for current resource rebuild receipts."""
from pathlib import Path
import collections,datetime,hashlib,json,struct
from swf_inventory import Reader,read_swf,TAG_NAMES,abc_inventory,CHARACTER_TAGS,walk_tags
ROOT=Path(__file__).resolve().parents[2]
BEHAVIOR={4,5,12,15,18,19,26,28,43,45,59,61,70,89,94}
def sha(b):return hashlib.sha256(b).hexdigest()
def root_tags(body,start):
 p=start;frame=0
 while p<len(body):
  off=p;head=struct.unpack_from('<H',body,p)[0];p+=2;code=head>>6;size=head&63
  if size==63:size=struct.unpack_from('<I',body,p)[0];p+=4
  payload=body[p:p+size];assert len(payload)==size;p+=size
  yield code,payload,off+8,frame
  if code==1:frame+=1
  if code==0:break
 assert p==len(body)
def inspect(path):
 raw,body,h=read_swf(path);tags=[];symbols={};exports={};behavior=[];attrs=[];abc=[];background=[];scenes=[];generated_roots=[];placements=[];definitions={};metadata=[]
 for c,x,off,frame in root_tags(body,h['tag_start']):
  row={'code':c,'name':TAG_NAMES.get(c,str(c)),'offset':off,'frame_index':frame,'payload_sha256':sha(x),'length':len(x)};tags.append(row)
  if c in CHARACTER_TAGS and len(x)>=2:definitions[struct.unpack_from('<H',x)[0]]={'code':c,'name':TAG_NAMES.get(c,str(c)),'length':len(x),'payload_sha256':sha(x),'payload_without_id_sha256':sha(x[2:]),'payload_hex_if_small':x.hex()if len(x)<=128 else None}
  if c in BEHAVIOR:behavior.append({**row,'payload_hex':x.hex()})
  if c in(9,65,69,77,86):metadata.append(row)
  if c==26:
   flags=x[0];placements.append({'frame_index':frame,'flags':flags,'depth':struct.unpack_from('<H',x,1)[0],'character_id':struct.unpack_from('<H',x,3)[0]if flags&2 else None,'payload_hex':x.hex()})
  if c in (76,56):
   r=Reader(x)
   for _ in range(r.u16()):
    cid=r.u16();name=r.cstr();(symbols if c==76 else exports)[name]=cid
  if c==69:
   flags=struct.unpack('<I',x)[0];attrs.append({'raw':flags,'use_network':bool(flags&1),'actionscript3':bool(flags&8),'has_metadata':bool(flags&16),'use_gpu':bool(flags&32),'use_direct_blit':bool(flags&64)})
  if c in(72,82):
   r=Reader(x);flags=struct.unpack('<I',r.take(4))[0]if c==82 else None;label=r.cstr()if c==82 else'';ab=r.take(len(x)-r.p);abc.append({'flags':flags,'label':label,'frame_index':frame,'abc_sha256':sha(ab)})
   if label.endswith('_flash_display_Sprite'):
    a=abc_inventory(ab);bodies={v['method']:v for v in a['method_bodies']}
    for cl in a['classes']:
     if cl['name']==label:
      generated_roots.append({'class_name':cl['name'],'super':cl['super'],'traits':cl['traits'],'static_traits':cl['static_traits'],'methods':[{'kind':k,'code_hex':ab[bodies[cl[k]]['offset']:bodies[cl[k]]['offset']+bodies[cl[k]]['length']].hex()}for k in ('initializer','static_initializer')]})
  if c==9:background.append(x.hex())
  if c==86:scenes.append({'sha256':sha(x),'hex':x.hex()})
 return {'path':str(path.relative_to(ROOT)),'sha256':sha(raw),'header':h,'root_tag_counts':dict(collections.Counter(t['name']for t in tags)),'root_behavior_tags':behavior,'root_placements':placements,'root_placement_definitions':{str(v['character_id']):definitions.get(v['character_id'])for v in placements},'small_bitmap_definitions':{str(i):d for i,d in definitions.items()if d['code']in(20,21,35,36,90)and d['length']<=128},'root_metadata_tags':metadata,'generated_root_class_bodies':generated_roots,'root_tags':tags,'symbol_classes':symbols,'symbol_class_definitions':{n:definitions.get(i)for n,i in symbols.items()if i},'export_assets':exports,'document_classes':[n for n,i in symbols.items()if i==0],'file_attributes':attrs,'background_rgb':background,'scene_frame_label_data':scenes,'doabc':abc}
def restored_root_check(old,new,receipt):
 report=receipt.get('root_timeline',{});mapping={i:new['symbol_classes'].get(n)for n,i in old['symbol_classes'].items()if i};mapping.update({x['original_id']:x['new_id']for x in report.get('copied_unlinked_definitions',[])})
 a=old['root_behavior_tags'];b=new['root_behavior_tags'];issues=[]
 if len(a)!=len(b):issues.append('root behavior tag count differs')
 for x,y in zip(a,b):
  payload=bytearray.fromhex(x['payload_hex'])
  if x['code']==26 and payload[0]&2:
   cid=struct.unpack_from('<H',payload,3)[0];target=mapping.get(cid)
   if target is None:issues.append('root placement has no verified ID mapping');continue
   struct.pack_into('<H',payload,3,target)
  if (x['code'],x['frame_index'],sha(payload))!=(y['code'],y['frame_index'],y['payload_sha256']):issues.append('root control differs after ID remap')
 for cid,item in old['root_placement_definitions'].items():
  target=mapping.get(int(cid));other=new['root_placement_definitions'].get(str(target))
  if not item or not other or item['code']!=other['code']:issues.append('placed root character type differs');continue
  if item['code']==22:
   # Independent fixed-sample check: source SHA anchors the previously fully
   # bit-parsed 94-byte Shape2, including StateNewStyles at offset 53.
   if item['payload_sha256']!='f889014d041532d511b9f00c812202134e92620e325d0bb6b79a2b7c9972f4c0':issues.append('unreviewed root Shape2');continue
   buf=bytearray.fromhex(item['payload_hex_if_small']);struct.pack_into('<H',buf,0,target)
   for off in(13,23,55,65):
    original_id=struct.unpack_from('<H',buf,off)[0]
    if original_id==65535:continue
    mapped=mapping.get(original_id)
    if mapped is None:issues.append('missing Shape2 bitmap mapping');continue
    aa=old['small_bitmap_definitions'].get(str(original_id));bb=new['small_bitmap_definitions'].get(str(mapped))
    if not aa or not bb or (aa['code'],aa['payload_without_id_sha256'])!=(bb['code'],bb['payload_without_id_sha256']):issues.append('root bitmap content differs')
    struct.pack_into('<H',buf,off,mapped)
   if sha(buf)!=other['payload_sha256']:issues.append('root Shape2 differs after complete bitmap remap')
 metadata_equal=[(x['code'],x['payload_sha256'])for x in old['root_metadata_tags']]==[(x['code'],x['payload_sha256'])for x in new['root_metadata_tags']]
 return {'restore_receipt_present':bool(report),'root_controls_and_reviewed_dependencies_match':not issues,'issues':issues,'metadata_payloads_equal':metadata_equal,'scope':'All root behavior payloads after verified name-based/reported dependency ID mapping; unlinked Shape2 verified against exact original hash and all four independently parsed bitmap offsets.'}
rows=[];owners=collections.defaultdict(list)
for p in sorted(ROOT.glob('*.swf')):
 if p.stem in ('3_L4399Main_gamefile','DataX_v76'):continue
 old=inspect(p);row={'module':p.stem,'original':old};rp=ROOT/'reverse/experiments/module-probe'/p.stem/'result.json'
 for ap in (ROOT/'reverse/exports'/p.stem/'inventory').glob('abc-*.json'):
  for c in json.loads(ap.read_text())['classes']:
   n=c['name']
   if '.as$'not in n and n not in('PrivateClass','ArrayTweenInfo'):owners[n].append(p.stem)
 if not rp.exists():row['rebuilt_status']='no_receipt'
 else:
  receipt=json.loads(rp.read_text());output=ROOT/receipt['output'];row['receipt_path']=str(rp.relative_to(ROOT))
  if receipt.get('invalidated'):row['rebuilt_status']='invalidated_receipt'
  elif any(r.get('repair','').startswith('Qualify ')for r in receipt.get('source_repairs',{}).get('syntax_repairs',[])):row['rebuilt_status']='obsolete_fully_qualified_repair'
  elif not output.exists():row['rebuilt_status']='missing_output'
  else:
   new=inspect(output);row['rebuilt']=new;row['root_restoration_audit']=restored_root_check(old,new,receipt);row['receipt_hash_matches']=new['sha256']==receipt['output_sha256'];row['rebuilt_status']='current'if row['receipt_hash_matches']else'output_changed_during_audit'
   os={n for n,i in old['symbol_classes'].items()if i!=0};ns={n for n,i in new['symbol_classes'].items()if i!=0}
   row['comparison']={'header_differences':{k:{'original':old['header'][k],'rebuilt':new['header'][k]}for k in ('version','rect_twips','frame_rate','frame_count')if old['header'][k]!=new['header'][k]},'missing_linkage_classes':sorted(os-ns),'missing_linkage_details':[{'name':n,'original_definition':old['symbol_class_definitions'].get(n)}for n in sorted(os-ns)],'linkage_type_changes':[{'name':n,'original':old['symbol_class_definitions'].get(n),'rebuilt':new['symbol_class_definitions'].get(n)}for n in sorted(os&ns)if (old['symbol_class_definitions'].get(n)or{}).get('code')!=(new['symbol_class_definitions'].get(n)or{}).get('code')],'extra_linkage_classes':sorted(ns-os),'original_linkages':len(os),'rebuilt_linkages':len(ns),'root_behavior_changed':[(x['code'],x['payload_sha256'],x['frame_index'])for x in old['root_behavior_tags']]!=[(x['code'],x['payload_sha256'],x['frame_index'])for x in new['root_behavior_tags']],'file_attributes_changed':old['file_attributes']!=new['file_attributes'],'background_changed':old['background_rgb']!=new['background_rgb'],'scene_frame_labels_changed':old['scene_frame_label_data']!=new['scene_frame_label_data'],'root_document_classes_added':sorted(set(new['document_classes'])-set(old['document_classes']))}
 rows.append(row)
 print(p.stem,row['rebuilt_status'],flush=True)
current=[r for r in rows if r['rebuilt_status']=='current'];main=json.loads((ROOT/'reverse/exports/3_L4399Main_gamefile/inventory/abc-0000.json').read_text());mainnames={c['name']for c in main['classes']};duplicates=[{'class_name':n,'resource_module_count':len(ms),'defined_in_main':n in mainnames,'resource_modules':ms}for n,ms in owners.items()if len(ms)>1 or n in mainnames];duplicates.sort(key=lambda x:(-x['resource_module_count'],x['class_name']))
summary={'resource_modules':len(rows),'original_document_class_modules':sum(bool(r['original']['document_classes'])for r in rows),'original_root_behavior_modules':sum(bool(r['original']['root_behavior_tags'])for r in rows),'original_root_behavior_tags':sum(len(r['original']['root_behavior_tags'])for r in rows),'current_rebuilt_modules':len(current),'status_counts':dict(collections.Counter(r['rebuilt_status']for r in rows)),'restored_root_receipt_modules':sum(r['root_restoration_audit']['restore_receipt_present']for r in current),'root_controls_dependency_match_modules':sum(r['root_restoration_audit']['root_controls_and_reviewed_dependencies_match']for r in current),'root_metadata_equal_modules':sum(r['root_restoration_audit']['metadata_payloads_equal']for r in current),'header_difference_modules':sum(bool(r['comparison']['header_differences'])for r in current),'missing_linkage_modules':sum(bool(r['comparison']['missing_linkage_classes'])for r in current),'linkage_type_change_modules':sum(bool(r['comparison']['linkage_type_changes'])for r in current),'extra_linkage_modules':sum(bool(r['comparison']['extra_linkage_classes'])for r in current),'root_behavior_changed_modules':sum(r['comparison']['root_behavior_changed']for r in current),'file_attributes_changed_modules':sum(r['comparison']['file_attributes_changed']for r in current),'background_changed_modules':sum(r['comparison']['background_changed']for r in current),'scene_frame_labels_changed_modules':sum(r['comparison']['scene_frame_labels_changed']for r in current),'new_root_document_class_modules':sum(bool(r['comparison']['root_document_classes_added'])for r in current),'cross_module_duplicate_names':len(duplicates)}
recovered_assets=[]
for p in sorted((ROOT/'reverse/build/module-probe').glob('*/compile-source/_assets/recovered-buttons.swf')):
 module=p.parents[2].name;original=next(r['original']for r in rows if r['module']==module);raw,body,h=read_swf(p);tags=list(walk_tags(body,h['tag_start']));buttons=[]
 for t,x in tags:
  if t['code']==34:
   matching=[n for n,d in original['symbol_class_definitions'].items()if d and d['payload_sha256']==sha(x)]
   buttons.append({'character_id':t['character_id'],'payload_sha256':sha(x),'length':len(x),'empty_records_and_actions':len(x)==6 and x[3:]==bytes(3),'exact_original_linkage_matches':matching})
 script_tags=[t['code']for t,x in tags if t['code']in(12,59,72,82)]
 recovered_assets.append({'module':module,'path':str(p.relative_to(ROOT)),'sha256':sha(raw),'nested_script_tags':script_tags,'buttons':buttons,'valid':not script_tags and bool(buttons)and all(b['empty_records_and_actions']and b['exact_original_linkage_matches']for b in buttons)})
summary['generated_recovered_button_assets']=len(recovered_assets);summary['generated_recovered_button_asset_failures']=sum(not r['valid']for r in recovered_assets)
result={'schema':1,'generated_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'scope':'Top-level SWF timeline, tag/file attributes and public linkage names; does not establish nested timeline or ABC semantics. Receipt snapshots may be superseded by ongoing builds.','summary':summary,'modules':rows,'generated_recovered_button_assets':recovered_assets,'cross_module_duplicate_definitions':duplicates}
(ROOT/'reverse/manifests/module-roots.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n');print(json.dumps(summary,indent=2))
