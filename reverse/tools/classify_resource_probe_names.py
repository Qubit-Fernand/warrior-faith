#!/usr/bin/env python3
"""Classify only the observed root/unnamed Shape auto-instance name differences."""
from pathlib import Path
import copy,hashlib,json,re
from swf_inventory import read_swf,walk_tags,Reader
ROOT=Path(__file__).resolve().parents[2]
RUN='20261023T172032Z-cf396b00'
RESULTS=ROOT/'reverse/experiments/resource-harness/results'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def evidence(package,module):
    manifest=json.loads((package/'probe-manifest.json').read_text());spec=next(x for x in manifest['files']if x['module']==module);path=package/'modules'/spec['file'];assert sha(path)==spec['sha256']
    _,body,h=read_swf(path);tags=list(walk_tags(body,h['tag_start']));symbols={};placements=[];defs={}
    for t,p in tags:
        if t['parent']!='root':continue
        if t.get('character_id') is not None:defs[t['character_id']]=t['code']
        if t['code']==76:
            r=Reader(p)
            for _ in range(r.u16()):
                cid=r.u16();name=r.cstr();symbols[name]=cid
        if t['code']==26:placements.append({'flags':p[0],'depth':int.from_bytes(p[1:3],'little'),'has_explicit_name':bool(p[0]&32),'character_id':int.from_bytes(p[3:5],'little')if p[0]&2 else None,'payload_hex':p.hex()})
    assert not any(cid==0 for cid in symbols.values()),'Unexpected document class'
    assert not any(t['parent']=='root'and t['code']in(4,12,59,70,94)for t,p in tags),'Unreviewed root timeline mechanism'
    if module=='Map0_v26':assert not placements
    else:
        assert module=='Enemy5_v2'and len(placements)==1
        placement=placements[0];assert not placement['has_explicit_name']and placement['depth']==2
        assert defs[placement['character_id']]==22,'Expected native DefineShape2'
        assert placement['character_id']not in symbols.values(),'Unexpected class binding for shape'
    return {'path':str(path.relative_to(ROOT)),'sha256':sha(path),'document_class':None,'root_placements':placements,'root_is_loader_content_with_no_authored_document_class':True}
def main():
    rawpath=RESULTS/(RUN+'-comparison.json');raw=json.loads(rawpath.read_text());rows={};packages={};inputs={str(rawpath.relative_to(ROOT)):sha(rawpath)}
    for mode in('original','rebuilt'):
        path=RESULTS/(RUN+'-'+mode+'.json');result=json.loads(path.read_text());inputs[str(path.relative_to(ROOT))]=sha(path)
        assert result['summary']['clean_complete']==162 and result['report']['complete'];rows[mode]={r['m']:r for r in result['report']['rows']};packages[mode]=ROOT/result['summary']['package']
    assert {x['module']for x in raw['differences']}=={'Enemy5_v2','Map0_v26'}
    classifications=[];remaining=[]
    for diff in raw['differences']:
        module=diff['module'];assert set(diff['differences'])=={'tree'}
        proof={m:evidence(packages[m],module)for m in packages}
        a=copy.deepcopy(rows['original'][module]['tree']);b=copy.deepcopy(rows['rebuilt'][module]['tree']);classified=[]
        pairs=[('tree.name',a,b)]
        if module=='Enemy5_v2':
            assert len(a['sample'])==len(b['sample'])==1 and a['sample'][0]['type']==b['sample'][0]['type']=='flash.display::Shape'
            pairs.append(('tree.sample[0].name',a['sample'][0],b['sample'][0]))
        for path,left,right in pairs:
            assert re.fullmatch(r'instance\d+',left['name'])and re.fullmatch(r'instance\d+',right['name'])
            classified.append({'path':path,'original':left['name'],'rebuilt':right['name'],'classification':'runtime_generated_instance_name','basis':'Native Loader content root with no document class'if path=='tree.name'else'Unbound native DefineShape2 at depth2; PlaceObject2 HasName bit is zero in both files'})
            left.pop('name');right.pop('name')
        if a!=b:remaining.append({'module':module,'original':a,'rebuilt':b})
        classifications.append({'module':module,'classified_fields':classified,'swf_evidence':proof,'remaining_tree_equal':a==b})
    assert not remaining
    report={'schema':'yzlr2-resource-name-classification-v1','runId':RUN,'inputs':inputs,'raw_difference_modules':2,'classified_runtime_name_fields':sum(len(x['classified_fields'])for x in classifications),'classifications':classifications,'remaining_structural_differences':remaining,'original_clean':162,'rebuilt_clean':162,'scope':'Only these three observed fields classified. Raw comparison preserved. No blanket stripping of names, no assertion of identical allocation counts or full game behavior.'}
    out=RESULTS/(RUN+'-classified-comparison.json');out.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print(json.dumps({k:report[k]for k in ('raw_difference_modules','classified_runtime_name_fields','remaining_structural_differences','original_clean','rebuilt_clean')},indent=2))
if __name__=='__main__':main()
