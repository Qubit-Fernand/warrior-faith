# 终章世界装置

`ChapterScenery.as` 是独立矢量表现组件，由当前 Controller 加入原地图的 `moveChild_Back`。它不拥有剧情、战斗、碰撞、键盘或存档，不修改传入状态。所有交互由 Controller 根据 `interactionPoints()` 的世界坐标自行检测。

```actionscript
var scenery:ChapterScenery = new ChapterScenery("dock", 1600, 450);
worldDecorationLayer.addChild(scenery); // 当前 Controller 使用 moveChild_Back
scenery.setProgress(chapterState); // 添加后立刻调用；首次直接恢复已保存位置
scenery.update(dt);               // dt 秒；暂停期间由 Controller 停止调用
var points:Array = scenery.interactionPoints();
if(!scenery.animating) { /* action visual has reached its endpoint */ }
scenery.settle();                 // explicit skip: same action endpoint, no progress changes
scenery.dispose();               // 清除装置并从父容器移除
```

场景 key：`dock`、`warden`、`regent`、`village_beacon`、`village_release`。构造默认世界宽 1600、地面 y=450。交互 x 值遵循本章约定，不随 width 缩放；width 用于木码头长度与场地残骸位置。若地图更窄，集成方须提供相应可达场地或整体设置坐标变换。

`setProgress` 复制 `bridgeOpen`、`rescuedGroups`（0–2）、`calibrationDone`、`beaconPrepared`、`releasePrepared`、`boss1Defeated`、`boss2Defeated`、`ending`、`endingChoice`、`endingNodes`（0–3）。首次加载直接显示持久化位置，之后渡桥平滑放下、获救居民沿地面走向船。它不自行推进救援计数，也不因走到船自动发放奖励。

交互对象结构 `{id,label,x,y,radius}`，半径 90、y 为地面。每次调用返回新数组和新对象。

| 场景 | 交互点 |
| --- | --- |
| dock | bridge 300、group1 620、group2 1080、compass 1380、exit 1510；完成点仍返回并改变提示，业务层决定是否可再次触发 |
| warden | boss1Defeated 后：beacon 250、release 1150、exit 1450 |
| regent | boss2Defeated 后：beacon 350、release 1100、return_warden 1400；选择中的 endingChoice 有效且 ending 为空时，另返回 ritual1 520、ritual2 800、ritual3 1050 |
| village_beacon / village_release | post 700，作为相应后日谈 NPC 交互 |

新绘素材：木港口与支柱、可降渡桥／断裂锁链、双关押点铁栏、两组不同衣色居民（各三人）、有船帆的归航船、可偏转指针罗盘、石砌归航灯塔、六扣解缚环、输光臂／冠轮残骸、熄灭神像、三座低矮路灯龛、守灯／归乡居民。全部由 Flash Graphics 绘制，无旧 Boss 素材、外部图像或图片加载器。

动画：桥旋转、居民步行／轻摆、船体浮动、罗盘校准方向、装置光脉冲、路灯龛灯光各自闪动。新场景只在地面附近叠加局部装置，不铺设整屏背景遮挡原地图。

生命周期：没有事件监听、计时器或 stage frameRate 改动；`dispose` 幂等，销毁后不再更新、不再返回交互。first `setProgress` 之前只能视为未初始化的装饰预览。

2026-10-26：子任务首版，源码与 API 静态检查。未由子任务编译或启动 Flash，实际地图遮挡／交互可达性／冷读恢复由主集成任务验证。

## 仪式与动画完成（第二轮补足）

`animating` 检查桥角、已校准罗盘针角、居民目标位置的误差是否大于 0.8。常驻光效、船体浮动与尚未校准的针不计入，避免永远等待。`settle()` 将这些行动动画立即推进到同一个最终 transform，不修改状态、奖励或任务；首次 `setProgress` 自动调用。Controller 应以 `!animating` 作为完成条件，并在 UI 模态／暂停期间停止等待推进；跳过动作调用 `settle` 后走同一完成回调。

`endingChoice` 仅控制三处仪式节点的预览类型；`endingNodes` 按顺序显示已点亮的灯或已打碎的锁环。未完成节点和已完成节点都返回交互点，顺序／重复检查由 Controller 承担。只有正式 `ending` 非空才显示最终世界态：长明保留灯塔光，散光使主解缚环彻底碎裂并熄灭供能光。这里不会自行设置 ending 或颁发奖励。

司灯／王座的出路航标与装置一样，在相应 Boss defeated 后出现。新增三个独立地面仪式节点、灯芯／断环碎片、返回司灯路牌。尚未经本子任务构建或 Flash 验收。

## 码头断电通路（第三轮补足）

场景另读 `dockRelays` 位掩码（bit 1 扫波继电器、bit 2 光锚继电器）。两处继电器本体／受击锁由 `ChapterDockEncounter` 负责；本组件不重复绘制攻击目标。关押点及居民画在机关右后侧 85 像素，交互仍保持 x620／1080。断电前地面提示使用金／紫色；供能解除后显示朝船方向的绿色箭头，第二段只有前后两处都安全才转绿。牢门在实际 rescuedGroups 推进后才打开，不能把击破机关等同于自动救人。场景不增加伤害或碰撞。

台词和场景同步为“攻击桥锁 → 击破继电器 → 开门撤离 → 航标校准”。首次恢复及跳过动画的规则不变。


## 居民与村庄回归表现细化（候选 6a 之后）

修改前 `ChapterScenery.as` SHA-256：`1fe4302a29e45f112c5386ac5ed305a87b76b5fa17137a71965a11a698458ae0`。对照 `034-candidate6a-release-cold-village.png`，原先圆头衣块与透明小房直接叠在原作悬赏板区域，比例和细节不协调。本轮仅调整装饰绘制，供下一候选统一整合；未修改已运行的 6a 包。

- `person()` 增加私有可选外观变体与提灯开关，保持返回 Sprite。使用曲线脸、分束发型、眼白/虹膜/高光、袖口、围裙或领口、分离的裤腿与靴子；成年人和儿童仍使用原有缩放规则。三种外观是无名居民的同人设计，不新增人物身份或原作设定。
- release 居民右手真正握住带提手、框架及灯芯的灯笼，柔光附着在手臂上；取消旧稿悬浮在衣服旁的孤立光点。beacon 居民保留无提灯的守灯造型。
- `animatePerson()` 只对私有身体/脚/手臂子层做小幅呼吸、交替步态与提灯摆动。外层居民坐标、目标点、朝向及救援速度仍由原逻辑控制。`settle()` 同时将腿部姿态复位；装饰动作不参与 `animating`，不会阻止剧情等待结束。
- release 熄灭神像改为带石座、兜帽、面部刻线、双手与衣褶的灰石雕像，保留不发光状态和原位置。只是通用纪念雕像，不声称恢复原作女神立绘。
- 原先高 132、宽 122 的半透明小房改成高约 52、宽 52 的低矮石质路灯龛，避开原作建筑轮廓与悬赏板主体；装饰位置为 x900/1100/1300，三灯独立闪动。改变的是装饰位置，所有 `interactionPoints()` 坐标、半径、标签和返回结构均未改。

静态检查范围：接口与交互块保持、装饰没有事件监听/输入/存档调用、dispose 原有数组清理覆盖新增子对象、diff 无空白错误。本子任务没有编译、启动播放器或修改 Controller；脚与地面、悬赏板遮挡、提灯层次、冷载入及救援步态仍需下一候选截图/实测验收。不可据此宣称与原作美术已经一致。


## 第三节点后的三段归光仪式

新增 `beginEndingSequence(ending:String):void`。Controller 在第三节点完成、已 `setProgress` 到正式 ending 并保存之后，显式调用一次，然后继续原有 `animateChange(2.5, ...)`；后者重复 `setProgress` 不会重置演出。例如：

```actionscript
scenery.setProgress(chapterState); // ending 已为 beacon / release
checkpoint();
scenery.beginEndingSequence(String(chapterState.ending));
animateChange(2.5, showEndingDialogue);
```

调用只对 regent 场景、合法结局且与本组件 progress.ending 相等时生效；同一组件实例最多开始一次。不会自动从 `setProgress` 启动，因此冷读仍直接显示保存的终态，不重播。公开接口没有改动已有方法的参数。

演出总长 2.3 秒，三段分别从 0 / 0.65 / 1.3 秒开始：

- beacon：三个节点依次由暗转亮，稀疏青绿光粒沿弧线汇向 x350 灯塔的灯室，抵达后短暂扩散光圈。
- release：三处节点的束缚环依次分成三段、分离并淡出；暖色光粒沿右侧返航方向 x1320/1368/1416 流去，对应人们提灯归家的方向。最后主解缚环跟随第三节点分离，再回到已保存的碎环终态。这些落点只是表现坐标，没有增加交互或人物。
- 演出图层完全透明，无满屏遮罩；只画小粒子/细线/环段，继续位于 world 的背景装饰层，不盖过角色层。灯塔位于镜头左侧时，可能只看到光粒朝左移动；本组件不移动镜头。

`animating` 在演出期间为 true，2.3 秒内恢复 false，不增加原来 2.5 秒的等待时间；游戏暂停时 Controller 不调用 update，演出也暂停。`settle()` 立即清理过程图形并显示相同终态，支持已有 Enter 跳过；dispose 清除图层引用。所有持续时间、节点临时可见态与过程几何都留在组件内部，不改章节状态、交互、存档或战斗。

本轮只做源码静态核查。实际镜头范围、三段节奏、暂停/跳过、冷读不重播及两个结局的最终画面尚待主任务统一构建运行验证。
