#!/usr/bin/env python3
"""Exercise real input mutation detection without changing game/toolchain inputs."""
import json,os,sys,tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(ROOT/'reverse/tools'))
from build_inputs import capture,finish,verify
r=Path(tempfile.mkdtemp(prefix='fingerprint-test-',dir=ROOT/'reverse/build'));src=r/'source';src.mkdir();asset=r/'assets';asset.mkdir()
(src/'Example.as').write_text('package {public class Example{}}');(asset/'a.xml').write_text('<a/>');recipe=r/'recipe.py';recipe.write_text('pass\n')
s=capture('equip_1_18',src,extra_trees=[asset],recipe_files=[recipe]);checks=[]
def check(label,condition):
 checks.append({'case':label,'pass':bool(condition)})
 assert condition,label
check('unchanged accepted',not verify(s));check('finish marks actual postcheck',finish(s)['post_build_verified'])
(asset/'a.xml').write_text('<changed/>');check('asset content change rejected',any('changed:'in x for x in verify(s)))
try:finish(s)
except ValueError:check('during-build mutation rejected by finish',True)
else:raise AssertionError('finish accepted changed input')
(asset/'a.xml').write_text('<a/>');check('restored identical bytes accepted',not verify(s))
(asset/'extra.xml').write_text('<extra/>');check('asset added rejected',any('added:'in x for x in verify(s)));(asset/'extra.xml').rename(r/'extra-preserved.xml')
(asset/'a.xml').rename(r/'a-preserved.xml');check('asset removed rejected',any('removed:'in x for x in verify(s)));(r/'a-preserved.xml').rename(asset/'a.xml')
recipe.write_text('raise RuntimeError()\n');check('recipe changed rejected',any('changed:'in x for x in verify(s)));recipe.write_text('pass\n')
prior=os.environ.get('JAVA_TOOL_OPTIONS');os.environ['JAVA_TOOL_OPTIONS']='-Dfingerprint_test=1';check('Java environment changed rejected',any('environment changed'in x for x in verify(s)))
if prior is None:os.environ.pop('JAVA_TOOL_OPTIONS')
else:os.environ['JAVA_TOOL_OPTIONS']=prior
check('restored inputs pass postcheck',finish(s)['post_build_verified'])
report={'scope':'Actual temporary inputs; stable game/toolchain files untouched. Files preserved using moves, no deletion.','module_input_files':len(s['files']),'toolchain_manifest':s['toolchain_manifest'],'checks':checks,'pass':all(x['pass']for x in checks)}
(ROOT/'reverse/experiments/module-probe/input-fingerprint-tests.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
