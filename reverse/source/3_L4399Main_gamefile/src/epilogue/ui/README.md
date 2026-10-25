# 终章表现组件

以下 ActionScript 3 文件只负责界面表现，使用 `src.epilogue.ui` 包。业务控制器负责剧情进度、战斗暂停、玩家输入复位、存档和场景切换。组件不会修改 `stage.frameRate`，不会直接读写玩家数据。

| 文件 | 用途 |
| --- | --- |
| `EpilogueView.as` | 940×580 逻辑画布：底部绢纸对话、目标提示、首领血条、记录本、选择、暂停和失败面板。父控制器把它加入舞台显示列表最上层。 |
| `WorldTimelinePause.as` | 对世界内受管原生动作根保存并保持播放意图，捕获 ADDED 时立即暂停新增受管子树；原停止对象不重启，clear 不播放旧世界。 |
| `TrackedMovieClip.as` | 新写 SWF9 原生播放命令跟踪基类；Skin / Skin_WuQi / Skin_ZhuangBei / Fly 继承它，覆盖 play/stop/goto/next/prev，避免调用不可用的 isPlaying。 |
| `ChapterButton.as` | 铜色边框按钮，鼠标悬停、键盘选中、禁用状态；销毁时移除自身监听。 |
| `PortraitArt.as` | 本次同人章节新绘的矢量人物徽章，不是原版角色素材的复原。奥古斯丁、塔丽莎、格蕾丽丝、霍根和勇士使用不同发型、服饰及轮廓，也支持治疗者与居民。剧情固定 key 为 `augustine` / `talisha` / `goddess` / `hogen` / `hero` / `villager`；旧别名仍兼容。可单独在场景中复用。 |

## 接入与数据格式

```actionscript
var view:EpilogueView = new EpilogueView(940, 580);
addChild(view);
view.onJournalRequest = openJournal;
view.onPauseRequest = openPause;
view.setObjective("终章 · 余火", "调查村庄留下的线索", "已找到 1 / 3");
view.showDialogue([
    {speaker:"塔丽莎", portrait:"talisha", text:"这次，我们一起回来。"},
    {speaker:"勇士", portrait:"hero", text:"我记住了。"}
], afterDialogue, alreadyRead, recordSkip);
```

`showDialogue(pages, onComplete, canSkip=false, onSkip=null)` 支持 `{speaker,text,portrait?}` 或 `[speaker,text]`。长文本按真实设备字体测量分页，并尽量在句末截断。鼠标点击绢纸、Enter、空格先显示本页全文，再继续翻页。只有 `canSkip` 为真时显示“跳过已读”，并允许 Esc 跳过。正常结束调用 `onComplete`；跳过依次调用 `onSkip` 和 `onComplete`，所以 `onSkip` 只应用于通知/统计，不应重复推进业务。

`showChoice(title, body, choices)` 的选项是 `{label,description?,action}`。建议 2–3 项，目前上限 5 项。上下键切换、Enter/空格确定、数字键 1–5 直接选择。动作调用前会关闭旧面板。设计时把问题压到约三行内，长篇解释放在前置对话。

`showJournal(entries, onClose)` 支持 `{title,text}`、对话对象或字符串。记录按可见高度分页；左右键翻页，Enter/Esc 关闭。空记录会显示明确的空状态。

`showPause(onResume,onJournal,onReturn)` 与 `showFailure(reason,onRetry,onReturn)` 使用相同选择组件。暂停的 Esc 等价于继续。失败不允许 Esc 无意关闭。Controller 应把返回回调接到正确的村庄恢复流程。

`setBoss(name,hp,maxHp,phase="",hint="")`、`hideBoss()` 更新顶部首领信息；`setObjective(chapter,objective,progress="")` 更新右侧目标；`setSize(width,height)` 使 940×580 画布等比居中适配。

## 生命周期与输入

- `modalOpen` 表示任何模态面板正在显示，`dialogueOpen` 仅表示对话。
- 打开新面板会静默关闭旧面板，不触发旧回调。
- `closeModal()` 也是静默关闭；Controller 如要取消业务，应自己处理。
- `dispose()` 清理按钮、键盘、逐帧监听并从父容器移除；不要再次复用已经 dispose 的实例。
- 模态期间接管键盘，阻止按键重复造成连续翻页；关闭面板的按键抬起也会被吞掉。Controller 仍须清除游戏中已经按下的方向/攻击状态，并暂停游戏更新；组件不承担游戏逻辑冻结。
- 对话只遮住底部 170 像素，保留世界画面；其余区域有完全透明输入屏障，阻止原 NPC 和菜单收到点击，不会因点击背景翻页。菜单有半透明全屏遮罩。屏障拦截点击、按下、抬起和滚轮，关闭面板时清理监听。

## 验证边界

2026-10-25：完成首版源码与静态结构检查。该组件未由 UI 子任务单独构建或启动 Flash；编译、游戏内截图、字体实际渲染、战斗输入隔离及完整流程验证由主集成任务统一完成。实际检验后应更新这条记录。

## 世界时间轴暂停

每个 Controller 创建一个 `WorldTimelinePause` 实例。模态打开时调用 `freeze(Main.world)`；业务恢复时调用 `resume()`；切图/销毁世界时调用 `clear()`。它只处理 `TrackedMovieClip` 受管根，不通过 currentFrame/totalFrames 猜测播放状态，也不读取 isPlaying。新写基类记录原生默认播放意图及所有显式播放控制命令，原生帧脚本调用 stop 同样经 override 更新意图；原生调用抛错则回滚。SWF9 的缺标签 gotoAndPlay 仍会开始播放，不能用标签存在性过滤命令；该边界由独立真实运行证明。

freeze 会 hold 全部受管对象，包括当时已停止者，以拦截同帧稍后的 play；重复 freeze 不覆盖首次集合。world 的 ADDED capture 监听在目标处理器前立即 hold 新增受管根。resume 只 release 仍在同一世界、且世界仍在原舞台上的对象；本来停止者不重启。移出世界者、被替换世界与 clear 路径解除持有但维持原生停止，清除引用和监听，不重播旧对象。

该工具不暂停未知/匿名 MovieClip、UI、计时器、音频或 ENTER_FRAME，不修改全局 stage.frameRate。Controller/Core 仍须拦截业务更新、输入和伤害，并在模态期间隐藏残留技能表现。`isFrozen`、`frozenCount` 与 `playbackDiagnostics` 可只读查看；mode 为 idle / tracked / tracked-partial，known/held 是受管数，unknown 是未触碰的 MovieClip 数，stopped 是首次捕获时明确播放的受管数。它不是“整个 Flash 世界每一条时间轴全部冻结”的承诺。

## 首轮运行图后的修正

对照主集成任务保存的原作奥古斯汀界面与第一段终章对白截图，保留已验证清晰的纸页正文布局。`augustine` 头像修正为银紫长发、年轻面部、额部黑色面饰与紫宝石、冷色铠甲和绿色大剑；撤销先前错误的老年长胡须形象。仍是本次章节新绘的矢量徽章，不是原图导出。键盘补充“打开暂停的 Esc 需先松开才可关闭”的保护，避免操作系统按键重复导致暂停闪开闪关；退出暂停后继续持有 Esc 也不会重开。更改待主集成任务下一轮构建和截图核验。


## 头像第二轮细化（2026-10-26）

`PortraitArt(identity, size=112)` 与 `setIdentity()` 接口、112×132 的逻辑绘制边界、固定剧情 key 均保留，没有添加图片资源或其他类。`mentor` 兼容别名指向奥古斯汀，避免记录本中回退成勇士。

- 勇士参照候选截图左上角原作头像的可见特征，改为蓝绿短发、分束刘海、较宽的 Q 版面部与青绿眼睛；没有把角色衣饰额外解释为原作设定。
- 奥古斯汀继续保留经原作截图确认的紫发、年轻面部、额部黑色面饰/紫宝石、铠甲与绿剑。新稿加入发色过渡、发丝与甲缘高光。
- 其他人物保留本同人版本的已有视觉设计，并用不同脸宽/下颌、长发/帽缘/王冠轮廓、窄眼与服装边线区分；未经原图核实的细节仍是同人视觉方案，不宣称复原原作。女神长发与细脸、塔丽莎较圆脸与帽缘、霍根方下颌与冠形肩甲、居民朴素短发与窄眼形成轮廓差异。
- 脸部、发顶、眼睛与背景采用少量 Flash 原生渐变；眼白、虹膜、瞳孔与小高光分层，替代旧稿的小圆点眼睛与大块阴影。运行时仍只有单个 Sprite 的 Graphics，不添加 ENTER_FRAME 或外部资源依赖。

这次只做源码和静态边界核查，没有单独构建或启动播放器。实际 112 像素头像的眼神、细线清晰度及整体风格需由主集成候选截图复核；不把本轮源码改动称作已通过视觉验收。


## 正式 SWF9 入口的播放态兼容与实测边界

主任务在 candidate10b 正式直接入口观察到 MovieClip.isPlaying Error 1069；高版本 observer 曾掩盖问题。先前“跳过未知时间轴”的安全降级在 candidate11 实际长对白中仍使雷云/图腾不断出现，并伴随高 CPU，因此该降级不能作为可交付暂停。独立 SWF14 helper 加载进 SWF9 Host 的方案也经真实运行失败：24 项断言中 9 项失败，仍读取不到 isPlaying，running 帧脚本持续增加；没有接入游戏。

随后采用原生命令跟踪，并先做独立 SWF9 四帧原生 DefineSprite 实验；不是 Python 镜像业务或 ENTER_FRAME 模拟动画。正式 debugger 直接运行 `tracked-20261025T210231.058686Z/TrackedHost9.swf`，专用 SO 读回 generation 精确一致、phase=complete、31 项检查全部通过。覆盖 frameScript stop 虚派发、缺标签与数字字符串原生语义、invalid scene 异常回滚、原停止保持、hold/play 阻断、原运行恢复、ADDED 自动 hold、未知 clip 不干预、移出/clear 不重启及重复调用。报告位于 `chapter/tests/timeline_pause/results/tracked-20261025T210231-actual-report.json`；测试源与构建 receipt 均保留。

正式代码是该已测类的机械包名/类名迁移，四个原基类仅改变继承并新增 import，保留 CRLF 和原方法。`chapter/content/extensions.json` 明确登记新增类，原始 FFDec 导出不改；read-only extension audit 通过。这里只证明隔离原生时间轴管理契约；游戏实际资源继承、连续施法后长对白新增 Fly/HitXX 数量、CPU、跳过/记录本/恢复、切图冷读仍由主任务下一候选正式入口验收。匿名 symbol 子时间轴不在覆盖范围，不能冒称完全暂停原游戏所有装饰或匿名命中图形。
