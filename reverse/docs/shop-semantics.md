# Shop, pet and save checks for the 928e build

`reverse/tools/audit_shop_cfg.py` compares16 named methods from seven original/Main928e P-code pairs.15 have equal basic-block branch topology and equal ordered non-conversion call names/arity per block. `PlayerData.addGold` differs; its proven NaN issue and expanded15-site audit are in `ordered-comparison-semantics.md`. This narrow CFG/call check does not prove property binding, every operand, aliasing, or all method behavior. The later24-method application includes the proven Main guards, loops and quantity local; no player was executed by this audit. See `main-semantic-repairs.json` for application provenance.

The checked methods cover SuppliesShopPanel quantity/purchase/sale, EquipShopPanel purchase, PlayerData payGold/addGold, PetPanel feeding/summoning/recall, Pet food clamp, TaskData prerequisites and Main JiaoYan/JiaoYan2. See `reverse/manifests/shop-cfg.json` for source/P-code hashes and exact scopes. Existing save validation boundaries remain in `save-network-boundary.md`; no check has been silently tightened.

## Concrete UI checks

1. In the original village `Map_0_0`, approach the potion NPC about510 map-local pixels left of the village chief. Original Map0 assets place 药品 at(921.05,401.85), 村长 at(1431.5,362.85), 装备 at(1921.9,228.35), all under `Map_0_0.moveChild`. These are display-registration positions, not screen click coordinates. Open the potion shop through the NPC's buy button. The first normal potion21110 has base price4 and shop price8. With two free consumable slots and≥16 gold, buying quantity2 must occupy two slots and subtract16 gold. Selling one color1 potion removes one slot and returns4 gold. Net after buying2/selling1: one potion and12 fewer gold. Sources: SuppliesXML21110; SuppliesShopPanel.buySuppliesByPlayerData/sellSupplies; Bag.addSuppliesBag/delSuppliesBag; ShopItemsShow displays2×price. Inventory is slot-based here, not potion stacking.
2. Quantity controls wrap down1→24 and up24→1. Potion buying checks affordability for the **requested** quantity before clamping to free slots. Gold16/request3/free2 shows金币不足 although two would fit; gold24/request3/free2 buys2 for16. Equipment buying requires the whole requested quantity to fit and uses9×base price. These are original source/P-code behaviors, not changes to make the UI more convenient. The host model in shop-cfg.json covers these examples.
3. For an already owned pet, pet panel出战 requires food>0;召回 closes the active pet without an item/gold charge. One63148宠物口粮 adds20 food capped at500 and consumes one item when food<500; at500 it consumes none. Source: Play_Interface.CW面板; PetPanel.chuzhan/zhaohui/setFood; Pet.setFood; OtherXML63148. Food decreases1 every1134 active ENTER_FRAME ticks (nominal42s at27fps), so make before/after comparisons promptly. Evolution and paid operations are not needed for this smoke test.

## Returning to the intact village

A graduation fixture was observed in `Map_0_3`, with the crying 妮蒂亚 panel exposing gifts/rewards. Do not identify a map from a similar village background or NPC names alone; the normal and alternate villages share these visual features. Selecting 新手村 in SelMap initially requests `(gameNum,gameNum2)=(0,0)`, but `Main.GameStart:769–781` redirects to0,4 if water!=1 and otherwise to0,3 if Map0_YN=true. Normal world-map selection does not reset this flag. `XX_MC.Close` and船长界面.GoGo set it true; no ordinary false-reset route was found. 船长 also charges10000 and is not a return-to-intact-village route.

For a clean test without editing the graduation fixture, completely close/relaunch the isolated test player and create a new character in an unused isolated slot. Fresh Main defaults Map0_YN=false and water1. Starting another character within the same process is not proof the static flag was reset. Root subsequently performed this cold-start/new-slot2 flow on the original control: the smiling 妮蒂亚 had a visible buy button, which opened the potion shop. Initial state was level1,4399 gold and8 red/8 blue potions. This confirms the normal shop entry in that original run; it does not mark rebuilt shop behavior passed.

Both `src.npc.药水商人界面` and `药水商人界面2` bind `buy_btn` directly to `BUY`, which calls `SuppliesShopPanel.open()` without a friendship/task condition. The original authored assets explain why the alternate panel appears to lack buying: symbol1772 (panel2) places `buy_btn` at(339,1010.35), below the560-pixel stage; symbol1776 (normal) places it at(43,529.35). The panels open at(0,0) by default. Gifts (`temp_btn`) and rewards (`temp2_btn`) are separate handlers and are not hidden shop-entry routes. `audit_potion_npc_buttons.py` / `manifests/potion-npc-buttons.json` retain original tag payloads and positions. These are stage-local registration coordinates, not host-window click coordinates.

## Numeric lowering boundaries

Original purchase loops use int32 decrement; rebuilt FFDec `*` locals use Number decrement. Once the capacity precheck/clamp has completed, positive iterations are≤24, so all25 initial states0..24 have identical loop traces in the host model. This is a bounded local argument, not a generic assertion that decrement and decrement_i are equivalent.

The down-quantity button has a separate **confirmed local integer-boundary difference**: int.MIN_VALUE decremented as int32 wraps to2147483647; rebuilt Number decrement gives−2147483649. Normal button values1..24 cannot reach it, but the original authored amount field is editable: binary traversal supplies `SuppliesShopShow`1813 → named`buyMenu`922 → named`amount`912, a DefineEditText with ReadOnly=false and no MaxLength. No `restrict`, `maxChars` or field-type reassignment was found in the Main source scan. Typing `-2147483648` and clicking down was subsequently exercised on the original isolated game with DiagnosticHarness v5; its full observed result is recorded below. The latest keep-trace rebuilt package still requires the matching UI comparison.

`audit_shop_amount_field.py` and `manifests/shop-amount-field.json` retain the exact original SWF/tag hashes, flags and placement path. Full original/rebuilt setDown P-code is retained in `experiments/ordered-comparison/shop-setDown-pcode.json`. The independent `shop-setDown-candidate.patch`, now applied to Main, changes only the local declaration in that method from `*` to `int`; do not globally rewrite every dynamic local. Root should test the freshly compiled opcode and the explicit entry boundary, as well as the ordinary1→24 wrap.


## Original quantity boundary: v5 actual UI pass

The operator cold-read original isolated slot2, opened the potion shop, typed `-2147483648`, and clicked down once. The saved v5 reports were independently read without opening the player or any SOL:

| Report under diagnostic-harness/results | Last sequence | Complete targetAmount text | Length |
|---|---:|---|---:|
| original-shop-v5-before-down.json | 232 | -2147483648 | 11 |
| original-shop-v5-after-down.json | 251 | 2147483647 | 10 |

Both reports have errors=[], observerErrors=[], and the selected samples have partial=false/groupErrors=[]. The exact observed display path is Stage → SuppliesShopPanel → SuppliesShopShow → buyMenu → amount (input TextField), all ancestor visible=true and alpha=1. The target text and ancestor path are untruncated. This is actual original UI evidence for INT_MIN being accepted and the down action wrapping to INT_MAX; it is stronger than the earlier host-only prediction.

Full-shop scanning still reports scanTruncated=true and fieldsTruncated=true. That does not truncate the prioritized target field, but prevents claiming all shop text was observed. v4's earlier panels=0 was a 60-second-stale successful snapshot followed by observer #1009 failures; retain it as a failed observation, not contrary original-game behavior. v5 observes Stage.name=null, which v4 failed to guard before substr.

`reverse/manifests/original-shop-quantity-v5-runtime.json` contains exact report hashes, original-control Main SHA `77ba138c038cb454d2324149d9afe1b99fcbdaeb69ce96ffe03eb107b27273f9`, wrapper SHA `7751f9b333c3ecb064d67287d22724622e3db39f6d9e8d4215452d98860f9c32`, complete target fields, and scope flags. Before-report SHA is `ad98f4648b9faa7833bd13ac32ec1f8fe405a2c99f0d265b9e720acdf426961a`; after-report SHA is `0faae6a142a3abedf79423a3a95249a4b2ec1d722ee820f8be29669565ce24be`.

The operator separately confirmed the original cold-read state of4387 gold, red9/blue8. The v5 snapshot confirms17 occupied consumable slots but only displays six item summaries; do not infer the full red/blue counts from that abbreviated inventory alone. No new purchase/sale is inferred from the numeric boundary snapshots.

**Pending:** run the same editable-field boundary on the newly rebuilt complete keep-trace package and compare using the same v5 wrapper, then direct-launch acceptance as appropriate. Original pass does not mark the repaired rebuilt setDown implementation or all shop behaviors passed.
