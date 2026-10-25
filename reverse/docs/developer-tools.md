# reverse/tools：逐文件工具手册

[返回项目 README](../../README.md) · [文件手册](developer-files.md) · [开发指南](developer-source.md)

日常只需 `rebuild_project.py`、`datax_source.py import-xml` 和 `启动源码重建版.command`。其余多为导出、构建内部实现或历史审计／修复。以下根据当前脚本的模块文档、入口和调用链整理，记录每个文件的具体职责与副作用。

“只读审计”通常指不改游戏源码／存档，**仍可能创建或覆盖报告、P-code和缓存**。有些脚本在顶层直接执行，不支持安全的 `--help`；不应批量执行所有工具试探功能。参数以源码中的argparse为准，历史实验可能写固定位置，执行前先审阅已有文件和所需输入。没有在本次文档任务中运行修复、导出或编译。

所有命令从项目根目录以 `/opt/miniconda3/envs/Qubit/bin/python` 调用。读指定诊断SOL的脚本与不读存档的构建器分列；不要把人物实时存档传给诊断解析器。重新生成报告不会自动重新验收玩法。

## 日常构建

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [rebuild_project.py](../tools/rebuild_project.py) | 统一status/audit/build/assemble；按当前源码与receipt判断164模块是否可组装 | status/audit写报告；build编译；assemble新建完整包；不启动游戏或访问存档 |
| [build_main.py](../tools/build_main.py) | 从canonical Main构建完整AS类集，做staging兼容修复和独立保存名替换 | 写Main staging、SWF、日志与receipt；常规从统一入口build main调用 |
| [datax_build.py](../tools/datax_build.py) | 编译DataX全部类，核对InData和XMLAsset绑定并恢复src.Data根类 | 写DataX产物和build回执，不自动导入XML |
| [datax_source.py](../tools/datax_source.py) | bootstrap为初次恢复迁移；import-xml将11个配置字符串同步到InData | 会写canonical源码并归档旧InData；已有工程一般只用import-xml |
| [probe_rebuild_module.py](../tools/probe_rebuild_module.py) | 从模块AS和无脚本素材编译资源库，再恢复名字、根结构及元数据 | 写模块staging/产物/result；统一入口build精确资源名调用 |
| [probe_resource_family.py](../tools/probe_resource_family.py) | 调度162个资源模块，有界并行、模块锁和汇总 | 真实编译；jobs限定1..3；不要同时修改输入或重复构建同模块 |

## 恢复工具

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [datax_recover.py](../tools/datax_recover.py) | 按原ABC的完整方法模板恢复InData的XML字面量和Factory调用 | 写恢复产物／证据；不是通用反编译器，不用于覆盖日常编辑 |
| [swf_inventory.py](../tools/swf_inventory.py) | 读取SWF/ABC结构、类和字节来源，生成库存 | 写inventory与清单；不执行SWF |
| [export_swf.py](../tools/export_swf.py) | 调用FFDec导出script/symbolClass/binaryData或图片／音效等，记录失败和占位 | 写ignored exports/logs及导出manifest；--force可重导出，先保护资产修改 |
| [archive_sources.py](../tools/archive_sources.py) | 将各包导出的AS归档为受维护源码并记录原始来源 | 会创建source和恢复清单；拒绝覆盖已编辑源码，日常开发无需重跑 |

## 构建支撑

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [build_inputs.py](../tools/build_inputs.py) | capture/finish记录实际构建前后输入；verify检查新增、删除、修改及环境 | 库模块；写摘要缓存、锁、工具链manifest，不生成游戏逻辑 |
| [probe_normalize_swf.py](../tools/probe_normalize_swf.py) | 修正已证实的Unicode DoABC长度问题，恢复声音元数据并归零ProductInfo时间戳 | 处理新产物；不复制原ABC，不保证字节确定构建 |
| [probe_root_timeline.py](../tools/probe_root_timeline.py) | 恢复原资源根时间轴、按钮、未绑定shape及bitmap依赖，去除compc合成根绑定 | 处理构建产物并提供修复函数；不要独立批量套用未知模块 |
| [probe_source_repairs.py](../tools/probe_source_repairs.py) | 编译阶段合法化非法AS名称与无效空语句，输出后恢复AVM2运行名 | 修改staging／产物，保留原可读源；此类修复不代表可任意删逻辑 |

## 启动支撑

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [launch_inputs.py](../tools/launch_inputs.py) | 批量检查每模块完整输入，去重共享工具扫描；仅构建环境差异只报告名称 | 库模块；不编译，不因缓存省略文件成员／哈希等检查 |

## 日常运行

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [launch_rebuilt.py](../tools/launch_rebuilt.py) | 选择严格重建包，检查来源、当前输入、独立保存名及Adobe签名 | 默认打开播放器；--check只检查文件／签名并报告是否可启动；自身不读写SOL |

## 静态审计

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [analyze_references.py](../tools/analyze_references.py) | 比对资源引用、SymbolClass及配置需求，区分字面量和真实加载路径 | 读SWF/源码、写依赖审计；不执行游戏或读取存档 |
| [audit_export_quality.py](../tools/audit_export_quality.py) | 核对ABC脚本／类覆盖、错误占位、Embed和无脚本素材、帧脚本 | 写导出质量报告；覆盖不代表行为等价 |
| [audit_main_repeat.py](../tools/audit_main_repeat.py) | 比较两个实际Main构建的解析后P-code/ABC，归类私有编号等变化 | 只读原候选，写比较证据 |
| [audit_main_bindings.py](../tools/audit_main_bindings.py) | 收集选定方法P-code的名称绑定证据 | 使用预先导出的P-code；重测前需重新导出，不是实时自动证明 |
| [audit_main_namespaces.py](../tools/audit_main_namespaces.py) | 按namespace比较类声明、方法签名和script分组 | 读取inventory的ABC；私有namespace不能只按字符串合并 |
| [audit_main_pcode.py](../tools/audit_main_pcode.py) | 比较抽样原版／重建P-code并记录差异 | 使用已有导出；不宣称全程序等价 |

## 历史构建

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [probe_equipment_family.py](../tools/probe_equipment_family.py) | 串行构建equip装备模块族并保留失败清单 | 真实编译和写产物；当前完整资源优先统一build resources |

## 结构审计

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [audit_module_roots.py](../tools/audit_module_roots.py) | 核对资源根时间轴、绑定与当前receipt中的恢复证明 | 写静态报告，不启动游戏 |
| [probe_verify_modules.py](../tools/probe_verify_modules.py) | 检查指定原版／重建模块结构、声音及父级每帧渲染 | 调用工具渲染并写对照报告；不是交互玩法验收 |
| [probe_verify_equipment_family.py](../tools/probe_verify_equipment_family.py) | 渲染装备族每个关联sprite的每帧，比较原版与重建 | 产生渲染和结果；不替代装备穿戴实际测试 |
| [probe_verify_root_repairs.py](../tools/probe_verify_root_repairs.py) | 对恢复的SimpleButton状态和根placement作图像检查 | 写图像比较结果 |
| [probe_verify_asset_continuity.py](../tools/probe_verify_asset_continuity.py) | 比较根修复前后字典标签和非根绑定，证明既有装备素材保留 | 静态连续性检查，不是新的一轮运行或渲染验证 |
| [probe_verify_fingerprint_generation.py](../tools/probe_verify_fingerprint_generation.py) | 核对资源构建generation与当前输入以及历史稳定字节 | 写报告，不编译或启动播放器 |
| [audit_output_abc_origin.py](../tools/audit_output_abc_origin.py) | 检查重建输出是否直接沿用原始完整ABC块 | 写来源报告；不证明方法语义或玩法相同 |
| [export_layout_manifest.py](../tools/export_layout_manifest.py) | 从已有FFDec无脚本XML中提取Map0布局样本 | 需已有完整XML及roundtrip结果；输出片段不是完整FLA |
| [returntown_label_audit.py](../tools/returntown_label_audit.py) | 读取回城动画标签相关的时间轴证据 | 写报告，不运行游戏 |

## 历史实验

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [compatibility_header_probe.py](../tools/compatibility_header_probe.py) | 制作只改变SWF头版本的兼容性对照包 | 新实验产物，不是正式严格assembly |
| [main_optimize_probe.py](../tools/main_optimize_probe.py) | 制作两次关闭优化的Main编译，研究重复构建差异 | 真实编译隔离候选，不替换正式候选 |
| [source_editability_probe.py](../tools/source_editability_probe.py) | 隔离修改一处源码标签，证明源码修改能进入编译产物 | 写实验副本、编译产物与证据；不运行Flash或访问SOL |

## 语义审计

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [audit_ordered_comparisons.py](../tools/audit_ordered_comparisons.py) | 盘点否定比较并给选定控制流保留操作数／分支证据 | 生成定位报告，不做全局opcode翻转 |
| [audit_continue_loops.py](../tools/audit_continue_loops.py) | 用实际P-code有限fixture复核两种错误continue恢复 | 执行受限指令模型，写证据，不运行SWF |
| [audit_nonstack_loops.py](../tools/audit_nonstack_loops.py) | 对非叠加物品扫描路径执行有限P-code fixture | 受限白名单解释，不是完整AVM2；不访问存档 |
| [verify_main_semantic_repairs.py](../tools/verify_main_semantic_repairs.py) | 对新Main编译结果的24个修复方法重新导出P-code检查 | 可能运行FFDec导出并写报告；不编译游戏或运行播放器 |
| [verify_nonmain_semantic_repairs.py](../tools/verify_nonmain_semantic_repairs.py) | 验证非Main修复方法在实际新ABC中的路径与模型 | 写对应输出的证据，不运行Flash |
| [audit_nonmain_semantic_final.py](../tools/audit_nonmain_semantic_final.py) | 汇总当前非Main结果、编译trace参数与source/recipe/generation关联 | 输出固定候选的最终局部语义报告，非全程序证明 |
| [audit_decrement_semantics.py](../tools/audit_decrement_semantics.py) | 复核5个曾标记方法中的7处减一指令 | 写语义证据，不改游戏源码 |
| [audit_remaining_infinite_loop_forms.py](../tools/audit_remaining_infinite_loop_forms.py) | 保留剩余while(true)形式的有限人工控制流观察 | 静态记录，不把语法形式自动等同死循环 |
| [review_remaining_comparison_guards.py](../tools/review_remaining_comparison_guards.py) | 复现剩余比较guard人工审查的证据清单 | 静态记录，绑定当前所读文本／候选 |

## 语义修复

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [audit_ordered_copies.py](../tools/audit_ordered_copies.py) | 逐原模块检查ordered guard的操作数／效果，准备最小修复 | 有候选／应用流程，先读参数和proof；不作无审阅批量修复 |
| [audit_continue_copies.py](../tools/audit_continue_copies.py) | 逐副本核证错位continue循环并准备修复 | 有应用流程；历史已修源不要盲目重复套用 |
| [audit_nonstack_copies.py](../tools/audit_nonstack_copies.py) | 每个原模块的非叠加扫描路径证明及窄修复候选 | 有应用流程；原proof和变更范围需对应 |
| [apply_main_semantic_repairs.py](../tools/apply_main_semantic_repairs.py) | 将已审核Main补丁应用到canonical并保存前后凭据 | 必须显式--apply；已有回执拒绝覆盖，不编译／运行 |
| [repair_enemy202_nonstack.py](../tools/repair_enemy202_nonstack.py) | 修复Enemy202非叠加循环，同时保持CheckTest调用顺序 | 会修canonical并留证；按专项历史用，不作通用初始化 |
| [repair_trace_continue_copies.py](../tools/repair_trace_continue_copies.py) | 修复两个旧Achievement变体的循环控制，同时保留日志表达式 | 会修canonical并留证，不可用来删除trace |

## 语义支撑

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [nonstack_path_interpreter.py](../tools/nonstack_path_interpreter.py) | 非叠加扫描路径的受限P-code解释实现 | 库／有限fixture；未知指令拒绝，不当作完整VM |

## 业务审计

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [audit_shop_cfg.py](../tools/audit_shop_cfg.py) | 药水商店控制流、调用关系及有限购买模型 | 不编辑游戏源码；有限模型不是商店UI验收 |
| [audit_shop_amount_field.py](../tools/audit_shop_amount_field.py) | 读取原始数量输入框的实际标志／布局 | 不执行SWF，不靠字段名猜输入行为 |
| [audit_potion_npc_buttons.py](../tools/audit_potion_npc_buttons.py) | 核对原药水NPC面板按钮placement | 结构报告，不是按钮点击实测 |
| [audit_task_integrity.py](../tools/audit_task_integrity.py) | 审计任务图、前置、配置和事件调用链 | 不访问角色／播放器；新增任务后需结合真实触发验证 |
| [audit_save_network_boundary.py](../tools/audit_save_network_boundary.py) | 盘点源码中的保存字段与外部服务调用边界 | 只读源码，不读个人SOL |

## 诊断探针

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [build_decrement_harness.py](../tools/build_decrement_harness.py) | 编译独立减一算术探针并检查输出 | 生成SWF/P-code；不启动播放器 |
| [build_ordered_comparison_harness.py](../tools/build_ordered_comparison_harness.py) | 编译纯数值比较探针并保存P-code | 生成探针，不运行 |
| [build_actual_class_harness.py](../tools/build_actual_class_harness.py) | 为实际恢复类制作隔离的对照测试 | 生成探针；不运行游戏或读取SOL |
| [resource_harness.py](../tools/resource_harness.py) | 准备原版／重建资源探针包，读取专用结果并比较 | 不启动播放器；可显式读取专用诊断SOL；不包含Main/DataX |
| [diagnostic_harness.py](../tools/diagnostic_harness.py) | 构建／安装只读游戏状态观察器，或解析其诊断SOL | 写ignored隔离包；只能接受测试保存名；自身不启动播放器，parse会读取指定诊断SOL |

## 诊断读取

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [read_actual_class_probe.py](../tools/read_actual_class_probe.py) | 读取显式指定的专用actual-class探针SOL | 会读取该诊断SOL，不写存档；不能传个人角色SOL |
| [capture_diagnostic_snapshot.py](../tools/capture_diagnostic_snapshot.py) | 单次显式读取诊断SOL并保存快照／出处 | 不轮询、不改游戏或写live SOL |

## 诊断比较

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [compare_actual_class_probes.py](../tools/compare_actual_class_probes.py) | 比较实际类探针输出，排除计时值等非目标差异 | 读探针结果，写差异；不扩大为全局等价 |
| [classify_resource_probe_names.py](../tools/classify_resource_probe_names.py) | 归类资源探针中观察到的根／未命名shape实例名称差异 | 仅解释所见差异，不自动抹除未知差异 |

## 原版对照

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [original_control_prepare.py](../tools/original_control_prepare.py) | 仅改原版ABC中的SharedObject名称，制作对照包 | 生成新包，不重新编译字节码，不访问实时存档；不是源码重建 |
| [original_control_seed.py](../tools/original_control_seed.py) | 保留AMF负载，仅改变显式fixture的SOL名称 | 默认输出ignored构建目录；--directory指定安装处，已存在拒绝；会写文件 |

## REA探测

| 文件 | 负责什么 | 输出／副作用与使用边界 |
| --- | --- | --- |
| [rea_probe.py](../tools/rea_probe.py) | 调用已固定的本地REA，验证格式支持边界和字节熵 | 写日志与manifest；不执行游戏、不注册全局工具，依赖本机REA隔离副本 |

## 根目录通用存档工具

`tools/sol.py` 是AMF/SOL对象图编解码库；`create_graduate_save.py` 创建候选体验档（`--apply`才写原目标）；`import_preset.py` 执行即备份并写指定槽位；`graduate-data.json` 是创建体验档的数据摘录。这些工具不会修改游戏规则，且不会自动被重建启动器调用。

## 如何追踪一次失败

1. `rebuild_project.py build ...`：先看它打印的 `reverse/build/project/build-*/stage-*.log`，再查看对应Main/DataX/模块的receipt；不要只看有无SWF。
2. `assemble`：看audit逐模块issues；源码、非AS输入、资产、工具链、配方或环境变化都可能导致旧凭据过期。
3. 启动失败：看 `reverse/logs/launcher/`；本机App外层日志还在 `~/Library/Logs/勇士的信仰/`。先区分有播放器未退出、包过期、缺输入或签名失败。
4. 运行失败：明确是直接Main还是diagnostic wrapper、使用哪个包与存档名，保存错误和操作步骤。wrapper会改变加载环境，不能替代直接运行。
5. 修改后重新生成当前候选证据。保留历史报告的候选摘要，不把旧报告手工改成通过。
