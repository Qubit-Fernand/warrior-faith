# 章节验收辅助程序

这些程序提供隔离测试输入和诊断；它们不替代真实游戏通关。

- `save_contract/`：复制真实 LocalSaveManager，仅将存储接口替换为内存事件对象，编译后在官方 Flash Debugger 运行。36项已于2026-10-26 02:10通过；不证明原生权限弹窗已经测试。
- `add_start_roles.py`：在播放器完全退出后，仅向独立 `yzlr2_rebuild_epilogue_v2.sol` 的空槽3、4、5追加起点。分别为正常属性完整流程、毕业属性且金币达到原上限、原主线70未提交。起点均不含新章节状态；已有槽位逐一做AMF图等价检查，写入前保存整份备份。拒绝占用槽位与其他保存名，不可重复覆盖。

实际运行记录与私人备份在 `chapter/evidence/private/`，不提交Git。新增测试槽不代表胜利、结局或奖励已验证。正式体验起点仍由 `reverse/tools/chapter_fixture.py` 生成。
