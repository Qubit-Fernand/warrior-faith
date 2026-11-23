# 回村归航契约测试

`build.py` 将当前 canonical 的 ChapterState、ChapterScenery、LanternCrossing 原样复制到独立目录，记录摘要，编译 SWF9 的 `HomecomingHarness.as`。不导入 Main，不加载玩家，不打开游戏 SOL。

在 Adobe Flash Debugger 中打开构建输出，26 项断言检查旧档新增收尾、顺序防护、错误方向、部分进度序列化、已完步骤防重复、奖励保留、长明隔离与未来版本保护。结果仅写 `returnlight_homecoming_contract_v1` 的诊断 SOL。编译本身不代表运行通过，真实报告见 `chapter/evidence/homecoming-contract.json`。

此测试不证明 Controller 场景连接、玩家移动范围、真盘冷启动或按钮排版正确，仍需完整游戏窗口验证。
