# 统一工程入口

在 `~/Games/勇者的信仰-逆向` 运行，下列工具只检查、编译和复制构建产物，不启动播放器，不读取／写入 SharedObject 或私人存档，不覆盖当前正在运行的目录。

```sh
# 检查当前源码与最近成功构建凭据
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rebuild_project.py status

# 深入核验 SWF、原始 ABC 未直接复用、素材无脚本、舞台及根类
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rebuild_project.py audit

# 依次调用主程序、DataX、162 个资源模块的现有构建流程
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rebuild_project.py build all

# 只有全部164模块通过严格核验才组装
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rebuild_project.py assemble
```

`build main`、`build datax`、`build resources` 可以分组；资源也可用精确模块名，例如 `build Enemy16`。`build all --dry-run` 输出命令而不执行。主程序始终传 `--all-definitions`，不接受只包含可达类的 main 构建充当完整重建。DataX 编辑与 XML 导入方式见 [datax-recovery.md](datax-recovery.md)。

各阶段的完整输出写入 `reverse/build/project/build-*/stage-*.log`，`stages.json` 只记 pipeline、退出码和日志。任何阶段失败就停止后续阶段。`status` 和 `audit` 是报告命令，运行成功不代表所有模块已完成；须看 `all_rebuilt_ready`，严格 `assemble` 会强制检查它。

## 凭据与过期判定

可编辑输入为 `reverse/source/<模块>/`；构建指纹覆盖整树（包括非 AS 文件），当前资源编译仍只消费 AS 与导出素材；素材暂时仍来自 `reverse/exports/<模块>/scripts/_assets`。入口每次计算实际文件哈希，不能因目录中已有 SWF 就认定构建有效。

- 主程序读取 `reverse/build/main-probe/build-all.json` 及各 `run-*/receipt.json`，选择最新的成功、完整类集、源码哈希一致且产物哈希正确的候选。拒绝旧完全限定 XMLAsset 动态绑定修复，并检查实际编译字节码中只存在声明的 `yzlr2_rebuild_*` 存档名。
- DataX 读取 `reverse/experiments/datax-recovery/build-*.json`，要求成功状态、canonical_source_hashes、正确 XMLAsset 编译绑定凭据、`src.Data` 根类恢复，以及没有复用原 ABC。
- 资源读取 `reverse/experiments/module-probe/<模块>/result.json`，核对 original_sha256、source_files、output_sha256、original_abc_reused=false 和无脚本素材凭据。旧 `Qualify ...` 修复及 invalidated receipt 均拒绝。旧凭据中 experiments 路径只用于转换为包内相对路径，实际仍必须与当前 canonical 文件哈希逐项一致。
- 资源的根时间轴还必须有 `root_timeline.verified=true`、`schema=1`、`original_abc_reused=false`。没有该验收可以显示“编译产物有效”，但不能显示“可严格组装”。已发现 Enemy16、Enemy5_v2 的旧构建丢失根 placements，故不可略过该步骤。

所有模块必须携带实际构建前 `capture`、构建后 `finish` 产生的 `input_fingerprint`，且 `post_build_verified=true`。入口使用 `build_inputs.verify` 重扫完整输入；源码新增／删除／修改、素材、修复脚本、工具链或环境变化都使其不能组装。Main 的资产版本从此由该完整输入账本覆盖；DataX 和资源的专用 assets ledger 继续额外检查。旧无指纹候选仍可显示 compiled=true，但 assembly_ready=false；这不撤销既有包与历史运行观察，只是不允许把旧证据充当本次可复现构建。

七个资源模块还包含构建阶段生成的 `_assets/recovered-buttons.swf`。入口单独核验 compile-source 中该文件的哈希、无脚本，并将 button_embed_repairs 的每个 original_definition_sha256 与原 SWF 中相应按钮定义匹配；不能把它误当丢失的导出素材，也不忽略未知额外素材。

深度 audit 还直接读取原版和候选 SWF：拒绝任何逐字节相同的原 ABC 块、意外 AS2 动作、缺失 AS3、根类不同（包括原版无根类但重建多出合成 Sprite），以及舞台尺寸／帧率／帧数不符；检查导出素材 SWF 不含脚本。这些检查配合构建来源证明没有直接拿原 SWF／ABC 充当重建。它们不证明所有方法语义相等，不替代图像和实际玩法验证。

报告在 `reverse/build/project/status.json` 或 `audit.json`，包含总数、有效编译数、可组装数、问题计数和每模块简明状态。`--details` 可把逐模块结果也打印出来。初次入口验证时识别到主程序 `96ce6635…b458ba`、DataX `02ab9b45…a3ce5def`，164 个候选均匹配 canonical，但 162 个资源缺少根时间轴验收，因此严格可组装数为 2；之后以重新运行结果为准。

## 组装规则

默认 `assemble` 在复制前进行深度 audit，要求 164/164 全部可组装；缺失或过期时退出非零，不创建“完整重建”目录，也不默默用原版补齐。

如果只是为了诊断，必须显式选择混合组装：

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rebuild_project.py assemble --partial
```

此时未通过完整静态核验的资源用经过原始清单哈希验证的原版文件替代。每个模块的 `provenance` 为 `source_rebuilt` 或 `original_fallback`，并保留 fallback 原因。主程序即使 partial 也必须是合格的隔离存档重建版，绝不退回使用私人原版存档名的主程序。

完整组装输出 `reverse/build/runtime-all-rebuilt-<UTC时间>/`；混合组装输出 `runtime-partial-<UTC时间>/`。始终新建目录，复制每个文件后复核哈希；同时检查 canonical 源码是否在组装期间发生变化。仅复制 164 个游戏 SWF，不复制播放器 exe、存档或诊断 wrapper。

`assembly.json` 记录每文件哈希、来源路径、receipt 路径及摘要、输入 generation/digest。来源 receipt 按哈希复制到包内 `.provenance/`，避免后续构建覆盖外部 receipt 后失去历史来源；组装复制前还会重新检查输入指纹。只有 `state=complete` 才是完成产物；中途出错保留 `state=failed` 与已复制文件供排查，绝不自动删除。`runtime_validated=false` 明确表示还没经过播放器验证。

## 当前依赖与限制

- Python 使用 `/opt/miniconda3/envs/Qubit/bin/python`，入口自身只用标准库及仓库内 SWF 解析模块；不使用系统 Node。
- Java 21、FFDec 26.3.0、Flex SDK 4.16.1、playerglobal32_0.swc 使用现有 `.runtime/shared-tools`。它目前是相邻游玩目录 `.runtime/tools` 的本机引用，并非随源码独立分发的工具链。
- 必须先有 canonical 源码、原版 164 SWF、`reverse/manifests/original-files.json`，以及本轮导出素材与库存。克隆 Git 后这些忽略产物不一定存在；本入口不会暗中下载或安装工具，也不能声称全新机器立即一键构建。
- `build all` 统一调用现有局部流水线，资源流程按自己的有效 receipt 缓存策略运行。目录不能同时被另一份同模块构建修改；若哈希核对遇到并发更新，重新检查，而非忽略差异。
- 编译、结构恢复、完整组装、直开游戏可玩是不同验收阶段；组装成功仍须检查攻击、技能、Boss、任务、保存／重读和原版对照。
- 输入指纹是实际本机构建记录，不是签名、跨机器位相同比特承诺或行为等价证明。旧 receipt 不补记事后哈希；必须真实重新编译才得到新 generation。工具链为本地内容哈希账本，依赖文件仍需自行保留。

## 完整输入指纹组装记录

`runtime-all-rebuilt-20261023T175702.006475Z` 已经严格深审与组装成功，164 个 source_rebuilt、0 fallback、164 个独立 input generation 和 164 份包内 receipt 快照。Main 为 `928e3d909992abb9b73e1820a45dd373d26171c460a72e296f605601df396248`，DataX 为 `02ab9b45c2310ffb79b2e84a1ba0d70da53b24f40a1a4a57f1148813a3ce5def`。这是带真实构建前后完整输入指纹的新代包，不追认旧171635包的工具链输入；旧包既有玩法观察仍保留。

Main 的重复构建并非字节确定，正式优化版及关闭优化实验均已记录编译器私有编号／脚本初始化差异，见 `main-optimize-false.md`。新包的静态组装通过不替代其928e版本的直接运行与Finder冷启动验收。

## 资源并行构建（2026-10-24）

162资源原本已通过编译参数 `-swf-version=<各自原版版本>` 保留版本，并在写receipt之前断言version/尺寸/帧率/帧数等于原件。完整175702包审计结果：原件153个SWF9、11个SWF11；旧重建仅Main/DataX提升至14，162资源零版本偏差。证据 `reverse/experiments/returntown-label-audit/all-module-versions.json`。Main/DataX的版本保留已另修recipe；不要把全部资源强行设为9，11个原SWF11必须继续保留11。

源码修复冻结后可以执行：

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rebuild_project.py build resources --jobs 3
# 或整个工程；Main、DataX依次构建，只有资源阶段并行
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rebuild_project.py build all --jobs 2
```

`--jobs`只允许1/2/3，默认1。每模块的两次编译依次进行，每个Java资源编译进程限制`-Xmx2g`；jobs3上限三个编译进程，不保证恰好加速三倍。这条“仅准备调度器、尚未正式执行”的状态属于初始交付历史；随后已实际启动`--jobs 3`资源构建，目前正在执行保留trace的新generation。运行前仍可追加`--dry-run`确认命令，但它不能替代实际编译凭据。

安全边界：每模块独占自己的staging/output/receipt，加独立非阻塞flock，重复构建同模块立即拒绝；同一工程同时只能运行一个资源族调度器。公共commands.jsonl追加受flock保护；输入哈希缓存原有flock和原子替换保留；内容寻址工具manifest用唯一临时文件原子写入相同内容。汇总resource-family.json只由调度器主线程原子写入。每模块子进程使用独立进程组，900秒超时后终止该组（含Java），避免Python退出释放锁后遗留编译器继续写文件。

修改canonical或recipe时不要同时编译；build-input前后复核会拒绝输入中途变化。不要同时在本工程单独启动相同module构建；独立cleanroom工程使用各自目录和锁，不受本工程锁影响。这次调度/锁/heap规则改变已进入资源recipe指纹，所以旧资源receipt会被识别为需重新构建，不能事后补签。DataX传递依赖该模块脚本，其下一轮构建也必须在脚本冻结后进行。

合成隔离检查已覆盖6模块最多3并发、完整单写汇总、同模块进程竞争拒绝、三进程共9条日志无破损；具体结果 `reverse/experiments/returntown-label-audit/resource-parallel-check.json`。这些合成测试本身没有启动Flex、Flash或读取存档，不应作为正式162资源完成证据；后续真实并行构建的完成状态须以resource-family汇总及每模块新receipt为准。


## trace 参数求值的编译兼容修正

三路正式 recipe（Main 的 mxmlc、DataX 和162资源的 compc）都显式加入 `-compiler.omit-trace-statements=false`，继续保持 `-debug=false`。不能仅因为 trace 是日志就让编译器删除它：参数表达式可能修改计数、读取触发状态或执行其他方法。`reverse/manifests/trace-compiler-omission-probe.json` 保存实际小程序编译及P-code证据，默认选项把 `trace("retained", effect())` 整条以及 effect() 都删除；显式false保留两次调用。

此次修改在全部构建调度/编译/产物写进程安全停止后落盘，每个recipe仅增加一个参数。`reverse/experiments/trace-preservation-recipe-check.json` 记录修改前后SHA、唯一命令参数断言；Python语法编译通过。三个recipe都已纳入真实构建前指纹，旧receipt不得追认新参数，已启动真实重新编译的新generation。共享SWF normalizer未改。此局部验证不是全量新产物完成声明。


## 当前 keep-trace 新代构建进度（2026-10-24 状态记录）

当前源代码与recipe保持冻结，资源正在用`build resources --jobs 3`实际编译；不能再把调度器描述为“尚未执行”。Main与DataX本轮构建已经成功，已读当前构建凭据确认输出：

- Main：`71b7c20c9edcc1da4dc3142bedfdc0572fe658a62bf4fd35252f854567370648`，凭据 `reverse/build/main-probe/build-all.json`。
- DataX：`5e2401a863f3e5a8bf744e26639efa608b9225de384360fc608b5fb313057a75`，凭据 `reverse/experiments/datax-recovery/build-full.json`。
- 非Main语义定点校验已通过84模块、1,363个已修改方法、13,976个有限路径fixture；检查实际编译命令保留trace、当前output/recipe/source/generation关联。[最终校验报告](../manifests/nonmain-semantic-final-validation.json) SHA-256为 `39868b75802bf1f71191c875d16ad7b8f3bef9d393f9c5771a73b878d19c15e3`。这是有明确范围的局部路径验证，不等于全部162资源编译结束或完整游戏语义证明。

本轮有两项必须保留的编译兼容修复：显式`-compiler.omit-trace-statements=false`保留原trace表达式及参数求值，见[真实编译/P-code探针](../manifests/trace-compiler-omission-probe.json)；Main/DataX最终输出保留各自原SWF9头版本，避免SWF11+对缺失动画标签改为抛出2109，见[回城错误与仅改header后的实测证据](returntown-label-audit.md)。162资源继续逐模块保留原版本，原SWF11资源不能强制降为9。两项修复不通过修改共享normalizer或跳过输入核验实现。

**尚未在本状态记录中确认：** 这轮所有164模块完成后严格组装的新完整包，以及该新包的玩法/冷启动/保存重读/原版数量边界对照。此前175702完整包、header9探针和独立药水改名实验都是各自固定哈希的历史证据，不能自动转移为本轮71b7/5e240全包通过。后续应使用完成的资源receipt、严格assemble输出及独立实际运行记录更新状态。
