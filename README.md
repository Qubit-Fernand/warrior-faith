# 勇士的信仰 5.6 单机版

本地游戏资源与恢复仓库，整理于 2026-10-19。

## 位置与来源

- 游戏目录：`/Users/AntiEntropy/Games/勇士的信仰5.6单机版`。本机 `~/games` 与 `~/Games` 指向同一个目录。
- 用户下载的原包保留在 `/Users/AntiEntropy/Downloads/勇士的信仰5.6单机版等4个文件.rar`。
- 原包 SHA-256：`28fcf38ddd6996bad7391cf5e07c09d8bda3a1aefd8548a6c6731b01a5a77a08`。
- 对应发布线索：https://www.bilibili.com/opus/1144775248772595719
- 内层 `勇士的信仰5.6.rar` 也保留在本目录，但不重复纳入 Git；解压后的游戏文件已全部纳入 Git。

## 文件与当前状态

- 164 个 SWF 文件，包含主程序、地图、角色、敌人、装备和音乐资源；保持原有同目录布局。
- `3_L4399Main_gamefile.swf` 为已验证的主程序；外层单独提供的文件与内层同名文件 SHA-256 完全一致，未修改其内容。
- `FlashPlayerStandAlone.exe` 为随包附带的 Windows 播放器，不能由 macOS 直接运行。
- `白屏修复-放游戏目录管理员身份运行.cmd` 为随包附带的 Windows 脚本；整理过程中未执行。
- 已使用 Adobe Flash Player 32.0.0.465 Mac 独立播放器进入村庄、保存进度，并在完全退出重开后读回第 8 槽位的 Lv1 角色。尚未验证完整关卡、战斗、商城及长期游玩。
- `SHA256SUMS` 记录全部 166 个原始游戏/工具文件的 SHA-256。
- 仓库仅在本地，未配置远端或上传。Git 快照用于恢复游戏文件；启动脚本另行备份本游戏存档，备份不纳入 Git。这些本地备份不能代替异盘备份。

## Git 与恢复

初始提交使用标签 `original-import` 固定，包含全部解压后的游戏资源、附带播放器、修复脚本和本说明。

查看当前改动：

```sh
cd "$HOME/Games/勇士的信仰5.6单机版"
git status --short
git diff --stat
```

以后修改游戏后，可按需保存新快照（提交前先检查暂存内容）：

```sh
git add -A
git diff --cached --stat
git commit -m "描述此次修改"
```

推荐的恢复方式是把初始版本导出到新目录，保留当前目录及所有修改：

```sh
cd "$HOME/Games/勇士的信仰5.6单机版"
restore_dir="$(mktemp -d "$HOME/Games/勇士的信仰5.6-恢复-XXXXXX")"
git archive original-import | tar -x -C "$restore_dir"
cd "$restore_dir"
shasum -a 256 -c SHA256SUMS
```

导出的目录包含可恢复的文件，不含 Git 历史和被忽略的原始 RAR。初始版本校验应全部显示 `OK`。

## Mac 上启动

1. 双击本目录的 `启动游戏.command`，自动打开游戏。使用 Adobe Flash Player 32.0.0.465 Mac 独立播放器，当前 Apple Silicon Mac 通过已有的 Rosetta 运行。
2. 点击「知道了」关闭更新说明。自己开始玩可选「新的开始」并使用第 1—7 个空槽位；第 8 槽位保留此次测试角色，也可从「读取存档」进入。
3. 使用英文输入法。常用操作为 A/D 移动、K 跳跃、J 攻击；完整键位以游戏内「操作说明」「系统 → 键位设置」为准。
4. **退出前点击「系统 → 保存进度」，确认出现「游戏保存成功」。** 然后按 `⌘Q` 退出播放器。
5. 启动脚本会在启动前和播放器退出后备份已有存档；游戏期间不要提前关闭脚本所在的终端窗口。备份只复制已写入磁盘的进度，不能代替游戏内保存。

播放器放在 `.runtime/adobe/Flash Player.app`，不是浏览器插件。无需运行包内的 EXE 或 CMD；未修改系统安全设置。

如果播放器缺失，脚本会使用本地 DMG，或从 Adobe 官方地址下载，并验证固定 SHA-256 后复制应用：

- 来源：https://fpdownload.macromedia.com/pub/flashplayer/updaters/32/flashplayer_32_sa.dmg
- SHA-256：`236ecef54a7d6c3eed739c74b7e14946b07b6156cbcedda3bbbf444f1d17023a`
- 下载文件保留在 `.runtime/downloads/flashplayer_32_sa.dmg`。
- 已检查 Adobe Developer ID 签名，Team ID `JQ525L2MZD`。该版本为历史播放器，只用于本地游戏；后续 macOS 或官方下载地址变化可能影响重装。

## 存档与备份

Adobe 当前实际存档：

```text
~/Library/Preferences/Macromedia/Flash Player/#SharedObjects/NS57UMMB/localhost/yzlr2_saves.sol
```

其中 `NS57UMMB` 是 Flash 生成的本机目录名，换机器可能不同。所有角色槽位在同一个 `.sol` 文件中。此次保存后文件为 24,381 字节，退出重开后第 8 槽位可读回。

启动脚本只备份 `#SharedObjects/*/localhost/yzlr2_saves.sol`，备份目录为：

```text
save-backups/时间-adobe-before或after-随机后缀/随机目录名/localhost/yzlr2_saves.sol
```

恢复时先退出播放器，保留当前存档副本，然后用所选备份覆盖当前 `.sol` 文件。换机器时应放进新机器实际生成的随机目录，而不是直接照搬旧目录名。存档并不保存在游戏文件或 Git 提交里；备份 `save-backups/` 才能保留游玩进度。

`.runtime/`、`save-backups/`、试验用空目录 `saves/` 均不纳入 Git。当前并未使用 `saves/` 存放实时存档。

## 兼容性记录

- **Adobe Mac 独立播放器：已验证新建角色、进入村庄、保存、退出重开、读档进入村庄。**
- Ruffle 0.7.1：可进入村庄，移动和跳跃有响应，但点击保存时 AMF 序列化栈溢出崩溃，无法正常保存，因此不作为本游戏启动方案。
- Ruffle stable 和下载用于排查的 nightly 仍保留在被 Git 忽略的 `.runtime/` 中；nightly 未进行游戏测试。早期不含 `adobe` 的备份目录是 Ruffle 的空测试存档，不可用于恢复 Adobe 进度。

## 待办

- 实际游玩时进一步确认战斗与后续关卡兼容性。

## 维护记录

- 2026-10-19：从用户 Downloads 中的 RAR 解压，保留原包；确认内外主 SWF 一致；建立 166 个游戏/工具文件的校验清单与本地 Git 初始快照 `original-import`。
- 2026-10-19：发现 Ruffle 0.7.1 保存崩溃；改用 Adobe 官方 Mac 独立播放器 32.0.0.465，验证第 8 槽位保存和退出重开读档；添加双击启动与前后存档备份。原始游戏资源保持不变。
