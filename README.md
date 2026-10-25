# 勇士的信仰 5.6 · 源码重建与二次开发

**本分支：`codex/reverse-engineering`。** 从本地 5.6 离线包恢复并维护 **164 个 SWF 模块、19,910 个 ActionScript 3 文件、11 份 DataX XML 配置**。这些源码已完成全包重编译和若干真实玩法验证，可用于继续修改游戏；不是原作者的 FLA／关卡编辑工程，也没有证明所有玩法与原版等价。

## 从这里开始

1. 先读本页，确认运行入口、源文件和生成产物的区别。
2. [文件与目录手册](reverse/docs/developer-files.md)：根目录、每个工作目录、资产、构建产物和证据怎么用。
3. [源码与二次开发指南](reverse/docs/developer-source.md)：核心类、11 个配置表、任务／Boss／装备的修改入口，以及修改后怎样重建。
4. [工具逐文件手册](reverse/docs/developer-tools.md)：每个 Python 工具的职责、输出和副作用。
5. [164 模块目录](reverse/docs/catalog/modules.md) → [逐文件索引说明](reverse/docs/catalog/README.md)：按文件查职责、类、方法行号、资源绑定；索引覆盖所有受 Git 管理的文件，并收录本次新文档。

索引是文本／声明提取，不冒充逐方法语义证明。重点业务类另有人工整理说明；大量重复类要依据加载域确定实际生效模块。**不要把不同 SWF 中的同名 AS 直接合并。**

## 三个版本与本机工作树

| 版本 | 分支 | 本机目录（相对 `~/Games`） | Games 快捷方式 |
| --- | --- | --- | --- |
| 原版 5.6 | `5.6` | `勇者的信仰/` | `勇士的信仰·原版5.6.app` |
| 同人终章开发版 | `codex/final-chapter` | `勇者的信仰-终章/` | `勇士的信仰·同人终章.app` |
| 源码重建版 | `codex/reverse-engineering` | `勇者的信仰-逆向/` | `勇士的信仰·源码重建.app` |

本机三个目录是同一 Git 仓库的三个工作树，分别保留自己的分支与未提交修改。日常进入对应目录即可，无需 checkout。不要将分支名相近误认为文件已同步；跨分支迁移修改需要显式审阅和合并。切换游玩版本前先在游戏内保存，再按 **⌘Q** 退出播放器。

Games 的三个专用快捷方式位于本机各工作树 `.runtime/launchers/`（Git 忽略），检查对应分支后调用启动脚本。仓库内旧 `勇士的信仰.app` 跟随本目录的 `启动游戏.command`，与三个专用入口不同。实时存档不在 Git 中，切换或回滚代码不会回滚角色。

## 玩哪一份、改哪一份

- **运行重建游戏**：双击 `~/Games/勇士的信仰·源码重建.app`，或执行 `./启动源码重建版.command`。
- **编辑逻辑**：`reverse/source/<模块>/` 中的 AS；改 DataX 表时另见显式 XML 导入步骤。
- **根目录 164 个 SWF**：仍是原始基线。双击 `3_L4399Main_gamefile.swf` 或运行旧 `启动游戏.command` 会走原版，而不是刚修改的源码。
- **真正运行的重建 SWF**：在 `reverse/build/runtime-all-rebuilt-<UTC>/`。构建后还须 assemble；入口不会自动编译，也不会把过期／缺失的模块偷偷替换为原版。
- **当前本机严格包**：`runtime-all-rebuilt-20261023T191531.793191Z`；Main 摘要前缀 `71b7c20c`，DataX `5e2401a8`。这是历史固定候选，后续修改要生成新包。

## 常用命令

以下命令从此工作树根目录执行，使用本机 Qubit Python；`status/audit` 会写报告但不启动游戏或读写角色存档。

```sh
cd ~/Games/勇者的信仰-逆向
PY=/opt/miniconda3/envs/Qubit/bin/python
"$PY" reverse/tools/rebuild_project.py status
# 查看计划，尚不编译
"$PY" reverse/tools/rebuild_project.py build all --dry-run
# 真正重建（主程序、DataX 顺序执行，资源最多 2 路编译）
"$PY" reverse/tools/rebuild_project.py build all --jobs 2
"$PY" reverse/tools/rebuild_project.py audit
"$PY" reverse/tools/rebuild_project.py assemble
./启动源码重建版.command --check
./启动源码重建版.command
```

局部改动可用 `build main`、`build datax`、`build Enemy16`；后续仍须严格 assemble。`status/audit` 命令退出成功不代表全部通过，要检查报告的 `all_rebuilt_ready`；assemble 不满足条件会拒绝。不要把 `--partial` 混合诊断包当成完整源码构建。

依赖包括 Python、Java 21、FFDec 26.3.0、Flex 4.16.1、playerglobal32 和 Adobe Mac Debugger。本机 `.runtime/shared-tools` 指向相邻原版目录的已有工具；本分支并不附带所有工具和导出素材，新 clone 不等于可以立即启动。准备和构建细节见[构建文档](reverse/docs/build-project.md)、[目录手册](reverse/docs/developer-files.md)。REA 当前已测版本不支持 SWF 语义反编译；它负责过通用字节特征探测，Flash 的恢复由 FFDec 与本工程脚本完成，详见[能力实测](reverse/docs/rea-capability.md)。

## 存档与运行边界

正式重建入口使用独立 `yzlr2_rebuild_probe.sol`；构建阶段只在 staging 将原保存名替换为 `yzlr2_rebuild_*`。原版 `yzlr2_saves.sol`、终章 `yzlr2_final.sol`／`yzlr2_epilogue.sol` 不作为重建运行目标。实时文件仍在 Flash 的 `#SharedObjects/<随机目录>/localhost/`，不随 Git 回滚。

启动器检查包内全部 SWF、源码／素材／工具指纹及播放器签名；已有 Flash 进程时会拒绝再次启动。它不读取、导入或备份 SOL。切换版本先保存并 ⌘Q，重要测试档另外备份。仅 `--check` 不启动游戏；实际打开标题页也不等于保存和关卡已验收。

## 已验证范围与未完成部分

[最终验收清单](reverse/manifests/final-acceptance.json)记录 164/164 源码重建、0 原始代码 fallback。已有实际记录覆盖指定候选的标题／村庄、落月之原四个普通房间与 Boss／结算、装备卸下穿回、商店买卖及冷读、主线110001触发领奖、双人按键设置烟测。2026-10-25 又从 Finder 冷启动确认该候选标题页。以上按固定候选与场景成立，详情见[最终报告](reverse/docs/final-report.md)和[历史过程](reverse/docs/research-history.md)。

仍未完成：全地图／Boss／物品／完整双人玩法回归；最终包商店 INT_MIN 边界的完整 UI 对照；以当前修复版本在全新目录重建全部164包并运行。旧 cleanroom 仅33模块阶段性通过。Flex 重复构建可能产生私有命名编号等字节差异，不能宣称位级复现或全游戏形式等价。

## 二次开发待办

- 把 Main 内嵌任务 XML 等素材建立为受版本控制的可编辑输入，并接入导入／指纹／构建流程；目前只是规划，不能直接放一个 taskData.xml 就期待生效。
- 从小修改开始：一处道具文字或一条战斗参数 → 对应模块构建 → 严格组装 → 实际画面／行为／保存重读。
- 新章节先复用已验证地图，明确任务前置、触发、战斗、奖励和结局。终章分支现有 wrapper 可作为创作参考，尚未自动整合进本工程任务系统。
- 每次功能修改记录源码 diff、包摘要和实测范围；不要把旧包的测试结果转移给新包。

## 维护记录

- 2026-10-24：164 模块恢复、修复、重建与指定场景验证。完整过程保留在[历史记录](reverse/docs/research-history.md)。
- 2026-10-25：三个独立工作树及专用快捷方式配置完成；本机布局见 `~/Games/README.md`。
- 2026-10-25：新增面向开发的文件、工具、源码手册与逐文件索引；旧研究记录保留。本次仅更新说明和索引生成器，不更改游戏 AS、XML、构建配方、运行包或存档。文档链接与索引覆盖核对通过；`启动源码重建版.command --check` 重新核对164模块／28,131输入，`source_inputs_current=true`、`launch_available=true`，未启动播放器或访问私人存档。

## 来源与许可边界

基于《勇士的信仰》5.6 离线包的非官方本地研究与修改。原游戏、角色、美术、音乐及第三方工具的权利归各自权利人所有；本仓库未对这些内容授予新的许可。离线包线索：[原下载说明](https://www.bilibili.com/opus/1144775248772595719)。恢复源码不是原作者 FLA 工程，也不代表官方续作。
