# DataX 源码可修改性最小证明

目标是证明“编辑源文本 → 重新编译 → 新 ABC 中对应 XML 的方法构造值变化 → 游戏界面显示变化”，不是在 SWF 字符串池上做二进制替换。只改一个显示名称，不改数值、ID、逻辑或存档。待正式全量构建结束，冻结输入后开展；不与正式构建共享 staging、receipt、缓存或输出目录。

## 最小编辑

选择 `DataX_v76-config/SuppliesXML.xml` 中编号 21110、品质1的消耗品，将 `<名称>低级体力药水</名称>` 单次替换为同为6字的 `<名称>源码测试药水</名称>`。`SuppliesFactory.createSuppliesByShop()` 从品质1集合建立商店条目，因此可在药水商店已有列表中观察名称，不需购买/使用物品。实际显示位置还需运行确认。

在完整独立 scratch 根目录中复制 `reverse/source/DataX_v76`、`reverse/source/DataX_v76-config`、`reverse/tools`、原始 `DataX_v76.swf`、DataX exports/inventory、script-free `_assets`、scripts-receipt.json 和 recovery.json。工具链可用只读共享的 `.runtime/shared-tools` 链接；工具本身、源码、配置、支持元数据必须复制，不能链接到正式可写文件。scratch 放在全新的 `reverse/build/source-edit-proof-<UTC>/project/`，不复制/导入原项目的 build-full.json。新构建的全部输入指纹、日志、staging 和 receipt 都归 scratch 自己的 ROOT。

不能直接在正式项目运行 `datax_build.py --source-dir <scratch>`：其 BUILD/REPORT/LOGS 仍由脚本所在项目决定，会写正式 staging 与 receipt。也不要通过 monkeypatch 模块全局路径绕过指纹。应从复制后的 scratch `reverse/tools/datax_source.py` 执行 `import-xml`，然后执行 scratch `reverse/tools/datax_build.py`。两个脚本均按自身路径定位 ROOT。原始游戏 SWF 只作资源、类清单和版本兼容基线，不作为 external-library ABC；沿用正式完整 DataX 源码重建路径。

## 静态验收

1. 编辑前记录正式 canonical 和 scratch 源码/配置的完整哈希账本。编辑后仅 XML 镜像的目标名称和 InData.as 对应 SuppliesXML 字符串跨度改变；其他10个 XML、全部非 XML AS 文本、其余 AS 文件和 assets 逐字节不变。使用字符串单次替换保留 XML 换行/空白，不重新序列化整棵 XML。
2. scratch `import-xml` 必须报告只有 SuppliesXML 改变、其他 AS skeleton 保持。新编译必须成功，生成全新 generation，finish 指纹前后核验通过，不复用原始 ABC。
3. 使用现有 `verify_compiled_indata` 解析新 ABC 方法的 XML 构造值并校验11项。应 `all_11_xml_constants_byte_exact=true`（匹配修改后的输入），`xml_constants_match_original_baseline=false`（名称有意改变）。额外解出编号21110的名称确为“源码测试药水”，其余 XML 树/条目只允许该名称变化；不能只用全局字符串搜索替代方法证据。
4. 保留 SWF 原版 version=9、完整类覆盖与 XMLAsset 绑定核验。正式 canonical、正式 receipts 和已验运行包的哈希仍保持编辑前状态。静态通过只证明可重新编译和读回，不能声称界面已显示。

## 独立运行验收（由主任务安排 UI）

复制一个已完成且来源明确的完整重建运行包到全新的实验运行目录。在副本中仅替换 scratch 生成的 DataX，记录163个其余 SWF 保持相同哈希、DataX 前后哈希。不要沿用 complete assembly.json 冒充该编辑已经 strict assemble；改用独立 experiment receipt，指向正式基线 assembly 的 SHA 和 scratch build receipt。

Main 需额外使用独立测试 SharedObject 名称（例如 `yzlr2_editability_probe`）以免写正在验收的测试档，采用已验证的 ABC 字符串池结构重写工具，只替换该名称并记录额外 Main 补丁 provenance；明确这一步是测试隔离补丁，不把 Main 计为本次源码修改证明。由主任务显式播种 tracked fixture，不读私人原始 SOL。不要使用原版快捷方式。

主任务冷启动该实验副本，打开药水商店，观察目标名称并截图。需要文本级证据时可在同一独立副本安装已编译 v4 observer（安装器目前只接受正式隔离/strict包，需为实验 provenance 单独增加明确校验，不能冒用 assembly），读取限定商店文本；直接启动截图仍是最终界面证据。不要为证明标签而购买物品或更改装备。结果分开记录“源码已改/编译通过/ABC已读回/实际显示已验”四项。

以上是原执行方案；下节记录已执行的静态证明。运行方式按主任务最新授权继承现有隔离测试 SO，不创建新 SO 名称，也不读取/复制任何 SOL。


## 2026-10-24 独立实编与 ABC 读回完成

scratch 根：`reverse/build/source-edit-proof-20261023T184238.485544Z/project`。
完整证据：其上级 `experiment.json`、`unmodified-build.json`、`modified-build.json` 和命令日志。

两次实际完整 DataX 编译依次使用同一 scratch 固定 staging：先不编辑，再只修改编号21110的名称并执行显式 import-xml。两次都从292个 AS 源文件编译，不使用原始 ABC external library；各自全新 input_fingerprint generation 且 post_build_verified=true。XML导入日志只有 SuppliesXML 一项变化，all_other_AS_text_preserved=true；源文件账本证明仅镜像 SuppliesXML.xml 和 InData.as 改变。正式项目两棵 DataX canonical/config 树前后哈希一致。

- 未编辑产物 SHA-256：`034770f64e875e33c2a96fe7ee7952fbf5f6609bae4ba9e69cfa5514998eed88`；generation `01e7961f-91a3-43f9-986b-64ce77d1db6c`。
- 编辑产物 SHA-256：`26b3e7b25b04b0bb88ccdeaecb9040349dc4d1d384e3ddfcddfff96ab4cf1f14`；generation `847720df-e30b-4762-9cc0-4ecf327f7e58`。
- 新产物 src.InData.SuppliesXML 方法的 pushstring 索引被实际解码，并对指向 XML 解析编号21110，名称确认是“源码测试药水”。11个 XML 方法完整操作码模板均通过，不只是搜索常量池。10个其他XML逐字节一致，SuppliesXML仅预期名称单次变化，SWF版本保留9。
- 新编译 all_11_xml_constants_byte_exact=true 代表匹配修改后的输入；xml_constants_match_original_baseline=false 是本实验预期，不是失败。无跨目录字节确定性声明。

待运行目录：`reverse/build/runtime-source-label-probe-20261023T184238.485544Z/`，直接入口 `3_L4399Main_gamefile.swf`。基线是已验证回城的 `runtime-header9-probe-20261023T182311.123031Z`；163个其他SWF哈希不变，只有DataX被换为本次源码编译产物。基线Main完整保留，继续使用 `yzlr2_rebuild_probe`，遵循主任务“继承已有隔离测试store”指令，未访问任何SOL。没有复制基线assembly或wrapper；独立 source-editability-experiment.json 明确不是正式 strict assembly，不匹配标准launcher选择模式。

边界：该旧运行基线 DataX 与本次源基线之间还有此前完成的语义修复；因此只声称本次 scratch 的源码改动是一条名称，不声称相对旧完整运行包的DataX业务差异只有名称。未编辑/编辑两次构建和11项XML字节比较用于分离这一点。

已完成：源文本编辑、完整编译、ABC方法构造值读回、独立运行包准备、正式canonical未变核验。该静态阶段之后，主任务已完成实际界面验收，见下一节。子任务自身未启动播放器、未安装wrapper、未读取/写入SOL。

可重做工具为 `reverse/tools/source_editability_probe.py --baseline <隔离完整包>`；它会新建时间戳目录并完成上述两次实编、读回和实验组装，不启动游戏。默认从调用 Python 环境继续执行，使用 Qubit；共享工具链只读访问，其余输入/缓存/日志/receipt全在 scratch。当前工具明确校验继承的测试store是 yzlr2_rebuild_probe，拒绝私人原始存档名。


后续编译器审计发现旧默认参数会剥离 trace 连同参数求值。上述独立标签实验使用当时复制的recipe，保留为历史源码修改性证据：其“指定XML名称经源码重编进入ABC”结论仍成立，但不把它当作最新全部语义修复的正式候选。正式三路recipe后来显式设置 omit-trace-statements=false 并需要新的generation；本历史scratch/运行包未被覆盖。


## 实际 UI 验收已通过（历史实验包）

主任务冷启动上述 source-label 实验包，新建单人slot2剑杖角色，打开妮蒂亚药品商店。截图 `reverse/logs/runtime/source-edit-label-visible.png`（SHA-256 `4de74c07414930036b35eeb714aaa7e93ed7d49611d6c6507a4cbb2d3a7d674a`）已由本子任务实际查看：窗口路径对应实验目录，第一行清晰显示“源码测试药水”，价格8；其余初级/中级/高级体力药水与魔力药水标题正常。画面可见金币4399、生命1428/1428，以及8红8蓝药水。

主任务另报告没有买卖，随后显式保存既有隔离 `yzlr2_rebuild_probe` 的slot2，MP771，slot1不变，播放器退出。这些操作顺序/存档槽/MP完整值不是本截图单独能够证明的，作为操作方记录保存；本子任务没有读取或核对SOL。新增 `reverse/manifests/source-editability-runtime-proof.json` 和 scratch 上级 `runtime-proof.json` 区分截图直接观察与操作方报告。运行包164个SWF现有SHA已重新核对，全部与实验manifest一致。

由此完成“指定源码名称编辑 → 独立完整DataX编译 → ABC方法构造值读回 → 冷启动实际UI显示”的闭环。结论限定为该历史实验的源码可修改性，不宣称最新正式164模块全包已完成运行验收或所有行为与原版等价。该实验仍保留当时编译选项（未加后续omit-trace修复）；原静态experiment/build receipts保持不改，用单独运行证据追加验收状态。
