# 5.6 runtime architecture — evidence and reconstruction constraints

This document describes the supplied **offline 5.6 package**, not a recovered original authoring project. The package already contains a local-save adaptation. Original module hashes are in `reverse/manifests/original-files.json`; the principal module is `3_L4399Main_gamefile.swf` SHA-256 `b362fd3035995e63998de714cec9eb2fbe5216b4ee078182d48e30f5e1474b32`.

## Evidence scope

`M/` means `reverse/exports/3_L4399Main_gamefile/scripts/`; `D/` means `reverse/exports/DataX_v76/scripts/`; each is a fresh FFDec export from the current original module. Main receipt reports 710 / 710 ABC scripts exported, with no decompiler issue markers. Fourteen principal main classes were text-compared to the prior cache and are identical, so line citations remain valid. This proves source extraction, not compilability or behavioral equivalence. The prior main cache had only 278 files and must not be used as a completeness measure.

Raw symbols checked by `reverse/tools/analyze_references.py` are read directly from all current 164 root SWFs. The tool does not execute the game or read personal saves. Whole-package ABC constant-pool scans find `SharedObject`, `getLocal`, `yzlr2_saves` only in the main module, with no matching storage API strings in the other 163 modules. This is strong static evidence for the known local-save path, not a proof against obfuscated/dynamic runtime construction.

## Startup and loading

1. `M/src/Main.as:638–715`: `InitXX` establishes stage/global references, registers serialization aliases, opens `Strat`, starts keyboard tracking, and initializes inline `TempData`. `LocalSaveManager.init()` runs at the title screen and may flush a new SOL before a player is selected.
2. `M/src/TempData.as:18–75`: version `560`; maps, enemy bundles and other assets are registered by filename. Filename suffixes are content revisions, not independent game versions.
3. `M/src/Strat.as:289–302`: slot metadata → `Main.applySaveObject(meta.data)` → `Strat.startGame`; new game paths create one/two players and select village map 0. The root document's normal loading route is `Main.Loading` → `Load.Open` → staged loaders.
4. `M/src/Load.as:108–205`: village startup loads map, data, three player-animation sets, three weapons, enemy skills, embedded `Data2`, music, pets and dynamic equipment. Subsequent level loads use existing global data and map/enemy caches. Map 17 and 81 have explicit enemy-bundle preload lists.
5. `M/src/ClassLoader.as:19–44,60–65,105–112`: `Loader.load`/`loadBytes` accepts an optional `LoaderContext`, usually omitted at call sites. Classes are obtained from each loader's `contentLoaderInfo.applicationDomain`; this is not an asset basename import. Preserve domain parentage and load ordering in a reconstruction. Whether duplicate classes bind to the same runtime definition must be tested, not inferred from matching names.
6. **False-complete loader hazard**: `ClassLoader.ioErrorFun:75–80` traces the error but then emits `Event.COMPLETE`. An event marked complete, or a completed loading bar, does not prove the file or required class loaded successfully.
7. `M/src/Main.as:751–857`: after `All_Loaded`, get level configuration then `GameStart`; destroy old world, instantiate map class, add players, initialize task/achievement state and HUD. `GameData.SelMapName:591–606` uses configuration `预留2/预留3`, with a map17 special case. `Main.AddMap` asks the loaded map module for that exact exported class.

## Runtime data and resources

| Concern | Source / binding | Consequence for a rebuild |
| --- | --- | --- |
| Level, enemy and enemy animation tables | `M/src/Data2.as:60–72` invokes inline XML functions in `M/src/_data/Data2_data.as` | Main holds level tables; do not assume DataX owns every table. |
| Tasks, achievements, pets, titles, shops and other data | `M/src/Data2.as:23–95`, binary-backed `Data2_*` classes and repository factories | Restore binary data tags and class linkage as well as `.as`. |
| Equipment, skill, consumable and item tables | `D/src/InData.as:25–37` factory initialization | Prior cache `EquipXML:40–48` was a timeout stub. Fresh export now restores the XML at lines42–54332 (1,392 equipment rows). |
| Player animation | `Load:375–426`, `Player.PlayerMcArr`, `Player.newSkin` | Animation symbols/timelines and code must agree. |
| Equipment appearance | `M/src/NewLoad.as:59–103` constructs `equip_<skin>_<className4>.swf` | Static quoted-filename searches miss dynamic equipment paths. Current equipment rows must drive the resource closure. |
| Map collision/render layers | `M/src/Map.as:53–105` uses timeline children `_Data`, `Data1`, `Data2`, `moveChild`, `map_3` | Flattening timelines or renaming instances destroys behavior even if scripts compile. |
| Enemy skins | `M/src/Enemy.as:164–268` reads enemy `关卡` and `名称`, then `EnemyArr[关卡].getClass(名称)` | Enemy numeric ID is distinct from enemy bundle/map ID. |

The same package names occur in many resource modules. A mass merge of all exported AS sources is not safe without identifying which definitions are active in their ApplicationDomains. Symbol linkage, dynamic properties, frame scripts, E4X XML initializers, and class aliases are integral parts of the program.

## Map progression: misleading missing-class reports

`reverse/manifests/resource-references.json` contains every fresh main literal filename and an XML-row versus actual SymbolClass audit. Fresh scan: 333 stage rows; 60 rows request unexported names if **each row is treated as a fresh map load**. All 60 are stages 51–55, rooms 2–5 across difficulties 1–3.

These are **in-place segments of a continuous map**, not demonstrated missing maps:

- `M/src/Map.as:43–49,140–151` defines scroll boundaries and `stopYn` for maps `50 < id < 81`.
- `M/src/GameData.as:329–342` (win condition 4) advances `gameNum2`, reloads enemy configuration with `GetData()`, and calls `world.NoStop()` without `GameStart()` or `AddMap()`.
- Normal entry loads room1; subsequent segments retain the same map instance. Forcing a direct `Loading()` at map55/room5 wrongly requests `Map_55_5`. The previous final-chapter test's failure on this direct warp is therefore not proof that the original sea progression is broken.
- A normal door transition uses `Door.GoWhere:111–115`, increments room and calls `GameStart`. It must not be confused with sea segment progression.

Other false-positive literal findings:

| Literal | Verified control flow | Classification |
| --- | --- | --- |
| `Enemy17.swf` | `Load.Loading:139–142` uses `Loading_Enemy_All` instead of `enemyArr[17]`. The preload list is at line46. | Registry entry bypassed in normal map17 load; not evidence enemy ID17 is unavailable. |
| `Data2X_v19.swf` | `Load.Loading_Data2:501–508` directly constructs `new Data2()`; `otherArr[11]` is not loaded there. | Obsolete/bypassed table entry. |
| `TempData.swf` | `Main.LoadTempDataArr:192–196` invokes inline `TempData.Init`; literal appears in unused `ClassLoader.NoCookie` helper. | No demonstrated live external dependency. |
| `HD61.swf` | `SixOne_Interface:357–375` loads it and requests `ysPanel`/`TiShi`. Constructor reachable through `Open`. No caller of `Open` found in full main export. | Conditional dependency; entry reachability unresolved pending all-module caller audit. Not “HD graphics” merely from its name. |
| `/_assets/assets.swf` | FFDec-generated `[Embed]` source reference. | Export/build asset container, not an original runtime network URL. |

## Player, enemy and combat

`Player.onENTER_FRAME:1235–1257` processes consumables/death then cooldowns, skin movement, keyboard control, physical movement. `KeyControl:1756+` refuses input while skin animation locks (`continuousTime`, `Get_StopRun`) are active. `getKeyStatus:2396–2431` maps configured keys to `BasicKey`. Inputs are not hardcoded only to one layout.

`Enemy` registers itself in `Enemy.All` after resolving its skin. It reads HP, speed, gravity, attack parameters, defenses, level, XP, gold, drops and attack distances from XML (`Enemy:193–268`). Its frame loop/movement AI begins at lines689/730. Skins and frame-triggered hitboxes contribute behavior; `Enemy.as` alone is not the complete enemy AI.

`HitXX` collects hit instances and dispatches damage to `Enemy.HpXX`, `Player.HpXX`, or `Player2.HpXX` (`M/src/HitXX.as:68–332`). Player effective attributes combine base growth, skills, equipment, titles, pets, etc. (`Player:470–1113`). Do not treat base HP or an XML attack coefficient as an effective final stat. `Enemy.HpXX:281+` handles damage/death and `TaskData.setEnemyNum(id)` at line512; player damage entry is `Player.HpXX:1526+`. Exact numerical equivalence remains a runtime-test requirement.

## Quest and progression

`TaskData.initAllTask:61–68` consumes `TaskFactory.allTask`, loads saved progress and computes active/completed tasks. Gates include player level (`playerLevelFun:318`), rebirth (`reOk:482`), predecessor task (`qzOk:512`), NPC and category. Level entry updates map/star conditions (`initGk:686–718`); `setTg:721` updates clear conditions; enemy death updates counters (`setEnemyNum:733`); item gains update goods (`addGoods:745`). `saveTask:181–200` supplies the `RenWu` field written by `Main.Save2`.

A task test must observe an actual condition change and saved/reloaded state. Calling a completion function directly is a test harness action, not validation of ordinary progression.

## Known external boundaries and next verification

`Main.serviceHold` is assigned only by `Main.setHold:633–636` in the fresh main source. The inspected local startup does not show an injected 4399 host. API events are installed by `Strat.onLog:159–164`; many service methods remain in `Api_4399_All`. Payment, ranking and lookup methods vary in null guards, so “offline means all APIs harmless/no-op” is not a defensible global claim. `X61_LingQue` has a direct URLLoader endpoint, and UI forum links use `navigateToURL`.

The fresh equipment XML has 1,392 rows and 24 distinct `加载文件` values (including 0, which means no dynamic file). Expanding the 23 nonzero values over all three skins produces 69 filenames, all present. This is an upper-bound filename closure, not proof all rows can be worn by every skin. Default `1_v2` assets are also present.

One type inconsistency needs behavioral verification: `EquipBaseData.getClassName4():String` (`repository/equip/EquipBaseData.as:367`) returns the raw string, but `EquipFactory.findClassName4():int` (`EquipFactory.as:216`) and `Equip.getClassName4():int` (`models/equip/Equip.as:195`) coerce it before `NewLoad` constructs a filename. Do not silently “fix” this in a fidelity rebuild or report new missing files based only on the string coercion; compare original and rebuilt behavior with affected equipment.

Next: complete all-module network/event caller audit; validate duplicate-class binding, timeline children and actual normal-stage progression in isolated runs. Static coverage and runtime-test results must remain separate.

## Concrete original-UI smoke plan (not executed by this analysis)

Use the same ordered actions against isolated original and rebuilt outputs; record pass/fail independently. Observe labels/state before clicking rather than hardcoding screen coordinates from a previous window.

1. Launch isolated title screen, dismiss version-update panel if present. Confirm only test SOL was created. Select a **new single-player character** in a test slot for quest coverage; use a distinct cloned high-level fixture slot for fast combat/skill coverage.
2. Enter village and inspect player, NPCs, background, HUD, equipment icons and sounds. Open keyboard settings if needed. Default P1 keys from `views/setKeyPanel/SetKeyPanel.as:16` are W/S/A/D, J/K/L, H/U/I/O, 1/2/3, Space/N. Do not assume a loaded fixture retains defaults. Move both directions, jump, attack, switch weapons; record animations and movement, not just key dispatch.
3. On the fresh character, accept village chief 霍根's `【主线1】落月之原` (ID110001). Its data explicitly requires map ID1, no clear requirement; starting prerequisite is -1. Source: `binaryData/8632_src.Data2_taskData.bin:3–42`. Enter map1 via normal world-map UI; observe quest becomes ready and return/turn in. This is a short genuine quest-trigger check without manufacturing completed flags.
4. Optional next quest110002 requires killing ten 小蛇 (enemyID1), prerequisite110001, lines44–85. This verifies enemy→quest-counter integration using ordinary play. Preserve an intermediate counter across save/relaunch if possible.
5. Normal-map combat: map1 `落月之原`, room1; boss route map1 room5 (bossID3). All five exact `Map_1_1`…`Map_1_5` symbols exist in Map1.swf. Follow normal `继续` doors after clearing rather than warp a room; observe load/transition and a real boss HP decrease/death. The high-level fixture speeds this route but is not evidence of fresh-character balancing.
6. In the fixture, use an unlocked skill and confirm animation, resource/cooldown change and enemy damage; open equipment, change a visible piece and inspect sprite/derived-stat change. Record a concrete item ID and before/after stat. Numeric equipment file values and `1_v2` are worth separate coverage because of the return-type inconsistency above.
7. Save via normal UI, quit that player, inspect isolated SOL/hash changed and the expected quest/equipment fields (private logs), relaunch and load same slot. Check village/map state according to the game's designed save behavior, equipment, level/gold and quest progress. Do not require exact current combat room persistence unless source says it is saved.
8. Additional map-family coverage if time: enter map51 at room1, clear a segment, and observe in-place scroll boundary release/next-wave progression. This tests the corrected sea-map model; do not start at room2–5 through a full loader.

For diagnostics, automated method calls or injected test probes may help inspect state, but clearly label these separately from the original-UI checks. A probe setting a task complete or applying damage is not a substitute for the corresponding gameplay test.
