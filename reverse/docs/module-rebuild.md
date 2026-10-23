# Representative module reconstruction

Status: all 162 resource libraries have compiled from recovered AS sources. The final pass restored omitted button bindings and root timeline data. All 162 current receipts have `root_timeline.verified:true`, exact repeat compilation, canonical source hashes and matching output hashes; `resource-final-validation.json` records the completed set. Offline comparisons cover 69 equipment libraries (24,449 frames), 9 additional small libraries, Enemy1 and Map1. Actual full-game runtime verification belongs to the parent task. This subtask has not executed the game or accessed SharedObject.

## Reproduce

From repository root, using Qubit Python:

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/probe_rebuild_module.py equip_1_18 --dynamic
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/probe_rebuild_module.py Music_v3 --dynamic
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/probe_verify_modules.py
```

Read editable AS sources under `reverse/source/<module>/`; build manifests are under `reverse/experiments/module-probe/`. Outputs are under `reverse/build/module-probe/<module>/`; logs and exact command arrays are under `reverse/logs/module-probe/commands.jsonl`.

- `equip_1_18/equip_1_18-rebuilt.swf`: `S2` and `src.Skin_ZhuangBei` both recompiled from readable AS. Original script bytecode is not retained.
- `Music_v3/Music_v3-rebuilt.swf`: all 15 Chinese Sound classes recompiled from readable AS. Original script bytecode is not retained.
- `ModuleProbe.swf`: standalone optional runtime harness. It loads only the two original resource libraries and their rebuilt equivalents into separate ApplicationDomains. It does not load the main game, write files or use SharedObject. Text display/trace reports class instantiation, all 340 parent-frame bitmap comparisons, constructor flags and 15 Sound durations/byte counts. Source is `reverse/experiments/module-probe/ModuleProbe.as`.

These modules use the original extracted art/timeline or MPEG sound data. This is asset recovery plus source recompilation, not original FLA recovery. Main and DataX have separate document-class build paths; whole-game acceptance also requires integration tests.

## Source provenance

Each result.json records original SWF SHA-256, all source-file hashes, asset hashes, output hash, normalization details, compiler-generated class and repeat-build comparison. FFDec-generated `[Embed]` annotations are reconstruction instructions, not recovered original source annotations.

FFDec `-exportembed -export script` emits plain AS and `_assets/`. For equipment, `_assets/assets.swf` has no DoABC/DoAction/DoInitAction tags (recursively checked). For music, `_assets/` contains 15 MP3s. The existing FFDec 26.3.0, Flex 4.16.1 and Java 21 toolchain is reused without modifying it.

## Experiments and issues resolved

1. Plain `-export script` emits Embed annotations but omits `_assets`; `-exportembed` is required.
2. `mxmlc` compilation initially reported missing `./themes/Spark/spark.css`, then `./macFonts.ser`. Passing the absolute `-Dflexlib=<SDK>/frameworks`, empty theme/library configuration and explicit playerglobal resolves this. Compiler configuration failure can return exit zero: output existence and strict SWF/ABC validation are therefore required.
3. Compiling `S2.as` as a document class with mxmlc creates both character and document bindings for `S2`. For a loadable resource library, compc is more appropriate: extract `library.swf` from its SWC. The library initially added an empty generated Sprite document class with allowDomain helper methods. The final root-restoration phase removes its id=0 SymbolClass binding so these originally document-class-free resources retain their native MovieClip roots. The unused compiler-generated class remains defined. Original `S2` remains linked to its asset sprite; character IDs are consistently remapped.
4. Flex compc defaults change SWF version, stage dimensions and UseNetwork flag. Build explicitly sets SWF version 9, 550×400 stage, and `use-network=false`, matching the representative originals. Main stage defaults must be inspected independently for other modules.
5. **Flex emits malformed DoABC tag lengths for Unicode tag names.** Music appeared to compile successfully, but strict parsing found truncated ABC and 4,212 trailing bytes. All 15 Chinese ABC names had lengths short by `UTF8_byte_count - UTF16_code_unit_count`. `probe_normalize_swf.py` first validates the declared ABC; only if it fails does it try this measured correction, require a fully parsed ABC, and fix its tag header. It then requires complete recursive SWF and every-ABC parsing. No original bytecode is copied. This is a compiler serialization repair, not stub code.
6. **MP3 export/reimport loses DefineSound timing metadata.** MPEG frame bytes remained identical, but Flex recalculated SoundSampleCount and replaced nonzero SeekSamples with zero in all 15 sounds. The normalizer matches original/rebuilt Sound linkage names, requires identical MPEG bytes, and restores the original seven-byte format/sample-count/seek header. This preserves the sound asset metadata; it does not copy any logic.
7. Compc embeds current compilation time in ProductInfo. Normalize that timestamp to zero. Two independent compiles now produce exactly identical normalized SWF bytes for each representative module.

Raw compiler outputs and pre-fix experimental outputs remain in ignored build/log folders for diagnosis. Files were not deleted.

## Verification evidence

`reverse/experiments/module-probe/validation.json` records:

- Equipment's original and rebuilt linked S2 sprites both have 340 frames.
- All 340 parent frames rendered by FFDec compare identically in size and RGBA bytes; each frame hash is recorded.
- All 15 Sound linkage names are present and their complete sound header plus MPEG data (excluding remapped character ID) match byte-for-byte after metadata restoration.
- Both normalized outputs parse fully and all ABCs parse to classes/method bodies.

Rendering with FFDec does not execute ActionScript. It does not prove timeline event order, nested animation progression, loading into the full game or playback quality. The optional runtime harness addresses a subset of those risks; full-game tests remain required.

## Generalization

- Small resource libraries can be reconstructed from AS plus script-free asset containers.
- All 69 equipment packages passed source compilation, class/member shape comparison and 24,449 offline frame comparisons.
- For large modules, the source may depend on frame-assigned display children or other modules' classes. Compile errors must be resolved from original ABC and timeline evidence, not by adding empty methods or erasing behavior.
- The Unicode DoABC length and MP3 metadata issues mean compiler exit status alone is weak evidence. The full-game pipeline should adopt strict structural validation and resource comparisons before player tests.

## Equipment family extension

`probe_equipment_family.py` applies source reconstruction to all 69 `equip*.swf` packages; `equipment-family.json` is the per-file compilation receipt. `probe_verify_equipment_family.py --resume` compares original/rebuilt named-sprite frame counts, class/super/member declarations and every parent timeline frame. Its incremental results are in `equipment-family-validation.json`. A partial manifest is not proof that the family is complete; require 69 completed receipts with no failure.

Both commands now use canonical sources under `reverse/source/`, while generated binary assets/outputs stay under ignored `reverse/build/module-probe/`. The original loader (`src.ClassLoader.getClass`) resolves definitions through `loader.contentLoaderInfo.applicationDomain.getDefinition`. That API observation alone did not justify discarding root timelines: later auditing found actual root placements in Enemy16 and Enemy5_v2. The final pipeline restores their native MovieClip roots and original controls, rather than relying on an empty generated Sprite.

## Expanded results and current build interface

The equipment extension completed: **69/69 packages, 24,449 parent timeline frames, all byte-identical RGBA comparisons**. Header audit also confirms each original version/stage/frame rate/frame count; three equipment packages are 27 fps rather than 24 fps. Nine additional small libraries passed the same offline comparison. Enemy1 passes 272 parent frames; Map1 passes 582. Counts come from their validation manifests, not a fixed frames-per-module estimate.

`probe_rebuild_module.py <stem> --dynamic` is the general resource-library CLI. It now prefers `reverse/source/<stem>/` as the editable source authority and never overwrites it. It reuses matching root export receipts for `_assets`, then stages sources/assets in a fixed build path. Before staging, the prior directory is moved into `source-history/`; stale files cannot silently participate. `--dynamic` requests `compiler.strict=false`, retaining AVM2 runtime coercions and dynamic references rather than inventing fields or stub methods. The original SWF's document class must be handled by the caller: the bulk resource script explicitly excludes Main and DataX because they have document classes.

The first bulk pass over all 162 resource SWFs produced 123 compiled candidates and 39 failures. The next pass repaired the known causes below and reached 162 compiled candidates. Independent root auditing then revealed omitted button/root artwork, which the final pass repaired. The final `resource-family.json` confirms all 162 current receipts; `resource-family-first-pass.json` and `resource-family-root-pass-first-attempt.json` retain initial failures, including the two empty-button cases fixed afterward.

### Reversible compile-source repairs

`probe_source_repairs.py` leaves canonical AS unchanged and logs every applied transformation:

- Standalone `{};` decompiler output becomes a legal empty statement. No executable body is removed.
- AVM2 permits names such as `BigShot A` that AS source syntax cannot express. The decompiler marks them as `§BigShot A§`. Compilation uses deterministic safe identifiers; afterward only the newly compiled ABC string pool and linkage strings are rewritten to restore the original runtime names. All ABC is parsed before and after. Original bytecode is never copied.
- Duplicate XMLAsset wildcard imports are expanded to explicit class imports, excluding the duplicate helper. This is allowed only after both original helper implementations compare text-identically apart from the package line.
- The older game's legacy `JSON.decode` conflicts with modern playerglobal's global JSON. The legacy class and its consumers use a unique temporary compile name, which is restored in newly compiled ABC to `com.adobe.serialization.json.JSON`. This avoids introducing a dynamic package-property chain.

An initial attempt to qualify static calls textually (`com.…XMLAsset.createXML`) was rejected after a runtime binding problem was discovered in the main-program investigation: non-strict compilation can interpret the package path as `getlex com`. All receipts using that former repair are invalidated and rebuilt. Enemy105's replacement output was independently P-code checked: XMLAsset directly resolves the short class name with only the intended Tool candidate; JSON directly resolves JSON, and its class package is restored. JSON's namespace set remains broad as in the original, including the global package, so its modern-player online path is **not claimed runtime-verified**.

Private namespace URI/file numbering may change under compilation. The lightweight module frame verifier compares class-shape multisets after normalizing those compiler-generated private labels; it does not prove exact private-identity or method-body equivalence. The separate namespace-aware audit and actual game integration tests remain necessary.

## Root timeline and omitted button recovery

`probe_root_timeline.py` is part of every resource build. FFDec omitted Embed annotations for 28 linked SimpleButton classes across nine modules, including 20 Map0 NPC/task buttons and the Map9 captain. Their AS constructors/click handlers existed, but successful compilation alone lost the original SymbolClass binding. The staging repair adds Embed annotations referencing the existing script-free `assets.swf` ExportAssets symbols. Seven empty mask buttons were absent even from that export, so a strict recovery branch copies only their six-byte DefineButton2 definitions (no states or actions) into a new script-free asset container. Nonempty missing assets fail closed. It preserves canonical source, verifies each asset symbol's character ID, and hashes all staged assets including recovered containers.

After compilation, root restoration verifies every original linkage name and tag type, removes the generated id=0 Sprite binding (the originals have no document classes), and restores original FileAttributes, background/scene metadata and root controls. Root PlaceObject2 character IDs are explicitly remapped. Enemy16 places linked `src.HitXX`; Enemy5_v2 places an unlinked Shape2 that FFDec omitted from assets. A complete shape-record parser recovers both bitmap fill arrays, including StateNewStyles: bitmap IDs 373 and 372 are copied with new IDs and all four bitmap references (two 0xffff sentinels) are remapped. Unknown fill/line/control forms fail closed. No original ABC is copied.

Music's original stream header is retained even though there are no stream blocks; audio execution equivalence is not inferred from their absence. `root_timeline.verified:true` is a structural gate, not runtime proof. `probe_verify_root_repairs.py` separately renders all four button states (including hit-test state) and the affected root frames; its manifest records exact original/rebuilt hashes.

## Final resource acceptance snapshot

`resource-final-validation.json` records **162/162 resource modules and 18,908 canonical AS files**, all recompiled with zero original ABC copied. Every current output hash matches its receipt, every module has an exact two-compilation match, and every root structural gate passes. The root-independent architecture audit is maintained separately under `reverse/manifests/module-roots.json`.

`root-repair-validation.json` records all 28 repaired buttons × four rendered states (112 PNG comparisons), plus Enemy16/Enemy5 root frames; all 114 comparisons pass at their recorded output hashes. `equipment-root-asset-continuity.json` shows all 69 equipment dictionaries and non-root linkage IDs remain byte-identical to the preceding compiler archives, preserving the previously rendered 24,449-frame art evidence after root metadata correction.

`asset-action-audit.json` covers all 163 exported asset SWF containers: no recursive script tags, no DefineButton2 conditional actions, no PlaceObject2/3 ClipActions, and no embedded DefineBinaryData. All 761 external `.bin` assets parse as XML. The seven generated empty-button containers are separately recorded in their module receipts and independently audited. This audit concerns asset code retention; it does not prove runtime equivalence of recompiled AS.
