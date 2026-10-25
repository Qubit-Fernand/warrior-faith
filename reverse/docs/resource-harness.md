# 独立资源加载对照探针

`reverse/experiments/resource-harness/ResourceHarness.as` 是独立探针，不包装或启动游戏主程序。`reverse/tools/resource_harness.py` 编译、准备配对包、读取专用 SOL 并比较结果；该工具不启动播放器。当前构建与包信息分别在 `build.json`、`latest-pair.json`。

## 当前待运行包

本轮 runId：`20261023T172032Z-cf396b00`。两包中探针 SHA-256 相同：`77db18a54c3c0a8f4f20a89a93a9a443400a5834744fcd26e01f64452e85d29e`。

- 原版：`reverse/build/resource-probe-20261023T172032Z-cf396b00-original/ResourceHarness.swf`
- 重建：`reverse/build/resource-probe-20261023T172032Z-cf396b00-rebuilt/ResourceHarness.swf`

各包实际复制并逐文件校验了162个资源；不使用指向可变构建目录的软链接。主程序和 DataX 不在包中。`probe-manifest.json` 固定每个模块的 SHA、原版 SymbolClass 名称、顺序、runId 与 manifestId。包旁 `package-receipt.json` 记录 manifest、wrapper 和静态审计输入的 SHA。

由运行负责人用隔离播放器打开上述 SWF，保留各包目录层级，让相对 URL 能读到同目录 manifest 和 modules。显示完成后先读取并导出本轮专用 `yzlr2_resource_probe.sol`，再关闭并运行另一包。不要把诊断 SOL 复制进游戏存档，也不要通过修改游戏档来启动此探针。若播放器不能读取本地 URL，记录 SECURITY_ERROR/IO_ERROR 并修正测试环境；不要据此判资源损坏。

## 观察范围

每个模块单独使用 `new ApplicationDomain(ApplicationDomain.currentDomain)` 和 `LoaderContext(false, domain)` 加载。根节点保持离开舞台，不调用任何游戏类的 constructor/factory/getDefinition；只对原版非零 SymbolClass 名调用 hasDefinition。SWF 本身固有的类初始化和根时间轴构造仍可能执行，不能把加载称为“完全不执行资源代码”。

每个模块记录 INIT、COMPLETE、IO_ERROR、SECURITY_ERROR、未捕获异常、12秒超时、根类型、子节点数量、MovieClip 帧数、缺失绑定数量及少量名称。Map0、Enemy5、Enemy16另记深度2、每层最多6个节点的显示树样本与关键类可见性。COMPLETE 后等待150毫秒收集即时异常，再 unloadAndStop；所有异常仍计入结果，批次继续不等于忽略失败。

**父域是独立探针，未包含游戏主程序的类型。** 这保留了独立子域的加载结构，但不能代替真实游戏里父类复用、同名类型身份、装备强制转换和 NPC 点击验收。卸载策略也比游戏缓存更积极。本探针仅是原版/重建在相同隔离环境下的导入对照门槛，不宣称语义等价。

## 诊断保存与读取

探针只调用 `SharedObject.getLocal("yzlr2_resource_probe")`，未显式指定localPath。**本次macOS官方projector实测，两包都写入同一 `localhost/yzlr2_resource_probe.sol`，不能据此承诺按包目录隔离。** 原版结果已先由read-sol导出JSON并保留原SOL哈希，再运行重建版；两包依赖固定专用名称与runId/mode/manifestId校验防止混读，不能同时运行。运行另一包会覆盖该专用SO的上一结果，但不涉及游戏SO。

唯一数据字段是 JSON 字符串 `json`，每完成一个模块和批次结束都 flush。显示 Persistence 状态；读回时同样检查 fatal/persistError。`complete=true` 表示批次结束，只有行状态为 complete、errorCount=0、missingCount=0 才计为 clean_complete。

历史wrapper 77db18a…及build/package收据中“package-local”文案是已被实测否定的旧假设，保留原产物以保证结果可追溯。本次只修正源码文案和未来构建收据，不重编译或覆盖既有包；当前AS源哈希因此有意不同于历史build.json。未来可改为名称包含runId/mode的SO，但需同步修改读取器，尚未实现。

在项目根目录执行（把 SOL 路径替换为该包实际生成路径）：

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/resource_harness.py read-sol /绝对路径/yzlr2_resource_probe.sol --package '/Users/AntiEntropy/Games/勇者的信仰-逆向/reverse/build/resource-probe-20261023T172032Z-cf396b00-original'
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/resource_harness.py read-sol /绝对路径/yzlr2_resource_probe.sol --package '/Users/AntiEntropy/Games/勇者的信仰-逆向/reverse/build/resource-probe-20261023T172032Z-cf396b00-rebuilt'
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/resource_harness.py compare reverse/experiments/resource-harness/results/20261023T172032Z-cf396b00-original.json reverse/experiments/resource-harness/results/20261023T172032Z-cf396b00-rebuilt.json
```

读取器只接受专用 SOL 文件名、TCSO内部名、唯一 json 字段、同一包的 runId/mode/manifestId 和合法的162模块顺序前缀；检查 wrapper/manifest 哈希。它不会扫描或读取其他游戏存档。结果写入 `reverse/experiments/resource-harness/results/`，保留原始 SOL SHA。比较器要求原版/重建同 runId、各162行且结束，比较状态、事件、错误、绑定、根树和帧数；时间耗时及 ApplicationDomain wrapper 的对象相等观察不作为结构差异。

## 重建探针或刷新模块后

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/resource_harness.py build
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/resource_harness.py prepare-pair
```

prepare-pair 要求全162模块静态 roots/linkage 审计通过且资源哈希仍匹配，然后创建新的唯一配对目录。不要覆盖此前已运行包；不同 runId 不作同批比较。编译通过、打包通过或读取器合成测试通过都不是播放器实测证据。

## 本轮实测与名称差异分类

根任务使用macOS官方projector实际执行：原版UTC 2026-10-23 17:47:34–17:48:21，重建17:50:36–17:51:25；两版均162/162 clean_complete，issues/fatal/persistError均为空。结果位于 `results/20261023T172032Z-cf396b00-{original,rebuilt}.json`，分别保留各自SOL哈希。顺序读回已避免共享专用SO覆盖后丢失原版数据。

原始comparison保留两模块的tree差异：Enemy5根名instance88→instance86、其Shape子节点instance89→instance87；Map0根名instance103→instance101。独立 `classify_resource_probe_names.py` 对实际包中的SWF重新核验哈希和root标签：两包两个模块均没有id0 document class；Map0没有root placement；Enemy5只有depth2的PlaceObject2，原/新HasName位均为0，放置对象均为未绑定类的原生DefineShape2。因此这三处名称归类为播放器生成的实例名，而不是遗漏的显式业务名称。

`results/20261023T172032Z-cf396b00-classified-comparison.json` 保存逐字段分类及SWF证据。仅剔除这三个有证据的字段后，根类型、孩子数量、帧数、采样树和关键绑定均相同；原始差异JSON没有修改，也没有通用忽略所有name字段。自动实例计数不同的具体分配顺序原因未定位，不能据此声称整个初始化过程一致。真正游戏父域、NPC交互和构造全部类型仍超出本探针范围。
