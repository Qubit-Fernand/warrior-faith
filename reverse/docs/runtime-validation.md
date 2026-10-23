# Runtime validation log

## Main reconstruction, first candidate

- Compiled all 710 exported script units with Flex; materialized from AS3 plus script-free asset SWF. External modules still original at this stage, so this is core reconstruction, not full-package completion.
- Test store: `yzlr2_rebuild_probe`, seeded only from repository graduation preset. Three protected live saves verified unchanged after title startup.
- Adobe Flash Player Debugger 32.0.0.465: title/update UI rendered successfully; isolated slot1 Lv85 visible and slots2–8 empty as expected.
- Reading slot1 failed with ReferenceError1065 `com` undefined in XingLingFactory.creatFactory via Data2/Load. Full-qualified syntax without matching import under non-strict Flex was treated as dynamic property traversal. Candidate is failed, not accepted.
- Repaired import sets: retain explicit Tool.XMLAsset, expand conflicting src.tool wildcard to used TiaoShi (or empty). Repeat runtime test passed read/save-slot loading and village entry.

## Core runtime candidate fee59837, 2026-10-24 00:16–00:40 Beijing

The running core SHA-256 is `fee59837cf0d2d331deeae2d917dda1a2fd0bf8208202e0954d46448f46fd57f`. The other 163 SWFs are still original, loaded from the isolated runtime directory; these results do not validate full-package reconstruction.

| Check | Observed result | Scope |
| --- | --- | --- |
| Title and update dialog | Pass | Debugger32.0.0.465, direct SWF open |
| Isolated preset read | Pass | Lv85 slot1; slots2–8 empty; initial HP48848, MP17571 |
| Village | Pass | Loaded with character/equipment/NPC visuals |
| Movement/jump/camera | Pass in sampled route | D/A/K, village to right portal, map1 rooms1–4 |
| World map/difficulty selection | Pass | 落月之原 one-star |
| Ordinary encounter | Pass | Snakes and one-eye enemies spawn, move, hit player and die |
| Basic attack | Pass in sampled encounter | J alone caused nearby remaining enemies to disappear and drop items |
| Skills | Pass in sampled encounter | U/I/O animation, MP reduction, hit numbers (one observed123680) and combos |
| Room completion | Pass for rooms1–4 | Exit appeared after enemies cleared; W moved to next room |
| Boss and clear result | Pass | Room5 金光蛇王Lv5 spawned and died; W portal opened result screen, then returned to village |
| Equipment manipulation | Pass | Dragging armor to bag removed it, character appearance and stats changed |
| Save and cold reload | Pass | System save success; full player quit/relaunch; armor remained in bag and stats persisted |
| Quest | Pass for main quest1 | Accepted 落月之原, entered map1, complete button enabled, reward granted |

Screenshots are under ignored `reverse/logs/runtime/`; capture timing after a damage animation may show a later frame, so textual observations and exact runtime hash are retained here. HP decreases while the game runs between actions; no numerical equality with an original control has yet been claimed. Protected original/final/epilogue save hashes were all unchanged at UTC16:36:50.

## Reproducible canonical-source candidate 96ce6635

`build_main.py` now consumes tracked `reverse/source/3_L4399Main_gamefile`, stages only exported non-AS resources, archives the previous staging directory, and compiles to a fresh output path. It checks compiler output existence and error text as well as return code; normalized output must parse recursively.

Two builds with fixed staging path (`run-39691ycz`, `run-txy0xskm`) produced byte-identical SHA-256 `96ce6635d3ad0868d83f0fcbe74890a3ef7dedbcf4046d5619b417a0b7b458ba`. Randomized staging paths were an unsuccessful reproducibility route: Flex changed private helper numbering and ABC ordering. The fixed-path candidate retains 712 classes/710 scripts/7148 methods and the audited XMLAsset binding, but has not yet been opened for runtime verification. It is separate from the currently running fee59837 candidate.

## Equipment/save observation, 2026-10-24 00:57–01:03 Beijing

Core candidate fee59837 remained paired with original external resource SWFs. Armor 热血—玄冰战甲+10 was dragged from equipped slot into bag cell1. HP maximum changed48848→23953, attack7104→5840, defense3658→1747, critical24.3%→23.4%, dodge24.5%→19.2%. After explicit System→保存进度, the player process was fully exited and restarted. Slot1 timestamp00:58:36, bag armor cell1 and all five values matched. EXP1603 and gold10000652 also persisted. Re-equipping restored HP maximum48848 and defense3658; current HP stayed23953, so low-HP attack modifiers apply and attack should not be compared to a full-health initial state.

Images: core-map1-clear-result.png, core-armor-removed.png, core-save-success.png, core-armor-cold-reload.png, core-quest-accepted.png. Screenshot capture after a temporary save-success toast can miss the toast; actual UI response and slot timestamp are recorded separately. The three protected user saves were checked again after save/reload and remained byte-identical to baseline.

## Gates at 01:05

Original comparison, full rebuilt resource integration, and fresh canonical-source candidate runtime were unverified at that checkpoint. Subsequent results below supersede this historical status.

## Main quest1, 2026-10-24 01:05 Beijing

Accepted through quest panel, then entered map1 one-star. Complete button changed from gray to blue. Clicking it removed the quest from accepted list and awarded one head equipment icon, EXP1603→2103 (+500), gold10000652→10000982 (+330), matching displayed rewards. Player was not edited or scripted to trigger the condition. Screenshots core-quest-ready.png, core-quest-turned-in.png and core-quest-reward-stats.png. This is still core fee59837 with original external modules.


## Original control, 01:09–01:18 Beijing

The control uses original Main with only the SharedObject string changed to `yzlr2_original_probe`; all 7,147 original method body hashes and the other 163 SWFs remain original. It is a save-isolated control, not a reconstructed main. The repository graduation preset was seeded into the separate store.

Observed: title/read/village, initial HP48848/MP17571/attack7104/defense3658/critical24.3%/dodge24.5%; skill NPC dialogue and skill panel (LV9, 999 points); armor removal produced HP23953/attack5840/defense1747/critical23.4%/dodge19.2%. Re-equipping left current HP23953, causing low-HP attack8880. Main quest1 completed on entering map1; turn-in gave exactly +500EXP/+330gold and a head item. Basic attacks, drops and H/U/O animations/MP use were observed in room1. The original control did not finish a Boss run in this sample. Images `original-*.png` under ignored runtime logs.

## Full source-rebuilt package, 01:19–01:43 Beijing

Package `reverse/build/runtime-all-rebuilt-20261023T171635.802067Z`: 164 rebuilt SWFs, zero original-code fallbacks. Main `96ce6635d3ad0868d83f0fcbe74890a3ef7dedbcf4046d5619b417a0b7b458ba`; DataX `02ab9b45c2310ffb79b2e84a1ba0d70da53b24f40a1a4a57f1148813a3ce5def`. Its 164 provenance receipts are pinned inside `diagnostic-origin/`; later builds do not alter this historical package. This package predates full build-input fingerprint gating, so current strict launcher will not select it.

Fresh isolated `yzlr2_rebuild_probe` fixture was installed while all players were stopped. Direct Adobe Debugger launch passed title, save-slot read, DataX initialization, village, skill-NPC dialogue/panel, matching initial stats and equipment visuals. Main quest1 was accepted, then Map1 one-star entered.

All four ordinary rooms were cleared in order and their W exits used. Snake and one-eye enemies spawned, moved, damaged the player and died; J attacks produced combos and equipment drops; H/U/O caused animations and MP reduction. Room5 金光蛇王Lv5 appeared, its HP bar emptied, and its portal led to the actual challenge-success screen. Result: time0:14:55, highestcombo9, hitsreceived455, totaldamage1671351, killpoints2. This is a human-operated sample with analysis pauses between inputs, not a performance benchmark. A surviving ordinary enemy did not prevent the Boss exit, consistent with the exit depending on Boss defeat rather than every enemy.

Return-to-village stats: EXP1621, gold10000655, killpoints1000001, HPmax48848, attack7104, defense3658, critical24.4%, dodge24.5%. Armor moved into bag cell1 changed HPmax23953/attack5840/defense1747/critical23.5%/dodge19.2%. Main quest1 turn-in awarded EXP+500=2121, gold+330=10000985, head item in bag cell2. Explicit system save displayed success.

Player was fully quit; `pgrep -fl 'Flash Player'` returned no process. Reopening the same immutable package showed slot1 timestamp **2026-10-24 01:41:29**. After reading, armor remained unequipped in cell1, reward head item remained cell2, EXP2121/gold10000985/killpoints1000001 and all five unequipped stats matched. This verifies persistent mutation rather than only re-reading the unchanged preset.

The +0.1 percentage-point critical difference from the original-control/core samples was investigated instead of ignored. After cold reload, monster book showed **小蛇 three gold stars**, earned attributes **critical20**, all other attributes0, totalstars3/30. This independently confirms the original random monster-card reward mechanism (`critical-rate-analysis.md`). Re-equipping restored HPmax48848 and defense3658; current HP23953 activated attack8880 as in the original control.

Images: `full-village.png`, `full-skill-npc-dialog.png`, `full-skill-panel.png`, `full-initial-stats.png`, `full-room1-combat.png`, `full-boss-entry.png`, `full-map1-clear-result.png`, `full-after-clear-stats.png`, `full-armor-removed.png`, `full-quest-ready.png`, `full-quest-reward-stats.png`, `full-save-success.png`, `full-cold-reload-stats.png`, `full-snake-card-confirmed.png`. Original/final/epilogue saves were rehashed after the test and remained unchanged.

### Build-repeat limitation discovered after runtime packaging

Two new input-fingerprinted Main builds `run-lx5icqis` and `run-b062kbrm` both succeeded, but hashes were respectively96ce6635 and928e3d909992abb9b73e1820a45dd373d26171c460a72e296f605601df396248. All46,154 SWF tags except the ABC payload are identical. Full resolved P-code comparison found only three compiler private-namespace serials and six single-class script initializer global-lookup/slot allocation differences; branch targets resolve to the same instruction. No business-instruction difference was found. These are static equivalence indications, not proof of all gameplay equivalence. Fixed staging alone therefore does **not** guarantee byte-reproducibility. See `module-probe/main-repeat-resolved-audit.json`; the later928e variant needs its own runtime sample.

### Coverage still open

This validates the full source-rebuilt package in one ordinary/Boss route and selected NPC/equipment/task/save flows. It does not cover all maps, enemy mechanics, careers, shops, pets, cooperative play, online services or every story branch. Audio has not been independently listened to. Newer strict fingerprints/launcher, resource import harness and numeric boundary harness still need runtime acceptance at this checkpoint.
