#!/usr/bin/env python3
"""Two isolated optimize=false compilations; never changes the official candidate."""
import hashlib,json,subprocess,tempfile,time,sys
from pathlib import Path
from probe_normalize_swf import normalize
from swf_inventory import abc_inventory,read_swf,walk_tags
ROOT=Path(__file__).resolve().parents[2]
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def tree(path):return {str(p.relative_to(path)):sha(p) for p in sorted(path.rglob('*')) if p.is_file()}
def inventory(path):
    raw,body,header=read_swf(path)
    abcs=[p[p.index(b'\0',4)+1:] for t,p in walk_tags(body,header['tag_start']) if t['code']==82]
    assert abcs
    return [abc_inventory(abc) for abc in abcs]
def main():
    receipt=ROOT/'reverse/build/main-probe/build-all.json';baseline=json.loads(receipt.read_text())
    source=ROOT/'reverse/build/main-probe/source';before=tree(source);receipt_sha=sha(receipt)
    out=Path(sys.argv[1]).resolve() if len(sys.argv)>1 else Path(tempfile.mkdtemp(prefix='main-optimize-false-',dir=ROOT/'reverse/build'))
    assert out.parent==ROOT/'reverse/build' and out.name.startswith('main-optimize-false-')
    report={'experiment':'compiler optimize=false, two actual builds; not an official build receipt',
        'source_receipt':str(receipt.relative_to(ROOT)),'source_receipt_sha256':receipt_sha,
        'staging':str(source.relative_to(ROOT)),'staging_files':before,'runs':[],
        'player_started':False,'canonical_modified':False,'formal_candidate_modified':False}
    for number in (1,2):
        run=out/('run-'+str(number));run.mkdir(exist_ok=True)
        raw=run/'raw.swf';normalized=run/'normalized.swf'
        command=[x for x in baseline['command'] if not x.startswith(('-output=','-compiler.optimize='))]
        command[-1:-1]=['-compiler.optimize=false','-output='+str(raw)]
        start=time.monotonic()
        resumed=raw.is_file()
        if not resumed:
            with (run/'compile.log').open('w') as log:
                result=subprocess.run(command,cwd=ROOT,stdout=log,stderr=subprocess.STDOUT,timeout=360)
            assert result.returncode==0
        assert raw.is_file() and 'Error:' not in (run/'compile.log').read_text()
        normalization=normalize(raw,normalized,ROOT/'3_L4399Main_gamefile.swf')
        data=inventory(normalized)
        (run/'abc.json').write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n')
        report['runs'].append({'run':str(run.relative_to(ROOT)),'command':command,'returncode':0,
            'resumed_existing_raw_after_inventory_assumption_failure':resumed,
            'seconds':round(time.monotonic()-start,3),'normalization':normalization,
            'normalized_sha256':sha(normalized),'abc_blocks':len(data),
            'classes':sum(len(d['classes']) for d in data),'methods':sum(len(d['methods']) for d in data)})
        assert before==tree(source), 'Official staging changed during experiment'
        assert receipt_sha==sha(receipt), 'Official receipt changed during experiment'
    report['normalized_byte_equal']=report['runs'][0]['normalized_sha256']==report['runs'][1]['normalized_sha256']
    report['staging_unchanged']=True;report['official_receipt_unchanged']=True
    (out/'report.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({'directory':str(out),'normalized_byte_equal':report['normalized_byte_equal'],
        'hashes':[r['normalized_sha256'] for r in report['runs']]},ensure_ascii=False,indent=2))
if __name__=='__main__':main()
