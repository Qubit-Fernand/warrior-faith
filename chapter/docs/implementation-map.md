# 归光之约 · 二次开发入口

## 受跟踪输入与构建

- `chapter/content/story.json`：对白和旅途日志，编辑后执行 `reverse/tools/chapter_source.py import`。
- `chapter/content/main-tasks.xml`：原版167条任务逐条保留；新增190001–190003使用保留的大类型3，由章节控制器管理，避免误用原生杀怪/领奖判定。
- `chapter/generated/import.json`：内容与生成物摘要；构建前严格核验，不允许修改后不导入。
- `chapter/generated/overlay/_assets/8632_src.Data2_taskData.bin`：明确在RAW素材复制之后覆盖到编译暂存区的任务资产；FFDec exports本身不修改。
- `reverse/tools/chapter_source.py`：验证原任务保留、新ID无冲突与对白结构，生成AS常量及任务覆盖资产。
- `reverse/tools/build_main.py`：原构建修复仍保留，新增内容/生成目录及导入器输入指纹，使用独立SO名`yzlr2_rebuild_epilogue_v2`。
- `reverse/tools/chapter_fixture.py`：从仓库明确提供的毕业预设创建两个新章节起点；正常原数值与10倍装备属性分别一槽；只声明原主线已提交，不写新章节胜利。只允许安装到新命名且空的测试SO。

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
| ui/EpilogueView.as | 绢纸对白、说话人、任务目标、首领血条、日志、选择/暂停/失败交互。 |
| ui/PortraitArt.as | 六个可辨识的新绘矢量人物头像；非原美术工程恢复。 |
| ui/ChapterButton.as | 菜单按钮与监听清理。 |
| ui/WorldTimelinePause.as | 只冻结原本播放中的世界MovieClip，恢复时验证仍属于同一舞台；不设置stage.frameRate。 |

## 核心接入点

`Main.applySaveObject/Save2`把章节状态放进与角色、背包相同的槽位对象；`GameStart/DelGame`管理控制器。`Main`只在新章节阻止原刷怪/胜利循环；`Player/Skin/Fly`用章节暂停标志停止各自更新。`Strat.NewSave`重置章节状态，`BasicKey.clearPressed`清除按住键。`GameStop`在章节UI存在时转入新暂停菜单。原版与源码重建工作树不随这些修改改变。

## 剧情选择、仪式与奖励提交

当前正式流程是码头真实攻击桥锁／继电器后救援，完成一次交互的罗盘校准，再进入诺弥与霍根两场战斗。战斗机制详见 [battle/README.md](../../reverse/source/3_L4399Main_gamefile/src/epilogue/battle/README.md)，不以早期剧情稿中的掩体或拉拽描述代替实际机制。

王座战后可返回司灯遗址补修另一装置。确认结局先设置 `endingChoice`，然后在 x520、800、1050 顺序完成三个仪式节点。`endingNodes` 的前两步各自保存；第三步把 `ending`、阶段、日志、已见结局、金币和防重标志一起 checkpoint，随后才播放结局演出。保存与背包属于同一角色槽对象；冷读恢复及重复领取仍须真实运行验收，不能仅凭代码推断已经验证。

当前两个结局均为本章一次 **50,000 金币**，共用 `rewardClaims.returnLight`。没有两种实物纪念品，也没有额外通关后挑战。差异是村庄灯塔／熄灭神像、窗灯／手灯、居民布置与 NPC 后日谈。

[三步航标校准草案](navigation-calibration-draft.md) 仅供首轮完整实测后评估，尚未接入 Controller 或正式内容导入。不要把环境转盘、镜片反射或其预计时长算入当前实现。

## 当前限制

这是开发中候选，尚未通过实际运行验收。当前单人；自定义首领不是原Enemy实例，依赖Enemy的宠物自动寻敌与部分套装被动尚未完整接入。新增艺术采用程序矢量并复用原角色/背景，不宣称全新手绘动画。实际时长、数值平衡与兼容范围必须以候选哈希对应的运行记录为准。

## 辅助诊断与验收

- `chapter/observer/Source.as` 与 `reverse/tools/chapter_observer.py`：被动采样，见 [诊断说明](../observer/README.md)。不推进游戏进度，包装不能替代直开验收。
- `chapter/evidence/acceptance.json`：23项最终验收矩阵。每条须有同一候选的真实证据，pending不能视为通过。
- `chapter/evidence/session.json`：开始时间、版本摘要、测试边界及检查点。
