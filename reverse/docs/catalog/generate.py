#!/usr/bin/env python3
"""Generate developer file/catalog documentation without importing project tools.

Reads tracked files plus nonignored new files in source/tools/docs; never reads
runtime/build/export/private/save trees. Writes only four catalog output files.
AS fields are lexical declarations, not an AS parser or a semantic proof.
"""
from pathlib import Path
from collections import Counter, defaultdict
import ast
import csv
import hashlib
import json
import re
import subprocess
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent
GENERATED = {f'reverse/docs/catalog/{n}' for n in ('files.tsv','modules.md','coverage.json','source-families.md')}
MAIN = '3_L4399Main_gamefile'
CORE = {
'Main':'全局入口、加载/场景/角色生命周期、保存对象装配',
'Strat':'标题界面、新建1P/2P、选择槽位与读取角色',
'LocalSaveManager':'离线SOL初始化与槽位读取/写入',
'SaveXX':'游戏内保存辅助与金币上限处理',
'InitData':'全局状态、增益计时及其保存/恢复',
'TempData':'版本与地图/敌人/资源文件注册',
'ClassLoader':'SWF加载、事件与ApplicationDomain按名取类',
'Load':'地图、DataX、玩家、武器和其他资源分阶段加载',
'NewLoad':'根据皮肤和装备配置动态加载equip资源',
'Data2':'Main内嵌数据与各Factory初始化',
'Data2_data':'内联关卡、怪物和敌人皮肤XML配置',
'GameData':'关卡参数、刷怪、胜负、地图类名与推进',
'Map':'地图层、卷屏、移动与场景结构契约',
'Door':'房间出口及地图转场',
'SelMap':'世界地图/难度/关卡选择',
'Player':'1P控制、属性、技能CD、伤害、移动和外观',
'Player2':'2P控制、属性、伤害、移动和外观',
'Enemy':'敌人实例属性、AI、伤害/死亡、掉落与任务计数',
'EnemySkin':'敌人皮肤及动画配套',
'EnemyLife':'敌人血量显示配套',
'HitXX':'命中目标分派、闪避暴击与伤害调用',
'WinShow':'通关结算、统计、回村/重开及任务通关更新',
'obj':'掉落物拾取与任务/背包更新',
'Play_Interface':'主HUD和面板入口',
'Api_4399_All':'遗留4399平台服务调用封装',
'InData':'DataX的11个XML字符串和Factory初始化',
'TaskData':'任务筛选、条件更新、槽位状态保存与NPC关联',
'TaskFactory':'任务XML解析、定义查询与任务对象创建',
'TaskBasicData':'任务定义字段封装',
'Task':'单任务状态与完成条件判断',
'TaskPanel':'任务列表/介绍/需求及接取提交交互',
'TaskDisplay':'任务展示与奖励对象发放',
'PlayerData':'可持久化角色数据对象',
'Bag':'背包容器与物品增删',
'EquipSlot':'装备槽及装备属性汇总',
'VT':'数值封装及getValue/setValue接口',
'Skin':'角色皮肤与动画配套',
'Skin_WuQi':'武器外观/动画配套',
'Skin_ZhuangBei':'装备外观/动画配套',
'ChongWu':'宠物运行逻辑',
'JingLing':'精灵运行逻辑',
}
XMLS={
'EquipXML':'装备定义','SuitXML':'套装效果','GemXML':'宝石与强化材料',
'GemProbabiltyXML':'强化成功率','GoldXML':'镶嵌/挖空费用',
'SuppliesXML':'消耗品定义','SkillXML':'技能等级数据','SkillConditionXML':'技能学习条件',
'QuestXML':'任务物品（不是任务清单）','OtherXML':'其他道具','makeXml':'制作卷轴与配方',
}
TOP={
'README.md':'当前分支介绍、运行方法、开发导航和验收边界',
'.gitignore':'Git忽略规则，隔离运行环境、构建产物和私人存档',
'.gitattributes':'Git文件处理规则','SHA256SUMS':'原包166文件基线哈希',
'启动游戏.command':'旧原版启动入口和原版存档备份，不运行重建包',
'启动源码重建版.command':'设置Python/日志并调用重建包校验启动器',
'FlashPlayerStandAlone.exe':'随包Windows播放器，不是macOS入口',
'白屏修复-放游戏目录管理员身份运行.cmd':'随包Windows白屏处理脚本，不是Mac入口',
'presets/毕业体验档.sol':'可导入单角色自定义体验预设，不是实时完整存档',
 'tools/graduate-data.json':'毕业体验档生成器所需装备/技能/地图摘录',
}

def family(module):
    if module==MAIN:return '主程序：流程、业务、存档与嵌入数据'
    if module=='DataX_v76':return '数据初始化与相关业务类'
    if module=='DataX_v76-config':return 'DataX可编辑配置，经import-xml进入AS'
    if module.startswith('Map'):return '地图资源/时间轴与附带逻辑'
    if module=='EnemySkill_v7':return '敌人技能资源与附带逻辑'
    if module.startswith('Enemy'):return '敌人动画/资源与附带逻辑'
    if module.startswith('PlayerMc'):return '玩家动画与附带逻辑'
    if module.startswith('equip_'):return '按皮肤/编号动态加载的装备外观'
    if module.startswith('WuQi'):return '武器外观与动画'
    if module.startswith('ShiZhuang'):return '时装外观'
    if module.startswith('ZhuangBei'):return '装备外观'
    return {'Music_v3':'音乐','Card_v17':'图鉴相关资源','ChongWu_v8':'宠物相关资源',
      'VIP_v2':'VIP相关资源','XLUP_v4':'星灵相关资源','YZJH':'计划相关资源'}.get(module,'资源模块（具体行为需查源码/加载点）')


def describe_as(rel,text):
    name=Path(rel).stem
    known=(rel.startswith(('src/','com/hotpoint/braveManIII/')) and name in CORE)
    if known:return CORE[name]+'；本模块副本，实际绑定需查加载域','已核对核心职责；不声明所有模块副本等价'
    if '[Embed(' in text:
        has_frames=bool(re.search(r'function\s+frame\d+\s*\(',text))
        return ('嵌入资源绑定类'+('，含时间轴帧脚本' if has_frames else '')+'；资源见Embed列，行为同时依赖基类'),'声明/Embed提取'
    if '_fla/' in rel or re.search(r'function\s+frame\d+\s*\(',text):
        return '时间轴/帧脚本；需检查addFrameScript、事件与帧标签','路径及方法声明归类'
    if rel.startswith('com/greensock/'):return 'GreenSock动画补间库：'+rel.removeprefix('com/greensock/'),'包名归类，具体接口见方法'
    if rel.startswith('com/adobe/serialization/json/'):return 'JSON解析/编码库：'+name,'包名归类'
    if rel.startswith(('mx/','fl/')):return 'Flash/Flex基础支撑类：'+name,'包名归类'
    if '/repository/' in rel:
        category=rel.split('/repository/')[1].split('/')[0]
        return category+' 配置定义/工厂：'+name,'包名/类名归类，未逐方法人工核证'
    if '/models/' in rel:
        category=rel.split('/models/')[1].split('/')[0]
        return category+' 运行数据/容器对象：'+name,'包名/类名归类，未逐方法人工核证'
    if '/views/' in rel:return '界面或配套状态：'+rel.split('/views/')[1],'包名归类，方法列供定位'
    if rel.startswith('unit4399/'):return '4399平台事件/服务支撑：'+name,'包名归类'
    if rel.startswith('src/npc/'):return 'NPC或NPC面板交互：'+name,'路径归类，具体NPC触发需查调用'
    if rel.startswith('src/tool/'):return '游戏辅助工具：'+name,'路径归类，具体职责需结合方法/调用'
    return '类/接口 '+name+'；具体行为需结合下列方法、基类及引用阅读','声明提取；业务职责未人工确认'


def as_info(text):
    pkg=re.search(r'^\s*package\s*([^\s{]*)',text,re.M)
    classes=re.findall(r'^\s*(?:(?:public|internal|dynamic|final)\s+)*(?:class|interface)\s+([^\s{]+)',text,re.M)
    bases=re.findall(r'\bextends\s+([^\s{]+)',text)
    methods=[]
    for m in re.finditer(r'^\s*(?:(?:public|private|protected|internal|static|override|final|native)\s+)*function\s+((?:(?:get|set)\s+)?[^\s(]+)\s*\(',text,re.M):
        # Count the line containing 'function', not preceding blank indentation.
        start=text.find('function',m.start(),m.end())
        methods.append(m[1]+'@'+str(text.count('\n',0,start)+1))
    embeds=re.findall(r'\[Embed\(([^\]]+)\)\]',text)
    imports=re.findall(r'^\s*import\s+([^;\s]+)',text,re.M)
    return (pkg[1] if pkg else '', '; '.join(classes), '; '.join(dict.fromkeys(bases)),
      '; '.join(methods),'; '.join(x.replace('\n',' ') for x in embeds),'; '.join(imports))


def other_role(path,text):
    if path in TOP:return TOP[path]
    p=Path(path)
    if p.suffix=='.swf' and len(p.parts)==1:return '原始基线SWF；'+family(p.stem)+'；不覆盖'
    if path.startswith('勇士的信仰.app/'):
        if p.name=='launch':return '旧App启动脚本，调用旧启动游戏.command'
        if p.name=='Info.plist':return '旧App应用标识、图标和执行入口元数据'
        if 'Info.before-icon' in p.name:return '换图标前的应用元数据备份'
        return '旧App图标/图标源资源；与业务源码无关'
    if p.suffix=='.py':
        try:return (ast.get_docstring(ast.parse(text)) or 'Python脚本；详见源文件与工具手册').split('\n')[0]
        except SyntaxError:return 'Python文件（解析失败，需人工检查）'
    if p.suffix=='.md':
        m=re.search(r'^#\s+(.+)',text,re.M)
        return '文档：'+(m[1] if m else p.stem)
    if path.startswith('reverse/manifests/'):
        return '结构化来源/审计报告：'+p.stem+'；须按内部摘要和时间定位候选，不能当当前运行状态'
    if path.startswith('reverse/experiments/'):
        kind={'.png':'运行/对照截图','.json':'实验回执/结果/摘要','.patch':'候选补丁文本（不自动应用）','.pcode':'导出ABC指令证据','.as':'实验探针AS源','.xml':'实验布局或数据片段','.log':'历史工具输出'}.get(p.suffix,'实验文本/辅助证据')
        if '.pcode.' in p.name:kind='导出方法指令片段'
        if p.name.endswith('.as.txt'):kind='历史探针AS快照'
        return kind+'：'+p.parent.name+'/'+p.name+'；不是canonical游戏源'
    return '项目辅助文件：'+path+'；具体用途见同目录文档/内容'


def main():
    tracked=set(subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0'))-{''}
    new=set(subprocess.check_output(['git','ls-files','--others','--exclude-standard','-z'],cwd=ROOT).decode().split('\0'))-{''}
    allowed_new={x for x in new if x.startswith(('reverse/source/','reverse/tools/','reverse/docs/')) or x=='README.md'}
    paths=sorted((tracked|allowed_new)-GENERATED)
    records=[];modules=defaultdict(list);families=Counter();class_modules=defaultdict(set);hashes={}
    for path in paths:
        p=ROOT/path
        if not p.is_file():continue
        # Do not resolve ignored runtime paths, or follow arbitrary symlinks.
        if p.is_symlink():continue
        raw=p.read_bytes();suffix=p.suffix.lower()
        text=raw.decode('utf-8',errors='replace') if suffix in {'.as','.py','.md','.xml','.json','.txt','.patch','.pcode','.command','.sh'} else ''
        module=path.split('/')[2] if path.startswith('reverse/source/') else ''
        pkg=classes=bases=methods=embeds=imports='';basis='文件类型/位置与已核对入口'
        if module and suffix=='.as':
            rel='/'.join(path.split('/')[3:]);role,basis=describe_as(rel,text)
            pkg,classes,bases,methods,embeds,imports=as_info(text)
            modules[module].append(path);families[family(module)]+=1
            for cls in classes.split('; '):
                if cls:class_modules[(pkg+'.'+cls).strip('.')].add(module)
            hashes[path]=hashlib.sha256(raw).hexdigest()
        elif module=='DataX_v76-config' and suffix=='.xml':
            e=ET.fromstring(text)
            role=XMLS.get(p.stem,p.stem)+f'；{len(e)}条直接子记录；import-xml后才进入编译'
        else:role=other_role(path,text)
        if suffix=='.json':
            try:
                j=json.loads(text)
                methods='top-level keys: '+', '.join(j.keys()) if isinstance(j,dict) else f'top-level {type(j).__name__}: {len(j)} entries'
            except (ValueError,TypeError):pass
        if suffix=='.py':
            try:methods='; '.join(f'{n.name}@{n.lineno}' for n in ast.parse(text).body if isinstance(n,(ast.FunctionDef,ast.ClassDef,ast.AsyncFunctionDef)))
            except SyntaxError:pass
        path_label=path.replace('\r','\\r').replace('\n','\\n').replace('\t','\\t')
        records.append([path_label,module,role,basis,pkg,classes,bases,methods,embeds,imports,str(len(text.splitlines())) if text else '', 'tracked' if path in tracked else 'new'])
    with (OUT/'files.tsv').open('w',newline='') as f:
        w=csv.writer(f,delimiter='\t',lineterminator='\n')
        w.writerow(['path','module','purpose','evidence_basis','package','class','extends','methods_or_json_keys','embed','imports','text_lines','git_state_at_generation']);w.writerows(records)
    lines=['# 164个SWF模块与对应源码\n\n[返回索引说明](README.md) · [源码指南](../developer-source.md)\n\n每行对应根目录一个原始SWF及其可编辑源码。后缀v数字为资源修订号。source中的同名类不能跨模块无条件合并；查看具体文件请在files.tsv按module筛选。\n\n| 模块／原始SWF | 源码目录 | AS文件数 | 用途 |\n| --- | --- | ---: | --- |\n']
    for module,files in sorted(modules.items()):
        lines.append(f'| [{module}.swf](../../../{module}.swf) | [{module}](../../source/{module}/) | {len(files)} | {family(module)} |\n')
    (OUT/'modules.md').write_text(''.join(lines))
    dup=sorted(((k,len(v)) for k,v in class_modules.items() if len(v)>1),key=lambda x:(-x[1],x[0]))
    s=['# 源文件家族与重复类\n\n[返回索引说明](README.md)\n\n以下由实际文件和声明统计。同名只表示声明名重复，不表示内容相同或运行时同一类。\n\n| 模块家族 | AS文件数 |\n| --- | ---: |\n']
    s += [f'| {k} | {v} |\n' for k,v in sorted(families.items())]
    s += ['\n## 出现模块数最多的同名类（前40项）\n\n| 类名 | 模块数 |\n| --- | ---: |\n']+[f'| `{k}` | {v} |\n' for k,v in dup[:40]]
    (OUT/'source-families.md').write_text(''.join(s))
    coverage={'schema':'developer-file-index-v1','indexed_files':len(records),'source_as_files':sum(map(len,modules.values())),
      'swf_modules':len(modules),'config_xml_files':sum(1 for x in records if x[1]=='DataX_v76-config' and x[0].endswith('.xml')),
      'tool_python_files':sum(1 for x in records if x[0].startswith('reverse/tools/') and x[0].endswith('.py')),
      'excluded_generated_files':sorted(GENERATED),'tracked_missing_on_disk':[x for x in sorted(tracked-GENERATED) if not (ROOT/x).is_file()],
      'canonical_as_tree_sha256':hashlib.sha256(json.dumps(hashes,sort_keys=True,separators=(',',':')).encode()).hexdigest(),
      'duplicate_class_names_across_modules':len(dup),
      'scope':'tracked files plus nonignored new source/tools/docs; ignored assets/build/runtime/private saves excluded; lexical metadata is not semantic proof'}
    (OUT/'coverage.json').write_text(json.dumps(coverage,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:coverage[k] for k in ('indexed_files','source_as_files','swf_modules','config_xml_files','tool_python_files','tracked_missing_on_disk')},ensure_ascii=False))

if __name__=='__main__':main()
