#!/usr/bin/env python3
"""Two old Achievement variants: preserve logging while fixing loop control."""
from pathlib import Path
import inspect,json,re,hashlib,time
import audit_continue_copies as audit
from audit_continue_loops import execute
from audit_shop_cfg import prop
ROOT=Path(__file__).resolve().parents[2];sha=lambda b:hashlib.sha256(b).hexdigest()
s=inspect.getsource(execute).replace('trace=[];calls=[]','trace=[];calls=[];log_calls=[]')
s=s.replace("  elif op=='pushtrue':", "  elif op=='pushstring':stack.append(json.loads(s.split(' ',1)[1]))\n  elif op=='add':\n   b=stack.pop();a=stack.pop();assert type(a) in (str,int,float) and type(b) in (str,int,float)\n   stack.append((str(a)+str(b)) if type(a)is str or type(b)is str else a+b)\n  elif op=='pushtrue':")
s=s.replace("elif op=='findpropstrict':assert prop(s)in ('getGoodsId','getTs','isRy','dbNum');stack.append(state)","elif op=='findpropstrict':\n   n=prop(s);assert n in ('getGoodsId','getTs','isRy','dbNum','trace');stack.append('trace'if n=='trace'else state)")
s=s.replace("  elif op=='callproperty':", "  elif op=='callpropvoid':\n   assert prop(s)=='trace';argc=int(re.search(r',\\s*(\\d+)$',s)[1]);args=[stack.pop()for _ in range(argc)][::-1];assert stack.pop()=='trace';log_calls.append(args)\n  elif op=='callproperty':")
s=s.replace("'termination':'return'", "'trace_calls':log_calls,'termination':'return'")
env={'re':re,'json':json,'prop':prop};exec(s,env);audit.execute=env['execute']
results=[audit.one((m,audit.SPECS))for m in ('Enemy20','Enemy202')]
# Other continue updater touches only other modules; wait to document its exclusions.
while not (ROOT/'reverse/manifests/continue-copy-repair-applied.json').exists():time.sleep(5)
report={'schema':1,'scope':'Actual original P-code finite fixtures with trace recorded as an external logging call. All original source trace expressions/arguments preserved byte-for-byte; loop branch/increment restoration only. No whole-method/runtime proof.','model_source':s,'modules':results,'fixture_count':sum(len(r['fixtures'])for m in results for r in m['methods'])}
out=ROOT/'reverse/manifests/trace-continue-copies-proof.json';assert not out.exists();out.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');files=[]
for mod in results:
 for r in mod['methods']:
  p=ROOT/r['source'];raw=p.read_bytes();a=r['before_method'].encode();b=r['after_method'].encode();assert raw.count(a)==1
  traces=lambda t:[x.strip()for x in t.decode().splitlines()if 'trace('in x]
  assert traces(a)==traces(b)
  new=raw.replace(a,b,1);assert b'\n'not in new.replace(b'\r\n',b'');p.write_bytes(new);files.append({'path':r['source'],'method':r['method'],'before_sha256':sha(raw),'after_sha256':sha(new),'trace_source_lines_equal':True})
(ROOT/'reverse/manifests/trace-continue-copies-applied.json').write_text(json.dumps({'schema':1,'proof_sha256':sha(out.read_bytes()),'files':files,'applied':True,'recompiled':False},ensure_ascii=False,indent=2)+'\n');print('Enemy20/Enemy202 four methods,36 fixtures,all trace source preserved',flush=True)
