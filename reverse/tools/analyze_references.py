#!/usr/bin/env python3
"""Read-only static dependency audit. No game execution or SharedObject access.

Usage: python reverse/tools/analyze_references.py [--scripts PATH]
Output distinguishes literal references from proven loading paths. The parser does
not treat a registered filename as reachable, nor an exported .as as complete.
"""
from pathlib import Path
import argparse, hashlib, json, re, struct, zlib, xml.etree.ElementTree as ET
ROOT = Path(__file__).resolve().parents[2]
p=argparse.ArgumentParser(); p.add_argument('--scripts',type=Path); args=p.parse_args()
fresh=ROOT/'reverse/exports/3_L4399Main_gamefile/scripts'
scripts=args.scripts or (fresh if (fresh/'src/TempData.as').exists() else ROOT/'.runtime/prior/decompiled/scripts')
scripts=scripts.absolute()
source_status='fresh_export' if '/reverse/exports/' in str(scripts) else 'prior_cache_pending_fresh_comparison'
def provenance(path,line):return {'file':str(path.relative_to(ROOT)), 'line':line, 'module':'3_L4399Main_gamefile.swf', 'source_status':source_status}
def symbols(path):
 b=path.read_bytes()
 if b[:3]==b'CWS':b=b[:8]+zlib.decompress(b[8:])
 if b[:3] not in (b'CWS',b'FWS'):return {'error':'unsupported compression'}
 offset=8+(5+4*(b[8]>>3)+7)//8+4; out=[]
 while offset+2<=len(b):
  rec=struct.unpack_from('<H',b,offset)[0];offset+=2;code,n=rec>>6,rec&63
  if n==63:n=struct.unpack_from('<I',b,offset)[0];offset+=4
  end=offset+n
  if code==76:
   count=struct.unpack_from('<H',b,offset)[0];pos=offset+2
   for _ in range(count):
    cid=struct.unpack_from('<H',b,pos)[0];pos+=2;nul=b.index(0,pos,end)
    out.append({'id':cid,'name':b[pos:nul].decode('utf-8')});pos=nul+1
  offset=end
 return out
inventory={x.name:{'sha256':hashlib.sha256(x.read_bytes()).hexdigest(),'symbols':symbols(x)} for x in sorted(ROOT.glob('*.swf'))}
refs=[];gaps=[];shared=[]
for path in sorted(scripts.rglob('*.as')):
 for n,line in enumerate(path.read_text().splitlines(),1):
  for m in re.finditer(r'["\']([^"\'\r\n]+\.swf)["\']',line):
   name=m.group(1);refs.append({'literal':name,'exists':name in inventory,'provenance':provenance(path,n),'context':line.strip(),'reachability':'unclassified_static_literal'})
  if 'Not decompiled' in line or 'Decompilation error' in line:gaps.append({**provenance(path,n),'context':line.strip()})
  if 'SharedObject.' in line:shared.append({**provenance(path,n),'context':line.strip()})
text=(scripts/'src/TempData.as').read_text(); tables={}
for table in ('mapArr','enemyArr','otherArr'):
 m=re.search(r'Load\.'+table+r'\s*=\s*\[(.*?)\];',text,re.S)
 vals={i:v for i,v in enumerate(re.findall(r'"([^"]*)"',m.group(1)))} if m else {}
 for m in re.finditer(r'Load\.'+table+r'\[(\d+)\]\s*=\s*"([^"]*)"',text):vals[int(m.group(1))]=m.group(2)
 tables[table]=vals
special={
 'Enemy17.swf':('bypassed_registry_entry','Load.Loading selects Loading_Enemy_All for gameNum 17; Enemy_All_Arr excludes 17. Not a missing enemy-ID-17 proof.'),
 'Data2X_v19.swf':('bypassed_registry_entry','Load.Loading_Data2 instantiates embedded Data2; does not load otherArr[11].'),
 'TempData.swf':('unused_helper_literal','ClassLoader.noCookieArr only; load does not invoke NoCookie. Main invokes inline TempData.Init.'),
 '/_assets/assets.swf':('ffdec_export_build_container','Generated Embed directive; not an original runtime load URL.'),
 'HD61.swf':('conditional_entry_reachability_unproven','SixOne_Interface constructor loads it, but no Open call found in main partial cache. Fresh all-module caller audit required.')}
for r in refs:
 if r['literal'] in special:r['reachability'],r['note']=special[r['literal']]
stages=[]
data_path=scripts/'src/_data/Data2_data.as'
if data_path.exists():
 data=data_path.read_text()
 for m in re.finditer(r'GameData\.GameDataXmlArr\[(\d+)\]\s*=\s*(<root>.*?</root>)',data,re.S):
  difficulty=int(m.group(1));xml=ET.fromstring(m.group(2))
  for row in xml:
   stage=int(row.findtext('大关'));room=int(row.findtext('小关'))
   key=18 if 18<stage<30 else stage;filename=tables['mapArr'].get(key)
   cls='Map_17_1' if stage==17 else 'Map_'+row.findtext('预留2')+'_'+row.findtext('预留3')
   symbol_names=[s['name'] for s in inventory.get(filename,{}).get('symbols',[]) if isinstance(s,dict)]
   stages.append({'difficulty':difficulty,'stage':stage,'room':room,'map_file':filename,'expected_class':cls,'symbol_present':cls in symbol_names,'map_instantiation_required':not (51<=stage<=55 and room>1),'progression_note':('In-place sea segment; GameData.Win(condition4) calls GetData + NoStop, not AddMap' if 51<=stage<=55 and room>1 else 'Normal map lookup or special wave path; see control-flow audit'),'boss_id':int(row.findtext('BOSSid')),'source_line':data[:m.start()].count('\n')+1,'reachability':'configuration_row; gameplay_entry_not_proven'})
# Whole-package constant-pool audit is an exact string scan, not execution proof.
api_scan=[]
for inv in sorted((ROOT/'reverse/exports').glob('*/inventory/abc-*.json')):
 raw=json.loads(inv.read_text());strings=raw.get('strings',[])
 hits=[x for x in strings if x in ('SharedObject','getLocal','getRemote','LocalConnection','FileStream') or x.startswith('yzlr2_')]
 if hits:api_scan.append({'inventory':str(inv.relative_to(ROOT)),'strings':hits})
equip={}
indata=ROOT/'reverse/exports/DataX_v76/scripts/src/InData.as'
if indata.exists():
 t=indata.read_text();m=re.search(r'EquipFactory\.myXml\s*=\s*(<info>.*?</info>)',t,re.S)
 if m:
  rows=ET.fromstring(m.group(1));groups={}
  for row in rows:
   filename=row.findtext('加载文件','0')
   groups.setdefault(filename,[]).append(int(row.findtext('编号')))
  equip={'source':str(indata.relative_to(ROOT)),'rows':len(rows),'file_values':[],'caveat':'All skins expanded as an upper bound; EquipFactory.findClassName4 returns int despite underlying string. Values containing _v2 require runtime-path confirmation; do not infer new missing filenames from coercion.'}
  for value,ids in sorted(groups.items()):
   filenames=[f'equip_{skin}_{value}.swf' for skin in range(3)] if value!='0' else []
   equip['file_values'].append({'value':value,'equipment_ids':ids,'expected_if_literal':filenames,'missing_if_literal':[f for f in filenames if f not in inventory]})
result={'schema':1,'source_scripts':str(scripts.relative_to(ROOT)),'source_status':source_status,'scope':'Original main source static references and stage XML vs root SWF SymbolClass; not whole-program reachability proof','main_swf_sha256':inventory['3_L4399Main_gamefile.swf']['sha256'],'registered_tables':tables,'literal_references':refs,'decompilation_errors':gaps,'shared_object_calls':shared,'stage_class_checks':stages,'stage_missing_symbols':[s for s in stages if not s['symbol_present']],'root_module_hashes':{name:x['sha256'] for name,x in inventory.items()},'map_class_symbols':{name:[v['name'] for v in x['symbols'] if isinstance(v,dict) and v['name'].startswith('Map_')] for name,x in inventory.items() if name.startswith('Map')},'package_storage_string_scan':api_scan,'equipment_dynamic_files':equip,'summary':{'swf_files':len(inventory),'literal_references':len(refs),'missing_literal_names':sorted({r['literal'] for r in refs if not r['exists']}),'stage_rows':len(stages),'stage_missing_symbol_rows':sum(not s['symbol_present'] for s in stages)}}
out=ROOT/'reverse/manifests/resource-references.json';out.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n');print(json.dumps(result['summary'],ensure_ascii=False,indent=2))
