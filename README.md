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

- `reverse/tools/`：可重复执行的盘点、导出、修复、构建脚本。
- `reverse/manifests/`：来源与模块清单、进度及覆盖统计。
- `reverse/docs/`：架构、工具证据、验证与未解决问题。
- `reverse/experiments/`：小模块及主程序重建实验的文本源与说明。
- `reverse/exports/`、`reverse/build/`、`reverse/logs/`：大批量产物与日志，忽略 Git。

## 当前进度

- 已建立独立 worktree，保留原目录 `5.6` 分支和终章分支。
- 164/164 个 SWF 已完成结构盘点、脚本及资源导出；19,910 个 AS 文件与原始 ABC 的脚本单元数量逐包一致，未发现导出超时或错误占位。
- REA 对当前 SWF 不提供语义反编译；已实测其二进制识别边界和熵分析。FFDec 负责 Flash/AVM2、资源和脚本恢复，详见 `reverse/docs/rea-capability.md`。
- 主程序全部 710 个脚本已重新编译；修复空语句及 XMLAsset 导入冲突，保留完整 712 类、7,148 方法。它已使用独立测试存档启动、读档、进入村庄、地图和普通战斗。此时外部资源仍为原版，不代表全包已重建。
- DataX 全部 292 个 AS 文件已编译，11 个 XML 方法的 3,087 条配置记录已核对；资源库批量重建和帧图像对照进行中。
- 核心候选 fee59837 已通过普通攻击、技能、落月之原全部五房间/Boss/结算、装备卸下和穿回、保存后退出播放器重读、主线1接受/触发/奖励；外部163包仍为原版。完整资源重建与原版对照尚待验收。

## 已有复现命令

在本目录运行，Python 使用 `/opt/miniconda3/envs/Qubit/bin/python`：

```sh
python reverse/tools/swf_inventory.py
python reverse/tools/export_swf.py --mode scripts --jobs 2
python reverse/tools/export_swf.py --mode assets --jobs 1
python reverse/tools/build_main.py --all-definitions
python reverse/tools/probe_normalize_swf.py reverse/build/main-probe/main-all-raw.swf reverse/build/main-probe/main-normalized.swf --original 3_L4399Main_gamefile.swf
python reverse/tools/datax_build.py
```

构建脚本暂时使用相邻原版目录的已有 Java、FFDec、Flex 和 playerglobal。后续要增加统一入口与工具探测，当前不能宣称全新机器一键可复现。

## 待办

1. 全部 SWF 标签、ABC、SymbolClass 与资源清单。
2. 全量脚本/配置导出及失败报告。
3. 小模块到主程序的源码编译和资源重建。
4. 隔离存档运行对照，完整记录成功、失败与未测项。
5. 阶段提交、工具路径与复现命令、最终验收审计。

## 维护记录

- 2026-10-24（北京时间）：开始四小时系统逆向；UTC 起点见 session.json。当前所有验收均未完成。
- 2026-10-24 00:27：全量导出阶段完成；主程序修复了实际读档时的 `ReferenceError #1065: com undefined`。关卡一房间已清怪并进入下一房间；当前整体 Goal 继续进行，未达到四小时及完整玩法验收。

- 2026-10-24 01:05：核心候选完成落月之原 Boss、装备/冷启动读档及第一条主线任务实测。已核验三份受保护存档哈希未改变。全部162资源模块已编译候选，发现并正在补回28个按钮SymbolClass和少量根时间轴/shape依赖；在修复与验证前不计全包完成。统一入口 `reverse/tools/rebuild_project.py` 已有严格组装门槛。
