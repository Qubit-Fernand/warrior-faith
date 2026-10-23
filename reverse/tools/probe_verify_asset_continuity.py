#!/usr/bin/env python3
"""Show that root restoration leaves previously rebuilt equipment art unchanged.

Compare final dictionary tags and non-root linkage mapping against the immediately
preceding archived compiler SWC. This is structural continuity, not a fresh render.
"""
import argparse,hashlib,json,zipfile
from pathlib import Path
from probe_rebuild_module import ROOT,BUILD,SOURCES,sha
from probe_normalize_swf import normalize
from probe_root_timeline import parts,bindings
from swf_inventory import CHARACTER_TAGS
ART=CHARACTER_TAGS|{8,13,62,73,74,78,88}
def digest(path):
 ts=parts(path)[3]
 return {'dictionary_tags':[(c,hashlib.sha256(x).hexdigest())for c,x in ts if c in ART], 'nonroot_linkages':{n:i for n,i in bindings(ts).items()if i}}
def main():
 results=[]
 for original in sorted(ROOT.glob('equip*.swf')):
  mod=original.stem;d=BUILD/mod;receipt=json.loads((SOURCES/mod/'result.json').read_text());assert receipt['root_timeline']['verified'];target=ROOT/receipt['output'];assert sha(target)==receipt['output_sha256']
  archives=sorted(d.glob('compile-*.swc'),key=lambda x:x.stat().st_mtime_ns);assert len(archives)>=4
  old=archives[-3];tmp=d/'previous-art-check-raw.swf';fixed=d/'previous-art-check-normalized.swf'
  with zipfile.ZipFile(old)as z:tmp.write_bytes(z.read('library.swf'))
  normalize(tmp,fixed,original)
  before=digest(fixed);after=digest(target);passed=before==after
  results.append({'module':mod,'prior_compiler_archive':str(old.relative_to(ROOT)),'prior_archive_sha256':sha(old),'prior_normalized_sha256':sha(fixed),'final_sha256':sha(target),'dictionary_tag_count':len(after['dictionary_tags']),'dictionary_and_nonroot_linkages_equal':passed})
  assert passed,mod
 report={'scope':'Equipment root restoration continuity against immediately preceding compiler SWCs. Prior frame-render report predates this pass; these identical dictionary bytes and linkage IDs require no fresh asset render. Does not assert runtime root behavior.','results':results,'pass':all(x['dictionary_and_nonroot_linkages_equal']for x in results)}
 (SOURCES/'equipment-root-asset-continuity.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print('PASS',len(results),'equipment asset dictionaries unchanged')
if __name__=='__main__':main()
