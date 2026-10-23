# 原版／重建版共用诊断加载器

此工具是独立观测 wrapper，不是游戏源码重建的一部分，也不能替代直接打开游戏的验收。当前版本为 **v5**，已由主任务在原版隔离包实际运行，完整读取药水商店数量 `-2147483648 → 2147483647`；前后快照均无游戏/观察器错误，partial=false。该原版边界通过不代表最新 keep-trace 重建全包已完成对照，后者仍待构建后运行。v2原始观测、v4失败和各版本源码/SWF归档均保留，下文版本章节是历史变更记录。

当前SWF SHA-256为 `7751f9b333c3ecb064d67287d22724622e3db39f6d9e8d4215452d98860f9c32`。编译收据build.json保持创建时runtime_tested=false，不回填历史；实际运行证据单独保存为 `reverse/manifests/original-shop-quantity-v5-runtime.json` 和results中的前后JSON。

## 复现

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/diagnostic_harness.py build
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/diagnostic_harness.py install reverse/build/runtime-original-control
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/diagnostic_harness.py install reverse/build/runtime-rebuilt
# 也支持统一入口刚生成的严格完整包（实际替换时间戳）
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/diagnostic_harness.py install reverse/build/runtime-all-rebuilt-<timestamp> --label full-rebuilt
```

安装接受两个既有隔离目录，或统一入口生成的 `runtime-all-rebuilt-*` 严格包。严格包须 assembly.json state=complete、164 个 source_rebuilt、零回退、partial_allowed=false；逐一复核 164 SWF 哈希及清单引用的构建 receipt 哈希。来源优先使用包内不可变receipt快照；若旧包只有外部可变receipt且已被替换，应重新assemble，不能忽略来源校验。partial 包被拒绝。

所有模式都解析目标主 SWF 的 ABC 字符串池，拒绝 `yzlr2_saves`，并要求预期的测试存档名。原版为 `yzlr2_original_probe`，重建版为 `yzlr2_rebuild_*`；严格包只接受后者。安装只增加／更新诊断文件，不修改游戏 SWF。更新已有 wrapper 前核验旧安装记录，并把旧 SWF 与记录归档到该包 `diagnostic-history/`；未知修改的 wrapper 不覆盖。安装后切勿把 wrapper 单独移入私人游戏目录；此防护在安装脚本中，运行中的 wrapper 不对目标 SWF 重新验签。

由主任务需要诊断时打开该目录的 `DiagnosticHarness.swf`，相对加载同目录 `3_L4399Main_gamefile.swf`。左上角显示 `DIAGNOSTIC`、序号、标签与保存状态。自动每秒采样，F8 额外手动采样；不取消或拦截游戏按键。不要同时开原版与重建版 wrapper，以免两者竞争写同一个诊断对象。

在 wrapper 已运行时，从终端请求带标签的快照：

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/diagnostic_harness.py label reverse/build/runtime-rebuilt 'quest-110002-before-save'
```

此命令只原子更新 `diagnostic-request.json`。wrapper 每秒用 URLLoader 读取该诊断文件，看到新的请求 ID 后设置后续样本标签并额外生成 `reason=label-request` 的一次样本。标签最多 64 字符；不把按键发给游戏，也不改 stage.focus。CLI 返回的是 requested，只有 SOL 中出现对应 label/reason 才确认执行；当前v5原版实际记录已带shop-intmin-v5标签；仍必须逐次核对请求对应的实际样本，不能仅凭CLI返回确认。`install --label ...` 只设初始标签，不请求额外快照。

**默认关闭未用类的精确引用解析。** 默认只记录已存在对象的 domain/Class 身份和 hasDefinition；资源与主程序的精确类引用比较为 null。确需诊断绑定时显式加 `install --resolve-class-identities`，或运行中 `label <目录> <标签> --resolve-class-identities`；关闭用 `--no-resolve-class-identities`。普通 label 不改变已有开关。报告头、每个样本和资源摘要均记录 resolveClassIdentities。开启后 getDefinition 可能触发未用类静态初始化，例如 HitXX 的 VT 随机掩码，影响初始化时序／随机序列；不是零扰动观测。关闭不能撤销已经发生的初始化，要恢复默认环境需重新启动。

## 观测范围与边界

- 新建 `ApplicationDomain(ApplicationDomain.currentDomain)`，游戏位于单独子 domain，wrapper 只有 `Source` 一个类，不链接游戏类。
- 主程序加载完成后读取已初始化的 `src.Main`。地图／房间来自 `Main.gameNum/gameNum2`；不额外初始化 GameData。
- v3 玩家记录 HP、MP、基础最大值 `hpBaseMax/mpBaseMax`、实际生效最大值 `hpEffectiveMax/mpEffectiveMax`、x/y、朝向、noMove；动画记录 `skin.runType/frame/stopRun/runOver/continuous` 及 MovieClip 当前帧／标签。
- 地图记录 x/y、宽度、runX/runY、nextNode、stopYn、MapData 实际类名。敌人只遍历 `world.moveChild_Enemy` 前 12 个直接子对象，并只采集类型确为 `src::Enemy` 的公开字段（id、life/lifeMAX、x/y、over、动画）。`enemyChildrenTruncated` 标示截断，不承诺敌人全集。
- VT 仅使用源码已核验的纯读取 `value` getter，再计算 `num-random`。任务对象例外使用下节列明的五个已审计只读方法（内部调用纯 getValue）；不调用任何 setter、战斗、保存或工厂操作，不调用任意对象 toString。不会记录原始掩码或对象引用。
- `identity` 是本次启动内部的弱引用对象编号，可用于比较同一敌人相邻快照的 HP。跨启动编号不可对应；1 Hz 采样可能错过瞬时命中，HP 下降也不能单独证明是哪次攻击造成。
- `availableDefinitions` 仅对固定八个已知名字调用 hasDefinition，记录当前 domain 可见性；不是完整的加载类枚举。地图／皮肤类名来自已存在实例，不实例化类。
- 附带 wrapper 实际帧计数与采样间平均 FPS。F8 与计时采样相邻时区间很短，FPS 不可作为精确性能基准。
- 错误事件只保留最近 8 条、每条最多 220 字符，不取消默认异常行为；不打开全局 mm.cfg。

## v2：任务、装备与资源身份

只有 `Main.loadSaveOver=true` 且已有 world 时才启用以下细节，来源是当前隔离测试游戏已加载的内存；不会打开任何游戏 SOL 文件。

- `TaskData.taskArr` 最多扫描前 512 个 Task，仅输出 ID 110001、110002。白名单 `getId/getState/getOldTime/getGoodsedNum/getEenemyedNum` 的当前源码均只有 VT 读取或直接返回数组；计数最多 6 项。**不调用 saveTask、isTaskOk、更新任务或查询工厂的方法。** 未找到标为缺项，不伪造 0。110001/110002 领奖后可回 state=0 并增加 oldTime；不能把 state=3 当唯一完成标准。详细规则见 behavior-expectations.md。
- 当前 player1 的 `bag/equipSlot` 使用纯公开 getter。最多读取 13 装备槽；五种背包每种最多扫描 24 槽、显示前 6 件，记录 slot、物品 ID、数量及截断标记。装备 ID 读 Equip.base，其他读 id/fallId；不读账号、名字、仓库或完整属性。P1P2=true 时附 player2 摘要。
- 从公开 Map.MapArr 观察当前地图、Map0、Map9；从 Enemy.EnemyArr、Player.PlayerMcArr 各取最多 3 个已有完整 loader，并从 NewLoad.zhuangBeiSkin 的稀疏三行最多取 6 个已有装备 loader。Map、Player 已有实例，Enemy 在 GameData.GetData 中已使用，NewLoad 在角色装备加载过程中已使用；读取这些已初始化容器不会触发新的资源加载。仅在显式开启类解析时还检查 Skin_ZhuangBei.PlayerMcArr／Skin_WuQi.PlayerMcArr 遗留容器。
- v3 每个资源默认记录缓存 ApplicationDomain/parent API 句柄编号和 src.Main/src.HitXX/src.Skin_ZhuangBei 的 hasDefinition。句柄编号不是底层 VM domain 身份证明。只有开启 resolveClassIdentities 才调用额外 getDefinition 比较 Class 引用是否严格等于 main domain 对应引用；默认或缺失为 null。不 new 类，不调用 load/getClass，不把资源 root 加到舞台。
- 从 loader.content 只读取现有 root 类型和直接子对象数量，用于 Enemy16/Enemy5 根恢复对照。HitXX.AllHitXX.length 默认仅在实际观察到舞台 HitXX 实例、取得其现有 Class 后读取；此前为 null。开启精确解析时可以额外解析 HitXX 类读取，不向其注册对象。
- v3 优先 Main.world、公开 MapData/MapData1/MapData2/moveChild 与 world 直接子对象，再遍历 stage；最多访问 800 个不同现有对象、每容器前 100 子对象，记录最多 12 个村长／装备／船长2 NPC。默认记录实例 constructor 身份和声明该名字的候选资源 domain；仅在显式开启时比较对应 Class 引用，生成 matchedResourceDomains。扫描截断明确标记。
- VIP／星灵／养成界面的 loadData 是 private，不绕过。仅对舞台上已存在的裸名 Skin 实例记录 Class 身份和 loaderInfo domain/url（最多 6 个），不会主动打开界面。loaderInfo 的 domain 是观测值，不单独当作定义归属的证明；没有实例就是未观察到。

v2 比 v1 每个样本更大，60 KB 上限可能把历史缩短到少于 24 次。重要检查点应请求标签后及时导出诊断 SOL。若今后修改上述 getter／只读方法，应重新审计观测逻辑。

TaskData 的访问边界由 Main.GameStart 源码顺序保证：`TaskData.initAllTask()` 在 `AddMap()` 之前；观测必须已有 world，因而没有为了采样而提前初始化它。核心文档类也只在 Loader COMPLETE 后解析。以上边界依赖当前已审源码，改变初始化顺序后需要重审。

## 独立 SOL 与解析

唯一打开／写入的 SharedObject 是 `SharedObject.getLocal("yzlr2_diagnostic_probe", "/")`。其中仅存 `data.payload` JSON 字符串，schema 为 `yzlr2-diagnostic-v1`，当前带 wrapperVersion=5，旧报告保留各自版本号。最多最近 24 次快照，UTF-8 JSON 超过 60,000 字节时继续丢弃最旧快照；单条仍超限则不写。只有当前测试游戏的有限状态摘要，不含账号或原始存档数据。日志可能包含本地 wrapper URL，只应作为本地诊断产物保存。

每次启动会用新的报告覆盖同名诊断对象；结束一组对照后应先复制诊断 SOL 到忽略的 `reverse/private/` 或 `reverse/build/`，再启动另一组。工具没有主动读取已有诊断 payload。`pending`／`write denied` 表示尚不能确认落盘，受 Flash 共享对象配额及权限影响；60 KB 上限不能保证同一来源其他对象占用配额时永不弹权限对话框。

主任务若已确定该诊断 SOL 的路径，可只解析它：

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/diagnostic_harness.py read-sol '/明确的诊断目录/yzlr2_diagnostic_probe.sol'
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/diagnostic_harness.py read-sol '/明确的诊断目录/yzlr2_diagnostic_probe.sol' --full
```

解析器先校验文件名、100 KB 上限、SOL 头及内部对象名，再使用现有 `tools/sol.py` 的 AMF3 解码器，拒绝其他 SOL。默认逐行摘要；`--full` 输出完整 JSON（包含动画／类可见性）。它不搜索私人 SharedObjects 路径，不改写任何 SOL。synthetic-parser-check.json 记录纯合成 SOL 的正例解析、错误内部名称拒绝测试；它不代表真实 Flash 运行测试。

## 与直接启动的区别

游戏在 Loader 子树而非顶层，root/parent、loaderInfo、ApplicationDomain 与直接启动不同；相对资源路径仍由相同目录加载。wrapper 默认舞台尺寸与帧率 940×580@27，游戏可以自行更改舞台属性，观测层不再写入它们。额外计时器、序列化和每秒 flush 会消耗执行时间；小指示器占用左上角像素且可能被游戏另加的舞台对象遮盖。此加载环境本身可能引入或遮蔽问题，所以只能用相同 wrapper 做原版／重建版对照，并必须再直接打开游戏验证最终行为。

严格组装包安装 wrapper 时，已核验的来源 receipt 会按 SHA-256 保存到包内 `diagnostic-origin/`（新统一入口同时提供 `.provenance/`）。标签请求继续校验包中 164 个文件、主 ABC 隔离名称、assembly 和 receipt 快照；后续外部构建覆盖 receipt 不会使已完成的历史运行包失效。它只证明安装时来源与现有包一致，不代表旧包对应当前编辑后的源码。

## v3 字段和域观测修正

v3当时只完成编译，随后由v4/v5替代；其源码/SWF/编译收据现保存在history/v3，v2对应history/v2。当前标签命令兼容v2至v5；不得用当前build.json的v5哈希识别历史v3产物。所有版本仅写诊断SO，不访问游戏SOL，不主动改变游戏对象或打开界面。

主任务的 v2 `results/original-village.json` 保留原样：SHA-256 `bb3f16733aba659a90d90f670eb8d011c5de922eb121cc9c2d0822735a2134c5`。该样本是 Map=0、room=3、world=Map_0_3 的毁坏村庄，不是包含普通村长／装备按钮的 Map_0_0。因此空 NPC 列表既可能来自当前地图内容，也受 500 节点扫描截断影响，不能宣称 NPC domain 验证通过或失败。

该记录的 hp=48848、hpMax=38463 来自不同语义字段：v2 的 hpMax 实际读取基础 `Player.hp_Max`。v3 明确改名 hpBaseMax，并另读 `Player.use_hp_Max` 为 hpEffectiveMax；MP同理。`Player.as:662–663` 先复制基础值，后续倍率、称号、精灵、印记、图鉴等继续改变 use_*；`Play_Interface.as:602–605` 实际界面取 hp/use_hp_Max、mp/use_mp_Max，`BagItemsShow.as:172` 属性页同样用 use_hp_Max。v2 的38463不能当作 UI 最大生命值，也不能据此判为重建行为偏差。后续v4/v5已有分开的基础/实际最大值快照；原毕业fixture这一特定数值应按各次报告对照，不由字段改名推定。

v2 每次重复获取 ApplicationDomain.currentDomain／parentDomain／loaderInfo.applicationDomain，并给返回的 API 对象编号。这些编号递增只说明采样得到不同对象句柄，不能证明底层域改变；目前没有独立 VM 实验证明 getter 包装器的精确实现。v3 缓存 wrapper/currentDomain；每个既有 LoaderInfo 只获取一次 applicationDomain，每个已缓存 domain 只获取一次 parentDomain。字段改为 cachedHandle/cachedParentHandle/requestedMainHandle/wrapperHandle，并显式 domainIdentityIsSemantic=false。缓存旨在避免把 getter 包装器分配误报为资源重载，它也不负责检测同一个 LoaderInfo 的后续 reload；该检查需要额外独立加载事件证据。

默认仍不解析未用类。只有显式 resolveClassIdentities 才用 Class 引用比较辅助判定父域查找／类型一致性；即使两个缓存域句柄不同，也不能得出类属于不同 VM 域。现有对象 constructor 引用可比较本次运行的 Class 身份，但不等于完整资源定义归属证明。v3 优先扫描当前 world 以提高 NPC 可见机会，保留 stageScanTruncated、childLimitTruncated 和 npcObservationComplete=false；扫描为空不能证明缺失。Map_0_0 的普通NPC在 moveChild 的直接显示子节点（原资产定义村长493、装备500），但不因此强行加载该地图。


## v4：药水商店只读文本边界观测

v4随后已安装并实际运行，遇到下节保留的observer #1009；不能作为shop数量边界通过证据。v3归档history/v3，v4归档history/v4，读取摘要带uiText；当前使用v5。v4 另将游戏错误监听挂在 `Loader.uncaughtErrorEvents`，用于加载内容的未捕获异常；不调用 preventDefault，错误仍交给原有 debugger 处理。这符合 [Adobe AIR API 的加载内容事件说明](https://airsdk.dev/reference/actionscript/3.0/flash/events/UncaughtErrorEvents.html)。尚未运行验证监听效果。

`uiText` 只检查游戏 stage 前 160 个直接子对象，按现有对象的 getQualifiedClassName 识别 SuppliesShopPanel，只有该实例及其祖先 visible=true、alpha 连乘大于0、确实连到 stage 时才收集文本。源码 `SuppliesShopPanel.open()` 将 ssp 直接加到 Main._stage，close() 只隐藏；因此这一路径覆盖现有界面，不为探针解析该类或读取静态 ssp/suppliesShowPanel，避免触发静态工厂初始化。找不到仅表示本次限定范围未观察到。

在已显示的商店子树内最多扫描 300 节点、每容器100子对象；先收集字段，优先 amount。最多记录16个可见 TextField、每字段128字符、合计1536字符，跳过 displayAsPassword。`targetAmount=true` 精确表示 name=amount 且显示父对象 name=buyMenu，对应源码现有 `suppliesShowPanel["buyMenu"]["amount"].text`。保留 fieldType、完整预算内 text、originalLength、textTruncated；数字即使因字段宽度而只能看见尾部，仍可从 text 读取全部字符。不会修改 text、selection、focus 或游戏状态。

每个字段附从 stage 到自身的 ancestors（最多24层、每层 name/className/visible/alpha）和路径完整标记。这里的“可见”仅指显示列表 visible/alpha，不验证遮挡、mask、屏幕边缘裁剪或玩家实际看到哪些字符。stageScanTruncated、scanTruncated、childLimitTruncated、fieldsTruncated、textTruncated、ancestorPathTruncated 均明确报告；observationComplete=false 时不能据空字段断言界面不存在。原有24快照/60KB预算不变，较大文本样本会缩短保留历史。

后续由运行验收者显式安装并打开 wrapper 后，保持商店购买数字框打开，再调用 `diagnostic_harness.py label <隔离运行目录> shop-amount-boundary`；导出诊断 SOL 后 `read-sol ... --full` 的最后标签样本中查看 `uiText.fields` 的 targetAmount/text/originalLength。F8 或每秒自动样本也可使用。v4初始交付时仅提供准备好的工具；随后主任务已安装并运行，历史失败与v5成功结果见下文。子任务本身不操作UI或访问SOL。


## v5：观察器失败隔离与商店显示树修正

主任务实际运行 v4 后保存 `results/original-shop-before-down.json`（SHA `c0a113ccb71599f775e59eb6ebdac1ce6761513a2bf1104b4efc52522f310f63`）。其最后成功样本 ms=128457，末尾 observer #1009 已到188835，差60378ms。最后样本 panels=0 只描述一分钟前的旧状态；打开商店后每轮capture抛错，整份新快照没有入队。因此不能据此断言SuppliesShopPanel不是显示对象，或当前数量字段不存在。该旧样本 tasks.scanned=167 并已找到110001/110002，也不能据此把异常归因于新角色没有任务。

源码关系：SuppliesShopPanel继承MovieClip，构造函数addChild(suppliesShowPanel)，其类型为全局SuppliesShopShow；open()将ssp直接addChild到Main._stage。Main._stage直接来自stage。v5仍匹配现有控制器，另识别现有SuppliesShopShow视图；只用原生getChildByName在观察到的view中优先找buyMenu.amount，不读取ssp/suppliesShowPanel静态变量，也不解析/实例化这些类。stage最多24个直接子对象的name/className/visible元数据随样本保存，帮助核对实际显示树，不读取其他文本或应用。

v4的 `current.name.substr(...)` 未保护null，只有开始遍历已显示面板的完整祖先链时才执行，Stage或其他未命名对象name为空是一个具体可导致#1009的候选原因。v5已改为null安全；但旧错误没有stack和group，**尚不能断言这是唯一实际根因**。新版本按组记录errorID、message和可用stack，支持后续实测定位。

每次采样先尝试uiText，再分别采scene/player/world/tasks/inventory/resources/definitions；每组自己的try/catch只隔离诊断读取异常。每条快照带partial、groupStatus（ok/unavailable/error）、groupErrors，即使任务或资源观察失败，也继续入队其他结果。report.observerErrors只保留最近8项观察器错误，独立于原report.errors中的游戏加载/未捕获错误，避免重复观察器错误淹没游戏错误。Loader.uncaughtErrorEvents监听保持，不调用preventDefault，不吞掉游戏的异步未捕获异常。60KB/24样本预算仍有效；组内截断仍查看uiText等自身标记，partial=false不表示所有预算都未截断。

v5已编译并完成下节原版实际观测，SWF SHA `7751f9b333c3ecb064d67287d22724622e3db39f6d9e8d4215452d98860f9c32`（9373bytes），Source SHA `7936334dbab5182559aa90ba31ef2afdd0c777bc55b31da0a8ed498cce0a3c72`。v4源码、SWF和build.json已保留在history/v4；原实测JSON未改。编译时子任务没有安装或启动v5；随后主任务实际运行已完整读取amount且前后记录无#1009，见下一节。


## v5 原版 INT_MIN 数量递减实际证据

主任务在原版隔离包冷读slot2后打开药水商店，输入 `-2147483648` 并点击一次减少按钮。独立读取已导出的JSON确认：

| 记录 | 最后序号 / 时间ms | targetAmount.text | originalLength | 字段截断 |
|---|---:|---|---:|---|
| original-shop-v5-before-down.json | 232 / 240189 | -2147483648 | 11 | false |
| original-shop-v5-after-down.json | 251 / 258470 | 2147483647 | 10 | false |

两份report均wrapperVersion=5、errors=[]、observerErrors=[]；上述样本partial=false、groupErrors=[]、uiText组ok。before SHA `ad98f4648b9faa7833bd13ac32ec1f8fe405a2c99f0d265b9e720acdf426961a`；after SHA `0faae6a142a3abedf79423a3a95249a4b2ec1d722ee820f8be29669565ce24be`。目标路径完整为 Stage → SuppliesShopPanel → SuppliesShopShow → buyMenu → amount，所有祖先visible=true/alpha=1。Stage.name实际为null，确认v4不检查null直接substr的分支确实有问题；v5该路径已成功。

**目标字段完整不等于整个商店扫描完整。** 两份uiText的scanTruncated=true、fieldsTruncated=true、observationComplete=false；300节点/16字段预算仍截断其他内容。但优先目标targetAmount字段本身textTruncated=false、pathTruncated=false、visibilityComplete=true，足以确认本次完整数字，不能借此声称商店全部文本都已观察。

主任务UI另确认冷读后金币4387、红药9、蓝药8。快照背包只摘要前6物品、occupied=17，不能从该截断列表单独重新推出9红8蓝，运行证明将这些数量单列为操作方UI报告。本子任务只读指定JSON，没有访问SOL或操作UI。最新keep-trace重建全包同输入对照仍待完成；不得把原版通过当作修复后重建版通过。
