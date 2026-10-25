# 源码入口与二次开发路径

[返回项目 README](../../README.md) · [文件手册](developer-files.md) · [逐文件索引](catalog/README.md)

本页 `M/` 指 `reverse/source/3_L4399Main_gamefile/`；`B/` 指 `M/com/hotpoint/braveManIII/`；`D/` 指 `reverse/source/DataX_v76/`。其余路径相对根目录。以下是已定位的职责与修改顺序，不是原作者设计文档。

## 先建立运行顺序

`M/src/Main.as` 初始化舞台、序列化类型和 `Strat` 标题界面；`Strat` 选择新角色或读档，经 `Main.applySaveObject()` 恢复数据，再走 `Main.Loading()` → `Load.Open()`。`Load` 依次装载地图、DataX、玩家动画、武器、敌人技能、音乐、宠物和装备；`Data2` 也在这里初始化。完成后 `Main.GameStart()` 建地图和角色，帧事件驱动移动、碰撞、战斗和任务。

修改某个文件后，先判断它属于哪一个模块：Main是主流程，DataX是数据初始化，地图／敌人资源模块还附带大量同名依赖。Flash的ApplicationDomain决定实际取哪个类；“全局搜索同名文件后批量替换”会破坏模块间差异。

## Main核心文件：先读这些

| M/ 下路径 | 职责 | 主要定位方法／配套文件 |
| --- | --- | --- |
| `src/Main.as` | 全局入口、角色数据装配、加载场景、保存、世界及角色创建销毁。 | `InitXX`、`regAllClass`、`applySaveObject`、`Save/Save2`、`Loading`、`GameStart`、`AddMap/AddPlayer`。 |
| `src/Strat.as` | 原名如此：标题、新建1P/2P、读档槽位与开始游戏。 | `NewGame1/2`、`LoadSave/LoadNum`、`startGame`；不是拼写错误后可随意重命名。 |
| `src/LocalSaveManager.as` | 本离线包的本地SOL槽位管理。 | `init`、`saveSlot/loadSlot`、`getSlotTitles`；原源码存档名由build staging隔离。 |
| `src/SaveXX.as` | 游戏内保存辅助与金币上限处理。 | 与Main保存对象／SOL工具不同层次。 |
| `src/InitData.as` | 全局可保存状态与计时、增益等。 | `Init`、`SaveInitData`、`LoadInitData`。 |
| `src/TempData.as` | 版本及地图、敌人、其他资源的文件登记。 | `Init`；名字存在不代表运行路径一定加载。 |
| `src/ClassLoader.as` | 统一加载器及按名字取类。 | `load/loadBytes/getClass`、ApplicationDomain；IO错误也会发COMPLETE，不能只看加载完成事件。 |
| `src/Load.as` | 首次与关卡的分阶段加载。 | `Loading_*`、`onLoaded_*`；地图17/81有专门预加载。 |
| `src/NewLoad.as` | 动态装备资源加载。 | `Loading_Equip`、`LoadGo/LoadEnd`；生成equip文件名。 |
| `src/Data2.as` | Main内嵌配置的初始化总入口。 | 连接Data2_data和一系列Factory。 |
| `src/_data/Data2_data.as` | E4X内联关卡表、怪物表与怪物皮肤表。 | `关卡数据1..4`、`EnemyXML_*`、`EnemySkinXML_*`；不是DataX的XML目录。 |
| `src/Data2_*.as` | 嵌入数据包装类（任务、宠物、称号、商店等）。 | `[Embed(source=...bin)]` 指向真正数据；索引列出实际Embed路径。 |
| `src/GameData.as` | 关卡参数、刷怪、胜负、关卡推进与场景名选择。 | `GetData`、`MonsterGo`、`Win/Lose`、`SelMapName`。 |
| `src/Map.as` | 地图层、移动／卷屏、场景碰撞相关结构和地震等。 | `NoStop`、`Run`、`GetPathsAndSpeed`，依赖时间轴 `_Data/Data1/Data2/moveChild/map_3`。 |
| `src/Door.as` | 房间出口／转场。 | `GoWhere` 等；普通门与连续海图推进不同。 |
| `src/SelMap.as` | 世界地图、关卡选择和难度入口。 | `OpenMapNum`、`GameGo`。 |
| `src/Player.as` | 1P帧循环、属性叠加、技能／消耗品CD、键控、伤害、移动与外观装配。 | `onENTER_FRAME`、`KeyControl`、`ALLcompute`、`HpXX`、`CanSkill`、`newSkin`。 |
| `src/Player2.as` | 2P的对应逻辑，并非Player的自动继承镜像。 | 修改共享体验要单独评估2P路径。 |
| `src/Skin.as`、`src/Skin_WuQi.as`、`src/Skin_ZhuangBei.as` | 角色／武器／装备外观及动画配合。 | 配合PlayerMc、WuQi、equip等资源帧。 |
| `src/Enemy.as` | 怪物实例、属性、AI移动、受伤／死亡、掉落及任务击杀更新。 | `SkinData`、`HpXX`、`Dead`、`MoveData/MoveRun`。 |
| `src/EnemySkin.as`、`src/EnemyLife.as` | 敌人外观与血条等配套显示。 | 配合Enemy模块具体皮肤与帧脚本。 |
| `src/HitXX.as` | 命中收集、阵营／目标分派、暴击闪避与伤害入口。 | 调用Player/Player2/Enemy的伤害方法，不能独立代表全部伤害公式。 |
| `src/HitF.as`、`src/HitKG.as`、`src/HitP.as` | 攻击命中相关显示／判定配套类。 | 具体调用以索引方法和import追踪，不能凭缩写推断全部语义。 |
| `src/obj.as` | 掉落物／拾取及任务物品更新链。 | 配合Enemy掉落、背包和TaskData。 |
| `src/WinShow.as` | 胜利结算、用时／连击／被打显示、回村与重开。 | `TextShow`、`回村`、`重开`；任务条件会读取部分显示值。 |
| `src/Play_Interface.as` | 游戏主HUD与面板入口。 | 改入口和可见状态从这里追踪。 |
| `src/ChongWu.as`、`src/JingLing.as` | 宠物／精灵相关运行逻辑。 | 配合对应Factory、数据与资源包。 |
| `src/Api_4399_All.as`、`unit4399/events/` | 遗留4399服务接口与事件类型。 | 离线并不证明所有调用都是空操作；见网络边界审计。 |
| `src/npc/` | NPC面板和交互逻辑；村庄资源包还带NPC点击入口。 | 村长任务等需同时看Map0的类。 |
| `src/tool/` | 文本、校验、界面、难度、调试等杂项辅助。 | 与 `B/Tool/XMLAsset` 同名类需分清导入。 |

其余AS不是漏掉：完整名单在 `catalog/files.tsv`，包含类、基类、方法行号、import与Embed。上表用于决定先读哪几个文件。

## 业务对象包：数据、对象、界面分开

| B/ 路径 | 作用 |
| --- | --- |
| `repository/<类别>/*Factory.as` | 从配置初始化／查找各类定义；并不是直接显示面板。 |
| `repository/<类别>/*BasicData.as` 等 | 装备、任务、宠物等一条配置记录的字段封装。 |
| `models/<类别>/` | 当前角色持有或参与计算的物品／任务等运行对象。 |
| `models/container/Bag.as` | 背包及增删物品等容器行为。 |
| `models/container/EquipSlot.as` | 装备槽与装备属性汇总。 |
| `models/player/PlayerData.as` | 可保存的角色数据；与场景中的 `src.Player` 对象不同。 |
| `models/common/VT.as` | 数值封装；很多字段通过 `getValue/setValue` 访问，别当普通Number任意替换。 |
| `views/<面板>/` | 显示、按钮事件和交互；消费models/repository。 |
| `views/taskPanel/TaskData.as` | 可接／进行／完成任务筛选、条件更新、保存与NPC关联。 |
| `models/task/Task.as` | 单任务状态及完成条件判断。 |
| `repository/task/TaskFactory.as`、`TaskBasicData.as` | 任务XML解析与记录。 |
| `views/taskPanel/TaskPanel.as`、`TaskDisplay.as` | 接取／提交、介绍／需求展示、奖励对象发放。 |
| `views/setKeyPanel/` | 按键设置、冲突处理；不要假定所有存档仍使用默认键位。 |
| `views/suppliesShopPanel/`、`views/equipShopPanel/` | 药水和装备商店交互。 |
| `Tool/XMLAsset.as` | 将嵌入ByteArray等转为XML；与 `src/tool/XMLAsset.as` 有命名冲突历史。 |

`com/greensock/` 是动画补间库，`com/adobe/serialization/json/` 是JSON实现，`mx/`、`fl/` 为Flash/Flex支撑类；一般业务修改不从这里开始。默认包和 `*_fla/` 下很多类是图形绑定和帧脚本，`frame1` 等方法仍可能改变事件、动画或攻击判定，不能当“没有业务的空类”批量删除。

## DataX的11份配置：每个文件干什么

目录 `reverse/source/DataX_v76-config/`；以下行数为本次文档生成时的直接子记录数，共3,087条，并非所有游戏数据总量。

| 文件 | 条数 | 初始化消费对象 | 修改用途 |
| --- | ---: | --- | --- |
| `EquipXML.xml` | 1392 | `EquipFactory.myXml` | 装备ID、名称、属性、部位、外观加载信息。 |
| `SuitXML.xml` | 30 | `EquipFactory.suitXml` | 套装属性／技能，和装备初始化配合。 |
| `GemXML.xml` | 242 | `GemFactory` | 宝石／强化材料定义。 |
| `GemProbabiltyXML.xml` | 135 | `GemProbabilityFactory` | 强化成功率表；保留文件原拼写。 |
| `GoldXML.xml` | 62 | `GoldFactory` | 按掉落等级等关联的镶嵌／挖空费用，不是角色金币余额。 |
| `SuppliesXML.xml` | 25 | `SuppliesFactory` | 消耗品名称、效果、价格和冷却等。 |
| `SkillXML.xml` | 702 | `SkillFactory` | 技能各级数据；技能实际行为还依赖Player、皮肤与帧脚本。 |
| `SkillConditionXML.xml` | 265 | `SkillConditionFactory` | 学习技能所需等级、职业／重生／点数等。 |
| `QuestXML.xml` | 40 | `QuestFactory` | **任务物品**，例如碎片；不是剧情任务清单。 |
| `OtherXML.xml` | 139 | `OtherFactory` | 其他道具、叠加／类型／用途等。 |
| `makeXml.xml` | 55 | `MakeFactory` | 制作卷轴、材料与配方。 |

`D/src/Data.as` 是恢复的DataX根类，`D/src/InData.as` 执行11个XML初始化方法。`import-xml` 把XML变成InData中的字符串；普通 `build datax` 不自动做这一步。不要同时手改InData字符串和未同步的XML，否则下次导入会覆盖字符串。

## 一个完整的小修改流程

例：只修改一种药水的显示名称（先在测试分支／当前工作树保留diff）。下列是流程说明，本次文档更新没有执行修改。

1. 在 `SuppliesXML.xml` 按编号定位条目，改名称，保留ID／类型／效果等字段。
2. 执行以下命令，审阅XML和InData的diff，确认没有顺带改其他数据。

```sh
PY=/opt/miniconda3/envs/Qubit/bin/python
"$PY" reverse/tools/datax_source.py import-xml
git diff -- reverse/source/DataX_v76-config/SuppliesXML.xml reverse/source/DataX_v76/src/InData.as
"$PY" reverse/tools/rebuild_project.py build datax
"$PY" reverse/tools/rebuild_project.py audit
"$PY" reverse/tools/rebuild_project.py assemble
./启动源码重建版.command --check
./启动源码重建版.command
```

3. 用独立测试档打开药水商店和背包，查看新文字、价格和效果；保存、完全退出、再读档。不要以“编译成功”代替这些实测。
4. 记录新包目录和摘要。若要撤回，恢复这两个源文件的目标改动，再重建DataX和组装；不要直接改新包SWF或篡改receipt。

只改Main代码用 `build main`；只改某资源模块用例如 `build Enemy16`；改共享构建脚本／工具链可能使全部模块过期，应根据audit决定重新构建范围。构建期间冻结输入，不同时编辑同一个模块。

## 任务与故事：原版任务表在哪里

主线任务清单来自 `M/src/Data2_taskData.as` 的Embed，当前实际输入为：

```text
reverse/exports/3_L4399Main_gamefile/scripts/_assets/8632_src.Data2_taskData.bin
```

它是UTF-8 XML，已有167条任务记录（审计见 `reverse/manifests/task-integrity.json`）。主程序 `Data2.taskData` → `TaskFactory` → `TaskData/Task` → `TaskPanel/TaskDisplay` 消费它。**还没有与DataX等价的受控任务XML导入流程**；单纯在source新建同名bin或taskData.xml不保证生效，build_main随后复制的原导出非AS资源可能将其覆盖。

扩展故事先实现这条工程链：受Git管理的任务配置 → 显式导入到构建素材 → 真实输入指纹 → 新Main包 → 任务UI/触发/奖励/持久化测试。实现前临时改ignored资产只适合隔离实验，不能作为可复现交付。

任务条目的前置（只有 `-1` 表示无前置）、等级／重生、NPC、需求、奖励类型与ID必须同时有效。`QuestXML`不是任务表；奖励类型也必须对应正确物品表。杀怪由Enemy更新计数，入图由GameData/TaskData更新，通关由WinShow更新。新增任务不能只做一个可点击按钮就算接入主线。

新增终章建议先把“解锁前置 → NPC接取 → 正常地图进入 → Boss/通关条件 → 领奖 → 结局呈现 → 保存重读”做成可验收链。原 `TaskPanel` 支持任务介绍／需求展示，不等于已经有通用多轮剧情系统。更详细约束见[扩展章节指南](modding-guide.md)。

## 地图、Boss与美术

地图数值／敌人表从Main `Data2_data.as` 找，具体Map/Enemy模块负责动画／时间轴和附带逻辑；必须保持实际导出类、帧标签和碰撞层名。新增Boss往往同时涉及敌人配置、皮肤／攻击资源、关卡刷怪／Boss ID、任务条件和掉落，不能只改 `Enemy.as`。

修改素材需要受版本控制的资产输入或补丁流程，当前 `_assets` 仍处于ignored导出目录。整包重新导出会覆盖它。新增图片不能自动变成关卡对象；还要处理SymbolClass、实例、帧脚本、根时间轴、碰撞和加载域。原作者FLA／关卡编辑器并未恢复。

## 不要无意撤销已经核证的兼容修复

- Main的XMLAsset导入冲突、空语句和独立存档名由staging修复；已有补丁要求精确匹配，修改附近代码后需重新审阅，不能跳过断言。
- 反编译的有序比较、continue位置、非叠加物品扫描循环曾有语义缺陷，canonical源已作定点修复；不能用重新导出的旧AS覆盖。
- 三路编译保留 `-compiler.omit-trace-statements=false`，因为trace参数可能有副作用。
- Main/DataX保留各自原SWF9语义，资源包逐模块保留原版本（部分是11），不能一律升级／降级；缺失动画标签的异常行为与版本有关。
- 类名修复、根时间轴恢复、SimpleButton绑定、shape依赖和声音元数据都有专用流程。不要删除“看起来多余”的恢复步骤来让编译通过。
- 验收方法：输入／产物来源检查 + 相关语义／结构检查 + 当前包直接运行 + 存档冷读。旧截图、诊断wrapper或少数fixture不能证明修改后的整包正确。
