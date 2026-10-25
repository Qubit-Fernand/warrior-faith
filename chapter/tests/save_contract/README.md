# LocalSaveManager 的独立 AS3 契约测试

这个测试编译当前真实 `LocalSaveManager.as` 的隔离副本；不是 Python 镜像保存逻辑。运行时由真实 AS3 类执行快照、确认、回滚、pending 锁和 NetStatus 回调处理。

## 隔离方式

`build.py` 在新的 `reverse/build/chapter-save-contract/run-*/source/` 中复制测试源和当前 canonical 保存类，只作三类精确文本替换：

1. `import flash.net.SharedObject` 换为 `chaptertest.FakeSharedObject`；
2. 两处 SharedObject 类型换为 fake 类型；
3. `SharedObject.getLocal(SO_NAME)` 换为 fake 的 `getLocal`。

每个替换点有固定出现次数断言；反向替换后必须与 canonical 原始字节完全一致。因此没有更改保存控制流。canonical 文件在编译后再次校验未变，并保存 SHA-256 到 receipt 与生成的 BuildInfo。

FakeSharedObject 是 EventDispatcher，只在内存模拟 `data`、flush 返回值/抛错、持久化快照和 NetStatus；它不导入或打开真实 SharedObject。canonical 中的原 SO_NAME 字符串只传给 fake，永远不会成为本测试的真实存储目标。

唯一真实 SharedObject 是测试结果：`yzlr2_rebuild_save_contract_diag_v1`，路径 `/`。测试不读取或写入真实游戏槽位，不导入 Main/Controller，不自动启动播放器。

## 覆盖范围

共 36 个 AS3 断言，按真实异步事件时序分段执行：

- getLocal 异常、初始化不隐式 flush；
- 同步 flushed 与同步结果不调用异步回调；
- 完整嵌套数据/背包快照、读取副本不污染确认数据；
- 两个槽位隔离；
- 异常 flush 返回值和 flush 抛错后的内存回滚；
- pending 期间读到旧确认槽位，拒绝覆盖/另一槽写入；
- 等待期间 live data 改动不会混入待写快照；
- 无关 NetStatus 不完成事务；
- 成功/失败回调各只调用一次，重复事件被忽略；
- pending 拒绝后保留旧确认内容；
- 回调执行前释放 pending 锁，允许回调发起下一笔完整保存；
- 读回 fake 持久化内容与原提交对象对应。

Canvas 固定显示 RUNNING/PASS/FAIL 标题，下方可滚动检查列表。结果 JSON 包含每项结果、最终确认/模拟磁盘数据、canonical SHA 与构建 generation。诊断结果的 `reportMemoryReadback` 只是报告 SharedObject 的内存读回，不冒充磁盘冷启动证明。

## 使用

```sh
python3 -B chapter/tests/save_contract/build.py
```

脚本只编译独立 harness，用既有 Main 相同的 `strict=false` / playerglobal32 设置。没有调用主项目构建、import、组装或播放器。曾尝试 strict=true，Flex 对未改动的 saveSlot try/catch 返回路径给出“函数没有返回值”；最终保持主项目既有设置，没有为通过测试添加保存控制流。

由主任务另行打开输出 SWF。运行结束后读取指定的诊断文件：

```sh
python3 -B chapter/tests/save_contract/read_report.py /实际路径/yzlr2_rebuild_save_contract_diag_v1.sol
```

reader 只接受该专用名字（含 Flash 可能省略前缀后的文件名形式），同时验证 SOL 内部名称，拒绝读取游戏存档。

## 本次产物与状态

- 已编译：`reverse/build/chapter-save-contract/run-20261025T172612.793533Z/SaveContractHarness.swf`
- SWF SHA-256：`c9d2405dc4e2c94e3ccaaa8e2ac1f69125028bb80a030e8ed499de819aa07951`
- 受测 canonical SHA-256：`a2b7d7494f51afe079432cffea840de3567302c2588d5f79e414bb99759ad093`
- 同目录 `receipt.json` 保存适配点、输入/输出 SHA、编译命令和 `runtime_executed:false`。

**2026-10-26 02:10 已通过 Finder 使用官方 Flash Debugger 实际运行，Canvas 显示 PASS（36 checks），完全退出后读取专用诊断 SOL：completed=true、pass=true、failures=0，受测 canonical SHA 与上述一致。** 截图与完整报告在 `chapter/evidence/private/033-save-contract-*`。reader 另显式支持实际观察到的 macOS `yzlr2_re#/build_save_contract_diag_v1.sol` 分段路径，仍核对完整 SOL 内部名称。 即使将来 fake 测试全部通过，也不能证明原生 Flash 存储许可弹窗的 pending 允许/拒绝已真实触发；那仍需独立运行验证。本测试也不覆盖 Main 的提示 UI 或 Controller 跨场景/跨 slot 队列。
