# 归光之约 · 二次开发入口

下表列出正式终章工作树中的可编辑输入、生成类和原作接入点。10 月 26 日已从正式入口跑通两条结局，各次构建及剩余验收项见[运行记录](../evidence/session.json)和[验收表](../evidence/acceptance.json)。

## 受跟踪输入与构建

- `chapter/content/story.json`：对白和旅途日志，编辑后执行 `reverse/tools/chapter_source.py import`。
- `chapter/content/main-tasks.xml`：原版167条任务逐条保留；新增190001–190003使用保留的大类型3，由章节控制器管理，避免误用原生杀怪/领奖判定。
- `chapter/content/extensions.json`：明确列出允许新增的类与生成背景；实际条目数以该清单及导入验证结果为准，不在文档硬编码。验证精确集合、路径安全、710个原类和原始来源摘要，不能靠自动扫描放行新文件。
- `chapter/generated/import.json`：内容与生成物摘要；构建前严格核验，不允许修改后不导入。
- `chapter/generated/overlay/_assets/8632_src.Data2_taskData.bin`：明确在RAW素材复制之后覆盖到编译暂存区的任务资产；FFDec exports本身不修改。
- `reverse/tools/chapter_source.py`：验证原任务保留、新ID无冲突与对白结构，生成AS常量及任务覆盖资产。
- `reverse/tools/build_main.py`：原构建修复仍保留，新增内容/生成目录及导入器输入指纹，使用独立SO名`yzlr2_rebuild_epilogue_v2`。
- `reverse/tools/chapter_fixture.py`：从仓库明确提供的毕业预设创建两个新章节起点；正常原数值与10倍装备属性分别一槽；只声明原主线已提交，不写新章节胜利。只允许安装到新命名且空的测试SO。

- `chapter/assets/backgrounds/`：生成背景、完整提示词与SHA清单；导入器逐一核验并复制到受控overlay。
- `mx/core/BitmapAsset.as`：新增最小PNG Embed兼容类，不是恢复的原游戏源码。

## 主程序源码

以下路径相对`reverse/source/3_L4399Main_gamefile/src/epilogue/`。

| 文件/目录 | 职责 |
|---|---|
| ChapterContent.as | 从story.json生成的内容常量，勿直接编辑。 |
| ChapterState.as | 版本1的独立角色内状态、默认值、复制及恢复。未来版本只保留数据并禁止进入，避免误降级覆盖。 |
| ChapterController.as | 村庄NPC入口、正式原主线解锁、地图切换、演出/交互、战斗事件、日志、失败重试、结局仪式和幂等奖励。 |
| battle/ChapterEncounter.as | 新首领真实攻击接入；诺弥地波／光锚与半血加速；霍根独立两段血池、追光锁定、夺光蓄能打断及失衡奖励；供能节点与战斗诊断。 |
| battle/ChapterDockEncounter.as | 码头桥锁和两处继电器的真实命中、危险区与完成事件，控制器负责存档。 |
| battle/BossBody.as | 诺弥与霍根的原创组合矢量轮廓和动画。 |
| battle/BattleHazard.as | 预警与实际碰撞共用几何；地波／光锚、追踪后锁定光束、夺光爆发与绿色安全区。当前没有拉拽场机制。 |
| scene/ChapterScenery.as | 渡桥、居民移动、船、罗盘、装置及两种结局世界表现；只接收状态，不写存档。 |
| scene/ChapterNavigation.as | 潮痕、帆纹、回光线索及三个航标盘；只读状态，Controller记录转动与锁定。 |
| scene/ChapterBackdrop.as | 导入器生成的三场景PNG Embed引用，1600×580完整画幅。 |
| ui/EpilogueView.as | 绢纸对白、说话人、任务目标、首领血条、日志、选择/暂停/失败交互；模态关闭后恢复Stage焦点并保留持键屏障。 |
| ui/PortraitArt.as | 六个可辨识的新绘矢量人物头像；非原美术工程恢复。 |
| ui/ChapterButton.as | 菜单按钮、监听清理与鼠标回调后的Stage焦点归还。 |
| ui/WorldTimelinePause.as | 章节模态的时间轴暂停／恢复协调。SWF9 不能依赖原生 isPlaying；下一次接入使用显式追踪的播放状态，恢复时验证舞台归属，不设置 stage.frameRate。正式包行为待复验。 |
| ui/TrackedMovieClip.as | SWF9 显式记录根时间轴的 play/stop/gotoAndPlay/gotoAndStop 状态，供暂停后恢复；候选12已在开发树接入玩家、武器、装备与 Fly 四类动画根。正式树待同步，隔离测试通过不代表游戏包验收通过。 |

## 核心接入点

`Main.applySaveObject/Save2`把章节状态放进与角色、背包相同的槽位对象；`GameStart/DelGame`管理控制器。`Main`只在新章节阻止原刷怪/胜利循环；`Player/Skin/Fly`用章节暂停标志停止各自更新。`Strat.NewSave`重置章节状态，`BasicKey.clearPressed`清除按住键。`GameStop`在章节UI存在时转入新暂停菜单。原版与源码重建工作树不随这些修改改变。

## 剧情选择、仪式与奖励提交

当前正式流程是码头真实攻击桥锁／继电器后救援，观察潮痕／船帆／回光，旋转三处航标并确认罗盘，再进入诺弥与霍根两场战斗。战斗机制详见 [battle/README.md](../../reverse/source/3_L4399Main_gamefile/src/epilogue/battle/README.md)，不以早期剧情稿中的掩体或拉拽描述代替实际机制。

王座战后可返回司灯遗址补修另一装置。确认结局先设置 `endingChoice`，然后在 x520、800、1050 顺序完成三个仪式节点。`endingNodes` 的前两步各自保存；第三步把 `ending`、阶段、日志、已见结局、金币和防重标志一起 checkpoint，随后才播放结局演出。保存与背包属于同一角色槽对象；冷读恢复及重复领取仍须真实运行验收，不能仅凭代码推断已经验证。

当前两个结局均为本章一次 **50,000 金币**，共用 `rewardClaims.returnLight`。没有两种实物纪念品，也没有额外通关后挑战。差异是村庄灯塔、本章设置的熄灭引路像、路旁灯龛／居民手灯、居民布置与 NPC 后日谈；不关闭或改写原游戏所有神像、地图和任务。

[三步航标校准](navigation-calibration-draft.md) 已接入 Controller 和槽位保存，后续候选已有操作记录，具体版本及范围见运行记录。早期“候选3已编译、待运行”仅属于历史阶段，不能作为当前状态。先前候选完成的 calibrationDone 会恢复为三盘已锁定；新增的观察过程不倒扣已获得进度。

## 当前限制

当前最终同包验收仍未完成，已有候选的局部实战与冷读证据须按对应包摘要引用。当前仅单人，不支持本地双人进入本章；自定义首领不是原 Enemy 实例，宠物／精灵的自动寻敌与依赖原 Enemy 逻辑的特定装备／套装被动尚未接入，不能按原版效果预期。新增艺术采用程序矢量和三张imagegen场景背景，复用原角色动画，不宣称全新手绘动画。实际时长、数值平衡与兼容范围必须以候选哈希对应的运行记录为准。

## SWF9 播放状态追踪的边界

本轮交接时，主任务已在 generation `210231` 的隔离 SWF9 环境核验 31 项原生时间轴追踪检查通过；候选12随后已在开发树把 `src/epilogue/ui/TrackedMovieClip.as` 接到 Main 的四类动画根及 WorldTimelinePause，并完成内容导入、开始 Main 构建。该候选明确新增类清单为16项；正式树的代码与清单仍待同步，应以各树实际清单核对。隔离结果仅证明测试合同，不证明 Main 构建完成、正式入口可玩或最终同包通过。候选11的拒绝记录保留，不被隔离测试覆盖。

覆盖目标是玩家、武器、装备与 Fly 的受追踪根时间轴；匿名子时间轴与未接入的原生装饰可能继续播放。业务暂停守卫另行阻断章节伤害与战斗计时，并须在直开游戏中复验。不能宣称完整原生世界的全部时间轴均已冻结。

## 辅助诊断与验收

- `chapter/observer/Source.as` 与 `reverse/tools/chapter_observer.py`：被动采样，见 [诊断说明](../observer/README.md)。不推进游戏进度，包装不能替代直开验收。
- `chapter/evidence/acceptance.json`：最终验收矩阵，条目以文件实际内容为准。每条须有同一候选的真实证据，pending不能视为通过。
- `chapter/evidence/session.json`：开始时间、版本摘要、测试边界及检查点。

## 保存结果和金币上限（候选4起）

`src/LocalSaveManager.as` 负责整份AMF快照、flushed/pending/blocked/failed、异步许可结果和确认槽位。`Main.Save2` 保留原保护，仅确认成功后触发成功提示；当前角色的状态不会被另一角色的延迟结果冒认。`ChapterController.onSaveResolved` 在没有章节Controller的普通地图也可继续当前角色的排队快照。

`rewardClaims.returnLight` 新含 total/gold/pending，金币上限内实际到账后减少余额，余款由奥古斯汀保管；点击导师补领，不重复创建整份奖励。第三节点依然将结局、库存和余额一起保存。详见 [保存契约](save-flush-contract.md)、[奖励检查点](reward-and-checkpoints.md)、[暂停辅助计时器](player-pause-review.md)、[焦点问题回归](modal-focus-regression.md)。这些文档明确区分静态审查、候选局部运行和最终验收。

## 本分支推荐运行命令

```sh
/opt/miniconda3/envs/Qubit/bin/python -B reverse/tools/chapter_source.py import
/opt/miniconda3/envs/Qubit/bin/python -B reverse/tools/build_main.py --all-definitions --save-name yzlr2_rebuild_epilogue_v2
/opt/miniconda3/envs/Qubit/bin/python -B reverse/tools/rebuild_project.py assemble
./启动同人终章.command --check
./启动同人终章.command
```

本分支Main默认保存名已改为新版独立名；精确参数仍建议保留以便审阅。终章启动脚本使用`launch_rebuilt.py --expect-save`强制拒绝其他保存名。原版/源码重建工作树的脚本与默认值不随这里改变。测试辅助程序用途见[测试目录](../tests/README.md)。

11 月 13 日候选 17 的运行验证在 [candidate17-playtest.md](candidate17-playtest.md)；两套独立角色的实测时间、结局、余额和旧档保护检查见 [candidate17-native-results.json](../evidence/candidate17-native-results.json)。原生窗口截图和完整角色备份只在本机 evidence/private/，不属于构建输入。
