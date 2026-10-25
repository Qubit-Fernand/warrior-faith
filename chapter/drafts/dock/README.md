# 码头教学战斗草稿

此目录尚未接入 canonical 源码或构建。主任务确认后，将 `ChapterDockEncounter.as` 放进 Main 包的 `src/epilogue/battle/`；它复用同包已有 `BattleHazard`。不替换旧 Boss，不写存档，不调用原胜利或奖励。

## API

```actionscript
var dock:ChapterDockEncounter = new ChapterDockEncounter(1600, 450, {
    player: Main.player_1,
    bridgeOpen: state.bridgeOpen,
    dockRelays: state.dockRelays,
    attack: 1200
    // nodeHealth: 90000 // 若要固定测试角色属性，显式设定
});
Main.world.moveChild_Other.addChild(dock);
dock.addEventListener(ChapterDockEncounter.CHANGED, dockChanged);
// Controller 的非暂停游戏帧，dt 为秒。
dock.update(dt);
dock.setPaused(true);
// 退出地图时移除 Controller 自己注册的事件，再调用 dispose。
dock.dispose();
```

公开只读 `bridgeBroken`、`relays`、`snapshot`。事件名固定 `chapterDockChanged`，仅在桥锁或一台继电器首次损坏时触发。读档构造不会重新触发事件。`relays` 为已关闭位掩码：1=扫波继电器，2=光锚继电器，3=两者关闭。

主任务 Controller 须自行：

1. 在 dock 场景创建该对象，暂停/死亡时停止驱动；离开时销毁。
2. 事件后复制 `bridgeBroken → state.bridgeOpen`、`relays → state.dockRelays` 并保存检查点，刷新场景表现。
3. 取消原 `E` 一键断桥路径；桥锁必须由真实攻击破坏。桥未开时保持原 x430 边界。
4. 第一组居民要求 `(dock.relays & 1) != 0` 才可救援；第二组要求 `(dock.relays & 2) != 0`。未满足时显示“先关闭旁边的继电器”。
5. 死亡重试重新构造草稿对象；已断桥锁和已关闭继电器从 options 恢复，不重新产生危险。未破节点重新满血，不保存半途 HP。
6. `ChapterState` 若新增 `dockRelays`，为旧状态提供默认 0 并做 0..3 规范化；勿把以前单纯 E 救人推定为真实通过新危险测试。

## 位置、外观与战斗

- 桥锁 x300：铜色绞链、挂锁和锁孔，损坏后锁身落下、链条断开。
- 扫波继电器 x620：横向感应轮，关闭后轮盘坠落、导轨断裂；金色地波在 x430–875 教跳跃。
- 光锚继电器 x1080：竖直双叉与悬晶，关闭后叉臂折断、晶体落地；紫色光柱在 x900–1480 教横移。
- 碰撞体均为各装置本地 x[-30,30]、y[-92,-6]，普通地面攻击更容易触及；每台装置都有短血条与受击闪烁。
- 危险只在玩家进入对应区域后启动；预警 1.65 秒。击破对应继电器立即取消它尚在预警或释放中的危险，永久停止再次产生。两处危险不会为了给远处玩家施压而同时启动。
- 攻击使用原 `HitXX.AllHitXX`，计算玩家有效攻击 × 职业倍率 × 该 HitXX 技能倍率；节点不做原 Enemy 专有的暴击、状态异常或套装触发，也不伪造原杀敌数。
- 每个 HitXX 对每个部位只结算一次。`Fly.life==0/over` 被过滤，有限穿透按已接受的新部位消耗，`-1` 无限穿透保留。地图碰撞仍依赖原 `HitXX.HitEnemy()` 正常运行。
- 伤害通过不加入显示树的真实 `HitXX` 调用原 `Player.HpXX()`，保留防御、硬直、击退和生命值逻辑。默认基础伤害1200，必须按实测角色防御调平。

默认继电器生命在入场时计算一次：`min(120000, 玩家有效攻击×职业倍率×12)`；桥锁取其80%。未达到上限且普攻倍率约1时，桥锁约10击、继电器约12击。技能可更快打断；高攻击毕业装备超过上限后能快速击破。若正常测试角色攻击也超过1万，主任务可显式传入 `nodeHealth=该角色基准普攻伤害×12`，避免正常角色意外少于8击。没有按时间强制削血，也没有等待足够秒数才能破坏的门槛。

`snapshot` 包含节点血量、已完成位掩码、实际玩家命中次数、Boss/机关造成真实扣血次数、当前危险、lastHitBounds/nodeBounds。坐标均相对该战斗根层，保存的是数值，不暴露显示对象引用。

## 当前验证

仅完成静态包名、括号结构、必需接口与禁止保存/胜利调用检查；没有运行编译、Flash 或 Git。需要主任务实际验收普通普攻破节点、两种躲避、受击扣血、关闭后取消危险、死亡恢复、退出后没有残留危险，以及不能靠 E 绕过战斗。
