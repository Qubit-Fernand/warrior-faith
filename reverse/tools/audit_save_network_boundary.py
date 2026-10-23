#!/usr/bin/env python3
"""Source-only inventory of save fields and external-call boundaries; reads no saves."""
from pathlib import Path
import hashlib,json,re,datetime
ROOT=Path(__file__).resolve().parents[2]
MAIN=ROOT/'reverse/source/3_L4399Main_gamefile'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def section(text,name):
    m=re.search(r'function '+name+r'\(',text);n=re.search(r'\b(?:public|private|protected|internal)\s+(?:static\s+)?function\b',text[m.end():]);end=m.end()+n.start()if n else len(text);return m.start(),text[m.start():end]
def main():
    path=MAIN/'src/Main.as';text=path.read_text();fields={}
    for name in('Save2','applySaveObject'):
        offset,part=section(text,name);fields[name]=[{'field':m[1],'line':text.count('\n',0,offset+m.start())+1}for m in re.finditer(r'save\["([^"+]+)"\]',part)]
    aliases=[{'name':m[1],'class_expression':m[2],'line':text.count('\n',0,m.start())+1}for m in re.finditer(r'registerClassAlias\("([^"]+)",([^;]+)\);',text)]
    calls=[];inputs={str(path.relative_to(ROOT)):sha(path)}
    pattern=re.compile(r'(SharedObject\.(?:getLocal|getRemote)\(|\b(?:navigateToURL|sendToURL)\(|\bnew (?:URLRequest|URLLoader|Socket|NetConnection)\(|ExternalInterface\.(?:call|addCallback)\(|Main\.serviceHold\.\w+\(|urlLoader\.load\()')
    for path in sorted(MAIN.rglob('*.as')):
        source=path.read_text()
        for line,code in enumerate(source.splitlines(),1):
            if pattern.search(code):calls.append({'path':str(path.relative_to(ROOT)),'line':line,'code':code.strip()});inputs[str(path.relative_to(ROOT))]=sha(path)
    for relative in('src/LocalSaveManager.as','src/Strat.as','com/hotpoint/braveManIII/views/taskPanel/TaskData.as','com/hotpoint/braveManIII/models/task/Task.as'):
        path=MAIN/relative;inputs[str(path.relative_to(ROOT))]=sha(path)
    report={'schema':'yzlr2-save-network-boundary-v1','utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'inputs':inputs,'literal_save_fields':fields,'dynamic_player_fields':['p1','p2 (when P1P2 is true)'],'amf_aliases':aliases,'source_boundary_sites':calls,'scope':'Main module source inventory only. Host methods may perform network outside these sources. Declaration/string presence is not proof of reachability; absence of literal calls is not whole-program noninterference. No save file read, no API invoked.','save_accessed':False,'network_service_contacted':False,'player_started':False}
    (ROOT/'reverse/manifests/save-network-boundary.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');print(json.dumps({'literal_written_fields':len(set(x['field']for x in fields['Save2'])),'literal_read_fields':len(set(x['field']for x in fields['applySaveObject'])),'aliases':len(aliases),'boundary_sites':len(calls)},indent=2))
if __name__=='__main__':main()
