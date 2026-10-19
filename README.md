# 勇者的信仰 · 本地游戏与同人终章

基于《勇士的信仰》5.6 单机包的本地运行、存档工具和同人终章开发项目。非官方项目；原游戏、角色、美术、音乐和随包工具的权利归各自权利人所有。本仓库未对第三方资源授予新的许可。

## 版本

| 分支 | 内容 |
| --- | --- |
| `5.6` | 原版 5.6 游戏、macOS 启动器、毕业体验档与存档工具 |
| `codex/final-chapter` | 在原版基础上加入同人终章的开发版本 |

**当前分支：原版 5.6。** 本分支不包含终章源码或终章入口；终章开发情况请切换到 `codex/final-chapter` 查看。

```sh
git clone https://github.com/Qubit-Fernand/warrior-faith.git
cd warrior-faith
git checkout 5.6                  # 原版
# 或者
git checkout codex/final-chapter  # 同人终章开发版
```

切换前先在游戏内保存并退出播放器。不要使用强制 checkout 丢弃自己的改动。Git 管理程序版本，实时角色存档不会随分支切换或回滚。

## macOS 运行

双击目录内 `勇士的信仰.app` 或 `启动游戏.command`，启动当前分支对应的版本。脚本使用 Adobe Flash Player 32.0.0.465 Mac 独立播放器，首次运行会从 Adobe 官方地址下载并验证 SHA-256。Apple Silicon 需要 Rosetta；原版包附带的 Windows EXE/CMD 不用于 Mac 启动。

- 原版：读取角色后正常游玩。
- 终章：先读取角色，再点击右上角「终章 · 归来的曙光」。这是新写的同人剧情，复用原版地图、敌人素材和战斗系统。
- 使用英文输入法；A/D 移动、K 跳跃、J 攻击，其他键位以游戏内说明为准。
- 退出前在游戏内「系统 → 保存进度」，确认保存成功后按 `⌘Q`。启动脚本在启动前、退出后备份已写入磁盘的存档。

目前 Python 工具和终章启动脚本使用 `/opt/miniconda3/envs/Qubit/bin/python`，这是开发机环境路径；其他机器应修改为可用的 Python 3 路径。播放器官方下载地址和后续 macOS 兼容性可能变化。

## 目录

```text
3_L4399Main_gamefile.swf  原版主程序
Map*.swf / Enemy*.swf    地图、敌人及其他原版资源
启动游戏.command         当前分支的启动脚本
勇士的信仰.app           调用启动脚本的 Mac 图标入口
presets/                毕业体验角色预设
tools/                  SOL 编解码、角色创建和导入工具
mod/                    终章源码、剧情配置和构建脚本（终章分支）
终章入口.swf             编译后的终章逻辑（终章分支）
终章核心.swf             使用独立存档名的主程序副本（终章分支）
SHA256SUMS              原版 166 个文件的校验清单
```

`.runtime/`、`save-backups/`、`saves/` 和原始 RAR 不纳入 Git。原版资源可用 `shasum -a 256 -c SHA256SUMS` 校验。

## 存档

Flash 实时存档位于：

```text
~/Library/Preferences/Macromedia/Flash Player/#SharedObjects/<本机随机目录>/localhost/
```

| 文件 | 用途 |
| --- | --- |
| `yzlr2_saves.sol` | 原版角色 |
| `yzlr2_final.sol` | 终章角色；首次从原版复制，之后独立保存 |
| `yzlr2_epilogue.sol` | 终章进度和结局；开发版本还含调试记录 |

实时存档和 `save-backups/` 不上传。恢复备份前先退出播放器，并保留当前存档副本。

`presets/毕业体验档.sol` 是单角色预设：85 级、剑杖双职业、六件 +10 装备，装备固定属性为原表的 10 倍，属于自定义体验数值。它不代表正常掉落的极限装备，也不包含个人旧账号云存档。导入前请阅读 `tools/import_preset.py` 的参数帮助；工具自动备份当前完整存档。`tools/create_graduate_save.py` 可从已有角色生成预设，省略 `--apply` 时仅生成候选文件。

## 终章开发

- `mod/story.json`：三章对话、战斗配置、两个结局。
- `mod/src/Epilogue.as`：章节菜单、战斗流程、封印与进度逻辑。
- `mod/generate_story.py` 和 `mod/build.sh`：将剧情嵌入 ActionScript 并编译入口。
- `tools/prepare_epilogue.py`：校验原版主程序、生成独立核心、初始化并备份终章存档。核心仅替换存档名 `yzlr2_saves` → `yzlr2_final`。

这不是原始 FLA 工程。原版通过 FFDec 分析；新增逻辑由 Apache Flex 编译。构建依赖 Java 21、Apache Flex SDK 4.16.1、playerglobal32 和 Python 3，可通过 `EPILOGUE_JAVA`、`EPILOGUE_FLEX`、`EPILOGUE_PLAYERGLOBAL` 指定本机路径。工具安装包和反编译结果不在仓库中。

```sh
./mod/build.sh
```

待完成：第三战封印交互、最终战与结局实测、第二战至第三战的特效清理复测、失败重试、回血上限及调试记录清理。

## 已知限制与来源

- Adobe Mac 独立播放器已验证原版创建角色、保存重读、村庄和幽灵船战斗；未逐一验证所有地图。
- Ruffle 0.7.1 在本游戏保存时发生 AMF 序列化崩溃，当前不作为运行方案。
- 村庄左侧特殊传送门曾卡在加载画面，普通世界地图右侧入口已验证。
- 离线包发布线索：https://www.bilibili.com/opus/1144775248772595719
- 原版主程序保留原样；同人剧情并非官方续作。所有修改仅用于本地单机体验。
