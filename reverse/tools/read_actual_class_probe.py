#!/usr/bin/env python3
"""Read only an explicitly named dedicated actual-class probe SOL; never write SOL."""
from pathlib import Path
import argparse,hashlib,json,sys
ROOT=Path(__file__).resolve().parents[2]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 ap=argparse.ArgumentParser();ap.add_argument('sol',type=Path);ap.add_argument('--package',required=True,type=Path);a=ap.parse_args();package=a.package.resolve();assert package.parent==ROOT/'reverse/build/actual-class-harness'
 config=json.loads((package/'fixture.json').read_text());assert sha(package/'ActualClassHarness.swf')==config['wrapperSHA256'];assert sha(package/'subject-library.swf')==config['librarySHA256']
 name='yzlr2_actual_class_'+config['mode']+'_'+config['subjectSHA256'][:12]+('_'+config['wrapperSHA256'][:8]if config.get('probeFormat')=='json-v3'else'');p=a.sol.expanduser().resolve();assert p.suffix=='.sol';data=p.read_bytes();assert len(data)<250000
 # macOS projector may split the logical SO name across '#/' path components.
 # The caller supplies an explicit probe path; authenticate its internal SOL
 # header before decoding any report instead of assuming a flat basename.
 assert data[:2]==b'\0\xbf'and data[6:16]==b'TCSO\0\x04\0\0\0\0'
 n=int.from_bytes(data[16:18],'big');assert data[18:18+n].decode()==name,'Not the requested dedicated probe SO'
 sys.path.insert(0,str(ROOT/'tools'));from sol import loads,Obj,Arr
 internal,fields=loads(data);assert internal==name and set(fields)in ({'report'},{'json'})
 def plain(v):
  if isinstance(v,Obj):return {k:plain(x)for k,x in v.fields.items()}
  if isinstance(v,Arr):assert not v.assoc;return [plain(x)for x in v.dense]
  return v
 report=json.loads(fields['json'])if'json'in fields else plain(fields['report']);assert report['schema']=='yzlr2-actual-class-result-v1'and report['config']==config
 rows=report['rows'];passed=sum(r['passed']for r in rows);assert passed==report['passed'];assert len(rows)<=183
 summary={'mode':config['mode'],'subject_sha256':config['subjectSHA256'],'observed':len(rows),'passed':passed,'total_expected':183,'fatal':report['fatal'],'complete':report['complete'],'all_passed':report['complete']and len(rows)==183 and passed==183 and not report['fatal'],'source_sol_sha256':sha(p),'wrapper_sha256':config['wrapperSHA256'],'scope':'Actual original/rebuilt game class execution with synthetic local records in ABC-identical library; 172 nonstacking container cases and11 achievement paths. Does not cover SetKeyPanel or normal game lifecycle.'}
 out=ROOT/'reverse/experiments/actual-class-harness/results';out.mkdir(exist_ok=True);target=out/(config['mode']+'-'+config['subjectSHA256'][:12]+'-'+config['wrapperSHA256'][:8]+'.json');target.write_text(json.dumps({'summary':summary,'report':report},ensure_ascii=False,indent=2)+'\n');print(json.dumps(summary,ensure_ascii=False,indent=2));print(target)
if __name__=='__main__':main()
