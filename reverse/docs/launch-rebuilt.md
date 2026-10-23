# 源码重建版双击入口

工程根目录的 `启动源码重建版.command` 是独立入口，原有 `启动游戏.command` 和原版应用快捷方式保持原样。脚本根据自身位置定位工程，不硬编码中文目录名。使用现有 Qubit Python，不安装依赖。

首次准备或编辑代码后，在工程根目录运行：

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rebuild_project.py build all
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rebuild_project.py assemble
```

已有正确的新构建凭据时，只需 `assemble`。缺少导出素材、原版文件或工具链时先按 [build-project.md](build-project.md) 准备；入口不会自动下载或用原版补齐。之后双击 `启动源码重建版.command`，校验完成才打开游戏。需要英文输入法；在游戏内保存，再正常退出播放器。

默认选择 `reverse/build/runtime-all-rebuilt-*` 中 `createdUTC` 最新的完整严格包。若最新包损坏或相对当前源码已经过期，直接失败，避免悄悄打开旧游戏。可明确选择另一个仍与当前输入匹配的完整包：

```sh
./启动源码重建版.command --package reverse/build/runtime-all-rebuilt-具体时间
```

## 启动前校验

- assembly 必须完整、164/164 源码重建、零原版 fallback；核对每个 SWF、包内来源 receipt 和 assembly 摘要。
- 每份 receipt 必须有真实构建前后输入指纹；重新检查当前源码整树、素材、修复脚本、恢复元数据、工具链和相关环境。源码编辑后需要重新构建、组装。
- 解析主 SWF 的实际 ABC 字符串池，必须只有 `yzlr2_rebuild_*` 独立存档名，不能含 `yzlr2_saves`。入口不扫描、备份、读取或导入任何 SOL；游戏运行时自行使用其独立测试存档。
- 使用已有 Adobe Flash Player Debugger 32.0.0.465，检查应用标识、完整代码签名与 Adobe Team ID `JQ525L2MZD`。先寻找工程 `.runtime/adobe-debug/Flash Player.app`，再从已配置 `.runtime/shared-tools` 的实际位置寻找同一 runtime 下的 adobe-debug。也可显式 `--player-app '/已有路径/Flash Player.app'`。
- 已有 Flash Player 或 Debugger 进程时拒绝打开新实例，避免同一测试存档被并发使用；不关闭现有程序。

通过后用 macOS `open -n -W -a` 直接打开包内主游戏 SWF，不加载 DiagnosticHarness，不改全局 Flash 配置。终端等待播放器退出。失败时终端显示具体原因与准确构建命令，双击时保留窗口等待回车。

## 只读检查与验证状态

```sh
./启动源码重建版.command --check
```

`--check` 核验文件与播放器签名，输出已运行播放器及 `launch_available`，绝不启动游戏。它退出成功表示文件与签名校验通过；若 `launch_available=false`，须先退出已有播放器。需要其他 Python 时可设置 `YZLR2_PYTHON`，但环境指纹变化可能要求重新构建。

脚本和签名检查、旧无指纹包拒绝、源码输入过期的隔离回归均由子任务完成。检查不等于 Finder 冷启动、画面或玩法验收；主任务负责停止服务后的真实双击启动验证。历史运行包在源码变更后仍是有效历史记录，但默认启动入口只接受与当前输入匹配的新包。
