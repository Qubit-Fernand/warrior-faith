# 终章世界装置

`ChapterScenery.as` 是独立矢量表现组件，加入原地图的 `moveChild_Other`。它不拥有剧情、战斗、碰撞、键盘或存档，不修改传入状态。所有交互由 Controller 根据 `interactionPoints()` 的世界坐标自行检测。

```actionscript
var scenery:ChapterScenery = new ChapterScenery("dock", 1600, 450);
worldDecorationLayer.addChild(scenery); // Controller 传入对应地图的 moveChild_Other
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

新绘素材：木港口与支柱、可降渡桥／断裂锁链、双关押点铁栏、两组不同衣色居民（各三人）、有船帆的归航船、可偏转指针罗盘、石砌归航灯塔、六扣解缚环、输光臂／冠轮残骸、熄灭神像、三间窗灯小屋、守灯／归乡居民。全部由 Flash Graphics 绘制，无旧 Boss 素材、外部图像或图片加载器。

动画：桥旋转、居民步行／轻摆、船体浮动、罗盘校准方向、装置光脉冲、住宅窗光各自闪动。新场景只在地面附近叠加局部装置，不铺设整屏背景遮挡原地图。

生命周期：没有事件监听、计时器或 stage frameRate 改动；`dispose` 幂等，销毁后不再更新、不再返回交互。first `setProgress` 之前只能视为未初始化的装饰预览。

2026-10-26：子任务首版，源码与 API 静态检查。未由子任务编译或启动 Flash，实际地图遮挡／交互可达性／冷读恢复由主集成任务验证。

## 仪式与动画完成（第二轮补足）

`animating` 检查桥角、已校准罗盘针角、居民目标位置的误差是否大于 0.8。常驻光效、船体浮动与尚未校准的针不计入，避免永远等待。`settle()` 将这些行动动画立即推进到同一个最终 transform，不修改状态、奖励或任务；首次 `setProgress` 自动调用。Controller 应以 `!animating` 作为完成条件，并在 UI 模态／暂停期间停止等待推进；跳过动作调用 `settle` 后走同一完成回调。

`endingChoice` 仅控制三处仪式节点的预览类型；`endingNodes` 按顺序显示已点亮的灯或已打碎的锁环。未完成节点和已完成节点都返回交互点，顺序／重复检查由 Controller 承担。只有正式 `ending` 非空才显示最终世界态：长明保留灯塔光，散光使主解缚环彻底碎裂并熄灭供能光。这里不会自行设置 ending 或颁发奖励。

司灯／王座的出路航标与装置一样，在相应 Boss defeated 后出现。新增三个独立地面仪式节点、灯芯／断环碎片、返回司灯路牌。尚未经本子任务构建或 Flash 验收。

## 码头断电通路（第三轮补足）

场景另读 `dockRelays` 位掩码（bit 1 扫波继电器、bit 2 光锚继电器）。两处继电器本体／受击锁由 `ChapterDockEncounter` 负责；本组件不重复绘制攻击目标。关押点及居民画在机关右后侧 85 像素，交互仍保持 x620／1080。断电前地面提示使用金／紫色；供能解除后显示朝船方向的绿色箭头，第二段只有前后两处都安全才转绿。牢门在实际 rescuedGroups 推进后才打开，不能把击破机关等同于自动救人。场景不增加伤害或碰撞。

台词和场景同步为“攻击桥锁 → 击破继电器 → 开门撤离 → 航标校准”。首次恢复及跳过动画的规则不变。
