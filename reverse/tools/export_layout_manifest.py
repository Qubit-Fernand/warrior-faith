#!/usr/bin/env python3
"""Extract a small inspectable Map0 layout sample from FFDec's script-free XML.
Requires the ignored full XML and its no-op roundtrip already generated; does not
mutate source/assets or claim the snippets form a self-contained FLA project.
"""
from pathlib import Path
import collections,json,xml.etree.ElementTree as ET
from PIL import Image
from swf_inventory import read_swf,walk_tags,sha
ROOT=Path(__file__).resolve().parents[2];base=ROOT/'reverse/build/layout-probe';out=ROOT/'reverse/experiments/layout-probe';out.mkdir(parents=True,exist_ok=True)
xml=base/'Map0-assets.xml';tree=ET.parse(xml);root=tree.getroot()
inventory=json.loads((ROOT/'reverse/exports/Map0_v26/inventory/structure.json').read_text());names={r['id']:r['name']for r in inventory['symbol_classes']}
selected={493:'village-chief-button',504:'moveChild',505:'Map_0_0',412:'shape-example'};snippets=[];placements=[]
for node in root.find('tags'):
 cid=next((int(node.attrib[k])for k in ['spriteId','buttonId','shapeId']if k in node.attrib),None)
 if cid not in selected:continue
 path=out/(str(cid)+'-'+selected[cid]+'.xml');ET.ElementTree(node).write(path,encoding='utf-8',xml_declaration=True);snippets.append({'id':cid,'type':node.get('type'),'class':names.get(cid),'path':str(path.relative_to(ROOT)),'sha256':sha(path.read_bytes())})
 frame=1
 for child in node.findall('./subTags/item'):
  kind=child.get('type')
  if kind=='ShowFrameTag':frame+=1
  if not kind.startswith('PlaceObject'):continue
  ref=int(child.get('characterId','0'));matrix=child.find('matrix')
  placements.append({'parent_id':cid,'parent_label':selected[cid],'frame':frame,'character_id':ref,'class':names.get(ref),'instance_name':child.get('name'),'depth':int(child.get('depth')),'tag':dict(child.attrib),'matrix':dict(matrix.attrib)if matrix is not None else None,'translation_pixels':[int(matrix.get('translateX','0'))/20,int(matrix.get('translateY','0'))/20]if matrix is not None else None})
inputs=[ROOT/'reverse/exports/Map0_v26/scripts/_assets/assets.swf',base/'Map0-assets-roundtrip.swf'];parsed=[]
for p in inputs:
 raw,b,h=read_swf(p);tags=list(walk_tags(b,h['tag_start']));assert not any(t['code']in (7,12,59,72,82)for t,_ in tags)
 parsed.append((h,tags))
assert len(parsed[0][1])==len(parsed[1][1])
diffs=[]
for (a,x),(b,y)in zip(parsed[0][1],parsed[1][1]):
 assert (a['code'],a.get('character_id'),a['parent'])==(b['code'],b.get('character_id'),b['parent'])
 if x!=y:diffs.append({'code':a['code'],'character_id':a.get('character_id'),'old_bytes':len(x),'new_bytes':len(y)})
images=[]
for label in ['before','after']:
 paths=list((base/('render-'+label)).rglob('*.png'));assert len(paths)==1,paths
 with Image.open(paths[0])as im:
  rgba=im.convert('RGBA');images.append({'file':str(paths[0].relative_to(ROOT)),'size':list(rgba.size),'rgba_sha256':sha(rgba.tobytes())})
result={'schema':1,'scope':'Map0 art-container no-op XML roundtrip and selected layout snippets. No runtime gameplay or edited placement validation.',
 'inputs':[{'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes())}for p in inputs],
 'xml':{'path':str(xml.relative_to(ROOT)),'sha256':sha(xml.read_bytes()),'bytes':xml.stat().st_size,'generator':root.get('_generator'),'schema_major':root.get('_xmlExportMajor'),'schema_minor':root.get('_xmlExportMinor')},
 'snippets':snippets,'placements':placements,'roundtrip':{'tag_count':len(parsed[0][1]),'character_ids_and_tag_order_equal':True,'header_fields_equal':{k:parsed[0][0][k]==parsed[1][0][k]for k in ['signature','version','rect_twips','frame_rate','frame_count']},'changed_payloads':diffs,'changed_payload_types':dict(collections.Counter(str(d['code'])for d in diffs)),'all_non_shape_payloads_equal':all(d['code']in (2,22,32,83)for d in diffs),'rendered_images':images,'Map_0_0_frame1_RGBA_equal':images[0]['size']==images[1]['size']and images[0]['rgba_sha256']==images[1]['rgba_sha256']},
 'boundary':'XML rewriting reserializes 96 shape payloads; one map frame equivalence does not validate all button states/animations. Snippets reference other character IDs in the full 44 MB XML and are not standalone compilable assets. This experiment is not wired into production build.'}
(out/'Map0-layout.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n');print(json.dumps({'snippets':len(snippets),'placements':len(placements),'changed_shape_payloads':len(diffs),'map_frame_equal':result['roundtrip']['Map_0_0_frame1_RGBA_equal']},indent=2))
