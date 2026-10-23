# 业务类副本的反编译损失修复

游戏的多个资源 SWF 含有同名业务类，不同副本版本并不完全相同。本轮没有按同名类统一替换：先从每个原 SWF 导出目标类的 P-code，保留完整命名空间、原文件与方法哈希，分别核对控制流与有限路径，再修改已证实的源码片段。主程序由另一份审计单独处理，本文统计只含非 Main 副本。

最终源码冻结账本是 `reverse/manifests/nonmain-semantic-source-freeze.json`：461 个文件、1,363 个方法修改。

| 修复 | 方法数 | 原版证据与修改边界 |
| --- | ---: | --- |
| addGold 上限条件 | 48 | 49 个带上限原副本均为 `ifngt`，取分支到写金币；Main 单独修复，其余 48 份恢复 `!(sum > cap)`。36 个无上限副本未改。 |
| 背包/仓库非堆叠扫描 | 444 | 每份实际原 P-code 跑遍 24/35 格的每个单空位及全满场景；恢复有界扫描及失败返回。 |
| EquipSlot、Bag、ChongWu 关系条件 | 736 | 分别核验原比较操作数与取/不取分支的局部效果，恢复 NaN 时不同的否定关系语义；不声称整方法等价。 |
| SetKeyPanel.closeOk / Achievement.getIddo | 135 | 分别核验原按键与多地图路径，恢复被错误 `continue` 跳过的递增及循环退出。 |

普通非堆叠副本覆盖 83 个模块、438 方法、12,589 个具体路径 fixture。Enemy202 另有 6 方法、172 个 fixture：原代码含 `CheckTest.Testing/TestingOther` 与成功、失败出口的 `setMD5/setMD5Other` 调用，修复保留对应调用顺序。此特殊证明将调用体视作不透明操作，以 Testing 返回后的任意格位状态分析局部扫描；没有宣称模拟校验函数。

Enemy20 与 Enemy202 的成就方法还有原始 `trace`。单独的 4 方法、36 个 fixture 保留了全部 trace 表达式及参数文本；没有用普通版本整个方法覆盖它们。其余 continue 副本为 131 方法。

关键账本：

- `addgold-original-49-proof.json`：全部 49 份原方法指令、字节码、分支方向与哈希。
- `nonstack-copy-original-proof.json`、`ordered-copy-original-proof.json`、`continue-copy-original-proof.json`：每原模块的局部证据与候选源码前后文本。
- `enemy202-nonstack-proof.json`、`trace-continue-copies-proof.json`：保留副作用的特殊路径模型与完整原指令。
- 对应的 `*-applied.json`：实际源码修改前后 SHA。部分文件包含多批不同方法修改，前一批 SHA 是中间状态；最终状态以 source-freeze 为准。

`verify_nonmain_semantic_repairs.py --watch` 只接受已按冻结源码重新编译、具有构建前指纹及事后核验的产物；按产物 SHA 导出 P-code，再检查全部 1,363 个修复方法；仅当完整输出字节哈希相同时，允许复用该哈希下已经导出的 P-code，不按模块名或旧世代直接复用。它同时支持优化与未优化编译器的等价布尔分支形态，保留实际 guard witness；循环模型仅允许明确支持的指令，未知路径拒绝通过。进度在 `nonmain-semantic-validation-progress.json`，逐产物报告在 `reverse/manifests/nonmain-repair-verification/`。

这些是局部语义与有限路径验证，并非 AVM2 全模拟、全游戏等价证明或游戏运行验收。初期新目录的固定提交 875 基准仍保留已证实的旧问题，不能把它的构建成功当作本轮修复成功；见 `cleanroom-875-partial.json`。构建后的实际游戏验收由运行测试记录单独说明。

修复脚本是一次性的证据驱动迁移入口，会拒绝覆盖已有最终账本；日常修改和重建请直接编辑 canonical `reverse/source/`，使用统一构建入口，不要重复应用本轮迁移脚本。

## 编译器 trace 剥离的后续修正

实际新 ABC 验收发现，Enemy20 的 trace 源码虽保留，默认编译产物仍省略了调用。独立微型实验 `trace-compiler-omission-probe.json` 进一步确认：在与项目相同的 `debug=false`、空 load-config 下，默认设置不仅移除 trace，还移除其参数中的函数调用；显式 `-compiler.omit-trace-statements=false` 同时保留两者。

因此 Main、DataX、资源三条 recipe 均已显式保留 trace，并重新生成构建世代。旧 tracefalse 批次的部分验收与失败诊断保存在 `nonmain-pretrace-validation.json`；它不是新版完整通过报告。新 watcher 同时检查所有 build_recipe 输入哈希，避免把旧 tracefalse 产物算作新结果。资源队列切换时等待当前编译完成，仅停止尚未生成任何子进程的下一批 Python 入口；见 `resource-queue-drain-for-trace.json`。

最终汇总入口 `audit_nonmain_semantic_final.py --wait` 会在全部 84 个非 Main 模块通过后，再核对逐模块产物、构建世代、receipt、验证器与最终源码哈希，以及实际成功编译命令中的保留 trace 参数。资源命令的日志时间须位于该世代的构建前 capture 与事后 postcheck 之间。仅在全部检查通过时写出 `nonmain-semantic-final-validation.json`；进度文件本身不等于完整验收。

## 当前新产物验收结果

保留 trace 的新构建现已通过全部 84 个非 Main 模块、1,363 个修复方法的检查，其中循环模型执行了 13,976 个有限路径 fixture，未发现未解决失败。补齐全部实际证明输入的哈希后，全部方法已再次执行检查。`nonmain-semantic-final-validation.json` 同时确认：当前源码冻结哈希匹配、逐产物/世代/receipt 与验证器输入一致、实际编译命令保留 trace。每个模块的详细报告均记录完整证据输入哈希；此结论不扩大到未检查方法、任意运行状态或全游戏等价。

## Main 与非 Main 的最终语义修复摘要

两组累计修复 **1,387 个模块内方法位置**（Main 24 + 非 Main 1,363）。同名方法存在多个历史版本，不能把此数量当作 1,387 个互不相同的业务功能，也不能把两组不同验证范围合并成全游戏等价证明。

| 范围 | 当前产物与报告 | 已验证内容 | 结论边界 |
| --- | --- | --- | --- |
| Main：24 方法 | `main-semantic-repairs-validation-71b7c20c9edc.json`，输出 SHA `71b7c20c9edcc1da4dc3142bedfdc0572fe658a62bf4fd35252f854567370648` | 15 处关系条件与紧邻分支效果；6 个容器方法的 172 个实际 P-code 场景；2 个 continue 循环方法的 18 个场景；商店 `setDown` 的 int32 减量恢复 | 检查实际新 ABC 的指定局部条件、受限循环模型与数值语义；该报告未启动播放器或访问存档 |
| 非 Main：84 模块、1,363 方法 | `nonmain-semantic-final-validation.json`，逐模块输出 SHA／构建世代详见报告 | 48 addGold、736 其他关系条件、444 非堆叠循环、135 continue 循环；循环共 13,976 个有限路径场景。Enemy20/Enemy202 的 trace 参数与 CheckTest 不透明调用顺序分别核验；实际 keep-trace 编译命令与完整输入哈希通过 | 关系条件为局部分支证据；循环只执行明确支持的实际 P-code 路径。不是完整 AVM2 模拟，不涵盖未列出的方法或任意游戏状态 |

Main 的源码修改来源分为 `main-semantic-repairs.json` 的 22 方法与 `main-continue-repairs.json` 的 2 方法，前者单独写“22”不代表遗漏后续两项。旧 `main-semantic-repairs-validation-2c0b888c0b16.json` 是先前构建的报告，应按输出 SHA 区分，不能代替上述保留 trace 的新产物。

另有独立的真实类执行证据 `reverse/experiments/actual-class-harness/runtime-comparison.json`：官方 Adobe 调试播放器在移除 Main 文档类绑定、保持游戏 ABC 原字节的库中执行每轮 172 个 Bag/Storage 场景和 11 个 Achievement 场景。该证据与上述静态／受限 P-code 模型不同；它不覆盖 SetKeyPanel、完整游戏生命周期或全游戏等价，也不应重复计入修复方法数量。实际包内玩法验收另见运行记录。
