#!/usr/bin/env python3
"""One explicit diagnostic-SOL read; no polling, game mutation or live-SOL write."""
import argparse,hashlib,json,sys,time
from pathlib import Path
from datetime import datetime,timezone
from urllib.parse import unquote
ROOT=Path(__file__).resolve().parents[2]
NAME='yzlr2_diagnostic_probe'
def sha(data):return hashlib.sha256(data).hexdigest()
def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('source',type=Path);p.add_argument('output',type=Path);p.add_argument('--runtime',type=Path,required=True);p.add_argument('--expected-amount');a=p.parse_args()
 source=a.source.expanduser().resolve();output=a.output.resolve();runtime=a.runtime.resolve()
 assert source.name==NAME+'.sol','Only explicit diagnostic SOL accepted'
 assert output.is_relative_to(ROOT/'reverse/experiments/diagnostic-harness/results') or output.is_relative_to(ROOT/'reverse/experiments/final-runtime')
 meta=output.with_name(output.stem+'-capture.json');assert not output.exists() and not meta.exists(),'Refusing to replace historical captures'
 before=source.stat();assert before.st_size<=100000;data=source.read_bytes();after=source.stat()
 assert (before.st_size,before.st_mtime_ns)==(after.st_size,after.st_mtime_ns),'Diagnostic file changed during read; request another explicit capture'
 assert time.time()-after.st_mtime<15,'Diagnostic file stale; no polling was attempted'
 assert data[:2]==b'\0\xbf' and data[6:16]==b'TCSO\0\x04\0\0\0\0';size=int.from_bytes(data[16:18],'big');assert data[18:18+size].decode()==NAME
 sys.path.insert(0,str(ROOT/'tools'));from sol import loads
 name,fields=loads(data);assert name==NAME and set(fields)=={'payload'}
 report=json.loads(fields['payload']);assert report['schema']=='yzlr2-diagnostic-v1' and report['wrapperVersion']==5
 assert 0<len(report['samples'])<=24 and len(report['errors'])<=8 and len(report.get('observerErrors',[]))<=8
 assert unquote(report['wrapper'])==unquote((runtime/'DiagnosticHarness.swf').as_uri()),'Not the requested runtime wrapper'
 assert unquote(report['loadedURL'])==unquote((runtime/'3_L4399Main_gamefile.swf').as_uri()),'Not the requested runtime main'
 sample=report['samples'][-1];amount=[f for f in (sample.get('uiText') or {}).get('fields',[]) if f.get('targetAmount')]
 if a.expected_amount is not None:
  assert len(amount)==1 and amount[0]['text']==a.expected_amount and amount[0]['originalLength']==len(a.expected_amount) and not amount[0]['textTruncated'],'Expected complete amount field absent or different'
 output.parent.mkdir(parents=True,exist_ok=True)
 encoded=(json.dumps(report,ensure_ascii=False,indent=2)+'\n').encode();output.write_bytes(encoded)
 receipt={'schema':'yzlr2-explicit-diagnostic-capture-v1','captured_utc':datetime.now(timezone.utc).isoformat(),'source_name':NAME+'.sol','source_bytes':len(data),'source_sha256':sha(data),'source_mtime_ns':after.st_mtime_ns,'runtime':str(runtime.relative_to(ROOT)),'output':str(output.relative_to(ROOT)),'output_sha256':sha(encoded),'last_sequence':sample['sequence'],'sample_ms':sample['ms'],'sample_partial':sample.get('partial'),'target_amount':amount,'expected_amount':a.expected_amount,'game_errors':report['errors'],'observer_errors':report.get('observerErrors',[]),'source_read_only':True,'polling':False,'ui_operated':False,'no_game_sol_read':True}
 meta.write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n');print(json.dumps({'output':str(output),'sequence':sample['sequence'],'partial':sample.get('partial'),'amount':[f['text'] for f in amount],'game_errors':len(report['errors']),'observer_errors':len(report.get('observerErrors',[]))},ensure_ascii=False))
if __name__=='__main__':main()
