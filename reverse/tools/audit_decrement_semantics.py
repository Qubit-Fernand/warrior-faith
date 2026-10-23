#!/usr/bin/env python3
"""Audit the seven subtract-by-one sites in five previously flagged methods."""
from pathlib import Path
import hashlib,json,math,re
ROOT=Path(__file__).resolve().parents[2]
BASE=ROOT/'reverse/build/main-audit'
FRESH=ROOT/'reverse/build/decrement-audit/rebuilt96ce'
SWF=ROOT/'reverse/build/main-probe/run-39691ycz/normalized.swf'
HASH='96ce6635d3ad0868d83f0fcbe74890a3ef7dedbcf4046d5619b417a0b7b458ba'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def method(p,name):
    text=p.read_text();m=re.search(r'function '+re.escape(name)+r'\(',text);end=text.index('end ; code',m.end());part=text[m.start():end];start=re.search(r'^\s*code\s*$',part,re.M)
    offset=m.start()+start.end();return [{'line':text.count('\n',0,offset+x.start())+1,'code':x.group().strip()}for x in re.finditer(r'[^\n]+',text[offset:end])if x.group().strip() and not x.group().strip().startswith('debug')]
def op(row):return row['code'].split()[0]
def local(row,n):return row['code'] in ('getlocal '+str(n),'getlocal'+str(n))
def context(lines,index):return lines[max(0,index-4):index+5]
def main():
    assert sha(SWF)==HASH
    specs=[('src/Player','runPower',3),('src/Player','MoveData',1),('src/Player','MoveRun',1),('com/hotpoint/braveManIII/models/equip/Equip','setRemainingTime',1),('com/hotpoint/braveManIII/models/equip/Equip','setSysTime',1)]
    rows=[]
    for cls,name,count in specs:
        paths={'original':BASE/'original/scripts'/f'{cls}.pcode','rebuilt':FRESH/'scripts'/f'{cls}.pcode'}
        assert paths['rebuilt'].read_bytes()==(BASE/'rebuilt/scripts'/f'{cls}.pcode').read_bytes()
        codes={k:method(p,name)for k,p in paths.items()};a=codes['original'];b=codes['rebuilt']
        old=[i for i,x in enumerate(a)if op(x)=='subtract'and i and a[i-1]['code']=='pushbyte 1']
        if name in ('runPower','MoveData'):
            new=[i for i,x in enumerate(b)if op(x)=='decrement'and ('"length"' in b[i-1]['code'] or name=='runPower' and local(b[i-1],3))]
        elif name=='MoveRun':new=[i for i,x in enumerate(b)if op(x)=='decrement'and b[i+1]['code']=='pushtrue']
        else:new=[i for i,x in enumerate(b)if op(x)=='decrement']
        assert len(old)==len(new)==count,(name,len(old),len(new))
        pairs=[]
        for oi,ni in zip(old,new):
            # No branch target label lies between pushing constant 1 and subtract.
            assert a[oi-1]['code']=='pushbyte 1' and b[ni]['code']=='decrement'
            assert op(a[oi-2]).startswith(('getlocal','getproperty'))
            pairs.append({'original_context':context(a,oi),'rebuilt_context':context(b,ni),'original_pair_contiguous_without_internal_label':True,'integer_opcode_used':False})
        rows.append({'class':cls.replace('/','.'),'method':name,'sites':pairs,'input_files':{k:{'path':str(p.relative_to(ROOT)),'sha256':sha(p)}for k,p in paths.items()},'original_subtract':sum(op(x)=='subtract'for x in a),'rebuilt_subtract':sum(op(x)=='subtract'for x in b),'whole_method_equivalence_proven':False})
    samples=[-math.inf,-2**53,-2**31,-1.5,-1,-0.0,0.0,0.5,1,2,3,4,12,2**31-1,2**31,2**32-1,2**53,math.inf,math.nan]
    vectors=[]
    for value in samples:
        # Both AVM2 non-_i operations are defined on ToNumber; these are expected
        # values for a future AVM run, not a second independent VM implementation.
        expected=float(value)-1.0
        vectors.append({'input':repr(value),'number_result':repr(expected),'signed_int32_wrap_would_differ':value==-2**31})
    assert float(-2**31)-1.0==-2147483649.0
    report={'schema':'yzlr2-decrement-semantics-v1','rebuilt_swf':str(SWF.relative_to(ROOT)),'rebuilt_swf_sha256':sha(SWF),'method_count':5,'site_count':sum(len(r['sites'])for r in rows),'methods':rows,'numeric_expectation_vectors':vectors,'scope':'Local non-_i subtract-by-one versus decrement proof and operand/use-site evidence, not full CFG or property-binding equivalence. Vectors use host IEEE-754, not executed AVM2.','player_started':False,'save_accessed':False}
    (ROOT/'reverse/manifests/decrement-semantics.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print(json.dumps({'method_count':5,'site_count':report['site_count'],'vectors':len(vectors),'swf':HASH},indent=2))
if __name__=='__main__':main()
