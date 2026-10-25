# 在恢复源码上扩展章节

本文只描述原版5.6已核实的入口和建议修改顺序，不新增剧情或修改游戏源码。路径均相对项目根目录；下文 `MAIN/` 指 `reverse/source/3_L4399Main_gamefile/`，`TASK/` 指其 `com/hotpoint/braveManIII/`。方法名和行号来自当前恢复源，后续修改后应以方法定位。

当前工程可以修改 ActionScript 并重建164个SWF；这不等于已经恢复原作者的 FLA、美术工程、关卡编辑器或全部玩法的语义证明。新增章节先复用已验证的地图/角色/界面资源，以小步修改隔离构建验证。新增美术和时间轴属于另一条资源编辑路线，需要独立补齐 SymbolClass、实例名、帧脚本和依赖审计。

## 哪些文件是编辑入口

| 内容 | 当前入口 | 使用者与边界 |
|---|---|---|
| 主逻辑、任务逻辑、地图/敌人数值 | `MAIN/` 下 AS | 已纳入源码指纹；编译时复制到固定 staging，勿改 `reverse/build/` 中间文件 |
| 地图/怪物/皮肤资源类逻辑 | `reverse/source/Map*/`、`Enemy*/`、各装备模块 AS | 大量类是资源绑定类；修改原逻辑的实际模块，而不是随便改重复的 src.Main 副本 |
| 装备、技能、任务物品等11份 DataX XML | `reverse/source/DataX_v76-config/*.xml` | 编辑后必须 `datax_source.py import-xml` 才进入 `reverse/source/DataX_v76/src/InData.as`；普通构建不自动导入 |
| 主线/每日任务清单 | 原始嵌入 `reverse/exports/3_L4399Main_gamefile/scripts/_assets/8632_src.Data2_taskData.bin` | 实际为UTF-8 XML；`MAIN/src/Data2_taskData.as:5` Embed，`Data2.as:31` 公开 taskData，TaskFactory解析。当前尚没有与 DataX 相同的 canonical XML 导入入口 |
| 图形/动画/按钮/音效/字体及其他嵌入数据 | 各模块 `reverse/exports/<module>/scripts/_assets/` | 这是忽略 Git 的导出输入，受到构建指纹保护；重新导出会覆盖。不要把直接改这里当成已经可维护的章节补丁 |

要正式改任务 XML，建议先把它迁入受版本控制的专用配置目录，建立显式导入/暂存覆盖流程，并让 `build_inputs.py` 和构建 recipe 记录新输入；保留原始导出供对照。**这是待实现的工程建议**，不能假定当前脚本自动读取 `taskData.xml`。`build_main.py` 目前先复制 tracked AS，再从 RAW 导出树复制所有非AS资源，因此仅把同名资产放进 source 目录仍可能被原导出覆盖。

DataX 中的 `QuestXML.xml` 是任务物品表，由 QuestFactory 使用；它不是上述167条任务的清单。不要把任务条目塞进 QuestXML。

## 任务、叙事与结局入口

`TASK/repository/task/TaskFactory.as:224` 的 `xmlLoaded()` 将 `<任务>` 读入 TaskBasicData/allTask；字段包括 ID、名称、级数、介绍、需求、大/小类型、委托人、前置任务ID、重生条件、完成条件及奖励。`TaskBasicData.creatTaskBasicData():82` 把数值封装成 VT，把逗号分隔字段变成平行数组。

原叙事呈现可追踪到 `TASK/views/taskPanel/TaskPanel.as:350,385–386`：任务列表显示名称，详情显示 `getTaskIntroduction()` 和 `getDemand()`。这证明介绍/需求可作为章节文字入口；它不是一个已发现的通用多轮对话树或过场脚本系统。NPC资源和主程序的面板另行绑定：例如 `reverse/source/Map0_v26/src/npc/村长.as:15–21` 注册CLICK并打开 `src.npc.村长任务界面`，后者还管理送礼/好感度。不能把“村长有界面”推断成所有剧情都在那里。

任务流程必须同时检查：

1. `TaskData.stateNpc()/levelOk()/reOk()/qzOk()` 决定可显示集合；`qzOk():512` 只把前置 `-1` 当作无前置，其他值调用 `isOldById():541` 检查该任务 oldTime>0。添加一个 XML 条目不等于它一定显示。
2. `TaskPanel` 接取设置 state=1（627）；提交按类型设 state=0或3并增加oldTime（644–655）；`Task.isTaskOk():598` 聚合地图、难度、击杀、物品、等级、金币、时间、连击、被打、通关、好感和排行榜条件，设state=2或1。
3. `GameData.GetData():63` 调 `TaskData.initGk()`；其686–719行只在小关1初始化地图/星级记录。`Enemy.as:512–513,573–574` 更新击杀并检查任务；`obj.as:130–131` 更新拾取；`WinShow.as:61–62` 标记通关并检查任务。
4. `TaskDisplay.awObj():175` 奖励类型1=EquipFactory，2=GemFactory，3=SuppliesFactory，4=OtherFactory。对应 ID 必须在正确表里存在；类型、ID、数量、概率数组要对齐。这里只核实映射，不把“长度正确”当成奖励对象可成功生成。

完成条件的字段名也不能脱离代码理解：`Task.yhdOk():570` 用 npc 作为 `InitData.qinMiDu_Arr` 的索引读取好感度，不代表“点击这个NPC”；时间/连击/被打检查（422–458）读取 WinShow.txt_1/2/3，而不是 Task 内那些重置但未参与判断的私有计数。需要对话完成或新战斗统计条件时应显式实现，不能只填XML字段名。

新增最终章节建议先明确“旧主线完成后解锁的任务链→进入指定地图→指定Boss/通关条件→提交奖励与结局呈现”。这些环节有原版入口，但最终任务ID、原故事的正式终点和新结局表现必须另行设计，本文不据数字大小推断故事顺序。若需要自动结局演出，应新增独立逻辑并以完成事件驱动；原版任务介绍字段本身不支持完整演出。不要靠每次读档重复发奖励实现结局。

## 地图、刷怪、掉落的对应关系

`MAIN/src/_data/Data2_data.as` 中 `关卡数据1/2/3/4` 分别赋值 `GameData.GameDataXmlArr[1..4]`（18、4578、9092、13606行），代表按 `GameData.gameLV` 选择的配置组。每条 `<关卡>` 以大关/小关匹配；`GameData.GetData():55–104` 读取预留1→过关条件、同屏数量、刷怪频率、总数、BossID、30个固定怪物ID和5个随机ID。刷怪频率乘 `Main.fps`，所以配置5不是5帧。`MonsterGo()`、`WhoAreYou()`、`Win()` 决定实际生成和胜利，修改房间数量后必须检查它们与地图出口。

同文件 `EnemyXML_1/2/3/4`（15360、23628、31896、40164行）赋值 `Enemy.EnemyXmlArr[1..4]`，包括HP/攻击/防御/经验/金钱、20组普通掉落与特殊掉落等；EnemySkinXML族定义皮肤和动作参数。`MAIN/src/Enemy.as:222–262` 读取数值/掉落，`装备掉落():596`、`掉落物品计算():648`、`任务品掉落():1171` 消费。普通掉落概率由累积权重逻辑使用，不应未经核查把所有数字解释为百分比。任务物品另经 QuestFactory/特殊任务分支；`TaskData.tsTaskArr` 和任务210002对 OtherFactory 有专门处理。

地图可见性与配置是分开的：`MAIN/src/TempData.as:31–55` 建立 Load.mapArr/enemyArr 文件名映射；`Load.Loading_Map():277` 把19–29归并加载Map18资源；Enemy可能有额外包列表。`MAIN/src/SelMap.as:164–228` 读取 `Main.guanKa`，按M1–M16、M51–M55及M17/M18/M81等时间轴实例绑定按钮。增加 MapX.swf 文件并不自动增加选图按钮、加载映射、房间出口或解锁条件。`MAIN/src/Map.as` 管碰撞/场景行为，实际地图类从资源域取出，构造位置见 Main.as:843–849。

`GameData.GuanKaXX():372–390` 还按当前地图编号+1开启后继关，并提升当前图难度状态；新增章节地图若采用不连续编号，不能直接依赖这个顺序解锁逻辑。

因此最初的可玩扩展可以复用一张已有地图和已有敌人，先验证任务触发、房间配置与结局，再扩展新资源。若复用原ID承载不同内容，需要新存档/明确版本迁移；否则老进度会被重新解释。

## 一个最小、可回滚的文字修改示例

以下只是文档示例，未写入游戏源码。改动 `TASK/models/task/Task.as:119` 的方法，只对任务110001加可辨识标记，不改变任务ID、条件或存档格式：

```actionscript
public function getTaskIntroduction() : String
{
   var text:String = TaskFactory.getTaskIntroduction(_id.getValue());
   return _id.getValue() == 110001 ? "【文字验证】" + text : text;
}
```

在独立工作分支保存这一个差异，使用全新的测试存档名构建，然后打开任务详情确认标记显示、退出重读仍能正常进入任务。回滚只还原该方法并重建同一模块；不要清空所有 source 或覆盖用户存档。其用途是证明“tracked AS修改→新ABC→隔离运行→实际UI”链路，不是新章节完成验收。

## 构建和验证命令

在项目根目录运行，`python` 以下明确使用Qubit；先保留当前已验收包及assembly清单。示例测试名可按章节迭代另取，必须保持 `yzlr2_rebuild_` 前缀：

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/build_main.py --all-definitions --save-name yzlr2_rebuild_chapter_text1
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/audit_task_integrity.py
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rebuild_project.py audit
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rebuild_project.py assemble
```

assemble 默认拒绝缺少有效重建收据/输入指纹或不完整资源，不会启动播放器；测试打开其新输出目录。`--partial` 允许原版回退，只适合明确标注的局部实验，不能用它声称完整章节包已经重建。需要构建资源模块可用 `rebuild_project.py build Map1`（实际模块stem）；全资源用 `build resources`，全部用 `build all`。统一 `build main/all` 使用默认测试名；如果要保留上例自选名字，主程序用显式 build_main命令。

修改DataX XML时先执行 `datax_source.py import-xml`，再 `datax_build.py`；直接改InData时不要用旧XML覆盖。改变构建工具或资产也会使旧收据过期，按审计提示重建依赖模块。独立 `resource_harness.py` 探针可对资源加载做原/改版对照，详见 resource-harness.md，但它没有真实游戏父域，不能代替剧情流程测试。

每次章节修改至少验证：入口是否可见；任务接受/条件更新/提交；地图加载与结束；奖励只发一次；保存退出后重读；已完成任务不能无意重开。新增Boss/技能还须测试实际战斗和动画帧事件，而非只看类存在。当前静态工具中的基线比较可能把有意新增类/资源报为差异，必须明确记录并更新扩展验收，不能随手删除检查。

## 当前可编辑范围与复现门槛

“19,910份AS可编辑”表示这些文件是代码权威，不表示任意结构改动都已由工具支持。两个明确的构建契约需要保留：

- `build_main.py:54–64` 的 staging 修复必须找到 Player2 的旧空语句、三个文件的原 wildcard import，以及 LocalSaveManager 的原存档名字面量。若你先在canonical里自行清理这些内容，构建会以 `Expected repair not found` 停止；需要同时审查并更新对应recipe与验证，不能删掉断言后继续宣称恢复等价。普通 Task 介绍文字修改不会触及这些前提。
- `datax_source.py` 与 DataX 验证固定现有11个XML方法/加载关系。改这11份表的数据属于已有路径；新增第12张表、改方法名或加载顺序，需要显式扩展导入与原/新版验证。普通 `import-xml` 不是一个任意AS重写器。

干净clone的步骤见 `reconstruction-boundaries.md`：原基线SWF、工具链、inventory与`-exportembed`素材都仍是必需输入。只拉取AS不会得到可链接的美术。独立新工作目录实验只完成33/164模块，未完成全量严格组装或运行；不要把同机已有完整包的成功转写成“全新机器一键复现”。

2026-10-24交付审查时，保留trace的新Main71b7c20c9edc已通过24方法定点检查及183真实类回归；非Main全部采用显式`omit-trace-statements=false`的新世代仍在完成编译/组装与全包玩法验证。这是当时的阶段快照，不是永久状态；应以当前严格`audit`、新的`assembly.json`及对应运行证据确定可启动的包。历史928e或2c包不代表已包含后来的全部修复。

## ApplicationDomain和存档的两个主要陷阱

游戏每个 ClassLoader 默认用独立子域，父域是游戏主程序；公共基类复用父域，兄弟资源不应合并成一个域。多个资源里的 src.Main/HitXX/Skin_ZhuangBei副本，以及 VIP/XLUP/YZJH 的同名 Skin，不能因名字重复就删掉或统一当前域。完整依据见 application-domain-audit.md。XMLAsset与JSON还有实际发生过的编译歧义：当前构建修复显式import/短名绑定；在strict=false模式直接写完全限定调用曾生成动态getlex com并在读档报1065，编译成功不证明绑定正确。

`Main.Save2():419` 将 `TaskData.saveTask()` 存入 RenWu；其181–199行按任务ID保存 `[state, oldTime, goodsCounts, enemyCounts, overTime]`，107–168行恢复。任务ID及数组位置属于持久化语义：不要重新编号旧任务，也不要在同ID下改变怪物/物品数组长度或顺序而不迁移旧值；`Task.setEneSave()`/setGoodsed()直接恢复数组，不会替新增条件自动补齐。`Main.regAllClass()`注册的AMF类型、VT包装及对象图身份同样不可用普通JSON随意替代。

原本 `TaskSlot.initSlotArr()`/addTask只给15个槽位，超出时未自动扩容；新增大量同时进行的任务须另测UI和容器。`TaskData.BoXX`/小类型恢复规则与每日重置也会改变读档状态。为章节设计明确的版本标记和一次性迁移是建议工作，**现有工程没有已实现的通用章节存档迁移器**。任何调试首次开标题页都可能初始化SO并flush，必须在启动前隔离测试名；具体措施见 save-isolation.md。

## 本次新增独立静态验收

`reverse/tools/audit_task_integrity.py` 生成 `reverse/manifests/task-integrity.json`：原SWF DefineBinaryData cid8632与导出任务XML全字节匹配，167个任务无重复ID/前置循环，任务引用的敌人/地图至少存在于适用配置组，怪物/物品/奖励平行数组长度一致；主模块62处直接 `TaskData.method(...)` 调用均有声明。它不验证动态调用、奖励对象ID、全任务可达性或运行完成性。

这是原版任务资产的基线审计，当前强制断言cid8632字节一致；正式引入canonical任务XML时要另加明确的修改版输入选项并保留该原版对照，不能把这条基线断言直接删掉以获得“通过”。审计将已知配置问题列入清单而不自动改源，退出成功仅表示审计执行成功。

发现5条原版每日任务将前置写为0：410015神奇的丹药、410038神奇的丹药2、410042打忍者比赛、410044惩治吞食者、410047强大的贝尔。不存在任务0；按 qzOk/isOldById源码，这些条目通过通常前置过滤时不入可接任务集合。可能是作者主动停用的配置，意图无法仅由源码判定。本轮保留原行为并报告，不将其当作重建引入的bug，也不把0当作新增任务的无前置模板。
