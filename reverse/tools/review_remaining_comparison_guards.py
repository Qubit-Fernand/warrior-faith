#!/usr/bin/env python3
"""Reproduce the evidence inventory for manually reviewed changed guards."""
from pathlib import Path
import sys,json,re,difflib,hashlib,os
os.chdir(Path(__file__).resolve().parents[2])
sys.path.insert(0,'reverse/tools')
from audit_decrement_semantics import method
R=Path('.')
notes={('com/adobe/serialization/json/JSONEncoder.pcode', 'objectToString'): 'Function filtering and XML length filtering use iffalse→body with '
                                                                       'true jump-skip versus iftrue→skip; captured-slot numbering changes '
                                                                       'remain outside this local guard claim.',
 ('com/adobe/serialization/json/JSONTokenizers.pcode', 'unescapeString'): 'indexOf result is converted to int before the reversed >=0/<0 '
                                                                          'partition. Integer domain excludes NaN; '
                                                                          'substr-with-one/two-arguments remains on the corresponding '
                                                                          'exit/continue path.',
 ('com/greensock/OverwriteManager.pcode', 'manageOverwrites'): 'Same compound boolean; original iffalse→body / true→jump skip becomes '
                                                               'iftrue→skip. No relation changed.',
 ('com/greensock/plugins/ShortRotationPlugin.pcode', 'initRotation'): 'Original ifnlt equals lessthan;iffalse. Both preserve NaN false '
                                                                      'comparison; both successors retain +/-360 adjustment.',
 ('com/hotpoint/braveManIII/models/achievement/Achievement.pcode', 'getNumByType'): 'Four isMany/getIsPile not;iffalse become iftrue. '
                                                                                    'Constant pushfalse/iffalse and pushtrue/iftrue branch '
                                                                                    'scaffolding is removed; quest loop still uses '
                                                                                    'index<length body and index>=length exit.',
 ('com/hotpoint/braveManIII/models/achievement/Achievement.pcode', 'goodsOk'): 'isRy() not;iffalse becomes iftrue; mdFunction call remains '
                                                                               'on !isRy path.',
 ('com/hotpoint/braveManIII/models/task/Task.pcode', 'isEnemyOk'): 'Changed final branch targets the immediately following instruction in '
                                                                   'both versions. Both paths return the same Boolean local; it has no '
                                                                   'effect.',
 ('com/hotpoint/braveManIII/models/task/Task.pcode', 'isGoodsOk'): 'Changed final branch targets the immediately following instruction in '
                                                                   'both versions. Both paths return the same Boolean local; it has no '
                                                                   'effect.',
 ('com/hotpoint/braveManIII/repository/equip/EquipBaseData.pcode', 'createEquip'): 'Integer random attribute indexes: ifne→body / equal '
                                                                                   'jump-skip becomes ifeq→skip. The remaining numeric '
                                                                                   'relations are unchanged.',
 ('com/hotpoint/braveManIII/repository/equip/EquipBaseData.pcode', 'createShopEquip'): 'Same integer random attribute-index guard as '
                                                                                       'createEquip; ifne plus jump-skip becomes ifeq '
                                                                                       'skip.',
 ('com/hotpoint/braveManIII/views/achPanel/AchData.pcode', 'duAc'): 'Two null guards invert ifne plus unconditional skip into ifeq skip; '
                                                                    'null/non-null paths correspond.',
 ('com/hotpoint/braveManIII/views/achPanel/AchData.pcode', 'upPoint'): 'equals;iffalse becomes ifne for title ID25. Both jump on not-equal '
                                                                       'including unordered values.',
 ('com/hotpoint/braveManIII/views/itemsPanel/MenuTooltip.pcode', 'lijifuhua'): 'moneyOK not;iffalse becomes iftrue; !moneyOK still '
                                                                               'returns.',
 ('com/hotpoint/braveManIII/views/itemsTooltip/ItemsTooltip.pcode', 'slotSuitTooltip'): 'Equip null test: ifne→body with equal jump-skip '
                                                                                        'becomes ifeq→skip.',
 ('com/hotpoint/braveManIII/views/makePanel/MakeData.pcode', 'getArr4'): 'Changed >=4/<4 guard reads Array.length (uint); same splice(0,4) '
                                                                         'versus splice(0) exit routes, no NaN operand.',
 ('com/hotpoint/braveManIII/views/petPanel/PetPanel.pcode', 'timeFunction'): 'Main.P1P2 not;iffalse becomes iftrue; !P1P2 still returns '
                                                                             'before2P work.',
 ('com/hotpoint/braveManIII/views/wantedPanel/WantedPanel.pcode', 'open'): 'Main.wts not;iffalse becomes iftrue; construction remains on '
                                                                           'the missing-state branch.',
 ('src/Enemy.pcode', 'HpXX'): '57362 exclusion and id5003 number-display exclusions invert ifne+jump into ifeq skip. ID31 preserves y-200 '
                              'special placement; non31/non5003 retains ordinary number display, separately for critical and normal '
                              'damage.',
 ('src/Enemy.pcode', 'MoveRun'): 'One collision Boolean swaps physical branch order without swapping increment/jumpType effects; '
                                 'greaterthan;iffalse becomes ifngt, which is identical even for NaN.',
 ('src/GameData.pcode', 'AddKillPoint_fun'): 'Kill-point compound bool condition: false→skip versus true→body with explicit jump-skip; '
                                             'underlying greaterthan operands retained.',
 ('src/LocalSaveManager.pcode', 'pad2'): 'ifnlt becomes lessthan;iffalse: exactly the same <10 branch, including hypothetical NaN. pad2 '
                                         'parameter is also int.',
 ('src/Main.pcode', 'AddPlayer'): 'Two missing player_1/player_2 not;iffalse branches become iftrue; only absent player instances are '
                                  'constructed.',
 ('src/Main.pcode', 'applySaveObject'): 'Missing guanKa element not;iffalse becomes iftrue; same missing-element initialization. This does '
                                        'not establish saved-object schema validity.',
 ('src/Player.pcode', 'HpXX'): 'Damage display flag not;iffalse becomes iftrue; same nonflag path opens damage-number visual.',
 ('src/Player.pcode', 'KeyControl'): 'skin/Get_StopRun/noMove Boolean negations removed with complementary branches. Movement commands '
                                     'remain gated by the same conditions; this review does not prove the entire long method.',
 ('src/Player.pcode', 'MoveRun'): 'Four Boolean negations removed with complementary branches. Collision adjustment and jumpType paths '
                                  'correspond; Number decrement audit is documented separately.',
 ('src/Player.pcode', 'UserObj'): 'CanUserObj not;iffalse becomes iftrue; false still returns before item action.',
 ('src/Player2.pcode', 'HpXX'): 'Damage local is int. lessthan;iffalse becomes ifnlt; both clamp a negative result to0 and preserve '
                                'nonnegative result.',
 ('src/Player2.pcode', 'MoveRun'): 'Collision Boolean branches reorder; corresponding increment versus jumpType=2 successors preserved. No '
                                   'new relational test.',
 ('src/ShopKillPoint.pcode', 'AddBuyNum'): 'Quantity availability not;iffalse becomes iftrue; false still returns before mutation.',
 ('src/SixOne_Interface.pcode', 'okgo'): 'Three 2P other-bag capacity tests invert >=1/<1 guard. backOtherBagNum returns uint; the '
                                         'error-return and reward-add blocks correspond. Compound capacity Boolean true/false blocks '
                                         'reorder without changing the tested >= operands.',
 ('src/Vip_Interface.pcode', 'ChuanSong'): 'Compound item-presence condition not;iffalse becomes iftrue. Error message remains on '
                                           'missing-item path.',
 ('src/Vip_Interface.pcode', 'ChuanSong2'): 'Compound item-presence condition not;iffalse becomes iftrue. Error message remains on '
                                            'missing-item path.',
 ('src/_data/XingLingFactory.pcode', 'GetTolal_Data'): 'The >0 versus !(<=0) operand is explicitly convert_u before both branches. uint '
                                                       'excludes NaN; the same total-attribute body is entered for positive values.',
 ('src/npc/All_Npc.pcode', 'NpcGetPlayerObj'): 'Quest/state exclusion compound bool: iffalse→body with true jump-skip becomes iftrue→skip. '
                                               'Numeric prerequisite comparisons remain separate.'}
assert len(notes)==35
out=[]
for (cls,name),note in notes.items():
 x={'class':cls,'method':name};versions={}
 for v,base in [('original','reverse/build/ordered-comparison/original/scripts'),('rebuilt928e','reverse/build/main-repeat-pcode/run-b062kbrm/scripts')]:
  p=Path(base)/x['class'];body=method(p,x['method']);branches=[j for j,z in enumerate(body)if z['code'].startswith('if')]
  versions[v]={'file':str(p),'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'branch_contexts':[[z for z in body[max(0,j-5):j+4]]for j in branches]}
 out.append({'class':x['class'],'method':x['method'],'status':'reviewed_no_repair_warranted_for_changed_guards','reason':note,'whole_method_equivalence_proven':False,'versions':versions})
report={'schema':1,'scope':'Manual local predicate/successor review of remaining35 branch-sequence candidates. Neither opcode-sequence matching nor this review certifies whole-method binding/operand/effect equivalence. Six other candidates are confirmed bounded-loop loss;15 are confirmed NaN guard loss.','items':out,'counts':{'nan_guard_repairs':15,'nonstack_loop_repairs':6,'other_guard_reviews':35,'total':56},'no_player_or_save_access':True}
Path('reverse/manifests/ordered-comparison-remaining-review.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print(report['counts'])
