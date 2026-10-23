# Main rebuild: semantic and namespace audit

This audit compares the original main ABC and the current all-definitions main build inventory. It does **not** certify gameplay equivalence. No player was launched by this audit; runtime results are owned by the root test session.

Reproduce declaration audit:

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/audit_main_namespaces.py
```

Inputs and their SHA-256 values are recorded in `reverse/manifests/main-audit-namespaces.json`. That tool reads the original exported ABC and independently parses the **current** `reverse/build/main-probe/main-normalized.swf` into `reverse/build/main-audit/current-inventory`. It records both the SWF and ABC hash. This avoids a verified stale-root-inventory problem encountered during refresh: current SWF was `fee59837…` while the root inventory still described `2ba9830e…`. The tool augments the existing parser in memory and does not modify root's `swf_inventory.py`.

P-code samples from nine classes are under ignored `reverse/build/main-audit/{original,rebuilt}/scripts`. `reverse/tools/audit_main_pcode.py` generates `reverse/manifests/main-audit-pcode.json`, which fingerprints these sample files independently because the root may have rebuilt the current SWF since extraction. This sampled comparison remains applicable to unchanged classes, not to a subsequently repaired XMLAsset caller without re-export.

## Class coverage and the apparent duplicate

Both original and rebuilt contain **712 actual class records, 710 script records and 7,148 method records**. A plain-name set has 711 entries because two classes display as `PrivateClass`.

They are not one duplicate public definition:

| Owner script | Original private namespace | Rebuilt private namespace |
| --- | --- | --- |
| `com.hotpoint.braveManIII.views.setKeyPanel.SetKeyPanel` | namespace kind5, empty URI, index52 | kind5, empty URI, index49 |
| `com.hotpoint.braveManIII.views.skillPanel.SkillPanel` | kind5, empty URI, index53 | kind5, empty URI, index50 |

Each helper remains in the same script as its owner. The class name, kind and URI alone are insufficient to identify a private namespace; the two identities remain distinct. A decompiler/build process that merged them would be wrong, but this output has **not** merged them.

All 710 script class groupings are preserved, though script order changes. There are no additional/missing public/package/internal class definitions. All 243 private-member namespace owner groupings have the same partition in original and rebuild. Some original named private URI labels become empty strings in the compiler output; these text changes do not represent an observed collapse of namespace identity.

## Declaration, default argument and constant audit

After normalizing private URI labels, the audit compares trait kind, attribute flags, types, method return/parameter types, flags and optional defaults. No ordinary method optional-default difference was found. It also compares decoded trait default constants, retaining their ABC kind.

There are 25 class-level differences when constant storage kinds are retained:

- **23 numeric representations**: 21 Greensock plugin `API` constants change from double `1.0` to integer `1`, and `src.ChongWu.timeNum` / `src.YongShi61.timeNum` from double `270.0` to integer `270`. The declared trait types remain the same. Values agree, but the report retains the encoding difference rather than claiming byte identity.
- **Intentional test namespace**: `src.LocalSaveManager.SO_NAME` changes `yzlr2_saves` → `yzlr2_rebuild_probe`.
- **Constructor metadata**: `PayMoneyVar` initializer return type is original `void` versus rebuilt untyped `*`. Both sampled bodies call `constructsuper 0` and end `returnvoid`; no lost constructor operation was identified in the selected-opcode check. This metadata difference should not be used as evidence that ordinary method signatures were changed.

No field/method was replaced by an empty stub to obtain these results.

## Confirmed binding risk: strict=false is not equivalent binding

The source is dynamically permissive, but `strict=false` also changes generated lookup forms. For example, original `ClassLoader.load` uses a `QName(flash.display,Loader)` and `QName(flash.net,URLRequest)`; rebuilt code uses `Multiname("Loader", namespace-set)` and `Multiname("URLRequest", namespace-set)` covering wildcard imports. Likewise, unqualified instance accesses can become `getlocal0 + initproperty Multiname` rather than `findproperty + setproperty QName`.

This matters in a way already reproduced by the root runtime test: a fully qualified source expression `com.hotpoint.braveManIII.Tool.XMLAsset.createXML` compiled under strict=false as a lookup of a variable named `com`, then a property chain. The resulting `ReferenceError #1065: com is not defined` appeared after title-screen startup when reading a fixture. That failure is a concrete counterexample to class-count coverage implying runnable semantics.

Root's correction is to make imports unambiguous and call the short `XMLAsset` name, preserving the namespace selected from the original p-code. Do not repair this by inventing a global `com` object, suppressing the exception, or replacing the XML loader with empty data.

The namespace-set scan finds two ambiguous `XMLAsset` multinames in original and none in the pre-fix rebuilt inventory. That absence was **not a success condition**: the faulty qualified expression no longer referred to class-name `XMLAsset` at all. Collision analysis must be combined with actual executed opcode paths.

Recommended gate after each import repair: inspect its rebuilt p-code for `getlex/ findpropstrict` on the intended class namespace; then exercise the feature that invokes it. Merely importing the class somewhere or booting the title is insufficient.

## Equipment getClassName4 coercion chain

The previously suspicious String/int mismatch is present in the **original bytecode**, not introduced by the reconstruction:

1. `repository.equip.EquipBaseData.getClassName4` declares return `String`, fetches `_className4`, returns it.
2. `repository.equip.EquipFactory.findClassName4` declares return `int`, calls the first method, returns its result.
3. `models.equip.Equip.getClassName4` declares return `int`, calls the factory, returns it.

The same declarations and return-value sequence are in rebuilt p-code. Neither factory body introduces an explicit extra `convert_i` in the rebuilt version. `NewLoad` then assigns this result to a String used in the equipment resource filename. Preserve this chain for baseline fidelity; changing it to String throughout would be a gameplay/resource behavior change and needs a separate justified patch.

The static resource upper bound is still complete: all 69 literal equipment filename possibilities from table values are present. Runtime coverage should include an ordinary numeric `加载文件` item and a `1_v2` item, because the latter exercises the unusual conversion/default fallback route.

## Sampled Player/Enemy/loader paths

The nine-class p-code pass covers **382 named methods**: ClassLoader12, Main35, Enemy27, Player106, NewLoad5, Equip84, EquipFactory33, EquipBaseData76, PayMoneyVar4. Counts match in each original/rebuilt pair.

A selected arithmetic/throw/return opcode-count check found five methods with differences: Player `MoveData`, `MoveRun`, `runPower`, and Equip `setRemainingTime`, `setSysTime`. They have fewer `subtract` opcodes in the rebuild and corresponding `decrement` forms. This is consistent with compiler lowering of subtraction by one, but **opcode counts alone do not prove the operand/control-flow equivalence**, so they remain explicit targeted regression points rather than silently normalized “passes.”

`ClassLoader`, `Main`, `Enemy` and `NewLoad` have matching counts for those selected opcodes. Their scope/binding forms still differ, as above. No assertion is made about complete control-flow equivalence of all 7,148 methods.

## Initialization order and remaining gates

Original main DoABC flags=1, unnamed block; rebuilt flags=1, label `frame1`. Both document classes are `src.Main`. The original last script group is LocalSaveManager while the rebuilt last group is 雪. Script-group preservation and equal DoABC flags are evidence, but not a proof that class initialization side effects have identical timing. Many gameplay globals construct VT values or arrays statically; test first-ever startup and cold loading, not only a warmed player session.

Before accepting main reconstruction:

1. Re-export/audit repaired XMLAsset callers against the exact current SWF and confirm intended class binding.
2. Cold start, isolated fresh-slot creation and isolated old-slot read must all pass, so initialization differences cannot hide behind cached state.
3. Validate normal movement/jump/knockback/camera bounds (`MoveData`, `MoveRun`, `runPower`), not just a title screen.
4. Validate equipment expiration/date path if claiming that subsystem; current arithmetic scan only identifies the relevant methods.
5. Keep the test SharedObject change explicit; do not “normalize it away” in the final provenance report.
6. Use runtime observations together with the declaration audit; neither alone establishes complete game equivalence.


## Refresh after explicit-import XMLAsset repair

Current audited SWF SHA-256: `96ce6635d3ad0868d83f0fcbe74890a3ef7dedbcf4046d5619b417a0b7b458ba`.
Freshly parsed ABC SHA-256: `1bd60fe801d23a63ccbd9de7a6218a94411512dddd610d2f4a6101a75c1678bc`.
Namespace/declaration results above remain unchanged on this repaired version. The nine-class rebuilt p-code sample was re-exported and its per-file hashes refreshed.

`main-audit-xmlasset-bindings.json` captures fresh p-code of ShopFactory, XingLingFactory and Shop_LiBao2. Their four XMLAsset class lookups now directly name `XMLAsset`; the namespace sets include `com.hotpoint.braveManIII.Tool` and exclude `src.tool`. No `getlex/findpropstrict Multiname("com",...)` was found in those bindings. This is concrete static evidence that the previous qualified-name variable chain has been removed. It still does not replace the root's runtime fixture-load test.

The current static behavioral acceptance values and UI routes are in `behavior-expectations.md`; notably main-quest turn-in is state0 plus incremented oldTime, not state3.

The latest refresh uses root's fixed-staging, tracked-AS build (two root runs `run-39691ycz` and `run-txy0xskm`). Declaration, private partition and selected binding results remain unchanged; all nine sampled rebuilt classes and the three XMLAsset callers were freshly exported from `96ce6635…`. `audit_main_bindings.py` records the binding evidence. At this audit handoff, runtime observations still apply to the earlier `fee59837…` output; the exact `96ce6635…` output requires its own restart/fixture-load acceptance. Static similarity is not substituted for that runtime check.
