# 勇士的信仰 · 同人终章《归来的曙光》

**本分支：`codex/final-chapter`，开发中。** 在原版 5.6 的加载器外增加可玩的三场战斗、对话和两个结局。第一、第二章都是后加的同人内容；使用原版地图、敌人 AI 和素材，并非原游戏隐藏章节。它与源码重建分支是两种不同的开发方式。

现有记录已验证前两场战斗；第三战的封印交互、最终战、两个结局和完整连续通关仍未验收。2026-10-25 的快捷方式测试只确认进入村庄及终章界面，不改变以上状态。

## 三个版本与本机工作树

| 版本 | 分支 | 本机目录（相对 `~/Games`） | Games 快捷方式 |
| --- | --- | --- | --- |
| 原版 5.6 | `5.6` | `勇者的信仰/` | `勇士的信仰·原版5.6.app` |
| 同人终章开发版 | `codex/final-chapter` | `勇者的信仰-终章/` | `勇士的信仰·同人终章.app` |
| 源码重建版 | `codex/reverse-engineering` | `勇者的信仰-逆向/` | `勇士的信仰·源码重建.app` |

本机三个目录是同一 Git 仓库的三个工作树，分别保留自己的分支与未提交修改。日常进入对应目录即可，无需 checkout。不要将分支名相近误认为文件已同步；跨分支迁移修改需要显式审阅和合并。切换游玩版本前先在游戏内保存，再按 **⌘Q** 退出播放器。

Games 的三个专用快捷方式位于本机各工作树 `.runtime/launchers/`（Git 忽略），检查对应分支后调用启动脚本。仓库内旧 `勇士的信仰.app` 跟随本目录的 `启动游戏.command`，与三个专用入口不同。实时存档不在 Git 中，切换或回滚代码不会回滚角色。

## 运行和存档

双击 `~/Games/勇士的信仰·同人终章.app`，或在本目录执行 `./启动游戏.command`。读入角色后点击右上角「终章 · 归来的曙光」。当前错误提示里还有旧名称 `启动终章.command`，实际入口是 `启动游戏.command`。

- `yzlr2_final.sol`：独立的角色存档。只有首次发现目标不存在且找到唯一原版存档时，准备脚本才从 `yzlr2_saves.sol` 初始化；以后分别保存。
- `yzlr2_epilogue.sol`：按角色槽位记录 `completed`、`ending`、`attempts`，还包含开发调试记录。当前按键事件也会写调试状态，启动／交互测试不能假定存档绝不变化。
- 启动前及播放器退出后保存备份到本目录 `save-backups/`。游戏内保存后再 ⌘Q；代码回滚不会恢复上述两个 SOL。

## 终章文件逐一说明

| 文件 | 功能 | 修改后怎样生效 |
| --- | --- | --- |
| `mod/story.json` | 标题、序言、三章地图／房间／Boss 配置、战前战后对话、结局 `guardian` 与 `dawn`。章节标题中的“主线71–73”是同人标签，未接入原版任务 ID。 | 修改后执行 `./mod/build.sh`。 |
| `mod/src/Epilogue.as` | 新入口类；加载核心、访问原类、叠加 UI、推进战斗、处理封印／结局与独立进度。 | 修改后执行 `./mod/build.sh`。 |
| `mod/generate_story.py` | 读取并校验剧情（固定三章、两个指定结局），将 JSON 转成 AS 字符串常量。 | 被构建脚本自动调用。 |
| `.runtime/epilogue-generated/StoryData.as` | 上一步生成的 `StoryData.JSON_TEXT`，供 `Epilogue` 编译时引用，Git 忽略。 | 不手改；下一次构建会重生成。 |
| `mod/build.sh` | 用 Qubit Python 生成剧情，再用 Java/Flex 的 mxmlc 编译入口。 | 输出根目录 `终章入口.swf`。 |
| `tools/prepare_epilogue.py` | 校验原版主 SWF，仅将核心存档名 `yzlr2_saves` 换为等长的 `yzlr2_final`，准备角色并备份两个终章存档。 | 启动脚本自动调用；**有文件与存档副作用**，不是纯校验。 |
| `终章核心.swf` | 上述替换产生的主程序副本；仍使用原版代码，未经过源码重建。 | 准备脚本按原主程序生成，不手工编辑。 |
| `终章入口.swf` | `Epilogue.as` 与生成的剧情编译产物；加载 `终章核心.swf`。 | 实际启动文件，不是源码编辑入口。 |
| `启动游戏.command` | 准备播放器与核心、备份终章存档、打开入口、等待退出并再次备份。 | 本分支专用启动流程。 |
| `勇士的信仰.app/` | 仓库内旧 App：`Info.plist` 描述应用，`Contents/MacOS/launch` 调用启动脚本，`Resources/WarriorIcon.icns` 为图标。 | 本机使用名称明确的 Games 专用快捷方式。 |

### 原版资源与通用工具

| 文件／目录 | 用途与操作方式 |
| --- | --- |
| `3_L4399Main_gamefile.swf` | 原版主程序；运行、存档和战斗的入口。作为基线保留。 |
| `DataX_v76.swf` | 装备、技能、消耗品等数据及相关类；不是所有游戏数据的唯一来源。 |
| `Map*.swf` | 村庄及关卡的画面、碰撞层、时间轴和类。编号是资源编号，后缀是资源修订号。 |
| `Enemy*.swf` | 敌人相关类、动画与技能资源；敌人 ID 不一定等于包编号。 |
| `PlayerMc_X*.swf` | 三套玩家动画资源。 |
| `WuQi_X*.swf`、`ZhuangBei_X*.swf`、`ShiZhuang_X*.swf` | 武器、装备及外观资源。 |
| `equip_<skin>_<编号>.swf` | 69 个按皮肤和装备配置动态加载的外观包。必须保持文件名与配置对应。 |
| `Music_v3.swf` | 音乐资源。 |
| `Card_v17.swf`、`ChongWu_v8.swf`、`VIP_v2.swf`、`XLUP_v4.swf`、`YZJH.swf` | 图鉴、宠物、VIP、星灵、计划等功能相关资源包；业务入口仍需配合主程序。 |
| `SHA256SUMS` | 原包 166 个文件（164 个 SWF 和随包 EXE/CMD）的基线哈希。只检验原包，不覆盖新增源码与文档。 |
| `FlashPlayerStandAlone.exe`、`白屏修复-放游戏目录管理员身份运行.cmd` | 随包 Windows 工具，不是 macOS 启动入口。 |
| `.gitattributes`、`.gitignore` | Git 文件处理与忽略规则。 |
| `.runtime/` | 本机播放器、工具、缓存及专用快捷方式；不随 Git 分发。 |
| `save-backups/`、`saves/` | 本机备份与候选存档，不上传。并非 Flash 实时存档所在目录。 |

旧 App 的 `Contents/Resources/` 还保留 `FlashPlayer.icns`（旧播放器图标）、`Info.before-icon-change.plist`（换图标前元数据）、`WarriorIcon.png` 和 `WarriorIcon.iconset/*.png`（各尺寸图标源）；包内 `Icon` 加回车字符的文件是 Finder 自定义图标资源。这些文件用于应用显示，不参与游戏逻辑。

## 存档与工具逐文件说明

实时存档位于 `~/Library/Preferences/Macromedia/Flash Player/#SharedObjects/<本机随机目录>/localhost/`。随机目录因机器而异，不要硬编码；修改前退出普通播放器和 Debugger，并备份当前文件。

| 文件 | 功能与读写范围 |
| --- | --- |
| `tools/sol.py` | SOL / AMF 编解码库；`loads`、`dumps` 读写对象图，`Arr`、`Obj` 保留数组／类型信息，`graph` 用于核对共享引用和循环引用。被其他脚本导入。 |
| `tools/graduate-data.json` | 创建毕业档用的装备属性、技能等级、地图 ID 数据；只是工具所需摘录，不是完整游戏数据库。 |
| `tools/create_graduate_save.py` | 从已有角色复制到空槽位并调整等级、装备、解锁等。默认只在 `save-backups/` 生成候选，`--apply` 才写目标 SOL；拒绝覆盖已占槽位。 |
| `tools/import_preset.py` | 将预设导入指定 SOL 的一个槽位，保留其他槽位，先备份完整原文件。**执行即写入**，不是预览；`--replace` 才允许覆盖已占槽位。 |
| `presets/毕业体验档.sol` | 自定义单角色体验预设：85 级、剑杖双职业、六件 +10 装备，固定属性为原表的 10 倍。并非正常掉落上限或个人旧账号云存档。 |

先查看参数，再明确选择存档文件和槽位：

```sh
/opt/miniconda3/envs/Qubit/bin/python tools/create_graduate_save.py --help
/opt/miniconda3/envs/Qubit/bin/python tools/import_preset.py --help
```

不要将 Git 中的预设直接覆盖完整实时存档；使用导入工具才能保留其他角色。恢复时先保存当前副本，再复制所需备份。Git 不保护实时存档。

## 阅读 Epilogue.as 的顺序

| 方法／状态 | 负责什么 | 调整时注意 |
| --- | --- | --- |
| `boot()` → `ready()` | 将核心载入 ApplicationDomain，解析 `src.Main/GameData/Player/Enemy`，安装 UI、计时器和事件监听。 | 加载域决定动态类是否与原游戏共享；不能随意替换。 |
| `state()`、`persist()` | 用 `Main.saveNum` 对应独立槽位；flush 终章 SOL。 | 更改结构需要考虑已有进度兼容。 |
| `openJournal()`、`dialog()`、`dialogPage()` | 章节菜单与逐页对话。 | 显示文字来自 JSON；菜单有固定三章假设。 |
| `startBattle()` | 清理上一场特效、选地图／房间、准备加载与尝试次数。 | 地图必须真的导出该房间的类；海上连续场景不能直接当独立房间跳转。 |
| `tick()` | 驱动加载、死亡重试、Boss 识别、胜利和第三战状态；有 25 秒加载超时。 | 同时接收帧事件和定时器；避免重复奖励与跨槽位状态污染。 |
| `configureBoss()` | 设置 HP、攻击参数、防御、颜色；第三战冻结 Boss 并布置三道印。 | `attackMultiplier` 实际直接写入敌人攻击字段，不等于已证明的最终伤害倍率。 |
| `drawSeals()`、`keyDown()` | 画光环，E 键（69）在距离阈值内解印，回血并解除 Boss 保护。 | 目前第三战尚待实测；键盘拦截、坐标和血量上限均需回归。 |
| `completeBattle()` | 增加完成计数、保存角色、显示战后对话并继续。 | 重试／重复调用不应重复推进。 |
| `chooseEnding()`、`ending()` | 选择并保存两个结局，写角色状态、返回村庄。 | JSON 键与代码硬编码一致；不能只改 JSON 来增加第三种结局。 |
| `showPanel()`、`closePanel()` | 对话层与按钮；将舞台帧率降为 0，再恢复。 | 必须测试关闭面板后的输入与动画恢复。 |
| `abandon()`、`returnTown()` | 取消当前战斗、切回城镇。 | 已完成进度独立保存，不等于可恢复战斗中间帧。 |
| `onError()`、`finishEffects()` | 记录错误上下文；特定 Boss108 特效在换场景前跳到终止帧清理。 | 不吞原错误；不是通用特效销毁方案。 |

## 构建与修改流程

在本机终章目录中执行：

```sh
cd ~/Games/勇者的信仰-终章
git status --short --branch
./mod/build.sh
# 检查源码与编译产物变化，再启动测试
./启动游戏.command
```

依赖：Qubit Python、Java 21、Apache Flex 4.16.1 和 `playerglobal32_0.swc`。`mod/build.sh` 可通过 `EPILOGUE_JAVA`、`EPILOGUE_FLEX`、`EPILOGUE_PLAYERGLOBAL` 指定已有路径；Python 路径目前固定为 `/opt/miniconda3/envs/Qubit/bin/python`。本机 `.runtime/tools` 和 `.runtime/adobe` 链接复用相邻原版目录，因此不要移走共享运行环境。新克隆不带这些依赖。

仅修改对话：改 JSON → 构建 → 查看换行／按钮／继续流程。修改战斗：同时核对 JSON 中的 map/room/bossId 与原游戏资源，重测进入、击杀、重试、连续转场和退出重读。要增加章节数量，必须同时修改生成器的三章断言和 `Epilogue.as` 内固定计数／结局条件，不能只追加 JSON。

若要把终章做成原版任务系统的一部分，下一步应在源码重建分支实现任务配置导入、触发与结局界面；当前 wrapper 没有自动完成这种整合，不能直接把其整个分支覆盖过去。

## 待办与维护记录

- 第三场三道封印交互、解印后 Boss 恢复、狂暴、死亡重试及最终两个结局。
- 第二场到第三场的特效／加载域清理、回血上限、跨角色进度与完整连续通关。
- 调试记录写盘频率与错误提示旧入口名；发行前清理，但保留必要错误定位。
- 2026-10-25：新增独立工作树与快捷方式；本 README 逐文件说明现有实现与二次开发限制。本次未改源码、剧情或构建产物。

## 来源与许可边界

基于《勇士的信仰》5.6 离线包的非官方本地研究与修改。原游戏、角色、美术、音乐及第三方工具的权利归各自权利人所有；本仓库未对这些内容授予新的许可。离线包线索：[原下载说明](https://www.bilibili.com/opus/1144775248772595719)。恢复源码不是原作者 FLA 工程，也不代表官方续作。
