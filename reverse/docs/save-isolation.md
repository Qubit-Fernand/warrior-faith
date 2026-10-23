# Save isolation and test protocol

This is a source-derived protocol; it does not assert that a test environment has already been launched or validated. No personal live save is needed to build the game.

## Verified local save behavior

Citations refer to fresh `reverse/exports/3_L4399Main_gamefile/scripts` (`3_L4399Main_gamefile.swf`). Save-related classes were compared with the prior cache and are text-identical; main exports all 710 ABC scripts with no decompiler issue markers.

- `src/LocalSaveManager.as:10–12`: SharedObject name `yzlr2_saves`; eight slots, indexes 0–7.
- `init:19–36`: `SharedObject.getLocal(SO_NAME)` with no explicit `localPath`; initializes an array and **flushes on the title-screen startup** if absent.
- `saveSlot:39–54`: invalid slot indexes fall back to 0; metadata `{index,title,datetime,data}` is stored and flushed.
- `loadSlot:57–65`: returns metadata; `Strat.LoadNum:289–302` passes `meta.data` to `Main.applySaveObject`.
- `Main.regAllClass:652–694`: class aliases cover PlayerData, Bag, Equip, VT, Task, etc. AMF3 graph identity/typed objects matter. JSON roundtripping is not equivalent.
- `Main.Save2:379–444`: writes players, storage, unlocks, quest data, achievements and many extension fields via `LocalSaveManager.saveSlot`; `saveNum < 0` becomes 0. `noSave`/multi-open flags can prevent a write.
- `verify` is a random scalar saved at Main:417 and read at264 in the fresh main source, not a checksum. There are still version/legacy account checks (`JiaoYan`, `JiaoYan2`:579–607), typed value semantics, and other integrity-related code. Do not generalize this to “zero validation everywhere.”

## Required isolation before first launch

1. Create separate original-comparison and rebuilt test outputs; launch each as a local file with sibling resource paths intact.
2. Patch or compile their `LocalSaveManager.SO_NAME` to distinct test names, e.g. `yzlr2_rea_o` and `yzlr2_rea_b`. Both are 11 ASCII bytes, matching the original `yzlr2_saves`. Equal length is convenient for an audited constant-pool patch but not proof that arbitrary string replacement is safe.
3. Verify the current main ABC strings/classes, exact original count and patch count, rewritten SWF header length, decompression, and source/ABC-level save-name reference. Keep original hashes unchanged. Never patch the authoritative original main in place.
4. Scan all loaded modules for `SharedObject.getLocal`/`getRemote` and other write paths. A single main constant rename isolates its known local manager; it is not whole-program proof until dependent modules have been examined.
5. Do not seed tests by overwriting `yzlr2_saves.sol`, `yzlr2_final.sol` or `yzlr2_epilogue.sol`. Prefer a new game; if high-level coverage requires a fixture, copy the repository's deliberate preset to a uniquely named test SOL with codec-adjusted internal name, or create a synthetic fixture from an isolated fresh save. Mark fixture-derived gameplay separately from natural progression.
6. Hash existing live-save files without logging contents before and after the run; include an unchanged-files receipt in private logs. Existing open game processes can write saves independently, so record their state and avoid attributing unrelated writes to the test.
7. First open only the isolated title screen, then inspect which test SharedObject was created. Continue only if the file path/name matches the intended test namespace. Record actual paths; do not infer them solely from changing process `HOME`.
8. Keep test SOLs and backups ignored/private. Do not upload or commit personal saves or credentials.

A stronger separation is a dedicated macOS user or a player runtime with a verified separate storage directory. Setting HOME alone is not an adequate claim of isolation for a native app that may obtain its home through system APIs.

## Cloud / external calls

Normal local persistence is `Main.Save2 → LocalSaveManager.saveSlot`; the fresh main code does not call a 4399 cloud-save endpoint in this route. `Main.setHold` can accept a host object; do not supply one. Do not log into 4399 or import a browser session for testing.

`Api_4399_All` still exposes payment/ranking/user-data calls via `serviceHold`, with inconsistent null guards. `src/tool/X61_LingQue.as` owns a direct HTTP URLLoader; forum buttons use navigateToURL. Thus a null host is **not** complete network isolation. Use local-with-files sandbox semantics (`-use-network=false` for rebuilt shells where applicable) and verify the output's FileAttributes. Do not click online-event, payment or forum controls as part of ordinary regression testing. Full rebuilt-program fidelity may retain these functions, but live service access is neither required nor authorized by this local test plan.

## Runtime acceptance record

For each of original comparison and rebuilt output, record test namespace, output hashes, player version, input fixture and exact actions. Verify: startup creates only test data; new game/fixture load; village; normal map and boss; movement/attack/skill/equipment; quest trigger; save; quit; relaunch; read same values. A “Save succeeded” UI is insufficient without inspecting isolated SOL changed state and successful re-read. Preserve failure logs rather than suppressing exceptions.

## Static audit receipt

`reverse/manifests/resource-references.json` includes the exact all-164-module ABC string scan. Only main contains known SharedObject/getLocal/save namespace strings; its only fresh-source SharedObject call is LocalSaveManager:25. No getRemote/LocalConnection/FileStream match was found in any module. This supports isolated name patching for this package, while actual created-file inspection and before/after live-save hashes are still mandatory runtime checks.
