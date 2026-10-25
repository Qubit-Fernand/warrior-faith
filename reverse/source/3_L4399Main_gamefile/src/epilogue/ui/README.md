# 终章表现组件

以下 ActionScript 3 文件只负责界面表现，使用 `src.epilogue.ui` 包。业务控制器负责剧情进度、战斗暂停、玩家输入复位、存档和场景切换。组件不会修改 `stage.frameRate`，不会直接读写玩家数据。

| 文件 | 用途 |
| --- | --- |
| `EpilogueView.as` | 940×580 逻辑画布：底部绢纸对话、目标提示、首领血条、记录本、选择、暂停和失败面板。父控制器把它加入舞台显示列表最上层。 |
| `WorldTimelinePause.as` | 按世界暂停能明确读取到正在播放的 MovieClip；SWF9 不支持读取播放态时跳过原生时间轴，避免误重启停止对象。销毁世界时 clear 不重启旧对象。 |
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

每个 Controller 创建一个 `WorldTimelinePause` 实例。模态打开时调用 `freeze(Main.world)`；业务恢复时调用 `resume()`；切图/销毁世界时调用 `clear()`。仅明确读到 Boolean true 的播放态才调用 stop 并进入快照；读到 false 或读取能力未知时不改变对象。重复 freeze 不替换首次快照。resume 只恢复快照中仍属于原世界、且原世界仍在原舞台上的对象；首次冻结时已停止的对象不会被重启。

该工具只处理 MovieClip 时间轴。Controller/Core 仍须自行拦截 ENTER_FRAME、计时器和业务输入，也须避免暂停期间新增运行中的世界动画。它不会递归到世界之外，不操作 UI 或舞台帧率。`isFrozen` 与 `frozenCount` 可供运行时诊断。

## 首轮运行图后的修正

对照主集成任务保存的原作奥古斯汀界面与第一段终章对白截图，保留已验证清晰的纸页正文布局。`augustine` 头像修正为银紫长发、年轻面部、额部黑色面饰与紫宝石、冷色铠甲和绿色大剑；撤销先前错误的老年长胡须形象。仍是本次章节新绘的矢量徽章，不是原图导出。键盘补充“打开暂停的 Esc 需先松开才可关闭”的保护，避免操作系统按键重复导致暂停闪开闪关；退出暂停后继续持有 Esc 也不会重开。更改待主集成任务下一轮构建和截图核验。


## 头像第二轮细化（2026-10-26）

`PortraitArt(identity, size=112)` 与 `setIdentity()` 接口、112×132 的逻辑绘制边界、固定剧情 key 均保留，没有添加图片资源或其他类。`mentor` 兼容别名指向奥古斯汀，避免记录本中回退成勇士。

- 勇士参照候选截图左上角原作头像的可见特征，改为蓝绿短发、分束刘海、较宽的 Q 版面部与青绿眼睛；没有把角色衣饰额外解释为原作设定。
- 奥古斯汀继续保留经原作截图确认的紫发、年轻面部、额部黑色面饰/紫宝石、铠甲与绿剑。新稿加入发色过渡、发丝与甲缘高光。
- 其他人物保留本同人版本的已有视觉设计，并用不同脸宽/下颌、长发/帽缘/王冠轮廓、窄眼与服装边线区分；未经原图核实的细节仍是同人视觉方案，不宣称复原原作。女神长发与细脸、塔丽莎较圆脸与帽缘、霍根方下颌与冠形肩甲、居民朴素短发与窄眼形成轮廓差异。
- 脸部、发顶、眼睛与背景采用少量 Flash 原生渐变；眼白、虹膜、瞳孔与小高光分层，替代旧稿的小圆点眼睛与大块阴影。运行时仍只有单个 Sprite 的 Graphics，不添加 ENTER_FRAME 或外部资源依赖。

这次只做源码和静态边界核查，没有单独构建或启动播放器。实际 112 像素头像的眼神、细线清晰度及整体风格需由主集成候选截图复核；不把本轮源码改动称作已通过视觉验收。


## 正式 SWF9 入口的播放态兼容

主任务在 candidate10b 正式直接入口观察到 `MovieClip.isPlaying` 的 Error 1069；较高 SWF 版本的 observer 曾掩盖这一兼容问题。不能把较高版本 wrapper 成功当作正式 SWF9 入口成功。本修复不提高 Main SWF 版本，也不设置全局 `stage.frameRate=0`。

`WorldTimelinePause.freezeTree()` 改为受 `try/catch` 保护的 `Object(clip)["isPlaying"]` 查询，只有返回明确的 Boolean true 才 stop/保存；false 保持不动；抛异常、undefined 或其他类型一律视为未知并跳过。不能用 `currentFrame`、`totalFrames` 或前后帧号猜播放态，也不能先 stop 全树再统一 play，因为那样会错误重启原本停止的时间轴。重复 freeze、同世界恢复、清引用不恢复旧世界的契约保留。

只读诊断：`playbackMode` 为 `idle`、`timelines`、`partial` 或 `logic-only`；`playbackDiagnostics` 返回新的 `{mode,known,unknown,stopped}` 对象。`known` 包括明确读到 true/false 的 clip；`unknown` 为无法可靠读取的数量；`stopped` 只计本组件实际停止并准备恢复的集合。clear/resume 后诊断归 idle。

**SWF9 降级边界：** 当播放态不可用时，原生时间轴可能继续动画，不能宣称完整的世界视觉冻结。Main/Player/Skin/Fly/命中检测的既有 ENTER_FRAME 暂停守卫以及终章战斗自身暂停继续承担业务冻结。本工具不会绕过这些守卫，不修改技能动作状态，也不擅自补一次 play。原生 frame-script 是否产生额外效果、对白前后动作是否连贯，仍需正式入口验收。

待主任务实测：直接打开 SWF9 正式入口，进入对白/暂停/记录本、完成及跳过连续对白，确认无 1069；停留期间确认 HP、敌人危险物和终章计时不推进；恢复后移动/攻击正常，原本停止的装置与界面不自行播放。observer 也应使用相同 SWF9 版本。可独立用 SWF9 两个多帧 clip（一个先 stop，一个正在 play）验证：未知模式不改变任一 clip；有明确 API 的模式只恢复原先在播放者。本子任务没有构建或启动任何播放器。
