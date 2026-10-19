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
- 已使用 Adobe Flash Player 32.0.0.465 Mac 独立播放器进入村庄、保存进度，并在完全退出重开后读回第 8 槽位的 Lv1 角色。后续已验证毕业档进入三星幽灵船、移动/攻击/释放技能及保存重开；未逐一测试全部关卡、商城及长期游玩。
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
2. 点击「知道了」关闭更新说明。直接选择「读取存档 → 01」进入 85 级毕业体验档；第 8 槽位保留原来的 Lv1 角色，第 2—7 槽位可用于新建。
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

## 旧账号存档与网络存档调查（2026-10-19）

- 用户记得有 4399 账号，可能使用云存档；尚未登录确认旧角色是否仍在。
- 当前离线包实际使用本地 `yzlr2_saves.sol`。云端角色需先通过本人账号正常读取，再研究导出数据与离线格式的转换；不能仅凭账号存在就断言能导入。
- 4399 官方资料中后续作品称为「勇者之刃信仰篇」，含远高于 5.6 的版本与新装备。新版数据回导 5.6 的兼容性未验证，不能直接覆盖现有存档。
- 搜索找到神装/极限存档线索，但未找到并验证可直接下载、兼容此离线包的通关 `.sol`：
  - B站「傲天易尘」2024-01-20 发布的极限存档/定制展示：https://www.bilibili.com/video/BV1tN4y1n7W8/ 。公开检索未确认独立存档下载链接。
  - 河马存档商店：https://www.4399hm.com/ 。页面宣称提供 99 级、绝世套装、上古武器的账号存档服务；这是第三方商家自述，未验证交付、安全或离线兼容性，未购买、未提供账号。
  - 当前离线版作者发布页：https://www.bilibili.com/opus/1144775248772595719 。页面提供游戏包与更新说明，未见通关存档附件。
- 官方旧入口 https://www.4399.com/flash/80727.htm 本次访问重定向到「勇者之刃」专题；核对旧角色时应明确选择「信仰篇」，避免进入「荣耀篇」。本次仅做公开检索和本地只读检查，没有覆盖存档或修改线上账号。

## 毕业体验档（2026-10-19）

用户选择「满级、神装、解锁关卡」，已写入本机第 1 槽位。第 8 槽位原角色经递归比较内容不变；Flash 重存时会调整动态字段顺序，因此文件字节不一定相同。

- 本包实际等级上限 **85**；剑、杖双职业转职/重生，剑杖技能和被动按本包各技能上限设置，额外 999 技能点。
- 热血—玄冰四件套 + 光之印记 + 真·绝杀者之杖，共六件 **+10**，两条附加攻击/暴击取表内上限。
- 为直接体验后期战斗，六件装备的固定属性设为原表的 **10 倍**，属于自定义体验数值；强化加成仍按本包表内 +10 数值。并非宣称正常掉落的合法极限词条，也未装入本包要求 100 级的新版装备。
- 已验证面板：HP 48,848、MP 17,571、剑攻击力 7,104、防御 3,658。
- 金币 9,999,999，击杀点 999,999。普通关卡进度设为 3，五座女神修复标记、村庄与水下入口标记已开启。没有伪造全部任务、图鉴和成就完成。
- 关卡 ID 来自本包数据：1–23、51–55、81、101–105。解锁标记不等于逐一验证每个地图均能运行。
- 已实测：读入 85 级角色、打开背包、选择并进入三星幽灵船、移动/攻击/释放技能、游戏提示保存成功、完全退出再读档仍为 85 级且装备属性保留。
- **已知限制：村庄最左侧地面特殊传送门测试时曾卡在加载画面；尚未定位原因。普通世界地图请走村庄最右侧地面传送门，按 W 进入，已验证可用。** 原始 SWF 未修改。
- 游戏正常保存后会把槽位标题改回 `P1:Lv85`，不影响体验档内容。

### 备份与复原

修改前完整存档：`save-backups/20261019-154229-graduate/before.sol`。
游戏保存验证后的完整存档：`save-backups/20261019-154229-graduate/verified-after-game-save.sol`。
`presets/毕业体验档.sol` 仅含体验角色，纳入本地 Git；现有其他角色不包含在该预设内。实时游玩存档和自动备份仍不纳入 Git。

恢复第 1 槽位到初始毕业体验状态（先退出 Flash；工具自动备份当前完整存档，保留其他槽位）：

```sh
cd "$HOME/Games/勇士的信仰5.6单机版"
/opt/miniconda3/envs/Qubit/bin/python tools/import_preset.py \
  "$HOME/Library/Preferences/Macromedia/Flash Player/#SharedObjects/NS57UMMB/localhost/yzlr2_saves.sol" --slot 1 --replace
```

重新从第 8 槽位制作到一个空槽位，例如第 2 槽位：

```sh
/opt/miniconda3/envs/Qubit/bin/python tools/create_graduate_save.py \
  "$HOME/Library/Preferences/Macromedia/Flash Player/#SharedObjects/NS57UMMB/localhost/yzlr2_saves.sol" --source-slot 8 --target-slot 2 --apply
```

可加 `--stat-multiplier 1` 制作保持原装备固定数值的版本；默认 10。省略 `--apply` 仅在备份目录生成候选文件，不写实时存档。工具拒绝覆盖占用槽位，换槽位时同步更新离线校验 token 内的槽位编号。

### 实现与维护

- `tools/sol.py`：仅依赖 Python 标准库的 AMF3/SOL 编解码，保留类型、数组、共享引用和循环引用；未知类型直接报错。
- `tools/create_graduate_save.py`：复制角色、配置等级/装备/技能/解锁、校验往返和其他槽位不变、保存修改前副本后写入。
- `tools/graduate-data.json`：从本包 DataX_v76.swf 装备/技能/地图表和主 SWF 强化表提取的必要条目。
- `tools/import_preset.py`：恢复预设到指定槽位，同时备份已有存档。
- 只读分析使用 FFDec 26.3.0 + Temurin 21；下载、解包、反编译和完整 XML 均在被忽略的 `.runtime/` 内。运行修改工具无需 Java 或反编译器。
