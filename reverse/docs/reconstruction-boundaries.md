# 重建输入、复现顺序与边界

本项目恢复的是可编辑 AS3 工程和可重用的美术／时间轴资源，不是原作者的完整 FLA 工程。以下结论来自当前三条构建流水线的路径与输入审计；编译成功、结构验收、实际玩法通过仍分别记录。

## 什么是源码，什么仍是原始输入

| 输入 | 当前用途 | 可否删除后重建 |
| --- | --- | --- |
| `reverse/source/<模块>/**/*.as` | 唯一可编辑代码权威；共 19,910 文件（主程序 710、DataX 292、资源 18,908） | 不可丢。重新反编译不能替代其中的人工恢复／后续修改 |
| `reverse/source/DataX_v76-config/*.xml` | 11 份易编辑的配置镜像；显式 `datax_source.py import-xml` 才写回 InData.as | 应保留；普通构建不会自动导入它们 |
| 根目录的 164 个原始 SWF | 经 `original-files.json` 固定的本包基线；用于资源导出、结构／类覆盖比对和部分元数据恢复 | 当前构建仍必需，不能只留下 AS |
| `reverse/exports/<模块>/scripts/_assets/` | 编译实际嵌入的资源，下面单独说明 | 可从相同原 SWF 和工具重新导出；若手工改过素材则须另行保存修改 |
| `reverse/exports/<模块>/inventory/` | SWF 结构、原 ABC 的解析清单；DataX 的覆盖／恢复校验还读取它 | 可以用 `swf_inventory.py` 重建 |
| `reverse/experiments/datax-recovery/recovery.json` | InData 恢复所依据的方法结构、XML 常量摘要与调用顺序；普通 DataX 构建读取此证据 | 应保留。缺失时可对原基线显式运行 `datax_recover.py` 重建证据，但不可用它覆盖编辑后的 canonical AS |
| `reverse/experiments/module-probe/*/src/` | 早期反编译快照；“18,908 个 AS 逐字相同”仅为语义修复前的历史结果。当前独立审计为 18,454 相同、454 不同、0 缺失 | 非构建权威；当前修复保存在 canonical。快照本地保留，专用 `.gitignore` 排除第二份源码 |
| `reverse/build/`、`reverse/logs/` | staging、编译结果、日志、哈希缓存 | 可重新生成；历史运行证据与包内 `.provenance` 应另外保存 |

当前快照比较见 `reverse/manifests/delivery-review.json` 的 `early_resource_snapshot_comparison`：比较了全部 18,908 个已有资源快照 AS 的完整字节。454 处差异对应后续资源语义修复，不应把早期 `src/` 复制回 canonical；总非 Main 修复还包含 DataX，详见 [语义修复摘要](semantic-copy-repairs.md)。

“原始”指此仓库基线游戏包，不意味着与当年的 4399 在线发行文件逐字节相同。原始清单还包含 Windows 播放器 EXE 和白屏修复 CMD；这两个文件不是源码编译输入，也不会进入严格组装的 164 SWF 包。

### 资源容器不是偷偷保留的程序

全量脚本导出实际提供 163 个 `_assets/*.swf`、761 个 `.bin`、16 个 MP3。163 个 SWF 是美术／字形／嵌套时间轴容器，Music 库使用独立 MP3 而没有该容器；761 个 `.bin` 全部能解析为 XML。

资源 SWF 的递归审计没有发现 DoABC、DoAction、DoInitAction。另查了容器内 350 个 DefineButton2 的动作偏移、64,061 个 PlaceObject2 与 12,303 个 PlaceObject3 的 ClipActions 标志，均不存在内嵌 AVM1 动作；没有 DefineBinaryData 隐藏 SWF。原始 ABC 只用于分析／验证，不作为嵌入素材传给 Flex。

资源构建还从原文件恢复了七个导出器遗漏的空按钮。它们是六字节、无状态／动作的 DefineButton2，写入 staging 的 `recovered-buttons.swf`，经过脚本空验证和哈希记录。它们是原美术定义，不是空函数或假实现。

此范围内仍然复用原来的矢量、位图、音频、显示列表层级、关键帧和布局；这些不会凭 AS 代码自动重新绘制出来。`-export assets` 得到的 SVG／PNG／字体文件主要用于阅读和编辑探索，当前编译实际使用的是 `-exportembed` 产生的 `_assets`。

### 三条构建链分别依赖哪些原数据

| 流水线 | 编译逻辑 | 非 AS 输入与原 SWF 的用途 |
| --- | --- | --- |
| `build_main.py --all-definitions` | 710 个 canonical AS，包含全部类；staging 修复 XMLAsset 导入／空语句，并改为独立测试存档名 | 复制主程序 scripts 导出目录中的非 AS 文件；normalizer 对原声音类恢复 sample-count／seek 元数据，前提是 MPEG 字节完全相同 |
| `datax_build.py` | 292 个 canonical AS；InData 的 11 段 XML 从 AS 读取并验证，不每次覆盖成原值 | `_assets`、recovery.json、原 ABC 清单；原 SWF 提供舞台／帧率、根标签和 `src.Data` 文档类绑定，以实际执行数据初始化 |
| `probe_rebuild_module.py <stem> --dynamic` | 162 个资源库，各自全部 canonical AS；显式的名称／导入修复只发生在 staging | `_assets`、导出凭据、原 SWF 的版本／舞台／帧率、声音头、SymbolClass、根控制／元数据；Enemy5 根 Shape2 及两张位图、七个空按钮也从原非代码定义恢复 |

资源库原来没有文档类。构建去掉 compc 自动增加的空 Sprite 的 id=0 绑定，恢复原生 MovieClip 根；Enemy16 的 `src.HitXX` 和 Enemy5_v2 的 Shape2 放置均按新角色 ID 重映射。原 ShowFrame／背景／场景标签／FileAttributes 等结构被保留。Music 的原流音频头也保留，不能因为没有流块就推断运行效果无关。

早期主程序和 DataX 输出 SWF 版本曾为 **14**；后续 compatibility recipe 已显式恢复原版本 **9**，新版 Main `run-lgf_klke` 与 DataX `run-2mbbd7gm` 已读盘确认。162 个资源库逐个保留各自原版本，其中 151 个版本 9、11 个版本 11。Flex 的 `target-player=32.0` 不等同于 SWF 版本 43。主程序 FileAttributes 为 8，原文件为 72（原 UseDirectBlit 位不保留）；DataX 原／新均为 8。这些是当前已记录的容器差异，不应写成全包每项容器属性完全相等。

## 工具与路径依赖

构建脚本按相对仓库根目录寻找以下布局：

```text
.runtime/shared-tools/
  java/jdk-21.0.12.1+1-jre/Contents/Home/
  flex/apache-flex-sdk-4.16.1-bin/
  ffdec/ffdec.jar
  ffdec/lib/...
  ffdec/flashlib/playerglobal32_0.swc
```

当前 `shared-tools` 是指向相邻游玩目录 `/Users/AntiEntropy/Games/勇者的信仰/.runtime/tools` 的本机软链接。先用 `readlink .runtime/shared-tools` 检查；干净 clone 中须自行提供同布局的现有工具目录或建立新链接，不应覆盖已有链接。FFDec 的 manifest 引用了多个 `lib/*.jar`，所以只复制 `ffdec.jar` 不足够。

主构建使用 Java 21、Flex 4.16.1、FFDec 26.3.0 和 playerglobal32；Python 实测为 Qubit 的 CPython 3.11.12。构建／盘点脚本用标准库，图像比较另外需要 Pillow。三条现行编译 recipe 均显式设置 `-compiler.omit-trace-statements=false`，避免默认设置删除原 trace 及其参数求值。此差异由独立真实编译/P-code 实验确认，旧默认 tracefalse 世代不能冒充此版本。源码构建不依赖 Node、REA、Windows EXE，也不依赖 `.runtime/prior`；只有辅助 `analyze_references.py` 在新导出缺失时仍可能回退到 prior，干净复现时先导出即可避免该路径。

尚无自动安装工具链或全新机器一键环境配置。哈希锁定不等于分发 JRE／SDK，Python 可执行文件与版本被记录，但整个 conda 环境没有一起归档。播放器及其运行时版本另属玩法验收输入。

## 干净 clone + 原始本包 + 现有工具的顺序

以下假定 clone 已包含本轮恢复后的 canonical 源码、`reverse/tools/`、基线清单、DataX 恢复证据和相关文本 manifest。不要在普通重建中运行 `archive_sources.py` 覆盖源码；它是初次归档工具，遇到已经恢复／编辑的 InData.as 会有意拒绝。

1. 检查根目录 164 SWF 是否与 `reverse/manifests/original-files.json` 一致。若 clone 缺游戏二进制，先从同一原始本包补齐；不要拿版本不同的同名文件混用。
2. 准备上面的 `shared-tools` 布局和 Python。`.runtime/prior` 可不存在。
3. 重新生成被 Git 忽略的 inventory 和嵌入素材。仅为了编译，不必再做全量 SVG／PNG 导出：

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/swf_inventory.py
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/export_swf.py --mode scripts --jobs 2
```

4. 保留 canonical AS。若 DataX recovery.json 缺失，可显式运行 `python reverse/tools/datax_recover.py` 重建原方法的证据；普通 DataX build 不会替你做这一步。若有意改配置 XML，先运行 `python reverse/tools/datax_source.py import-xml`，再检查 InData.as 的 diff。
5. 使用统一构建入口；它会分阶段停止失败，资源按新输入指纹判断缓存有效性：

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rebuild_project.py build all --jobs 3
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rebuild_project.py audit
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rebuild_project.py assemble
```

6. 只有 `all_rebuilt_ready=true` 和 `assembly.json` 的 `state=complete` 才表示严格全包组装完成。之后仍需使用隔离的播放器环境／存档名验证战斗、NPC、任务、Boss、结算、保存和冷启动重读。不要把 `--partial` 诊断包当作全量重建。

导出命令的进程 exit=0 本身不保证每个模块成功：应核对本轮所有 scripts-receipt.json 的 status=ok 与源哈希，并检查实际素材存在。已有导出凭据但其中的文件缺失时，`export_swf.py` 的旧恢复策略可能仅因 receipt 为 ok 而跳过。此时对相关模块显式加 `--force` 重导；这只应针对派生导出目录，不能覆盖 canonical 编辑。新干净 clone 没有这些忽略目录，因此不会触发此旧缓存情形。

## 输入指纹与构建世代

初始 receipts 主要覆盖 AS 和输出哈希。只看这些会遗漏主程序的美术修改、修复脚本变化、DataX 恢复元数据和工具链升级。`build-input-coverage-initial.json` 保存了只读插桩证据：当时主程序 ready=true，却没有读取任何素材或工具哈希。

新的 `build_inputs.py` 必须在 staging／编译前 `capture(...)`，结束后 `finish(...)`。每个 `input_fingerprint` 包含 UUID generation、捕获时间、输入规则、逐文件 SHA 和构建后复核标记；新增、删除或修改文件均会失效。它覆盖 canonical 整树、原 SWF、实际素材／配置／恢复元数据、实际修复脚本、完整 Java JRE／Flex SDK／FFDec 树（含 playerglobal），并记录 Python 可执行文件／版本与有关 Java／locale 环境变量。

6218 项公共工具输入存成一个内容寻址的 `reverse/manifests/toolchains/<sha>.json`，每个 receipt 引用其摘要，避免复制上百份工具清单。不可丢掉这个 manifest 后还声称 receipt 可核验。SHA 缓存位于忽略的 build 目录；只有 device、inode、size、mtime_ns、ctime_ns、执行权限位全部未变时复用摘要，目录仍每次扫描，因此新增／删除也会发现。这是可信本机工作流的缓存，不是防恶意篡改的签名系统。

构建中修改依赖会使 postcheck 失败，不会补写虚假的成功账本。`input-fingerprint-tests.json` 的十项实测覆盖原样通过、素材增删改、规则变化、Java 环境变化与构建中变更。旧构建的真实运行证据继续成立，但旧 receipt 不能事后伪装成有构建前哈希；新的完整指纹产物属于另一个 generation。组装时应保存实际 receipt 的内容快照，而不是仅留下未来会被覆盖的路径。

资源模块已做同一路径的双次编译比较；主程序在最新一轮相同 staging 路径下仍出现不同输出摘要，原因另由主任务调查，因此目前不宣称全包字节级确定构建。跨不同绝对 checkout 路径也不承诺字节完全相同。Flex 的文件私有 namespace 编号／ABC 排序会受 source-path 影响。换目录时应建立新 generation，比较结构和玩法，而不能仅凭二进制 hash 不同判定语义不同。

## 时间轴和布局的编辑边界

AS 中可以修改业务逻辑、数值、任务、对话和已有实例的动态行为。原场景的静态摆放、按钮状态、矢量路径和嵌套关键帧仍在美术容器中；它们尚未全部变成面向作者的独立编辑工程。

FFDec 提供 `-swf2xml`／`-xml2swf`，可将脚本为空的素材容器转成可编辑的标签、矩阵、形状记录，再序列化回 SWF。下面的可行性实验只处理派生副本，不改变 canonical 或当前组装包。该路线仍需要角色 ID／依赖图、SymbolClass 和所有状态的检查；不能把“XML 能导出”当作“任何布局修改都已验证可用”。

已完成的 Map0 小实验位于 `reverse/experiments/layout-probe/Map0-layout.json`：原素材容器 7.38 MB，经 FFDec 26.3.0 导成 43,952,310 字节 XML，再无改动导回。2624 个递归标签的类型／角色 ID／顺序相同；全部非 shape payload 完全相同，舞台、版本、帧率和帧数相同；`Map_0_0` 第 1 帧渲染 RGBA 逐字节相同。

不过，XML 重序列化使 **96 个 shape payload** 发生字节变化，因此这个实验只验证了上述结构和一个场景画面，不代表按钮全部状态、嵌套动画或任何实际布局修改都已验证。产物没有替换正式构建素材。

同目录保留四个小型 XML 片段：场景 sprite 505、`moveChild` sprite 504、村长按钮 493 和 shape 412；JSON 列出 28 个场景实例的类名、实例名、深度、变换矩阵及以像素表示的位移（原数据是 twips，20 twips = 1 px）。片段仍引用完整容器内的其他角色，不能独立编译。下一步编辑某个布局应以完整容器为输入，只改指定矩阵，核对依赖图和状态，重新编译关联 AS 后再做隔离玩法验收。`export_layout_manifest.py` 可从 ignored 实验文件重新生成这些阅读片段，尚不是通用布局构建入口。

主程序最新两次同路径构建的差异另见 `main-repeat-resolved-audit.json`。对 710 份 FFDec P-code 的比较保留私有 namespace identity，只规范化编译序号和方法内跳转地址：业务方法指令相同，差异集中在六个单类脚本初始化的 `getscopeobject 0`／`findpropstrict` 选择及对应 slot 0／1。解析后的 multiname 池差异也只对应这六个查找。该证据支持“尚未发现业务逻辑差异”，不等于已证明运行等价或已解决编译器的非确定性。

## 本轮完整输入记录的资源验收

`resource-fingerprint-validation.json` 记录了 162 个资源模块的实际新构建世代：162 个独立 generation、162 个构建后复核通过、162 个当前输入重新核验通过，问题列表为空；实际输出 SHA 也全部与此前稳定资源包一致。每条记录包含对应 receipt 的内容哈希、输入摘要和捕获／复核时间。旧的 `resource-final-validation.json` 保留为先前结构与画面验收记录，没有被事后补写成新的构建账本。主程序与 DataX 的新世代由各自构建凭据和统一入口另行记录。

## 实际新工作目录恢复记录

`cleanroom-875-partial.json` 记录了一次真正的独立本地 clone（`git clone --no-local --no-checkout`，checkout 固定提交 `875a2ea0d7827282783c7be9a540315c4de9f645`）。它未复制旧 build、exports 或有效成功 receipt；170 份提交中自带的历史构建凭据先移到工作目录之外保存，仅保留必需 DataX recovery 证据。同一台机器共用现有工具链；没有 `.runtime/prior`。因此应称“新工作目录恢复”，不能称“全新机器复现”。

从原 SWF 实际重新生成了 164 份 inventory 与脚本/素材导出；163 个素材 SWF 的脚本/动作检查、761 XML bin 解析全部通过。Main、DataX 与 Map0、Enemy5、Enemy16、Enemy1、一件装备的七模块闭环均完成深检查；新目录 Map0 的 20 按钮四态加 Enemy5/16 两根帧，共 82 张画面与原版逐 RGBA 相同。Main 类声明差异只重复既有已记录差异，没有新增遗漏。

随后原计划继续全资源队列；由于固定旧提交已被证明含反编译语义缺陷，明确转为优先修正版全包，在 Enemy213 完整成功并记录后停止旧队列。实际新编译成功 **33/164**（Main、DataX、31 资源），不是全量成功，也没有完整严格组装或游戏运行验收。全部文件保留在 ignored `reverse/build/cleanroom-20261024-015725/`，无删除；source/tools 与固定提交无 diff。需要继续该旧基准时可在其 workspace 执行 `rebuild_project.py build resources`，然后 audit/assemble，但不能将旧基准与最新语义修复混称为同一世代。

新目录输出与原目录不保证二进制相同，代表模块结构/画面及同目录重复编译分别验证；不能把换路径后新的 ABC 私有标识符当作业务语义等价的完整证明。最新业务副本修复与其新产物验收见 `semantic-copy-repairs.md`。

## ABC 来源与历史包的区分

只读检查 `reverse/manifests/output-abc-origin-snapshot.json` 对当时最新 164 个候选输出实际解析全部 DoABC，并去掉 flags/name 后，与全部 164 个原 SWF 的 ABC payload 哈希集合比较：**0 个完整原始 ABC 块匹配**。每份输出同时核对实际 SWF SHA 与其 receipt，并记录构建世代。此快照不意味着各模块都已完成同一轮 recipe 更新；完整交付仍须严格 assemble 与当前输入指纹检查。

两份保留的历史 `runtime-all-rebuilt-*` 组装记录均为 164 个 `source_rebuilt`、0 fallback，实际文件哈希及 ABC 检查通过。但早期 `runtime-partial-20261023T165516.854628Z` 明确为 2 rebuilt + 162 original fallback，仅为历史混合实验包，排除在“全源码重建包”结论之外。不能把它写成无原始代码的产物，也不能把历史全包的成功直接移用于新 keep-trace 世代。

全块哈希比较排除了原 ABC 原样整块搬入；它本身不证明没有任意字节码片段复用。更完整的来源依据还包括编译输入账本、真实 Flex 调用、无脚本素材容器审计和 recipe 代码。可使用 `python reverse/tools/audit_output_abc_origin.py` 重做此只读快照；不会重新编译或启动游戏。最新 Main／非 Main 语义修复统计与证据边界见 [语义修复摘要](semantic-copy-repairs.md)。
