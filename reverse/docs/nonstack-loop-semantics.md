# Six restored nonstacking paths fail to terminate on a full container

These are confirmed control-flow losses in original Main →928e reconstruction, independent of NaN input. They occur in `Bag.isGemBagEmpty`, `Bag.addGemBag`, `Bag.addOtherobjBag`, `Bag.addQuestBag`, `Storage.addGemStorage`, and `Storage.addOtherobjStorage`.

For a nonstacking item, original bytecode scans indexes0..23 (Bag) or0..34 (Storage). On an empty slot it returns true, assigning the item in the five mutating methods; if every slot is occupied it returns false. Recovered source expresses this as `while(true) { if(index < capacity) { ... index++; continue; } }`, with no exit when index reaches capacity. Recompiled code therefore spins at the limit until the host interrupts it. This is not an intentional original behavior.

The source entry points are under `reverse/source/3_L4399Main_gamefile/com/hotpoint/braveManIII/models/container/{Bag,Storage}.as`. Original and928e P-code full selected method bodies, including namespace operands, are retained as `reverse/experiments/ordered-comparison/nonstack-slices/*.json`. Input hashes are in `reverse/manifests/nonstack-loops.json`.

Reproduce:

```sh
python reverse/tools/audit_nonstack_loops.py
git apply --reverse --check reverse/experiments/ordered-comparison/nonstack-candidate.patch
```

The tool does not execute a SWF. Its restricted interpreter executes the **actual original/rebuilt P-code**, following labels/jumps and the instructions on the nonstacking path. It implements only the required local/stack, integer, array, branch and return instructions; `getIsPile`/`isMany` are the only mocked calls and both return false. Unknown executed instructions raise an error. A repeated full machine state (PC, locals, stack and array) detects the rebuilt cycle; this is not merely a wall-clock timeout.

There are172 finite fixtures: each possible single empty slot and the full container, for each method. Both versions agree on every fixture with a hole, including written index. All six full fixtures return false in the original and reach a repeated unchanged state in928e. This is strong evidence for this concrete path under the supplied ordinary array/item assumptions; it is not an AVM runtime result or full stacking-path equivalence proof.

A concrete example is `Bag.addGemBag`: original final scan checks `getlocal4; pushbyte24; iflt ofs00c1`, and its false successor executes `pushfalse; returnvalue`. Rebuilt code at index24 takes `ifnlt ofs003e`, then `jump ofs001d` back to the same bound test; neither local index nor bag changes. The other five methods have the same proven full-container cycle with their own recorded offsets.

The reviewed patch, now applied to Main, replaces each affected nonstacking branch with a bounded loop, returns true at the original success point and false after exhaustion. It changes no stacking algorithm, capacity, item type, or save representation. Before application the CRLF-aware patch passed `git apply --check`. Main now has22 applied method-level repairs, combining these six loops,15 negated-comparison guards and one shop integer local. `manifests/main-semantic-repairs.json` records every method before/after hash and original ABC provenance. Fresh compiled P-code/runtime validation is a separate pending step. Reverse-check verifies the applied loop patch against the repaired source.

Do not test the old928e full-container case in the user's running game merely to demonstrate a freeze. A future isolated regression harness or a repaired build should exercise empty-first, empty-last and full containers. Root owns any AVM/UI execution. Before restoring copies in DataX/resources, verify each module's original affected body: absence/presence of the same source idiom is candidate selection, not proof of an identical original loop.

The original stacking paths can return false even after moving items, and can assign through an index initialized to−1 in some circumstances. These are visible in original P-code too. This patch deliberately preserves them; correcting original game defects would require a separate specification.

The subsequent Main2c0b888c0b16 compilation passed the affected actual-P-code fixtures in `manifests/main-semantic-repairs-validation-2c0b888c0b16.json` (172 container and18 continue fixtures total), plus the other repaired branch/int32 checks. This is fresh compiled-code evidence; runtime game behavior remains a separate validation layer.
