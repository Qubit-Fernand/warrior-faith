# Negated ordered comparisons: confirmed recovery differences

This is a targeted **local branch** audit of original Main versus immutable rebuild `run-b062kbrm/normalized.swf`, SHA-256 `928e3d909992abb9b73e1820a45dd373d26171c460a72e296f605601df396248`. It finds 15 Main method sites where a decompiler simplification changes the unordered (`NaN`) case. It does not claim normal gameplay has reached those values, or that all other branches are equivalent. The22 proven Main repairs were subsequently authorized and applied, preserving CRLF; no build recipe, player or personal save was accessed by this audit. Application provenance is in `manifests/main-semantic-repairs.json`; a new compiled build has not yet been validated here.

Reproduce with `python reverse/tools/audit_ordered_comparisons.py`. Original P-code was freshly exported into `reverse/build/ordered-comparison/original/scripts`; the existing full 928e export is reused. `reverse/manifests/ordered-comparisons.json` fingerprints inputs and retains exact branch operands and both successor paths. Complete selected method slices, with source P-code line numbers and namespaces intact, are in `reverse/experiments/ordered-comparison/method-slices/`.

## Why this is a real difference

For ordered numbers, `!(a > b)` equals `a <= b`. For an unordered comparison, they differ: `a > b` and `a <= b` both evaluate false when either operand is NaN. AVM2 `ifngt` branches when the greater-than comparison is not true, including unordered results. Removing that logical negation changes behavior. The original [Adobe AVM2 Overview](https://burgerlib.readthedocs.io/en/latest/avm2overview.pdf), instruction descriptions for `ifngt`/`ifnle`, and the [FFDec instruction reference](https://jindrapetrik.github.io/as3_pcode_instructions.en.html) define this distinction.

The audit follows the actual jump destination, including jump-only blocks, rather than declaring a failure merely because two opcode names differ. All 15 witnesses have the same effect reached by original **taken** versus rebuilt **fallthrough** edges. Operand reads, the effect, and the bypass destination are inspected in their complete method slices. Namespace binding and all unrelated method paths are not proved equivalent by this local analysis.

| Methods | Original condition for the effect | 928e condition | Effect on NaN |
|---|---|---|---|
| `PlayerData.addGold` | `!(sum > Money_max)` | `sum <= Money_max` | Original writes; rebuilt retains old gold |
| 11 `EquipSlot.getAll*` methods below | `!(remainingTime <= 0)` | `remainingTime > 0` | Original includes the equipment statistic; rebuilt excludes it |
| `Bag.delGemById`, `Bag.delOtherById` | `!(requested > 0)` | `requested <= 0` | Original exits the deletion loop; rebuilt continues into bag inspection |
| `ChongWu.GoTo`, attack branch | `!(skillType > 0)` | `skillType <= 0` | Original clears attack flags and returns; rebuilt continues toward an attack frame name |

The 11 EquipSlot methods are `getAllHP`, `getAllMP`, `getAllAttack`, `getAllAttackIgnoreDefense`, `getAllDefense`, `getAllMoveSpeed`, `getAllCrit`, `getAllDuck`, `getAllHardValue`, `getAllMOKANG`, `getAllPOMO`. They each contain one inspected remaining-time condition and the same accumulator/loop-successor pattern. `getAllAttackMagic` is not silently included.

## Concrete counterexamples and limits

**Gold:** original `PlayerData.addGold` P-code pushes `_gold.getValue()+param1`, converts to Number, compares with `Money_max.getValue()`, and `ifngt` jumps to `_gold.setValue(sum)`. Its fallthrough jumps directly to return. Rebuilt `ifnle` skips that setter. With gold 100, increment NaN, cap 500000000, original stores NaN; rebuilt leaves 100. With gold 100, increment 0, cap NaN, original still calls the setter while rebuilt does not, even though both final values happen to be 100. Use increment 4 with NaN cap to observe different final values. Normal gold 100/increment4 produces104 in both; sum500000001 with cap500000000 is refused by both. Neither is a clamp implementation.

Source provenance: `reverse/source/3_L4399Main_gamefile/com/hotpoint/braveManIII/models/player/PlayerData.as:542`; `models/common/VT.as:111` returns `_value.num - _value.random`, and `setValue` accepts Number without a finite-value check. `src/InitData.as:232` sets the normal cap500000000. Number therefore does not establish a no-NaN domain. We have not established a normal UI route that supplies NaN to addGold.

**Equipment:** `models/equip/Equip.as:331` declares `getRemainingTime():Number`. For color≥4 it returns9999, so that path cannot supply NaN. Lower-color items return the VT value; the position<8 `<=0` repair does not repair NaN. With a lower-color equipped item's remainingTime=NaN and otherwise valid statistic10, original adds10 while928e adds0 at this site. Such a malformed fixture is a falsifiable test; we have not introduced one into a live save or claimed normal equipment produces it.

**Bag:** `models/container/Bag.as:1032,1082` accept `param2:Number`. With requestedNaN, original returns before reading a slot;928e enters the body. With a matching **nonstacking** item, the recovered path can remove that item whereas the original exits immediately. With stacking items, the subsequent `_loc5_ <= param2` loop is false and no such removal is inferred. This distinction prevents overstating the counterexample as all item types.

**Pet:** `src/ChongWu.as:236` reads an untyped array entry from `data.getPetSkillType()`. `models/pet/Pet.as:219` clones `_skill`, transforming only elements that compare `>0`; a NaN or missing entry is not transformed. Original attack selection rejects unordered values, recovered code can construct `攻击NaN` or `攻击undefined` and proceed. The normal four-entry skill factory domain has not been proved malformed. Do not claim a particular MovieClip exception before runtime testing that fixture.

## Minimal repairs and application record

`reverse/experiments/ordered-comparison/main-candidate.patch`, now applied to Main, changes only the 15 guards in four Main source files:

- addGold: `if(!(sum > cap))`.
- EquipSlot: `if(!(remainingTime <= 0))`.
- the two Bag methods: `if(!(requested > 0))`.
- ChongWu: `if(!(skillType > 0))`.

These preserve the original negated relation, including its unusual NaN behavior. They add no validity guard, exception suppression, new cap, clamp, or gameplay feature. A separate hardening change might deliberately reject malformed data, but that is a different task from restoration. Check a fresh compiled ABC after applying a candidate: optimization must not accidentally lower it back to the wrong branch.

There are **85** canonical PlayerData copies across the source tree. Method-body census finds **49** with Money_max and **36** without that cap. `playerdata-copy-census.json` lists all with complete bodies. This source census is only candidate selection; each original module's bytecode must establish the branch before copying the patch. DataX and resource definitions cannot simply be assumed dead: application-domain parent lookup often selects the main definition during normal game loading, while standalone resource loading can expose the local copy. See `application-domain-audit.md`. The rebuild agent independently verified all49 original method bodies: each has the same ifngt/write direction. Proof is retained in `manifests/addgold-original-49-proof.json`, with pre-repair Main/DataX comparison in `addgold-pre-repair-comparison.json`. Main was repaired in the22-method application; the other48 copies were then applied by the rebuild agent with per-file before/after checks in `addgold-copy-repair-applied.json`. The36 uncapped copies remain unchanged.

## Expanded census and deliberately unclaimed cases

Across710 original P-code files,630 named methods contain1143 negated ordered comparison sites.56 methods differ in their overall branch-opcode sequence. This includes boolean rewrites, loop layout changes and integer-safe transformations; it is **not56 bugs**. Anonymous initializers are outside this named-method census. Equal branch sequences are also not full equivalence proofs.

Examples checked to avoid false positives:

- `XingLingFactory.GetTolal_Data`: the inspected `ifnle`→`ifngt` compares a value after `convert_u` in the original and explicit uint/convert_u in928e. The comparison operand cannot be NaN. Its alternate local numbering is retained; this is not put in the15 failures.
- `JSONTokenizers.unescapeString`: the inspected changed relation tests `String.indexOf` after `convert_i`, so the comparison operand is int and ordered.
- `MakeData.getArr4`: Array.length is uint; a changed `<4` versus negated `>=4` route does not create a NaN counterexample for an actual Array.
- `LocalSaveManager.pad2` and `ShortRotationPlugin.initRotation` contain compiler boolean-expression lowering; their different branch sequences alone are not evidence of a flaw.

The follow-up completed local guard/edge review of all56 candidates:15 NaN guard losses, **six nonstacking full-container loop losses**, and35 changed-guard sites where no repair is warranted by the reviewed difference. The six real loop defects and172 actual-P-code model fixtures are documented in `nonstack-loop-semantics.md`. The35 local reviews, with per-method reasoning and original/rebuilt branch contexts, are retained in `manifests/ordered-comparison-remaining-review.json` and reproduced by `tools/review_remaining_comparison_guards.py`. They include boolean-negation lowering, branch-block reordering, equality-branch fusion, removed constant branch scaffolding, and integer-domain comparison reversals. This closes triage for the observed56 sequence differences; it does not prove all7,148 method bodies or all methods whose branch sequences happened to match.

## Isolated regression probe

`OrderedComparisonHarness.as` has15 expected tests: nine ordered/unordered relation cases and six gold cases. It imports only Flash display/text APIs, does not load game modules, and does not access SharedObject/network. `python reverse/tools/build_ordered_comparison_harness.py` compiles it and checks its own ABC class/API strings. The receipt `harness-build.json` records exact hash, compiler command, and the six test-method P-code bodies.

The harness uses the branch conditions proved above; it does **not** execute the original PlayerData class or prove the entire game. Its generated `originalGold` uses `greaterthan; iftrue` to skip, while `recoveredGold` uses `ifnle`, checked by the build tool. Root subsequently ran this exact SWF in the official Adobe debugger projector: **15/15 PASS, Failures0**, independently checked against `reverse/logs/runtime/ordered-comparison-15-pass.png`. `experiments/ordered-comparison/runtime.json` records the SWF/screenshot hashes and scope; the historical compilation receipt remains unchanged. This validates only branch-expression counterexamples, not actual game classes or the new game build.

## Validation after application

Root owns compilation and runtime. Once a fresh Main exists, run `python reverse/tools/verify_main_semantic_repairs.py --swf <new-main.swf> --export`. The tool first verifies all eight canonical file hashes against the22+2 method receipts, exports the eight affected classes, verifies all15 negated-relation effects and bypass successors, executes172 container plus18 continue-loop fixtures on that new actual P-code, and checks the quantity decrement uses an int32 opcode. Unknown lowering is rejected for manual review. The resulting hash-named validation manifest is separate from the application record.

Two additional misplaced-continue defects were found outside the negated-comparison census: `SetKeyPanel.closeOk` and `Achievement.getIddo`. They are applied in the separate `main-continue-repairs.json` receipt, bringing Main to24 methods. The four remaining JSON while(true) forms and three progression/error helpers have a documented manual CFG review in `remaining-while-loop-review.json`; no additional loop repair was identified in that scope.

Fresh Main `run-lgf_klke/normalized.swf`, SHA256 `2c0b888c0b161fbed2ef277f4bb05f305e0ffb32b7325f72ee16244a7de83ea6`, passed this24-method check after an independent8-class FFDec P-code export. All15 inspected comparison/effect routes,172 container fixtures,18 continue fixtures and the int32 quantity decrement passed. `manifests/main-semantic-repairs-validation-2c0b888c0b16.json` retains the hash-specific result; no player or save was accessed by this validation. An old928e negative control was rejected at the first addGold comparison. This does not establish whole-method/whole-game equivalence.

Main71b7c20c9edc (run-jl99at2l, explicit `-compiler.omit-trace-statements=false`) also passed the same24-method fresh-export checks. Its distinct report is `manifests/main-semantic-repairs-validation-71b7c20c9edc.json`; the2c report remains historical. These checks cover the repaired methods and do not independently certify every trace argument side effect elsewhere.
