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

## Remaining gates

Original comparison, full rebuilt resource integration, and fresh canonical-source candidate runtime remain unverified.

## Main quest1, 2026-10-24 01:05 Beijing

Accepted through quest panel, then entered map1 one-star. Complete button changed from gray to blue. Clicking it removed the quest from accepted list and awarded one head equipment icon, EXP1603→2103 (+500), gold10000652→10000982 (+330), matching displayed rewards. Player was not edited or scripted to trigger the condition. Screenshots core-quest-ready.png, core-quest-turned-in.png and core-quest-reward-stats.png. This is still core fee59837 with original external modules.
