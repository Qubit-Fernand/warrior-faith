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
- `3_L4399Main_gamefile.swf` 为主程序候选；外层单独提供的文件与内层同名文件 SHA-256 完全一致，未修改其内容。
- `FlashPlayerStandAlone.exe` 为随包附带的 Windows 播放器，不能由 macOS 直接运行。
- `白屏修复-放游戏目录管理员身份运行.cmd` 为随包附带的 Windows 脚本；整理过程中未执行。
- 完成解压和文件校验，尚未安装播放器或验证 Mac 上的启动、游戏流程及存档。
- `SHA256SUMS` 记录全部 166 个原始游戏/工具文件的 SHA-256。
- 仓库仅在本地，未配置远端或上传。Git 快照用于恢复游戏文件，不自动备份播放器存放在目录外的游戏进度，也不能代替异盘备份。

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

## 待办

- 尝试 Mac 版 Ruffle 加载主 SWF；如有兼容问题，再评估独立 Flash 播放器或 Windows 运行环境。
- 验证开始游戏和存档位置后，补充启动及存档备份方法。

## 维护记录

- 2026-10-19：从用户 Downloads 中的 RAR 解压，保留原包；确认内外主 SWF 一致；建立 166 个游戏/工具文件的校验清单与本地 Git 初始快照。
