# SWF9 主入口加载高版本暂停助手：隔离实验证据

目的：验证 SWF9 主入口的 MovieClip，能否由子 ApplicationDomain 中 SWF14 助手准确读取 isPlaying 并暂停/恢复，同时保留主入口的旧缺标签行为。这里没有游戏代码、游戏素材或游戏存档访问；不能用编译成功代替运行证据。

## 文件

- `src/TimelinePauseHost.as`：SWF9 文档类，显示 PASS/FAIL，并把真实 AS3 断言与样本写入专用 `yzlr2_timeline_helper_probe_v1` SharedObject。主入口自己读取 isPlaying、调用缺失帧标签，再加载助手后重测。
- `src/TimelineHelper.as`：SWF14 文档类，通过 `new ApplicationDomain(ApplicationDomain.currentDomain)` 加载。只读取 clip.isPlaying、记录明确正在播放者、stop/play；没有帧率、定时器、存档或游戏依赖。缺标签调用另作样本，不直接推定跨版本语义。
- `src/timelineprobe/ProbeClip.as`：新写四帧 MovieClip 的帧脚本计数器。它是真实原生时间轴，不是用 ENTER_FRAME 自增模拟动画。
- `build.py`：单独调用 mxmlc strict=true，核验 Host=9、Helper=14 的真实文件头。向 Host 新写一个四帧 DefineSprite，第一帧标签 `known`，SymbolClass 链接 ProbeClip；不拷贝原游戏 ABC 或素材。输出放到独立 `reverse/build/chapter-timeline-pause/run-*`，写编译日志与 SHA receipt。不会运行 Flash。
- `read_report.py`：只接受明确给定的专用诊断 SOL 路径，检查内部 SO 名后读出 `report`；不枚举或打开角色存档。

## 最新可运行候选

构建目录：`reverse/build/chapter-timeline-pause/run-20261025T205034.062685Z/`。
直接入口为 `TimelinePauseHost9.swf`，同目录必须保留 `TimelineHelper14.swf`。不要让高版本 observer 再包一层运行；Host 的“原生播放态不可读”断言就是用来发现这种污染。

运行后约 2 秒结束，可见画布列出断言；读回专用 SO 的 report 应有 phase=complete。主要断言：

1. 主文件头 9、两只自有 clip 均四帧；原先停止的 clip 保持在第 2 帧，另一只会执行真实帧脚本。
2. Host 加载前不能读 isPlaying，且缺标签调用不抛异常。
3. 子助手文件头 14、child domain 与父 domain 分离，助手类不泄漏到父 domain；助手准确读到 stopped=false / running=true。
4. 同步 freeze 只停一只 clip，重复 freeze 不覆盖首次集合；等待当前帧脚本结算 100ms 后，持续 400ms 两只 clip 的帧计数均不再增加。
5. resume 只启动原先播放的一只；原本停止者仍停第 2 帧；重复 resume 无效；已移出 owner 的 clip 不重启。
6. 加载助手后 Host 仍保留原来的缺标签结果及 API 可见性；helper 自己的缺标签调用记录在 samples.helperMissing。该样本允许“不抛”或预期的 2109，实际结果用于判断语义究竟按调用者还是实例归属，不预先把某种结果当作已证实。

若 helper 读取失败或其版本改变了 Host 行为，结果会有 FAIL，不能据此集成。若全部通过，结论范围仍只是“该播放器中 SWF9 自有 clip 的跨域读取与暂停可行”；正式游戏的加载依赖、暂停前产生/恢复后生成的 Fly、缓存包与冷启动还需集成实测。

当前状态：该 helper 方案已由主任务直接运行并确认失败，不能集成。详见下方实际结果。首轮严格编译因 AS3 编译器不接受 try/catch 内全返回的控制流而失败，补上不可达兜底 return 后重新独立构建；失败目录保留，不覆盖日志。


## 第一次直接启动的初始化修正

主任务直接运行第一版 Host9，文档类构造阶段读 `loaderInfo.swfVersion` 触发 Error 2099（文件尚未完全加载），测试断言尚未开始，不能计为 helper 方案成败。Host 初始化现在等待 LoaderInfo.COMPLETE 或后续 ENTER_FRAME，并先尝试读取版本；仍为 2099 时继续等待，成功后卸掉两处监听且只启动一次。新 run 为 `20261025T205034.062685Z`，其余实验逻辑保留；本子任务只重编译，尚未运行修正版。

## 2026-10-26 真实读取结果：高版本 helper 方案失败

主任务直接运行 `run-20261025T205034.062685Z/TimelinePauseHost9.swf`，专用 SOL 读回 `generation=20261025T205034.062685Z`、`phase=complete`、`runtimeExecuted=true`、24 项断言中 9 项失败、`flushStatus=flushed`。完整读回记录为 `results/20261025T205034-actual-report.json`。

- SWF14 helper 对 SWF9 stopped/running 原生 clip 的 `isPlaying` 读取均抛 Error 1069。freeze 捕获 0 个对象；结算后的 running 帧脚本计数仍从 18 增至 30，暂停实际失败。
- domain 直接对象相等断言失败，且 `helper.info().parentDomain=false`；该结果本身不证明 domain 合并，因为 ApplicationDomain 包装对象身份不一定相等。helper 类未泄漏到父 domain 的检查通过。这里无须依赖域解释，因为 API 读取和暂停已直接失败。
- Host9 缺标签调用前后均不抛异常；helper 自身缺标签调用抛 2109。加载 helper 没有使 Host9 获得 isPlaying。
- “running resumes”仅证明它仍在跑，不能抵消 freeze 的失败；移出 clip 不重启检查失败也依赖前置冻结失败，不能单独归因移除检测。

`read_report.py` 已修正递归解码 `tools.sol.Obj/Arr`，而不是把它们当作普通 JSON dict/list；只接受这两个独立实验的专用 SO 名，不碰真实角色存档。

## SWF9 原生命令跟踪实验（待主任务运行）

`build_tracked.py` 编译 `tracked-src/` 并新写两个四帧原生 DefineSprite，链接 `TrackedProbe` / `NativeProbe`。`TrackedClip` 覆盖 MovieClip 的播放/停止命令，保存原生默认播放意图，hold 期间阻断 play，恢复时仅恢复原本播放意图；没有 isPlaying 依赖，没有 currentFrame 猜测，没有全局帧率修改。`TrackedProbe` 的第三帧脚本可以调用 stop，用于核验虚派发。原生对照 clip 检查缺标签、数字字符串边界，不预设结果。

入口：`reverse/build/chapter-timeline-pause/tracked-20261025T205856.847279Z/TrackedHost9.swf`，真实头部 SWF9；诊断 SO `yzlr2_timeline_tracked_probe_v1`。构建成功不代表运行通过；未通过前不得接入游戏。

### 跟踪方案首轮实际结果与边界修正

`tracked-20261025T205856.847279Z` 已由主任务直接运行：24 项检查、2 失败；报告 `results/tracked-20261025T205856-actual-report.json`。原生四帧、frameScript stop 的 override 派发、hold/play 防重启、原停止对象不重启及 resume 均通过。失败暴露了不能假设“缺标签 gotoAndPlay 无操作”：在该 SWF9 实际入口，缺标签和字符串“2”都会继续 native 播放；后者样本双方均执行 11 帧，旧跟踪值却为 false。现已移除标签存在性过滤，让命令本身更新播放意图；原生抛错时恢复之前意图。

`tracked-20261025T210058.844051Z` 随后由主任务实际启动（关联的普通 Flash Player，不是预期 debugger）：31 项检查、1 失败。新增管理层 ADDED、unknown 保持、移除不重启、clear、repeat 等均通过；剩余失败是缺标签 gotoAndStop 的 native 对照计数。此轮仅存了调用时计数 12，未存冻结窗口结束双方计数，不能据此宣称原生停止命令失效。报告 `results/tracked-20261025T210058-actual-report.json`。

后续 `tracked-20261025T210231.058686Z` 将该检查改为：各 clip 在命令后等待 100ms 结算，分别记录当前计数；再等待 450ms，要求各自计数不增加，并完整保存 before/after。这里避免把同一帧已排队的帧脚本视为持续播放，也不以两个不同 clip 的累计帧数相等代替停止证据。待主任务用正式播放器运行。

### 正式 debugger 真实通过与接入

主任务直接运行 `tracked-20261025T210231.058686Z/TrackedHost9.swf`，截图由主任务保存为正式私有证据 079。专用 SOL 已读回并核对 exact generation、SWF9、phase=complete、31 checks、failures=0、pass=true、flushStatus=flushed。完整报告为 `results/tracked-20261025T210231-actual-report.json`。缺标签 stop 的 settle/after 样本可直接核验，不再把同帧已排队帧脚本误判为持续运行。

通过后将该轮测试源 TrackedClip / WorldTimelinePause 机械迁移为 canonical `src.epilogue.ui.TrackedMovieClip` / `WorldTimelinePause`（仅包名/类名变换及 CRLF），四个原基类 Skin/Skin_WuQi/Skin_ZhuangBei/Fly 新增 import 并改继承；extensions.json 明确登记新增 authored 类，read-only extension audit 通过。没有改变 Main SWF9 目标，没有调用全局帧率冻结，没有导入高版本 helper。主项目由 root 统一构建与正式游戏验收，子任务不操作播放器。

覆盖边界：只暂停这些受管动作/技能根及后来 ADDED 的受管根，不干预未知匿名装饰；业务 ENTER_FRAME/HitXX 守卫与残留技能隐藏仍必要。隔离测试通过不代替正式角色装备资源、长对白 CPU 与新增特效数量实测。
