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
- 每份 receipt 必须有真实构建前后输入指纹；重新检查当前源码整树、素材、修复脚本、恢复元数据、工具链。源码编辑后需要重新构建、组装。启动路径不运行Java或编译器；LANG/LC_ALL及Java构建选项等仅构建环境差异记录名称而不阻止启动，不记录值。真正build/assemble仍要求严格环境指纹。
- 解析主 SWF 的实际 ABC 字符串池，必须只有 `yzlr2_rebuild_*` 独立存档名，不能含 `yzlr2_saves`。入口不扫描、备份、读取或导入任何 SOL；游戏运行时自行使用其独立测试存档。
- 使用已有 Adobe Flash Player Debugger 32.0.0.465，检查应用标识、完整代码签名与 Adobe Team ID `JQ525L2MZD`。先寻找工程 `.runtime/adobe-debug/Flash Player.app`，再从已配置 `.runtime/shared-tools` 的实际位置寻找同一 runtime 下的 adobe-debug。也可显式 `--player-app '/已有路径/Flash Player.app'`。
- 已有 Flash Player 或 Debugger 进程时拒绝打开新实例，避免同一测试存档被并发使用；不关闭现有程序。

通过后用 macOS `open -n -W -a` 直接打开包内主游戏 SWF，不加载 DiagnosticHarness，不改全局 Flash 配置。终端等待播放器退出。每次通过 `.command` 进入均在 `reverse/logs/launcher/<UTC>-<PID>.log` 保存普通文本日志，权限由umask 077限制，包含错误、选定包及主文件摘要，不输出环境变量全量或其值。失败时终端显示具体原因与准确构建命令，双击时保留窗口等待回车。

## 只读检查与验证状态

```sh
./启动源码重建版.command --check
```

`--check` 核验文件与播放器签名，输出已运行播放器及 `launch_available`，绝不启动游戏。它退出成功表示文件与签名校验通过；若 `launch_available=false`，须先退出已有播放器。需要其他 Python 时可设置 `YZLR2_PYTHON`，但工具链文件变化仍会触发拒绝；仅启动环境与编译环境不同不会重新编译。

脚本和签名检查、旧无指纹包拒绝、源码输入过期的隔离回归均由子任务完成。检查不等于 Finder 冷启动、画面或玩法验收；主任务负责停止服务后的真实双击启动验证。历史运行包在源码变更后仍是有效历史记录，但默认启动入口只接受与当前输入匹配的新包。

新完整指纹包 `runtime-all-rebuilt-20261023T175702.006475Z` 的启动前检查已通过，Main928e、164模块、28,131个不同输入文件。批量核验对每份snapshot保持内部摘要、工具manifest摘要、逐模块目录新增/删除、内容哈希、大小、执行位和角色一致性；相同工具链/spec只扫描一次。首次批量检查输入阶段31.985秒（较原逐模块重扫超过3分钟减少），保留阶段进度输出；实际耗时随本机IO和缓存而变。

第一次Finder双击在未加日志的旧入口提前停止，具体错误未读取，不能追认成LANG原因或启动成功。已在独立测试进程移除LANG/LC_ALL，证实旧build验证会报环境变化，而新launch验证在文件仍一致时通过；Finder下一次冷启动仍由主任务实际验收。

隔离回归 `reverse/build/project/launcher-batch-check.json` 的11项均通过，覆盖源码变化、非AS新增、删除、执行位、内部摘要、postcheck、角色、工具manifest破坏和仅启动环境差异。另移除LANG/LC_ALL的完整164模块 `--check` 退出0，输入核验24.722秒，日志 `reverse/logs/launcher/20261023T181027Z-19081.log`；没有启动播放器。
