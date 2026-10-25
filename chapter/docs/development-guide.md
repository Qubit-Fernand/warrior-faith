# 《归光之约》二次开发入口

本章使用源码重建 Main 内的新逻辑，根目录旧 SWF 和旧 `mod/` wrapper 不会自动获得这里的修改。当前验证范围见 [运行记录](../evidence/session.json) 与 [验收表](../evidence/acceptance.json)。这里说明文件职责，不把尚待测试的实现写作交付完成。

## 改什么，去哪里

下表 AS 路径均相对 `reverse/source/3_L4399Main_gamefile/src/epilogue/`。

| 文件 | 负责什么 | 修改注意 |
| --- | --- | --- |
| `chapter/content/story.json` | 说话人、短对白、头像键、日志文字 | 编辑后运行 `chapter_source.py import`；不能直接改生成类 |
| `chapter/content/main-tasks.xml` | 完整原任务表和本章190001–190003记录 | 这是 Main 的任务表；DataX 的 QuestXML 是任务物品，不可混淆 |
| `chapter/content/extensions.json` | 显式允许的新增类及生成资源清单 | 新类需登记，保留原710脚本基线检查 |
| `chapter/assets/backgrounds/` | 三个场景的实际背景PNG、摘要及生成提示 | 修改图片后更新 manifest 并导入；提示词本身不是游戏资源 |
| `ChapterContent.as` | story.json 导入生成的运行内容 | 自动生成；手改将被一致性验证拒绝 |
| `ChapterState.as` | 独立章节状态、默认值、恢复和版本边界 | `fanChapterReturnLight` 随当前角色保存，不改原任务与罗盘字段 |
| `ChapterController.as` | 接取、场景装配、交互、剧情链、检查点、结局奖励 | 主协调者；暂停/转场/存档回调互有关联，应局部修改后实测 |
| `battle/ChapterDockEncounter.as` | 桥锁与两继电器的真实命中、危险与完成事件 | 不能用 E 直接完成；只有原玩家实际攻击可以造成伤害 |
| `battle/ChapterEncounter.as` | 两场Boss数值、阶段、供能节点、攻击扫描、胜利事件 | 毕业伤害不能跳过必需状态；第二Boss有独立第二血池 |
| `battle/BattleHazard.as` | 地波、光锚、追光、蓄能等预警/伤害窗口 | 画面提示必须与真实判定一致；暂停时不推进 |
| `battle/BossBody.as` | 新Boss组合外观、节点条、蓄能反馈、残骸退场 | 核心/节点自身图形边界参与碰撞；装饰应放外层，勿无意扩命中框 |
| `scene/ChapterScenery.as` | 渡桥、撤离居民、装置、仪式、结局村庄装饰 | `setProgress` 只展示传入状态；`settle` 跳到合法终点；不写胜利/奖励 |
| `scene/ChapterNavigation.as` | 三处可见航标线索与转盘展示 | 判定 `[3,2,1]`，Controller负责按键、顺序和保存 |
| `scene/ChapterBackdrop.as` | 背景PNG嵌入与场景选择 | 自动生成；原图/manifest是编辑入口 |
| `ui/EpilogueView.as` | 绢纸对白、选项、日志、暂停、死亡重试、Boss HUD | 关模态要归还Stage焦点；原生UI开关使用可见内容检测；不直接推进游戏状态 |
| `ui/PortraitArt.as` | 头像矢量绘制及角色差异 | 保留角色键；它不是原作者动画资源 |
| `ui/ChapterButton.as` | 可键鼠选择的按钮与焦点处理 | 长按与鼠标结束均要清输入，避免输入穿透 |
| `ui/TrackedMovieClip.as` | 记录原生播放命令并提供受控 hold/release | 四个动作基类继承；保留 SWF9 缺标签和异常语义 |
| `ui/WorldTimelinePause.as` | 暂停/恢复受管动作根并捕获新增对象 | 匿名子时间轴不猜测播放状态；与业务暂停守卫配合 |

本章还修改 Main 的生命周期/保存装配、LocalSaveManager 的完整快照及 flush 回执、Player 的辅助计时器暂停。详见 Git diff；它们会影响旧流程，因此章节测试外还须做原村庄、原战斗与保存回归。

## 可维护的构建流程

在当前终章开发工作树根目录执行：

```sh
PY=/opt/miniconda3/envs/Qubit/bin/python
# 若修改story、任务XML、背景或新增项清单：
"$PY" reverse/tools/chapter_source.py import
# Main内章节AS/内容变更只重编Main：
"$PY" reverse/tools/build_main.py --all-definitions --save-name yzlr2_rebuild_epilogue_v2
# 严格检查各模块并组合，不允许原ABC回退：
"$PY" reverse/tools/rebuild_project.py assemble
./启动同人终章.command --check
./启动同人终章.command
```

修改别的模块时先按 `reverse/docs/build-project.md` 重建对应模块，再 assemble。不要运行 `build all` 来替代依赖判断。构建结果在 `reverse/build/runtime-all-rebuilt-<UTC>/`，每包有 assembly.json；输入改变后旧包只供历史复现，不应被当前入口认作最新修改。

`启动同人终章.command` 强制要求 `yzlr2_rebuild_epilogue_v2`，验证完整包和已有官方播放器签名，并拒绝重复启动。候选6曾被保存名检查拦截，因此构建命令仍显式指定保存名。所有旧存档保持独立；Git回退代码不会回退实时角色。

## 状态与演出的分界

1. 提交原主线110117才开放村庄接取。开始体验可用明确生成的独立起点角色；不得修改旧角色强制进入。
2. 章节进度存入当前角色的 `fanChapterReturnLight`。已读对白、救援、转盘、装置、Boss胜利和仪式节点各有检查点。
3. 第三仪式节点、结局、已付金币和待领余额构成同一保存对象；奖励总额50000，金币满时余额保留。
4. 新仪式动画只在真实第三节点完成后显式启动。冷读直接恢复终态；跳过不会再发奖。
5. Boss胜利后的独立退场只改显示透明度，不再扫描命中或推进战斗计时。死亡重试另建战斗实例。
6. 对话输入、暂停、战斗输入需要同时恢复；仅关闭面板不等于恢复控制。新改动至少实测一次键盘和一次鼠标结束。

## 测试工具和证据

- `reverse/tools/chapter_fixture.py`：生成两个明确起点，不含新章胜利；只允许安装到该新保存名的全空槽位。
- `chapter/tests/add_start_roles.py`：向空槽追加正常、毕业金币上限、主线未提交的起点；保留已有槽位。
- `chapter/tests/copy_earned_role.py`：将有摘要的真实实战检查点复制到空槽，不编辑进度；用来检查另一结局。
- `chapter/observer/Source.as` / `reverse/tools/chapter_observer.py`：只读采样包装，不是正式游戏入口，也不算直接启动验收。
- `chapter/tests/save_contract/`：真实AS3保存管理器的隔离接口合同测试；不等同于原生权限弹窗测试。
- `chapter/evidence/session.json`：各候选摘要、实见行为、失败记录、续接点。
- `chapter/evidence/acceptance.json`：最终同包验收；历史包通过不能自动迁移过来。
- `chapter/evidence/private/`：截图、诊断与实战SOL备份，Git忽略。无私人测试档的仓库读者仍可按脚本生成全新起点。

切换测试角色使用完全退出播放器后重开，勿在旧窗口仍打开时使用“打开最近文件”。同一保存名的多窗口会争用内存快照。本章目标是单人流程，完整双人章节并未承诺或验收。

### 原生窗口让位

村庄章节HUD/E/Esc由Controller检查Stage/Main直接挂载的已知原生窗口及SelMap；必须有舞台内实际可见内容才让位。CardPanel存在visible=true但零子项、零边界的常驻空壳，不能仅看visible/stage。SelMap特殊难度页用父容器-2000、子容器+2000抵消，不能仅用root坐标判离屏。`snapshot.nativeUI`只读记录阻断对象和叶子边界；原生窗口关闭后恢复终章输入，长按键需释放后再触发。

原生暂停的隔离测试、实际报告和覆盖边界见 [timeline_pause](../tests/timeline_pause/README.md)。Main 的 SWF 9 版本不得为访问新 API 随意提高。

### 战败返村的原生生命周期

`Main.AddPlayer`沿用现有Player；HP为0时将其放到y=-50。`Main.GameStart`只对村庄变体0调用原生复活，主线后的变体3/4不调用。因此终章的死亡菜单必须在保存/Loading前显式复活并恢复真实HP/MP上限。正常活着返村和胜利返村不额外回血。候选12实际发现此缺陷，候选13补上该顺序，运行证据以验收表为准。
