# Original 5.6: concrete behavioral expectations

These are **static expectations derived from the original package**, not observed runtime passes. Use them to compare isolated original and rebuilt sessions. All source references below are under `reverse/exports/3_L4399Main_gamefile/scripts/` unless specified otherwise. Test difficulty must be `GameData.gameLV == 1`; higher difficulty uses different tables. A graduation fixture may alter progression, keys and derived attributes, so record the actual fixture and do not infer a fresh-character result from it.

## Map 1 / 落月之原

Map selection UI `src/SelMap.as:247–283` sets map ID then room1 after difficulty selection. Normal progression uses the `继续` door and `src/Door.as:111–115` increments `gameNum2` and calls `GameStart`.

From `src/_data/Data2_data.as` first difficulty table:

| Room | XML line | Required map symbol | Spawn sequence (0=random) | Random choices | Total normal enemies | Concurrent cap | Interval | Win condition | Boss |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 67 | Map_1_1 | 1 | none | 17 | 5 | 5 seconds | 1: clear enemies | none |
| 2 | 113 | Map_1_2 | 1,2 | none | 17 | 5 | 5 seconds | 1 | none |
| 3 | 159 | Map_1_3 | 1,2,0 | 1,2 | 17 | 6 | 5 seconds | 1 | none |
| 4 | 205 | Map_1_4 | 1,2,0,0 | 2,1 | 17 | 6 | 5 seconds | 1 | none |
| 5 | 251 | Map_1_5 | 0 | 1,2 | 5 | 2 | 5 seconds | 2: Boss HP<=0 | 3 |

`GameData.GetData:79` converts the configured interval to frames by multiplying `Main.fps`. The 5-second value is a frame-timed nominal interval, so frame drops/pause can change wall time. `MonsterGo:107–172` spawns normal enemies in batches up to the concurrent cap, decrementing the remaining budget. Boss creation is separate and occurs while `BOSS>0 && BOSSid>0`; boss spawns at `world._width-200, y380`. Wanted-target state may add an extra boss and alter the win condition; clear/record it in a comparison fixture.

All five Map_1_* symbols are verified present in original `Map1.swf`. Room1 contains only 小蛇; seeing 独眼怪 there with ordinary map state is a mismatch. Rooms1–4 open the next door only after `Enemy.All.length<=0`, no spawn budget, and enemy layer empty (`GameData.Win:247–268`). Room5's condition2 checks Boss HP, not necessarily cleanup of every remaining normal enemy (`GameData.Win:273–289`). Door opening is delayed via `Open(60)`; do not mark a transition failed immediately on last-hit animation.

Enemy table for difficulty1:

| ID | Symbol/name | HP | Physical defense | Attack coefficient | Magic attack / defense | Base XP | Gold | Bundle index | XML line |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 小蛇 | 852 | 4 | 1 | 0 / 0 | 18 | 3 | 1 | 15363 |
| 2 | 独眼怪 | 852 | 4 | 1 | 0 / 0 | 21 | 4 | 1 | 15444 |
| 3 | BOSS眼镜蛇（内部类名；UI 显示金光蛇王） | 6000 | 15 | 1 | 0 / 0 | 250 | 415 | 1 | 15525 |

`Enemy.SkinData:193–268` populates these values and resolves skins from `EnemyArr[关卡]`; this is `Enemy1.swf`, not `Enemy3.swf` for boss ID3. Before a first hit, the boss life/max pair should be6000/6000 at difficulty1 absent explicit test modifications.

## Damage and death invariants

The actual player attack, animation hit coefficient and number of hit components must be observed; an arbitrary fixed expected damage number is not valid across equipment and skills.

For a normal player hit with **no critical, no set-skill proc, water==1**, `Enemy.HpXX:310–334` computes approximately:

```
A = player.use_gongji.getValue()
h = HitXX.gongJi_hp
c = player.职业附加[player active skin category]
t = HitXX.times
r = Math.random(), 0 <= r < 1
raw = A*h*c * (1 + r*InitData.X002) + Enemy.gongJiPOWER
D = max(0, int(raw - enemy.防御力/t))
```

`InitData.as:175` sets X002=0.02. The integer local truncates the pre-clamp result. A critical flag multiplies by `tempXXX2` (created from `8/4`), but equipment set effects can add further modifications. When `water!=1`, a subsequent magic multiplier applies (`Enemy:459–462`). This is why comparing two independent runs requires an expected range or controlled instrumentation, not pixel-identical floating damage numbers.

**Analytic example only, not a fabricated test result:** A=100, h=1, c=1, t=1, gongJiPOWER=0 with the exclusions above yields damage96–97 to 小蛇/独眼怪 and85–86 to boss ID3. Ordinary game attacks may have different h/t/c and do not necessarily satisfy this example.

`Enemy:489–515` decreases HP only when damage>0 and life was positive, clamps lethal life to0, credits XP/gold, invokes quest/drop/achievement updates and returns. The normal path calls `TaskData.setEnemyNum(id)` then `TaskData.isEnemyTaskOk()`. It should not count the same already-dead enemy on repeated hits because the life>0 guard blocks that death branch. XP receives `InitData.GetEXPxN()`; with no timed multiplier the getter returns XX1 (`InitData:289–297`). Dead players do not receive XP/gold through `Player.ExpUP:401` / `MoneyUP:461`. Drops and set effects make total gold/XP comparisons noisy; record per-kill context if testing exact deltas.

## Task110001 and110002: states and persisted fields

Original XML is `reverse/exports/3_L4399Main_gamefile/binaryData/8632_src.Data2_taskData.bin`.

| Field | 110001 | 110002 |
| --- | --- | --- |
| Name | 【主线1】落月之原 | 【主线2】新的历练 |
| XML lines | 3–42 | 44–85 |
| Level | 1 | 1 |
| Quest giver | 霍根 | 霍根 |
| Prerequisite | -1 | 110001 |
| Main completion condition | enter map1 | kill10 enemies with ID1 小蛇 |
| Clear required | false | false |
| Map/star gate | map1 / any star | any map / any star |
| Reward | gold330, XP500, item12510×1 at100% | gold340, XP500, item12610×1 at100% |
| Small type | 0 | 0 |

State is not a simple permanent completed flag:

- New/unaccepted task starts state0 (`models/task/Task.as:47–59`). Accepting through task panel calls `taskJs`, sets state1 and checks current conditions (`views/taskPanel/TaskPanel.as:621–637`).
- `Task.isTaskOk:598–608` sets state2 when all conditions hold, otherwise state1. `GameData.GetData` → `TaskData.initGk` updates map conditions on room1; entering map1 normally is sufficient for110001 without clearing the level.
- `Task.setEnemyNum:330–349` increments the matching `_enemyedArr` counter up to its required amount. Killing enemy2 does not advance110002. At10 matching kills it should become ready via the death update path.
- **Claiming these main-quest rewards does not leave state3.** `TaskPanel.taskFinsh:640–656` sets smallType0/1 tasks back tostate0 and increments oldTime. State3 is used for smallType2 daily tasks. A passed110001/110002 should be identified by oldTime>=1 plus the progression/UI consequences, not by an expected state3.
- Turn-in requires sufficient inventory space (`TaskPanel.taskAw:661–697`); otherwise the UI reports 背包空间不足 and leaves it unclaimed.

`TaskData.saveTask:181–199` serializes non-smallType1 tasks into:

```
save.RenWu[taskID] = [state, oldTime, goodsCounts, enemyCounts, overTime]
```

The counter arrays can contain typed VT values. Do not compare their raw object identity or flatten the entire SOL to plain JSON; decode numeric values appropriately. For a partial110002 run: after e.g.3 snakes, save/reload should retain count3 and state1. After10 snakes before claiming: count10,state2. After successful reward claim: oldTime increments and counts reset via clearData; state0 is correct.

### Original UI route

Use a fresh isolated character to ensure these quests are available. Open the quest panel through the village chief/task UI, select the named quest, then the visible accept button. In code, button names prefixed `j` dispatch `taskJs`; `f` dispatch reward claim (`TaskPanel.doClick:564–575`). These names are diagnostic evidence, not instructions to inject synthetic clicks or call methods directly.

Accept110001 → enter map1 via normal map selection → inspect ready state → use menu 回城 → claim110001 → accept110002 → enter map1 → kill3 snakes → save/reload → confirm3/10 → kill7 more → confirm ready → claim reward. Main and fresh save histories may affect NPC presentation; use actual labels rather than old screenshot coordinates.

## Saving and UI cooldown

- HUD system-menu trigger is `Xfile_mc` → `File_OPEN` (`src/Play_Interface.as:107,895–908`). The menu binds `file_mc.save_mc` to 保存 and `city_mc` to 回城.
- 保存 calls `Main.Save()` only when `saveTime<=0`, then sets saveTime800, closes the menu and installs a frame countdown (`Play_Interface:936–957`). Displayed seconds are `int(saveTime/27)`; approximately29.6seconds at27fps. A second immediate save click during cooldown is **not expected to produce another save**.
- `Main.Save:359–366` delegates `Save2`. `Save2:379–444` can decline to save on noSave/multi-open flags; it builds the payload and delegates to `LocalSaveManager.saveSlot`. Metadata includes the selected slot index/title/date and data, followed by flush (`LocalSaveManager:39–54`).
- Turn-in of110001/110002 calls `Main.Save` through `TaskPanel.SaveXX:700–711`; neither ID is in the skip list atline179. An accepted quest alone does not prove it was persisted; perform an explicit successful save or turn-in.
- Save payload includes `p1`, `P1P2`, `changKu`, `guanKa`, `RenWu` and other persistent state. It does **not** save the transient current `gameNum/gameNum2`, active enemies or their HP. A restart returning to village is not a failed combat-room persistence check.

For save acceptance, record the test SO path/hash before and after a permitted save; reopen in the same isolated namespace and inspect the chosen slot. Require unchanged personal-save hashes. Preserve test field snapshots in private logs and report only relevant counters, never upload personal SOL contents.

## Boss 名称与显示层的区别（运行反馈核对）

地图 1/房间 5 的 Boss ID3 在 Data2_data XML 中的 `<名称>` 为 `BOSS眼镜蛇`，这是 `Enemy.SkinData`→`addSkin` 使用的类/linkage 名（Enemy.as:184–185、205），不是要显示给玩家的中文名称。`Play_Interface.as:558` 按 `"a" + bossIS.id` 切换 Boss 头像/标题时间轴。根运行验证反馈显示“金光蛇王 Lv5”，与该内部类名不矛盾。原主 SWF 的 DefineBinaryData cid8633（offset22406512）含“金光蛇王的卡片”，cid8632 的任务介绍也提到“落月之原内的金光蛇王”；这些原资源文本确认这是原游戏显示/剧情用名。本表的 HP 等仍取原战斗配置，UI 名称不能反向替换用于 getDefinition 的类名。
