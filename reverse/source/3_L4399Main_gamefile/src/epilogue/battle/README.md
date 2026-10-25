# 终章新战斗模块

此目录是《归光之约》同人续写的原创战斗实现，不是原作恢复出的 Boss。图形由 Flash Graphics 绘制，未使用黑暗王子或其他旧 Boss 的皮肤、时间轴和 AI。

## 文件

| 文件 | 职责 | 二次开发入口 |
|---|---|---|
| `ChapterEncounter.as` | 原玩家攻击桥接、Boss 血量、两侧供能节点、状态机、反击伤害、死亡事件、诊断 | `beginAttack()` 编排攻击；`playerDamage()` 计算真实攻击；`beginTransformation()` 处理第二血池；构造 options 调平衡 |
| `BossBody.as` | 诺弥三足底座、悬浮灯核、折叠透镜；霍根王座、中心人影、冠轮、输光臂；断臂与冠轮破裂 | `build()` 修改静态轮廓；`animate()` 修改关节、受击和阶段动画 |
| `BattleHazard.as` | 金色低位行进光浪、紫色竖直光锚，以及与显示共用几何的命中判定 | `render()` 改预警；`touches()` 改碰撞；`update()` 推进时间 |

## 集成契约

```actionscript
import src.epilogue.battle.ChapterEncounter;
var fight:ChapterEncounter = new ChapterEncounter("warden", arenaWidth, groundY, {
    left: arenaLeft,
    right: arenaRight,
    player: Main.player_1,
    beaconPrepared: false,
    releasePrepared: false
});
Main.world.moveChild_Other.addChild(fight);
fight.addEventListener(ChapterEncounter.DEFEATED, onBossDefeated);
// Controller 每帧调用；单位秒。地图换场、弹窗、暂停、死亡时停止驱动。
fight.update(deltaSeconds);
var hud:Object = fight.snapshot;
// hud.name / hp / maxHp / phase / hint
fight.setPaused(true);
// 重试前由 Controller 恢复玩家及地图检查点；reset 不会给玩家回血或写档。
fight.reset();
// 退出时由 Controller 移除自己的事件订阅，再销毁战斗。
fight.dispose();
```

`groundY`、`left`、`right` 必须是加入父层后的共同世界坐标；不要把屏幕坐标或摄像机平移后坐标混入。默认战斗根 Sprite 不平移，Boss 位于区间 64% 处。保留至少 400px 宽的平地，玩家初始位置须在边界内。此模块不改变地图碰撞、不创建新的 `Enemy`，也不负责禁止原刷怪和原 `GameData.Win()`；Controller 要在自定义战斗中接管这些流程。

公开只读项：`dead`、`finished`、`phase`、`hpRatio`、`hint`、`bossName`、`paused`、`snapshot`。

事件：
- `chapterBossDefeated`：每次 reset 后最多一次，只报告获胜，不写存档、不生成奖励、不调用原关卡胜利。
- `chapterBossPhase`：进入新阶段时一次。
- `chapterBossAttack`：新预警开始，可供控制器播放音效。

`snapshot` 还包含 `phaseHp/phaseMaxHp`、`state/elapsed`、`nodes/nodeMax`、`attackIndex`、`playerHits`（玩家攻击命中新 Boss 数）、`attacksLanded`（Boss 使玩家实际扣血次数）、`lastDamage`、`phaseTransitions`、`hazards`、`playerHp`、`lastHitBounds/coreBounds`、`lastHitAt/lastHitSource/lastHitResult`。`lastHitBounds/coreBounds` 使用战斗根层局部坐标，只保存 x/y/width/height 数值；未碰到核心的有效攻击也会更新 lastHitBounds，便于诊断地面普攻高度。应以这些真实状态判断测试是否发生，不能把截图中看到 Boss 当作完成战斗验证。

## 玩法与默认数值

- `warden`：缄潮司灯·诺弥；180 万血，低于半血后预警加快。两侧灯座各 12.6 万血。三足、透镜、灯核分别运动。
- `regent`：窃光王座·霍根；第一血池 180 万、第二血池 240 万。第一血池耗尽会清空危险区、断开供能节点，并进行 1.8 秒换阶段。冠轮变为八块分离残片；第二阶段增加双光锚并加快光浪。
- 供能节点仍在时，核心承受 30% 伤害；两侧节点都被真实攻击破坏后，核心承受全部伤害。节点不是永久无敌门槛。
- 金色地波的危险区域只有地面上方 34px；脚部跃升 36px 以上可躲避。紫色光锚高 360px，锁定在预警开始时的位置，必须横向离开，跳跃通常仍命中。
- 所有攻击至少 1 秒预警；光锚一次预警只伤害玩家一次；相同危险对象不会逐帧扣血。
- 灯塔准备使 Boss 基础攻击降到 72%；解缚环准备将攻击间歇从 1.35 秒延长到 1.9 秒，为玩家提供更长输出窗口。这两项援助不会改原装备和玩家永久属性。
- 原版 Enemy71 奥加的配置血量为 330 万（`src/_data/Data2_data.as`），用于数量级参考；这里数值尚需父任务实际运行后的普通装备和毕业装备平衡测试，不能视为已调平。

构造 `options` 可覆盖：`maxHealth`、`phaseTwoHealth`、`nodeHealth`、`attack`（默认1800）、`defense`（默认250）、`left/right`、`player`、`beaconPrepared/releasePrepared`。数值调参应明确记录测试角色面板和通关时间。

## 原系统兼容边界

玩家攻击读取原 `HitXX.AllHitXX`，只接收指定单人 `Player` 来源，按真实显示碰撞命中核心或节点，并使用原 `objArr` 防止同一 HitXX 对同一部位重复结算。支持职业攻击倍率、技能 HitXX 倍率、攻击增益、原暴击概率公式、连击计数与能量恢复。大范围技能可以命中多个不同部位，与原“一次攻击可命中多个敌人”的语义一致。直接父级为 `Fly` 的投射物会过滤 `life==0` 与 `over`，每命中一个新部位按原逻辑消耗一次正数 life；-1 保持无限穿透。同一部位已经存在于 objArr 时不重复消耗。非穿越投射物的地图碰撞仍由正常运行的 `HitXX.HitEnemy()` 处理。

Boss 反击创建**不加入显示树**的真实 `HitXX`，再调用 `Player.HpXX()`，因此沿用玩家防御、部分装备防护、伤害数字、硬直、击退和原生死亡。不能把该 HitXX addChild 到舞台：原 `ADDED_TO_STAGE` 需要真实皮肤祖先链。

以下未完整兼容，必须明确告知测试者：
- `BuffEnemy`、原 `Enemy.HpXX()` 内的特定套装/装备被动、宠物和精灵对 Boss 的自动寻敌，不会因新对象自动成为 `Enemy` 而生效。本实现没有假冒旧 Enemy 的击杀与掉落。
- 本模块仅绑定 `Main.player_1`，拒绝其他 Player 来源，尚未实现第二玩家的 Boss 仇恨、危险区命中和失败/复活协调，因此 Controller 当前拒绝本地双人入口。`Main.player_2` 实际也是 `Player`；不要与 PK 网络角色类 `Player2` 混淆。后者的 `HpXX()` 来源要求是另一条兼容边界，并非本地双人限制的原因。
- 不接管原地图重力、玩家落地、原玩家攻击事件与主循环；这些须由实际客户端运行验证。
- 毕业伤害仍然真实结算，没有按时间削血。最终 Boss 的两段血池独立，大伤害能立即打空当前池，但不会把第二阶段转换和清场回调一起跳过。

## 维护与验收记录

2026-10-25：新增三份 AS3 实现及本说明。首编译发现私有方法 transform 与 DisplayObject.transform 属性冲突，已改名 beginTransformation。随后依据原 HitXX 分支补入 Fly 的失效过滤和有限穿透消耗，增加数值化攻击/核心 bounds 诊断，并纠正本地双人 Player 与 PK Player2 的区别。子任务只做静态核对，不运行构建或 Flash；编译、实际命中、读档与原地图接入由主任务负责。

必须验收：剑/法杖至少各一种真实攻击；节点破坏；地波跳跃躲避；光锚横移躲避；受击实际扣血；两段血池与巨大伤害；暂停不会继续推进计时；死亡重试；退出销毁危险对象；同一场胜利事件只触发一次；普通装备和毕业装备分别通关。未经上述运行证据，不得标注“完整验证”。
