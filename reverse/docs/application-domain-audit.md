# 资源根时间轴、类绑定与 ApplicationDomain 审计

`audit_module_roots.py` 对原版 162 个无 document class 的资源 SWF 和每个当前有效重建 receipt 做只读比较；主程序与 DataX 不在该集合。`module-roots.json` 记录每个输入/输出 SHA-256、root tag、FileAttributes、SymbolClass、绑定对象类型和缺失详情。构建仍在持续修复时，以 manifest 的生成时间与各模块哈希为准；不能把本文中的修复前发现当作最终产物状态。

## 首次全量检查的实际差异

162 个原资源的根帧数都为 1、document class 都为空。**根时间轴并非全部为空**：

| 原模块 | 根帧 0 的执行/显示标签 | 原资源依赖 | 初版重建 |
|---|---|---|---|
| Enemy16 | PlaceObject2，depth=1 | cid23，绑定 `src.HitXX`，一个 DefineSprite | 丢失该放置；重建时该类绑定曾为 cid30，必须按最终 SymbolClass 重算 |
| Enemy5_v2 | PlaceObject2，depth=2 | cid374，DefineShape2，另引用 bitmap cid372/373 | 放置、shape、bitmap 均未进入导出 assets 或初版重建 |
| Music_v3 | SoundStreamHead2，payload `2e000000` | 没有 SoundStreamBlock；样本数为 0 | 丢失该配置标签；没有证据表明因此丢失了流式音频数据 |

Enemy5_v2 的 shape 初始填充数组有两个 type0x43 bitmap fill，BitmapId 分别为 0xffff 和 373；但这不是全部：完整位解析发现 payload offset53 还有 StateNewStyles，增加 offset55=0xffff、offset65=372 两个引用。初始引用位置分别为 offset13/23。解析消费全部94字节、8条edge，无其他引用。372/373 都是19字节的 DefineBitsLossless2。恢复时须完整解析新增样式、一并携带依赖并重映射字符 ID，不能只改第一个填充数组，或把 shape 和 PlaceObject 原字节直接粘到新字典里。0xffff 是特殊值，不作为真实字符编号重映射。构建代理也用 FFDec XML 独立确认该 StateNewStyles；其解析/恢复实现在 `probe_root_timeline.py`。

除此之外，原 162 个 root 中没有 PlaceObject/RemoveObject/StartSound/DoAction/DoInitAction/视频帧等本审计列出的执行标签。全量原 DoABC 是业务代码，不因根时间轴空白而视为没有代码。

初版 162 份重建均添加一个哈希命名的 Sprite document class，root 一帧、SWF 版本/尺寸/帧率与原版相同。全部生成 root 类的 constructor 字节码为 `d0 30 d0 49 00 47`（this/pushscope/this/constructsuper 0/returnvoid），static initializer 为 `d0 30 47`，无字段或额外实例方法。新增类本身未发现加载业务逻辑或创建额外图形的指令，但 MovieClip 根对象换成 Sprite 是可观察的类型/时间轴 API 差异。

FileAttributes 差异仅 96 个资源从 24 变成 8，即去除 HasMetadata；ActionScript3 始终为 true，UseNetwork/UseGPU/UseDirectBlit 始终为 false。初版所有背景变为白色，154 个与原背景不同。所有原 root 的 SceneAndFrameLabelData 都只是 `场景 1`、起点0、0帧标签，初版删除它。新增 ScriptLimits、ProductInfo、ExportAssets、DoABC 拆块/排序等均记录于 JSON；这些变化不能只凭一帧宣称字节或语义相同。

## SymbolClass：发现的真实功能阻塞

首次全 162 current 产物比较，非 root SymbolClass 名字缺失 28 个，分布 9 模块；已向构建代理提出修复。已有的同名绑定类型没有变化，也没有额外非 root linkage。

- **Map0_v26：20 个非空 DefineButton2。** 仓库、伽妮雅、制作机/2、塔丽莎、悬赏/2、技能/2、探险家/2、星冰、村长/2、船长、药品/2、装备/2、转职任务图标。原按钮长度 23–89 字节；例如村长 cid493 的资产在 FFDec `_assets/assets.swf` 内仍在，ExportAssets `symbol493`→493。其源码 `src/npc/村长.as` 却没有 Embed，constructor 注册 CLICK→Open→村长任务界面。这是“类声明存在但时间轴按钮不再使用该类”的具体失效路径，不能以类数量一致作为通过依据。
- **Map9_v2：src.npc.船长2。** 原 DefineButton2 51 字节，同类风险。
- **七个空遮罩。** Map14、Map17、PlayerMc_X0/X1/X2、ShiZhuang_X1/X2 的 `遮罩` 原 DefineButton2 都只有 6 字节，源码为空 SimpleButton。应保持绑定完整性，但其影响不能和上述非空、有交互的 NPC 按钮混为一谈。

`src.npc.村长` 和 `src.npc.装备` 等不在主程序的 712 类定义中，父域不会自动补出这些按钮绑定。复验标准是原 linkage 名全集恢复、绑定对象类型保持、按钮图形/状态与 constructor 事件处理运行正确；只恢复名字但指向错误 character ID 仍不合格。

## 游戏实际使用的加载域策略

源依据均为 `reverse/source/3_L4399Main_gamefile/`：

- `src/ClassLoader.as:19–44`：第二参数 LoaderContext 默认 null，直接传给 `Loader.load`。
- `ClassLoader.as:101–108`：从该 loader 的 `contentLoaderInfo.applicationDomain` 调用 getDefinition/hasDefinition。
- Load/NewLoad 和各 UI 调用 new ClassLoader 时只传资源 URL，没有提供新的 ApplicationDomain/LoaderContext。
- 主源码未发现把这些 loader 或 loader.content 加到舞台的路径；实际地图/怪物/皮肤都是 getClass 后另行 new，再 addChild（Main.as:843–849；Enemy.as:182–186；Player.as:2501–2509）。

同源正常加载下，null context 的默认选择是主程序域的独立子域；子域直接代码引用会复用父域已有类，同级子域不因按先后加载就合并成一个域。不要把此结构“简化”为所有资源都装进 currentDomain；那会改变同名定义的解析。该行为依据 [LoaderContext 官方参考](https://airsdk.dev/reference/actionscript/3.0/flash/system/LoaderContext.html) 与 [ApplicationDomain 官方参考](https://airsdk.dev/reference/actionscript/3.0/flash/system/ApplicationDomain.html)。自定义播放器是否完全实现相同规则仍须运行验证。

实际重复定义量也支持需要保留这个结构：`src.Main` 和 `src.HitXX` 各在 83 个资源中出现，`src.Skin_ZhuangBei` 在 157 个资源中出现且主程序已有该基类。另一个明确测试点是 `Skin` 同时存在于 VIP_v2、XLUP_v4、YZJH，主程序没有该裸名类，三个界面各自通过保存的 ClassLoader.getClass("Skin") 取自己的版本。完整名字→模块列表在 manifest 中；private helper 已从该重复名清单中排除，不能据此删除原 private 类。

这也界定 Enemy16 根放置的影响：原 HitXX constructor（原 Enemy16/src/HitXX.as:53–58，主程序版:45–50）读 Main._this 并注册 ADDED_TO_STAGE/REMOVED_FROM_STAGE；AllHitXX.push 在 ADDED_TO_STAGE 处理内。正常库 loader 没有进入舞台，故未找到该 root 放置参与正常战斗的源码路径，但构造/初始化时点仍有差异，不能直接判为无副作用。单独将整个 Enemy16 loader 加到舞台又不是原游戏加载方式，不能用这种测试代替游戏路径。

## 建议加载与实例化验证矩阵

以下是交给根运行流程的方案，本审计没有启动播放器或触碰存档：

1. **同源、隔离存档、全冷启动。** 固定 main/DataX/resources 的 SHA 清单，用原逻辑加载。记录 LoaderInfo COMPLETE 与 IO_ERROR；ClassLoader.as:74–78 会把 IO_ERROR 转成自己的 COMPLETE，故不能只听外层 COMPLETE。
2. **保留启动顺序。** `Load.as:108–205`：Map0 → 跳过 gameNum=0 的敌人加载（Load.as:304–309）→ DataX → PlayerMc X0/X1/X2 → WuQi X0/X1/X2 → EnemySkill → 内置 Data2 → Music → ChongWu → NewLoad 装备队列。不要为了快速验收改成全部资源并行装同一域。
3. **记录域与类型身份。** 每个 loader 验证 applicationDomain.parentDomain，记录 getDefinition("src.Main") 与主程序 Class 是否相同；同样对 HitXX、Skin_ZhuangBei 做身份与实例 `is` 检查。既测直接类型引用也测实际 getClass 路径，不靠可打印的类名判断两者是同一个 Class。
4. **兄弟域冲突测试。** 在独立诊断进程中先后加载 VIP/XLUP/YZJH，再反转次序；分别 getClass("Skin")，Class 对象应各自对应其原模块，不能都变成先加载的那个。无需打开涉及兑换/充值的业务操作；只测定义与对象绑定。
5. **原版 root 差异复验。** 以完全相同父域、同样不 addChild(loader) 的方式加载原/重建 Enemy16、Enemy5、Music；记录 content 类型/numChildren、HitXX.AllHitXX 前后长度及错误事件。诊断“原资源能看见根图形”与正常游戏是否用到根图形分开记录。
6. **村庄按钮必须真正点击。** 新建/读隔离档后点村长、装备、药品、技能、仓库和船长；验证实际显示实例属于正确 src.npc 类、constructor 事件已注册、对应面板打开，再关闭。Map9 船长2单独覆盖。静态绑定修复不替代这步。
7. **战斗和装备实例化。** 地图1/房间1→房间5，检查地图对象、Boss与小怪皮肤、HitXX 的继承身份；切换 X0/X1/X2 装备，验证 getClass 后对象为主程序 Skin_ZhuangBei 可接受的类型。进入特殊地图17/81时保留其额外敌人包加载列表。

不要在探针中强行 new 资源里的 src.Main 或批量 new 所有类：这会引入原库加载时没有的构造、保存、网络和 UI 副作用，且会把诊断对象变成另一种程序。

## 已修复样本的独立复审

审计工具新增 `root_restoration_audit`，不把构建报告里的 verified 字段直接当作通过：它重新核对控制标签，按原 linkage→新 linkage 重映射 PlaceObject ID 后比较 payload；对 Enemy5 的94字节特定 Shape2，用原 SHA 锁定独立完成的位解析结果，检查四个 bitmap 引用位置、完整重映射 shape 字节和两份 bitmap 去ID后字节。所有原 root 元数据 payload 也分别对照。

已确认以下修复样本无缺失 linkage、root 控制及已审查依赖一致、元数据一致：

- Map0_v26：`e25037165ce0375ba0eb2f07b5735cde23735e417a4b8c1108dc962f945ab68c`，20按钮 Embed 修复后全部67个原 linkage 恢复。
- Enemy5_v2：`33569db560ce1c736752355ef5edac545a1e25a706d0136007e20013875f40b3`，372/373 两个 bitmap 与 StateNewStyles 引用均恢复。
- Enemy16：`60811ea2d89e379fa80a25c21e5156b4a455c8c51af3f53a0cda177ae337a2de`，root HitXX 放置正确映射。

修复路线移除 compc 生成的 id0 SymbolClass 绑定，恢复原本无文档类的资源根；空的生成类 ABC 保留，但不再由根绑定创建实例。它本身只调用 super()、无业务字段/代码，未发现必须为此执行原 Main 的理由。仍需由播放器验证默认 MovieClip root、加载事件及按钮实例行为。

JSON 里的 `root_behavior_changed_modules` 是原始 payload 哈希比较，合法字符 ID 重编号也会计入；修复验收应看 `root_restoration_audit` 的重映射后结果，并结合未缺失 linkage 与类型检查，不能要求重编号后的二进制仍逐字相等。

七个缺失的空遮罩资源使用生成的 `_assets/recovered-buttons.swf` 补回。已独立读取每个新容器，确认递归没有脚本标签，且其中6字节 DefineButton2 payload 与对应原 SWF 的原定义逐字同哈希；无按钮状态或动作。该检查并入 `audit_module_roots.py`，最终 manifest 同时保存新容器 SHA，而非把“生成资源”当作未经检查的例外。

## 最终全包静态复审

生成时间：`2026-10-23T17:13:09.575073+00:00`。162/162 当前产物均通过独立 root 控制/已审查依赖核对，162/162 原 root 元数据 payload 一致；无缺失/额外 SymbolClass，无绑定对象类型变化，无版本/尺寸/帧率/根帧数差异，也不再有新增 id0 document class。7个恢复空按钮资产全部通过原定义哈希与无脚本检查。原始 root payload 哈希仍有两处不同（Enemy5/Enemy16），已确定仅是合法 character ID 重编号，重映射后的完整核对通过。此前21个非空交互按钮和7个空按钮绑定均已补回。

这些结果解除已识别的静态绑定/根资源阻塞；运行点击、真实父域身份和全部行为等价仍分别验收。
