# 原版／重建版共用诊断加载器

此工具是独立观测 wrapper，不是游戏源码重建的一部分，也不能替代直接打开游戏的验收。2026-10-24 v2 已编译并静态检查，尚未由此子任务启动播放器。相同 `DiagnosticHarness.swf` 已放入 `reverse/build/runtime-original-control/` 与 `reverse/build/runtime-rebuilt/`；具体 SHA-256 见源码目录 `build.json` 和各运行目录 `diagnostic-install.json`。v2 增加当前测试游戏内存的任务、装备与 domain 观测，以及标签快照请求。

## 复现

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/diagnostic_harness.py build
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/diagnostic_harness.py install reverse/build/runtime-original-control
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/diagnostic_harness.py install reverse/build/runtime-rebuilt
# 也支持统一入口刚生成的严格完整包（实际替换时间戳）
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/diagnostic_harness.py install reverse/build/runtime-all-rebuilt-<timestamp> --label full-rebuilt
```

安装接受两个既有隔离目录，或统一入口生成的 `runtime-all-rebuilt-*` 严格包。严格包须 assembly.json state=complete、164 个 source_rebuilt、零回退、partial_allowed=false；逐一复核 164 SWF 哈希及清单引用的构建 receipt 哈希。若后续构建替换了可变 receipt，应重新 assemble，不能忽略来源校验。partial 包被拒绝。

所有模式都解析目标主 SWF 的 ABC 字符串池，拒绝 `yzlr2_saves`，并要求预期的测试存档名。原版为 `yzlr2_original_probe`，重建版为 `yzlr2_rebuild_*`；严格包只接受后者。安装只增加／更新诊断文件，不修改游戏 SWF。更新已有 wrapper 前核验旧安装记录，并把旧 SWF 与记录归档到该包 `diagnostic-history/`；未知修改的 wrapper 不覆盖。安装后切勿把 wrapper 单独移入私人游戏目录；此防护在安装脚本中，运行中的 wrapper 不对目标 SWF 重新验签。

由主任务需要诊断时打开该目录的 `DiagnosticHarness.swf`，相对加载同目录 `3_L4399Main_gamefile.swf`。左上角显示 `DIAGNOSTIC`、序号、标签与保存状态。自动每秒采样，F8 额外手动采样；不取消或拦截游戏按键。不要同时开原版与重建版 wrapper，以免两者竞争写同一个诊断对象。

在 wrapper 已运行时，从终端请求带标签的快照：

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/diagnostic_harness.py label reverse/build/runtime-rebuilt 'quest-110002-before-save'
```

此命令只原子更新 `diagnostic-request.json`。wrapper 每秒用 URLLoader 读取该诊断文件，看到新的请求 ID 后设置后续样本标签并额外生成 `reason=label-request` 的一次样本。标签最多 64 字符；不把按键发给游戏，也不改 stage.focus。CLI 返回的是 requested，只有 SOL 中出现对应 label/reason 才确认执行；文件轮询、落盘与 UI 行为仍待实际播放器验证。`install --label ...` 只设初始标签，不请求额外快照。

**默认关闭未用类的精确引用解析。** 默认只记录已存在对象的 domain/Class 身份和 hasDefinition；资源与主程序的精确类引用比较为 null。确需诊断绑定时显式加 `install --resolve-class-identities`，或运行中 `label <目录> <标签> --resolve-class-identities`；关闭用 `--no-resolve-class-identities`。普通 label 不改变已有开关。报告头、每个样本和资源摘要均记录 resolveClassIdentities。开启后 getDefinition 可能触发未用类静态初始化，例如 HitXX 的 VT 随机掩码，影响初始化时序／随机序列；不是零扰动观测。关闭不能撤销已经发生的初始化，要恢复默认环境需重新启动。

## 观测范围与边界

- 新建 `ApplicationDomain(ApplicationDomain.currentDomain)`，游戏位于单独子 domain，wrapper 只有 `Source` 一个类，不链接游戏类。
- 主程序加载完成后读取已初始化的 `src.Main`。地图／房间来自 `Main.gameNum/gameNum2`；不额外初始化 GameData。
- 玩家记录 HP、MP、最大值、x/y、朝向、noMove；动画记录 `skin.runType/frame/stopRun/runOver/continuous` 及 MovieClip 当前帧／标签。
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
- 每个资源默认记录 domain、parent 身份和 src.Main/src.HitXX/src.Skin_ZhuangBei 的 hasDefinition。只有开启 resolveClassIdentities 才调用额外 getDefinition 比较 Class 引用是否严格等于 main domain 对应引用；默认或缺失为 null。不 new 类，不调用 load/getClass，不把资源 root 加到舞台。
- 从 loader.content 只读取现有 root 类型和直接子对象数量，用于 Enemy16/Enemy5 根恢复对照。HitXX.AllHitXX.length 默认仅在实际观察到舞台 HitXX 实例、取得其现有 Class 后读取；此前为 null。开启精确解析时可以额外解析 HitXX 类读取，不向其注册对象。
- 最多遍历舞台 500 个现有对象、每容器前 100 子对象，记录最多 12 个村长／装备／船长2 NPC。默认记录实例 constructor 身份和声明该名字的候选资源 domain；仅在显式开启时比较对应 Class 引用，生成 matchedResourceDomains。扫描截断明确标记。
- VIP／星灵／养成界面的 loadData 是 private，不绕过。仅对舞台上已存在的裸名 Skin 实例记录 Class 身份和 loaderInfo domain/url（最多 6 个），不会主动打开界面。loaderInfo 的 domain 是观测值，不单独当作定义归属的证明；没有实例就是未观察到。

v2 比 v1 每个样本更大，60 KB 上限可能把历史缩短到少于 24 次。重要检查点应请求标签后及时导出诊断 SOL。若今后修改上述 getter／只读方法，应重新审计观测逻辑。

TaskData 的访问边界由 Main.GameStart 源码顺序保证：`TaskData.initAllTask()` 在 `AddMap()` 之前；观测必须已有 world，因而没有为了采样而提前初始化它。核心文档类也只在 Loader COMPLETE 后解析。以上边界依赖当前已审源码，改变初始化顺序后需要重审。

## 独立 SOL 与解析

唯一打开／写入的 SharedObject 是 `SharedObject.getLocal("yzlr2_diagnostic_probe", "/")`。其中仅存 `data.payload` JSON 字符串，schema 为 `yzlr2-diagnostic-v1`，v2 带 wrapperVersion=2。最多最近 24 次快照，UTF-8 JSON 超过 60,000 字节时继续丢弃最旧快照；单条仍超限则不写。只有当前测试游戏的有限状态摘要，不含账号或原始存档数据。日志可能包含本地 wrapper URL，只应作为本地诊断产物保存。

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
