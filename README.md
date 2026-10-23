# 勇士的信仰 5.6 · 系统逆向工作区

本地研究分支 `codex/reverse-engineering`，基于 `5.6`；不自动 push。原版游玩目录仍在相邻的 `勇者的信仰/`，本目录为 `勇者的信仰-逆向/`。

## 目标与验收

持续至少四小时有效工作；分别验收可理解、可构建、实际可玩，未达成不能标记完成。封装原 SWF 或少量补丁不是源码重建。

## 基线与隔离

- 起点和版本：`reverse/manifests/session.json`。
- 原始 166 个文件已全部校验：`reverse/manifests/original-files.json`。
- 实时存档初始备份与校验在忽略的 `reverse/private/`，不得提交。
- 运行测试必须先采用独立存档名或独立播放器环境；禁止写原版、毕业档或终章存档。
- `.runtime/shared-tools` 只引用已有 FFDec/Java/Flex；`.runtime/prior` 引用旧分析成果。不要删除或修改共享工具和旧成果。

## 目录与职责

- `reverse/source/`：19,910 个可编辑 AS 文件；DataX 配置另有 `reverse/source/DataX_v76-config/`，修改后的导入步骤见文档。
- `reverse/tools/`：可重复执行的盘点、导出、修复、构建脚本。
- `reverse/manifests/`：来源与模块清单、进度及覆盖统计。
- `reverse/docs/`：架构、工具证据、验证与未解决问题。
- `reverse/experiments/`：小模块及主程序重建实验的文本源与说明。
- `reverse/exports/`、`reverse/build/`、`reverse/logs/`：大批量产物与日志，忽略 Git。

## 当前进度

- 已建立独立 worktree，保留原目录 `5.6` 分支和终章分支。
- 164/164 个 SWF 已完成结构盘点、脚本及资源导出；19,910 个 AS 文件与原始 ABC 的脚本单元数量逐包一致，未发现导出超时或错误占位。
- REA 对当前 SWF 不提供语义反编译；已实测其二进制识别边界和熵分析。FFDec 负责 Flash/AVM2、资源和脚本恢复，详见 `reverse/docs/rea-capability.md`。
- 主程序全部 710 个脚本已重新编译；修复空语句及 XMLAsset 导入冲突，保留完整 712 类、7,148 方法。它已使用独立测试存档启动、读档、进入村庄、地图和普通战斗。早期核心验收使用原版外部资源；后续全包验收见下。
- DataX 全部 292 个 AS 文件已编译，11 个 XML 方法的 3,087 条配置记录已核对；162个资源库已重建，根时间轴/绑定及装备帧对照已通过；164个模块的完整输入指纹重编译和严格组装已完成。当前候选为`runtime-all-rebuilt-20261023T191531.793191Z`：Main71b7c20c、DataX5e2401a8，164/164源码重建、零fallback。
- 核心候选 fee59837 已通过普通攻击、技能、落月之原全部五房间/Boss/结算、装备卸下和穿回、保存后退出播放器重读、主线1接受/触发/奖励；外部163包仍为原版。该阶段记录保留；现有全包实测见下。

## 最新候选与实际验收（191531包）

[最终候选来源报告](reverse/manifests/final-candidate-provenance.json)独立复核164个包内receipt、164个输入generation、28,131个当前输入文件和实际SWF哈希；未直接复用原ABC块，153个SWF9与11个SWF11均保留各自原版本。Main24个修复方法、非Main84模块/1,363方法/13,976有限路径fixture与候选哈希对应。保留trace表达式及参数求值、Main/DataX的SWF9语义修复已进入本轮编译。三份受保护用户存档只读SHA/大小复核均未变。

主任务已对该候选直接运行确认：Finder冷启动；slot2药水商店买2卖1、显式保存、完全退出至进程消失后coldread；任务110001接受→进入Map1触发→回城领奖；双人新建slot3、默认确认/Right移动、冲突A出现“键位未设置!”、recommended恢复确认及保存。截图和指定隔离存档只读摘要另存`reverse/experiments/final-runtime/`。任务领奖后摘要确认金币4717、经验500、state=0/oldTime=1、装备12510一件；摘要的持久化level仍为1，不能把画面动画当作持久化升级证明。该JSON是领奖后落盘证据，领奖后的再一次coldread应单独验收，不与此前商店coldread混称。

最终包v5诊断运行已完成落月之原四个普通房间、金光蛇王、挑战成功结算及返回村庄；卸甲/穿回与显式保存已验证。完全退出播放器、确认进程消失后，Finder再次直接启动正式Main，冷读slot1保留经验7191、金币10002242、击杀点1000003和六件装备。见`final-map1-*.json`及`final-slot1-cold-read.png`。wrapper会改变加载环境，因此另有直接启动和直接冷读测试。最终包商店INT_MIN边界的完整UI对照尚未测，不能借用原版对照或编译探针冒充。各项通过是已明确范围的实测，不是所有关卡、Boss、物品、2P玩法或全游戏形式等价证明。

## 已有复现命令

在本目录运行，Python 使用 `/opt/miniconda3/envs/Qubit/bin/python`：

```sh
python reverse/tools/swf_inventory.py
python reverse/tools/export_swf.py --mode scripts --jobs 2
python reverse/tools/export_swf.py --mode assets --jobs 1
python reverse/tools/rebuild_project.py build all
python reverse/tools/rebuild_project.py audit
python reverse/tools/rebuild_project.py assemble
./启动源码重建版.command --check
```

正常游玩入口是 `启动源码重建版.command`。它选择最新的严格重建包并检查源码、素材、工具链与构建凭据，使用独立的 `yzlr2_rebuild_probe` 测试存档。当前191531包（Main71b7/DataX5e240）的真实Finder冷启动已由主任务通过；此前Main928e阶段的冷启动证据保留为历史。原版快捷方式不变。

构建脚本使用相邻原版目录的已有 Java、FFDec、Flex 和 playerglobal；详见 [统一构建文档](reverse/docs/build-project.md)。固定旧提交875a2ea0的新目录cleanroom实验已按指令暂停：164模块素材全部重新导出，Main/DataX及31个资源实际编译成功，共33模块，未完成164全包组装/运行；证据见[cleanroom部分结果](reverse/manifests/cleanroom-875-partial.json)。它共享已核验工具链，不是全新机器安装，也不能充当当前语义修复版本的完整cleanroom验收。

## 待办与已知边界

1. 后续回归可补当前191531包商店INT_MIN下箭头的完整UI对照；原版UI与独立指令探针已有证据，最终包该UI路径仍标未测。slot1毕业档Map1实战及冷读已通过。
2. 如需完整新目录复现，另以当前修复提交重开全量cleanroom；旧875实验仅33模块阶段性通过。当前191531包真实Finder冷启动已经通过。
3. 扩大NPC/物品/地图抽样，核对诊断字段含义；未覆盖部分明确标记未测。
4. 交付与验收见[最终报告](reverse/docs/final-report.md)及[交付索引](reverse/manifests/final-acceptance.json)；本轮仅本地提交，不push。
5. Main 重编译存在编译器生成的私有编号及脚本初始化差异；96ce与928e两次构建之间未发现业务指令差异；与原版比较已另发现并修复若干关系/循环恢复缺陷，不能宣称二进制确定构建或全游戏形式等价。详见 [恢复边界](reverse/docs/reconstruction-boundaries.md)。

## 维护记录

- 2026-10-24（北京时间）：开始四小时系统逆向；UTC 起点见 session.json。开始时尚未进行验收；后续各阶段结果见下面记录。
- 2026-10-24 00:27：全量导出阶段完成；主程序修复了实际读档时的 `ReferenceError #1065: com undefined`。关卡一房间已清怪并进入下一房间；当前整体 Goal 继续进行，未达到四小时及完整玩法验收。

- 2026-10-24 01:05：核心候选完成落月之原 Boss、装备/冷启动读档及第一条主线任务实测。已核验三份受保护存档哈希未改变。全部162资源模块已编译候选，发现并正在补回28个按钮SymbolClass和少量根时间轴/shape依赖；在修复与验证前不计全包完成。统一入口 `reverse/tools/rebuild_project.py` 已有严格组装门槛。

- 2026-10-24 01:43：首个164/164源码重建包（Main96ce/DataX02ab、无原版代码fallback）完成启动、读档、村庄/NPC/技能、落月之原全部五房间/Boss/结算、卸甲、主线1领奖、显式保存及播放器完全退出后重读。原版对照确认初始属性/卸甲/任务奖励相符；通关后暴击+0.1已由小蛇三星图鉴的+20暴击属性解释。三份受保护存档仍哈希一致。
- 同一阶段：新增任务完整性审计、后续改写指南、减一指令语义复核及独立探针。Main再次编译出现96ce与928e两个字节版本；解析P-code仅见编译器生成私有编号和6处脚本初始化查找差异，故撤回“固定路径保证字节复现”的推论，保留可重复构建及逐版本玩法验证门槛。完整Goal继续，未达到四小时。

- 2026-10-24 02:00：164模块真实输入指纹严格包组装成功，全部source_rebuilt、零fallback。独立资源探针实际加载原版及重建版各162模块，均162/162完成无错误；Enemy5/Map0仅自动实例名称编号不同，保留原始差异。减一语义探针实际运行19/19通过。新目录从本地提交克隆重新导出与构建进行中。

- 2026-10-24 02:37：Main24方法的反编译恢复缺陷已修复并重新编译为2c0b888c（SWF9）；15关系分支、172容器路径、18循环路径及int32减一检查通过。原928e回城失败已追溯到SWF版本语义：原版9成功、新14失败、仅恢复9的探针成功。非Main1363处方法修复已按各原ABC核证，461源码文件已冻结，正在统一重建。新目录cleanroom仍以875a2ea0固定提交独立复现，不能混称为本次修复后的版本。

- 2026-10-24 03:15后：保留trace的新generation完成严格191531包组装，164/164零回退。独立来源审查通过；本包直接Finder冷启动、slot2商店买卖/完全退出冷读、110001触发领奖和slot3双人按键设置烟测均由主任务通过。当前继续v5数量边界与毕业档Map1实战，未把待测项提前记为通过。旧875 cleanroom按指令暂停在33模块，保留独立阶段性报告。

- 2026-10-24 04:12后：最终191531包完成落月之原四个普通房间/Boss/结算回村、卸甲和穿回、显式保存及完全退出后Finder直接冷读。独立审查重新读字节核验164模块与28,131输入，三份用户存档未变，原版5.6已跟踪文件干净。A/B/C按报告中的抽样范围通过；全地图等边界保留，当前完整cleanroom未验收。
