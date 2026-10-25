# 章节验收辅助程序

这些程序提供隔离测试输入和诊断；它们不替代真实游戏通关。

- `save_contract/`：复制真实 LocalSaveManager，仅将存储接口替换为内存事件对象，编译后在官方 Flash Debugger 运行。36项已于2026-10-26 02:10通过；不证明原生权限弹窗已经测试。
- `add_start_roles.py`：在播放器完全退出后，仅向独立 `yzlr2_rebuild_epilogue_v2.sol` 的空槽3、4、5追加起点。分别为正常属性完整流程、毕业属性且金币达到原上限、原主线70未提交。起点均不含新章节状态；已有槽位逐一做AMF图等价检查，写入前保存整份备份。拒绝占用槽位与其他保存名，不可重复覆盖。

实际运行记录与私人备份在 `chapter/evidence/private/`，不提交Git。新增测试槽不代表胜利、结局或奖励已验证。正式体验起点仍由 `reverse/tools/chapter_fixture.py` 生成。

- `copy_earned_role.py`：将哈希固定的实战检查点复制到新保存名的空槽，仅改槽位身份与标题；章节状态逐字段保持不变，已有槽位逐一校验。槽6用于双结局合法分歧测试。
- 播放器切换角色必须完整退出后重开；“打开最近文件”会保留旧窗口，可能争用同一保存名。正式启动器检测到任意 Flash 播放器时拒绝再启动。037诊断因此作废，038及之后为单窗口重做证据。

- `add_future_role.py`：只向空槽7加入版本99、零章节完成和独立opaque字段的兼容性起点，用于验证旧程序不降级或丢弃未来状态；追加前后备份并验证其他槽位完全不变。准备成功不代表运行验收。

## 完整 SOL 存档组切换与恢复

`switch_save_group.py` 用于八槽已满时切换独立验收组。它固定只操作当前 `NS57UMMB/localhost/yzlr2_rebuild_epilogue_v2.sol`，不改保存名、游戏包或 Flash 全局设置，没有编辑角色、金币或完成标记的接口。源仅允许 `chapter/fixtures/` 或 `chapter/evidence/private/checkpoints/` 下的完整 SOL。目标或源、其父路径若是符号链接，或文件有硬链接，都会拒绝。

先完整退出所有 Flash Player / Debugger。显式提供源文件 SHA 与当前 live 文件 SHA；默认仅预检，不创建目录、归档或临时文件。以下参数值须从对应实际文件核验，不要照抄旧轮次 live SHA：

```sh
python3 chapter/tests/switch_save_group.py \
  --source chapter/fixtures/归光之约-起点.sol \
  --source-sha256 7f21943d9c500e3c7636ef6aaa76f1de24789f7506d5be21b2b9789abbade4dd \
  --expected-live-sha256 <当前整份live文件的SHA256>
```

核对预检返回的路径、incoming/outgoing SHA 与占用槽位后，同样参数加 `--apply` 才执行。它先在唯一的私人 `chapter/evidence/private/checkpoints/save-groups/<时间戳-随机ID>/` 写入 `outgoing.sol`、`incoming.sol` 和 `prepared.json`；所有文件排他创建、fsync、读回验证，保存的是原始完整字节，不经过 AMF 重编码。然后同目录临时文件写入目标内容，再次确认播放器全部退出、live 字节与 inode 未变、源字节未变，才原子替换。读回成功后生成独立 `installed.json`，不覆盖 prepared 记录。

这份起点夹具有普通槽1、毕业槽2，均无新章节状态；它是已声明的 preset 派生测试起点，不代表实战赚得进度。若使用实战检查点，必须保留其真实章节状态，不能把中途检查点称为全流程起点。

**恢复旧组仍然调用同一工具**：以某轮归档的 `outgoing.sol` 为 `--source`，使用该归档的 SHA，并重新核验当前 live SHA。工具会先完整归档本轮新赚得的全部进度，再恢复旧组的原始字节；不要直接复制覆盖 live 文件，不要为了恢复清空新槽。不同组只能轮流处于 live 位置，所有历史版本均保留在私人归档中。

操作中断或校验失败时不自动回滚，也不删除文件：若只有 prepared 而无 installed，须比较实际 live SHA 与该记录的 incoming/outgoing SHA，确认替换是否已经发生。临时文件和完整归档保留以供检查；不要在播放器运行期间重试。进程双检查不能禁止用户在两次检查之间手动启动播放器，因此整个切换期间应保持所有播放器关闭。工具不会停止进程或改变任何全局设置。

实现验证：仅在隔离临时目录替换模块路径常量与进程检查入口，12 类场景通过：默认预检无写入、完整 apply、反向恢复先归档新组、错误双 SHA、同源目标、源/父路径软链接、硬链接、内部名称与8槽、准备期间 live/source 改变、第二次进程检查阻止切换、排他归档不覆盖。验证未对真实保存运行 `--apply`，没有启动播放器。测试临时文件保留，未执行删除。
