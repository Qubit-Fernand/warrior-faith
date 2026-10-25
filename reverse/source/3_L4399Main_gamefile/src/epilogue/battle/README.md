# 终章新战斗模块

此目录是《归光之约》同人续写的原创战斗实现，不是原作恢复出的 Boss。图形由 Flash Graphics 绘制，未使用黑暗王子或其他旧 Boss 的皮肤、时间轴和 AI。

## 文件

| 文件 | 职责 | 二次开发入口 |
|---|---|---|
| `ChapterEncounter.as` | 原玩家攻击桥接、Boss 血量、两侧供能节点、状态机、反击伤害、死亡事件、诊断 | `beginAttack()` 编排攻击；`playerDamage()` 计算真实攻击；`beginTransformation()` 处理第二血池；构造 options 调平衡 |
| `BossBody.as` | 诺弥三足底座、悬浮灯核、折叠透镜；霍根王座、中心人影、冠轮、输光臂；断臂与冠轮破裂 | `build()` 修改静态轮廓；`animate()` 修改关节、受击和阶段动画 |
| `BattleHazard.as` | 诺弥地波/锚印；霍根跟踪锁定光束、绿色安全区与全场夺光爆发；共用显示/命中几何 | `render()` 改预警；`touches()` 改碰撞；`trackPlayer()` 控制追踪锁定；`update()` 推进时间 |
| `ChapterDockEncounter.as` | 攻击打断桥锁与两台教学继电器，关闭危险后允许救援 | `snapshot/bridgeBroken/relays` 供 Controller 保存；`spawnHazard()` 调整教学区 |

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

- `warden`：缄潮司灯·诺弥；42 万血，低于半血后预警加快。两侧灯座各 2.4 万血。三足、透镜、灯核分别运动。
- `regent`：窃光王座·霍根；第一血池 28 万、第二血池 36 万，两侧节点各2.4万。第一血池耗尽会清空危险区、断开供能节点，并进行 1.8 秒换阶段。冠轮变为八块分离残片。霍根使用追光锁定和可打断的夺光蓄能，第二阶段缩短追踪/蓄能时间并缩小安全区；不再重复诺弥的地波循环。
- 供能节点仍在时，核心承受 30% 伤害；两侧节点都被真实攻击破坏后，核心承受全部伤害。节点不是永久无敌门槛。
- 金色地波的危险区域只有地面上方 34px；脚部跃升 36px 以上可躲避。紫色光锚高 360px，锁定在预警开始时的位置，必须横向离开，跳跃通常仍命中。
- 所有攻击至少 1 秒预警；光锚一次预警只伤害玩家一次；相同危险对象不会逐帧扣血。
- 灯塔准备使 Boss 基础攻击降到 72%，并使霍根安全区左右各扩大28px；解缚环准备将攻击间歇从 1.35 秒延长到 1.9 秒，并将霍根蓄能打断伤害需求降至70%，为玩家提供更长输出窗口。这两项援助不会改原装备和玩家永久属性。
- 原版 Enemy71 奥加的配置血量为 330 万（`src/_data/Data2_data.as`），用于数量级参考；这里数值尚需父任务实际运行后的普通装备和毕业装备平衡测试，不能视为已调平。

构造 `options` 可覆盖：`maxHealth`、`phaseTwoHealth`、`nodeHealth`、`attack`（默认1800）、`defense`（默认250）、`left/right`、`player`、`beaconPrepared/releasePrepared`、`interruptDamage`（霍根核心蓄能所需打断伤害）。数值调参应明确记录测试角色面板和通关时间。


### 节点读条与破坏反馈

左右供能节点各有独立64×6px血条与供能百分比；血条和文字位于 BossBody 的兄弟显示层 `nodeMeters`，不加入 `leftNode/rightNode`，不会扩大 `hitTestObject()` 的受击范围。命中节点只使对应节点闪烁；命中核心才使核心闪烁。

节点首次破坏时会产生5块短暂碎片、熄灭供能连线、保留倒地残件并显示“已切断”。两个节点都损坏时，每场只显示一次“护盾解除·核心完全暴露”。`snapshot.shieldReleased` 可核验该状态。霍根第二阶段的蓄能连线改从破冠残片汇入核心，不让已断节点重新发光。

### 霍根专属机制与真实反制

1. **追光锁定**：第一阶段总预警2.8秒，先跟随玩家1.7秒，然后固定在最后位置1.1秒；第二阶段为1.1秒追踪+1.1秒锁定。紫色标线显示“追踪中…”→“已锁定！横移！”，角色需横向离开锁定区域。伤害分别是基础攻击的1.1/1.3倍，光束持续0.6秒且每次最多结算一次。跳跃通常无法越过360px高光束。
2. **夺光蓄能**：第一阶段3.8秒、第二阶段3.2秒。Boss 核心出现聚光线、环形光晕和两条计量条：紫色是蓄能进度，绿色是真实攻击累积的打断进度。玩家可选择攻击核心打断，或者进入绿色安全区等待爆发结束。非核心命中不增加打断值。
3. **打断成功**：原 HitXX 对核心造成的原始伤害累计到阈值后立即取消爆发；2.8秒内实际核心伤害提高50%，显示“夺光打断·核心失衡”。阈值默认是角色有效攻击×职业倍率×3，限制在1000–90000，可用 `interruptDamage` 明确覆盖。供能护盾的70%减伤不会降低打断累计，避免节点仍在时无法反制。
4. **打断失败**：明确显示“未能打断！夺光爆发”，除绿色安全区外的全场承受基础攻击1.8倍伤害。爆发持续0.65秒，每次最多一次碰撞扣血。安全区第一阶段宽200px、第二阶段宽144px；出现时距玩家约140px，保证通常可以移动到达。安全区不消耗、修改或强迫选择任何剧情结局，它是本场临时解缚光环。

这些机制没有定时削 Boss 血量，也不强制延长低血战斗；正常攻击、技能、大伤害与两段血池规则仍真实结算。蓄能期间死亡或跨阶段会取消全部危险，不会留下延迟爆发。

诊断新增 `charging/chargeProgress/chargeDamage/chargeRequired`、`interruptions`、`chargeFailures`（蓄能释放次数，不等于扣血次数）、`sanctuaryEscapes`、`trackingDodges`、`exposedRemaining`、`lastMechanicResult`。危险自身带 `tracking/lockRemaining/safeCenter/safeHalfWidth`。Boss和码头均带 `frameDelta`、`playerStats`、`damageContacts`、`lastReceivedDamage`；Boss另有 `lastIncomingPower`。这些都是值快照，便于核验暂停、真实属性、几何碰撞和实际扣血；“碰到危险”与“真正扣血”分别计数。

## 原系统兼容边界

玩家攻击读取原 `HitXX.AllHitXX`，只接收指定单人 `Player` 来源，按真实显示碰撞命中核心或节点，并使用原 `objArr` 防止同一 HitXX 对同一部位重复结算。支持职业攻击倍率、技能 HitXX 倍率、攻击增益、原暴击概率公式、连击计数与能量恢复。大范围技能在同一帧按左节点、右节点、核心顺序遍历重叠部位，不再依赖 HitXX 至少存活三帧。直接父级为 `Fly` 的投射物仍过滤 `life==0`，并拒绝 `over` 且不处于“结束”标签的残留对象；处于“结束”标签的真实 HitXX 允许按普通规则命中。每命中一个新部位只消耗一次正数 life，耗尽后立即停止本 HitXX 的后续目标；-1 保持无限穿透。已在 objArr 中的部位既不重复扣血，也不重复消耗 life。每次结算后如果死亡或发生阶段切换，立即结束整轮攻击扫描，不能把当前池的溢出伤害或本帧其余攻击灌入新血池。非穿越投射物的地图碰撞仍由正常运行的 `HitXX.HitEnemy()` 处理。

Boss 反击创建**不加入显示树**的真实 `HitXX`，再调用 `Player.HpXX()`，因此沿用玩家防御、部分装备防护、伤害数字、硬直、击退和原生死亡。不能把该 HitXX addChild 到舞台：原 `ADDED_TO_STAGE` 需要真实皮肤祖先链。

以下未完整兼容，必须明确告知测试者：
- `BuffEnemy`、原 `Enemy.HpXX()` 内的特定套装/装备被动、宠物和精灵对 Boss 的自动寻敌，不会因新对象自动成为 `Enemy` 而生效。本实现没有假冒旧 Enemy 的击杀与掉落。
- 本模块仅绑定 `Main.player_1`，拒绝其他 Player 来源，尚未实现第二玩家的 Boss 仇恨、危险区命中和失败/复活协调，因此 Controller 当前拒绝本地双人入口。`Main.player_2` 实际也是 `Player`；不要与 PK 网络角色类 `Player2` 混淆。后者的 `HpXX()` 来源要求是另一条兼容边界，并非本地双人限制的原因。
- 不接管原地图重力、玩家落地、原玩家攻击事件与主循环；这些须由实际客户端运行验证。
- 毕业伤害仍然真实结算，没有按时间削血。最终 Boss 的两段血池独立，大伤害能立即打空当前池，但不会把第二阶段转换和清场回调一起跳过。

## 飞行物素材核对与复测边界

2026-10-26 只读解析原 `WuQi_X1_v6.swf` 的 SymbolClass、DefineSprite、FrameLabel、PlaceObject2 和 RemoveObject2：`法师魔法弹` 为 symbol24，`src.HitXX` 为 symbol7。运行标签第1帧放置 HitXX，第27帧移除；“结束”标签第28帧重新放置 HitXX，第29帧移除。这是独立爆炸段，不能仅因 `Fly.over` 为真就抹掉。原 `Fly.as` 的 life=0 分支会先把 life 设回 -1，再切“结束”并设置 over；原 `HitXX.HitEnemy()` 不统一拒绝 over，`onREMOVED_FROM_STAGE()` 则清空被移除 HitXX 的 objArr。因此允许结束标签中实际在舞台上的 HitXX，并不意味着对旧目标解除去重，也不会复活尚未切结束的 life=0 命中。

同一源素材中，雷光球在第1/9/16帧重新放置 HitXX；图腾、雷云、裁决光也反复移除、放置 HitXX。多段由这些实际命中实例/重新入场产生，不用计时器伪造伤害。此处仅支持直接父级为 Fly 的生命周期过滤，原自定义束缚控制、BuffEnemy 和自动寻敌仍遵守上节限制。

本轮只做源码/素材静态核对，未构建或运行播放器。需复测：法杖普攻的飞行段与结束爆炸段；生命为1的投射物不能同帧穿透全部部位；无限穿透单帧范围命中可分别结算重叠的节点与核心；同一个驻留 HitXX 后续帧不再重复扣血；雷云/图腾后续新段可以再次命中；巨大伤害触发霍根转场后当前扫描停止，第二血池保留且对白期间不受伤。结束爆炸碰墙仍须服从原地图碰撞顺序，不能据静态素材宣称实测通过。

## 本轮局部绘制与终态清理

2026-10-26：主任务的候选5普通档实测给出司灯95.829秒、王座136.808秒，并完成release结局；该证据只对应候选5，不能替后续修改作运行验收。胜利截图029/031的最后伤害数字残留，原因是 Controller 在 finished 后不再调用 encounter.update，浮字的渐隐计时也停止。本轮在 finish 的终态边界清空伤害浮字；reset/dispose同步清理。战斗中浮字原0.9秒渐隐与暂停逻辑保持，不为浮字新增独立计时器。

BossBody局部装饰：司灯底座增加铜甲接缝、通风槽、铆钉、透镜细肋与玻璃高光；王座改为两侧分面靠背和独立座基，中心保留人物空隙，增加冠轮刻线、扶手接头、锁链与人物头肩/手臂；二阶段在装饰层增加裂纹，原冠片分离轮廓增加断面线。未使用图片、旧Boss素材或新增类。drawCore、drawNode两个方法逐字节未改，核心/节点原位置、尺寸、摇摆及转动不变；新增细节属于frame/crown装饰，未加入core/node子树。只完成静态检查，实际呈现和重新构建由主任务验收。

退场补充：Controller不再更新finished战斗，因此仅调用一次body.animate(.05)会令主体透明度停在.975。本轮在finish清理浮字/危险后，立即隐藏蓄能条、供能百分比、连线和碎屑，再启动仅服务终态表现的一秒ENTER_FRAME收尾。它只调用BossBody.retireVisual(dt)，将主体alpha平滑降到.42、灯核到.12、冠轮到.3，保留可识别残骸；不删除场景中的归光装置。该收尾允许在胜利对白期间完成，不受战斗暂停阻塞，但绝不调用战斗update、不推进elapsed/stateTime、不扫描命中、不产生伤害、不发送胜利或存档事件。完成一秒、reset、dispose或离开舞台时均移除监听。snapshot新增visualRetirementActive/bodyAlpha，可核验退场完成时战斗时间与血量不变。此修改仍仅完成静态检查，待主任务重新构建和观察。

## 维护与验收记录

2026-10-25：新增三份 AS3 实现及本说明。首编译发现私有方法 transform 与 DisplayObject.transform 属性冲突，已改名 beginTransformation。随后依据原 HitXX 分支补入 Fly 的失效过滤和有限穿透消耗，增加数值化攻击/核心 bounds 诊断，并纠正本地双人 Player 与 PK Player2 的区别。新增霍根追光锁定、可打断夺光蓄能、失衡奖励和绿色避难区；码头与Boss加入实测属性/DT/接触和扣血诊断。基于候选2普通85级（HP18627、攻击2017.2、防御760.15）的开场实测，首6.3秒8次命中只削核心5914、节点合计45782，旧180万/126000节点可能形成长消耗战，故下一候选将诺弥调至42万、霍根28万+36万、节点统一2.4万；基础攻击保留1800。新增独立节点血条、单节点闪烁、断线碎片和护盾解除反馈。新参数仍须真实持续战斗验证，未宣称已达2–4分钟目标。子任务只做静态核对，不运行构建或 Flash；编译、实际命中、读档与原地图接入由主任务负责。

必须验收：剑/法杖至少各一种真实攻击；节点破坏；地波跳跃躲避；光锚横移躲避；受击实际扣血；两段血池与巨大伤害；暂停不会继续推进计时；死亡重试；退出销毁危险对象；同一场胜利事件只触发一次；普通装备和毕业装备分别通关；霍根追踪后锁定不再跟随、真实核心命中打断蓄能、失败爆发安全区内外差异、失衡增伤和二阶段加速。未经上述运行证据，不得标注“完整验证”。
