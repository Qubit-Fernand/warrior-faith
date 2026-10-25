# DataX 巨型 XML 恢复与全模块源码构建

2026-10-24：`DataX_v76.swf` 已从 canonical ActionScript 和不含脚本的资源重新编译出候选 SWF。**构建通过；本子任务没有单独启动播放器。主任务已在完整164模块包中实际验证DataX初始化和采样玩法，见下述运行证据。** 当前修复版 SHA-256 为 `02ab9b45c2310ffb79b2e84a1ba0d70da53b24f40a1a4a57f1148813a3ce5def`。旧 `f2435311…` 版本使用有风险的完全限定动态引用，已被当前版本取代，不能作为正确绑定的构建。本文没有把静态源码恢复或编译成功当作实际玩法验证。

## 当前产物与复现

```sh
cd ~/Games/勇者的信仰-逆向
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/datax_build.py
```

- 最终候选：`reverse/build/datax-recovery/DataX_v76-rebuilt.swf`。
- 修复后的完整编译源：`reverse/build/datax-recovery/full-source/`。
- 默认可编辑源码：`reverse/source/DataX_v76/`，也可传 `--source-dir`。
- 原始 11 份 XML 的可编辑归档：`reverse/source/DataX_v76-config/`，常规构建不自动覆盖 AS，操作方法见下节。
- 独立恢复的 `src.InData`：`reverse/build/datax-recovery/source/src/InData.as`。
- 关键恢复工具：`reverse/tools/datax_recover.py`；可单独运行，不调用 FFDec、不执行游戏。
- 当前报告：`reverse/experiments/datax-recovery/build-full.json`。
- 原始 ABC 到 XML/方法的映射：`reverse/experiments/datax-recovery/recovery.json`。
- 每次构建报告与完整编译日志分别在 `reverse/experiments/datax-recovery/build-*.json` 和忽略目录 `reverse/logs/datax-recovery/`。

编译源取自 canonical 目录，`_assets` 从完整导出目录暂存；工具只在构建目录应用兼容性修复，不改原始导出或相邻游玩目录。原始 ABC 不复用；20 个资源文件（19 个二进制数据文件、1 个素材 SWF）保留资源字节，素材 SWF 已检查没有 AS2/AS3 脚本标签。

固定路径的 `full-source` 用于稳定 Flex 文件私有命名空间。每轮先把整个旧目录移动至唯一 run 目录归档，再完整复制当前源码，所以删除的类不会残留。编译 SWC、原始及规范化 SWF 也写入本次唯一 run 目录；必须 exit=0、日志没有 `Error:`、产物确实存在且通过后续核验，才更新稳定候选路径，避免 compc 返回 0 后误用旧文件。

## 源码与 XML 编辑入口

`datax_source.py bootstrap` 已显式执行一次：确认 canonical InData 与本轮 FFDec 导出字节一致后，把它迁移为已证明等价的 `new XML(字符串)` 版本，并逐字节导出 11 XML。迁移前原件在忽略目录保留，完整原始 AS 也可从 Git 提交 `8d5450e` 恢复。迁移报告为 `canonical-migration.json`。正常 `datax_build.py` **不调用 recover，也不覆盖 canonical InData**。

直接修改 `reverse/source/DataX_v76/src/InData.as` 会进入后续构建。如偏好独立 XML 文件，编辑 `reverse/source/DataX_v76-config/*.xml` 后显式运行：

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/datax_source.py import-xml
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/datax_build.py
```

import-xml 仅替换当前 InData 中对应 11 个 JSON 格式字符串字面量；不重新生成整个类。它解析 XML、归档修改前 AS，并检查所有字面量之外的源码完全一致。合成测试往 Loading 加入自定义逻辑，再只改 EquipXML，确认自定义逻辑和其余十份 XML 保留（`xml-import-check.json`）。若方法改成未知表达式，工具拒绝，不猜测覆盖。

当前构建验证器仍要求 InData 保持原始 factory／属性／回调／Loading 顺序模板，XML 字节内容可变化。报告会分别标记“编译常量匹配当前 canonical AS”与“仍等于原版 XML”。改变这些方法的逻辑会触发验证失败，需要审查并扩展验证器；不会静默恢复为原方法。

## 巨型方法不是复杂计算

旧导出因超时给 `InData.EquipXML` 写入了占位异常。本轮 root 的 FFDec 全量导出已成功，耗时约 4 分 2 秒；其 `InData.as` 为 2,846,617 字节，没有该占位符。为了不依赖反编译器处理巨型 E4X 的性能，另建立了直接从 ABC 恢复的确定性路线。

原始 `src.InData` 位于 ABC 类索引 191。`EquipXML` 是方法 3428，**字节码仅 16 字节**；其余十个 XML 方法均为 23 字节。它们只是：

1. 获取一个 Factory 类。
2. 取 ABC 字符串常量，构造 XML。
3. 设置 Factory 的 XML 属性。
4. 部分方法调用对应 Factory 的初始化函数。

脚本验证整个方法体、参数个数、返回指令、没有多余指令、异常处理器及 activation traits，才生成 `new XML(原始字符串)`。遇到未知结构会失败，不使用空实现或占位符。

特别保留了原始行为：**`EquipXML` 没有调用 `creatEquipFactory()`**，不能凭常识补上。`Loading()` 的调用顺序也从其全部字节码恢复，包括 Equip 后调用 Suit、再调用 Gem。

| 方法 | 原始常量索引 | XML 直属记录数 |
|---|---:|---:|
| EquipXML | 5730 | 1392 |
| GemXML | 5731 | 242 |
| SuppliesXML | 5732 | 25 |
| SkillXML | 5733 | 702 |
| SkillConditionXML | 5734 | 265 |
| SuitXML | 5735 | 30 |
| GemProbabiltyXML | 5736 | 135 |
| GoldXML | 5737 | 62 |
| QuestXML | 5738 | 40 |
| OtherXML | 5739 | 139 |
| makeXml | 5740 | 55 |

总计 11 个 XML、3,087 条直属记录、2,843,857 个 UTF-8 字节。每份 XML 均通过 XML 解析；全部与本轮 FFDec 导出的 XML literal 匹配（比较时只统一文本换行）。最终编译产物里的 11 个 XML 常量则是**字节级摘要完全相同**。

不仅比较字符串是否存在：`verify_compiled_indata` 还解析编译后 11 个方法及 Loading 的完整指令模板，确认 Factory QName、XML 摘要、属性、回调名称、参数个数及调用顺序都一致。Flex 将部分 `getlex` 编译成 `findpropstrict/getproperty`，将丢弃结果的调用编译成 `callproperty/pop`；验证器检查这些实际形式，不要求原始字节码逐字相同。

## 全模块编译修复

编译输入包含 292 个导出的 `.as` 文件，使用 Flex 4.16.1 `compc`，只有 playerglobal 作为外部库，**没有链接原始 DataX ABC**。

- `Player.as` 两处及 `Player2.as` 一处孤立 `{};` 改成空语句 `;`，保留空分支。
- ShopFactory、XingLingFactory、Shop_LiBao2 和 Shop_LiBao 显式导入 `com.hotpoint.braveManIII.Tool.XMLAsset`，保留短名 `XMLAsset.createXML`；`src.tool.*` 在两个 factory 展开为实际用到的 TiaoShi，在两个礼包面板中移除。旧完全限定写法在主程序实测出现 `ReferenceError #1065: com undefined`，不可沿用。
- 每次 DataX 构建完成后使用 FFDec 新导出上述四类 p-code，核验六处 XMLAsset 的 getlex/findpropstrict 都含 Tool 命名空间、没有冲突的 src.tool 命名空间，并拒绝动态根名 com 的查找。p-code SHA-256、行号、指令文本及命令都写入本次构建报告；这是实际编译结果证据，不只是对 AS 文本的检查。
- `strict=false` 保留动态引用/转换，不为满足静态检查制造成员和函数。
- 使用共享 `probe_normalize_swf.py` 修复经过 ABC 解析确认的 7 个中文 DoABC 名称长度错误，并清零 ProductInfo 时间戳。没有复制原始 ABC。

原始 ABC 有 294 条类记录（293 个不同显示名称）；重建输出有 295 条类记录：

- 291 个原始非文件私有类的名称保持一致。
- `ArrayTweenInfo` 及两份 `PrivateClass` 被 Flex 编译为带文件私有命名空间的名字；数量、父类、实例及静态 traits 已核对。
- 另外多出一个编译器生成的素材 Sprite 包装类。

这是一份类覆盖核对，不是所有方法语义等价的证明。其他类没有像 InData 一样逐方法完成指令语义验证。

## 必须恢复 document class

`compc` 的 library SWF 默认根类是生成的 Sprite，而原始 DataX 的 `SymbolClass id=0` 是 `src.Data`。其构造函数会初始化角色、飞行和装备等表；只复制 library SWF 会遗漏初始化。

构建工具先证明原始根时间轴只有一帧、没有放置/移除对象及脚本动作，再恢复：

- document class：`src.Data`；
- 舞台：640 × 400，12 FPS；
- 背景色和场景标签。

保留重建的 ABC 和素材，未复制原始执行代码。若未来输入出现根时间轴动作，工具拒绝直接套用这个修复。

## 失败路线与验证边界

1. 初始直接编译 InData 及完整依赖，因 Player/Player2 的 `{};` 语法失败。记录：`compile.json`、`compile.log`。
2. 为 class-only 语法检查临时生成原始 DataX 外部 SWC，Flex 在解析自建 catalog 时失败（`SwcScript.setABC ... script is null`）。该路线已放弃，实验脚本移至回收站，命令和日志保留在 `compile-class-only.json`、`compile-class-only.log`。它未产生成功产物，也没有进入最终全模块构建。
3. 第一轮全模块编译又暴露 `Shop_LiBao.as` 的 XMLAsset 歧义，修复后编译成功。
4. 首次类覆盖检查将文件私有类的重命名当作缺失而失败；随后通过数量和 traits 单独解释，保留原始名字差异，不简单忽略缺失。
5. 全部构建通过后还发现 document class 问题，已修复；这也说明“编译成功”并不足以证明能运行。

最终候选重复构建的归一化 SWF SHA-256 应在当前 `build-full.json` 核对。播放器加载、与主程序 ApplicationDomain 的交互、全表初始化和实际玩法均由根任务继续验证；本子任务没有启动游戏或读取/写入个人存档。

## 构建输入指纹

`datax_build.py` 在复制 staging 之前调用 `build_inputs.capture`：覆盖 canonical 整树、20 个导出素材、DataX XML 镜像、原始 SWF、recovery.json、原 ABC 及 inventory、导出 receipt、全部直接及传递本地构建修复脚本，以及 Java/Flex/FFDec/playerglobal 工具链。XML 镜像仍必须显式 `import-xml` 后才进入 canonical InData，记录镜像哈希不改变这一编辑规则。

编译、归一化、类覆盖及六处 XMLAsset p-code 检查成功后，`finish` 重扫并要求构建期间输入未变化，之后才复制稳定候选和写成功 receipt。每次真实构建生成新的 generation；旧构建不追认指纹。统一入口要求当前输入仍匹配且 post_build_verified=true。

首个真实指纹构建：`build-20261023T172550.187267Z.json`，generation `3b841305-8973-4de2-9c3b-ad9cb2257a9c`，338 项模块输入、6218 项共享工具链输入，postcheck 通过。产物仍为 `02ab9b45c2310ffb79b2e84a1ba0d70da53b24f40a1a4a57f1148813a3ce5def`，与上一实际构建逐字节一致；`fingerprint-build-check.json` 记录统一深审通过，以及外部 receipt 更新后旧诊断包的来源快照仍有效。

## 完整包运行及复现边界补充

DataX02ab 已进入主任务实际运行的完整164模块包 `runtime-all-rebuilt-20261023T171635.802067Z`（Main96ce），通过存档读取、DataX初始化、村庄、技能面板、Map1五房间/Boss通关、装备变动、任务领奖、保存及冷重启。详见 [runtime-validation.md](runtime-validation.md) 的 Full source-rebuilt package，具体测试范围/截图/主程序hash均在那里记录。02ab也进入175702严格指纹包（Main928e），该包新增运行观察继续由该日志记录。这里“本子任务未运行”不等于“DataX从未经过全包运行”，但采样通过也不代表所有XML条目、关卡、事件都覆盖。

DataX在本工程固定full-source暂存路径的已记录重复编译曾输出相同02ab字节；这不是跨目录、跨机器、跨Java/Flex环境的字节确定性保证。Flex可把暂存源码路径和编译序号写入private namespace；Main后续固定路径也出现过96ce/928e差异，详见runtime-validation和main-optimize-false文档。每次构建必须保留真实输入指纹及输出hash，迁移目录后重新验证，不能只凭“源码相同”假定产物SHA必然一致。完整包当前也有独立玩法缺陷待原版对照（如返回城镇的“站立”标签错误，见returntown-label-audit），不应把DataX成功初始化写成整个游戏无错误。

2026-10-24版本兼容修复更新：DataX构建recipe现会在normalize/根恢复之后保留原SWF9版本；原02ab的header-only实测变体为05edda0b…，与Main一起恢复版本后系统回城成功。正式recipe尚未重新编译，02ab仍是旧构建历史hash。新版本证据/局部函数幂等检查见returntown-label-audit.md和recipe-header-check.json；不得把新规则追认到旧receipt。
