from pathlib import Path
import json
root=Path(__file__).resolve().parent.parent
story=json.loads((root/'mod/story.json').read_text())
assert len(story['chapters'])==3 and set(story['endings'])=={'guardian','dawn'}
for chapter in story['chapters']:
 assert chapter['hp']>0 and chapter['room']>0
 for field in ['before','after']:
  assert all(len(p)==2 and all(isinstance(x,str) and x for x in p) for p in chapter[field])
out=root/'.runtime/epilogue-generated';out.mkdir(exist_ok=True)
payload=json.dumps(json.dumps(story,ensure_ascii=False),ensure_ascii=False)
(out/'StoryData.as').write_text('package { public class StoryData { public static const JSON_TEXT:String = '+payload+'; } }\n')
