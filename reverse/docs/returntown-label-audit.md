# 返回城镇“站立”标签错误的原版对照

2026-10-24 主任务在严格全重建包 `runtime-all-rebuilt-20261023T175702.006475Z`（Main928e）机械试验场战斗后选择系统→返回城镇，Debugger报ArgumentError #2109，栈包含 MovieClip.gotoAndPlay → src.Skin.GoTo → src.Player.信春哥 → 一起信春哥 → Play_Interface.回城。截图 `reverse/logs/runtime/latest928e-returntown-error2109.png`，SHA-256 `40525377c12543a67f7e62363584da72bbf33ece85fc65fef31f8f06fb44a1cf`。本子任务只读取SWF/源码，没有运行游戏或改canonical/运行包。

## 静态结论

原版就存在 `skin.GoTo("站立",1,true)` 调用，而原版和重建版 `Skin_player0` 均没有“站立”帧标签；两者都有第25帧“站”。角色动画标签和场景数据未显示该标签在重建中丢失。**最新运行对照：主任务在原版direct control、同毕业fixture、机械试验场一星、J连击17/HP48081后，系统→返回城镇成功，无异常；重建失败时HP32552。不能认定为原版已确认bug。两次即时状态不同；后续定位到原版SWF9与重建SWF14的兼容语义差异，见下节，尚待独立运行验证。**

| 项目 | 原版 | 严格包重建版 |
| --- | --- | --- |
| PlayerMc_X0_v10 SHA-256 | e287f98fe64962cedd92c0596b0fdcfb72d661c5fc846c13a17e2a3a52008ee5 | 5c472109099fbb2604f018634c1930164a310da1a8c80e5afbf786f5f6c5b4f3 |
| src.Skin.Skin_player0 character ID | 233 | 246 |
| 总帧数 | 413 | 413 |
| 帧标签 | 21个 | 21个，名字及帧号逐项相同 |
| 站 | 第25帧 | 第25帧 |
| 站立 | 不存在 | 不存在 |
| DefineSceneAndFrameLabelData | root第0帧“场景 1”，标签表空 | 相同 |

动画标签顺序：走、跑、站、跳、被打、攻击1、攻击2、攻击3、攻击4、跑攻、上挑、下斩、转职技能1–4、技能1、技能4、技能3、技能2、怪物技能。标签数据直接解析SWF标签43；场景数据直接解析标签86，未依赖反编译出来的AS推断。角色Sprite的其他控制payload哈希并非全部相同（character ID重排等也会影响它们），本审计不据此声称整个Sprite字节相同。

原版主SWF的FFDec P-code `original/scripts/src/Player.pcode:1121–1125` 明确出现 skin、pushstring "站立"、pushbyte1、pushtrue、callpropvoid GoTo,3；重建主SWF同样出现该参数序列。原版 `Skin.pcode` 的 GoTo 方法先按第三参数设置stopRun；在CanGoTo允许后把参数写入runType并以一个参数调用gotoAndPlay(runType)。没有把“站立”改写为“站”的分支。对应可读源码 `Player.as:388`、`Skin.as:328–391`。

`src.Skin.Skin_player0` 继承 `src.Skin`，当前可读类只添加9个震动帧脚本，没有覆写GoTo/otherGoTo，也没有额外生成“站立”标签。错误文本中的“场景站立”不能反推SWF实际存在这个场景名；二进制场景表只显示上表内容。

## 证据和复查

运行 `/opt/miniconda3/envs/Qubit/bin/python reverse/tools/returntown_label_audit.py`，只读原版与固定175702包，导出指定两类的P-code，不启动播放器。报告位于 `reverse/experiments/returntown-label-audit/timeline.json`；完整P-code和命令日志在同目录original/rebuilt；`pcode-evidence.json`保留原始语句、行号和文件哈希。未来修改资源后应重新运行，不能把本结论推广到未检查的角色皮肤或其他版本。

## 原版成功后的分支复核（进行中）

Player.信春哥的原/新P-code均检查对象存在性 deadX && skin && skin_Z && Boolean(skin_W)，不检查deadX.visible或HP。一起信春哥先把deadX.visible设false后仍调用该方法。Skin.GoTo原/新均在param3=true时设stopRun=true；进入gotoAndPlay还需runType不同、CanGoTo允许。没有发现param3分支反转。

get_Skill_Id_and_LV在两边都对不存在于skillArr的“站立”返回[-1,-1]；CanGoTo只拒绝level==0，再交给parent.CanSkill；Player.CanSkill在SkillFactory没找到技能时返回true。不能用“不是技能所以必定被拒绝”解释原版成功。完整原始P-code和便于阅读的逐方法切片留在证据目录；切片仅缩写名称显示，不作为QName/namespace完全等价证明。

现有静态路径下，若四个对象存在、当前runType不是“站立”、SkillFactory没有type=-1/level=-1条目，两版都会尝试不存在的标签。仍需验证回城时实际runType/skin引用、进入的对象/类、是否中途重建皮肤，以及播放器异常处理状态。不可为消除提示直接把标签改成“站”，这会绕过尚未解释的运行差异。

## SWF版本兼容线索：原9／重建14

原Main与仅改存档名的control均为SWF9，重建928e为SWF14。三者都没有EnableDebugger、EnableDebugger2、EnableTelemetry标签，不能用“只重建版带debug标志”解释差异。FileAttributes原/控制为0x48，新为0x08；ScriptLimits原/控制为递归256、超时60，新为递归1000、超时60。完整字段直接从原件读取，见debug-flags.json。

[Ruffle自己的MovieClip兼容实现](https://raw.githubusercontent.com/ruffle-rs/ruffle/e092c78c26fa419d1ebf8601c9a0a9b761638e94/core/src/avm2/globals/flash/display/movie_clip.rs) 在goto_frame中使用caller_movie_or_root版本分支：>=11时不存在的标签抛2109；旧版本缺标签返回0后进入至少第1帧。代码还明确错误信息把帧标签字符串重复用作场景名，吻合本次“场景站立”而SWF并无此场景的现象。源码本地快照及SHA/commit见version-compat-source.json。**这是第三方兼容实现支持的强线索，不是已在本次Adobe播放器上完成的A/B证明。**

这可同时解释原新业务CFG相同、原新都缺“站立”、却只新版本报错。修复方向应先隔离验证原SWF版本/兼容语义，而非直接改“站立”为“站”。原version9缺标签可能跳第1帧（本角色为“走”），改为“站”也并不保持原动作语义。降低version也可能影响其他API可见性或VM兼容规则，正式构建若调整版本必须重走启动、加载、战斗、回城、保存等验收；当前未修改任何游戏包。

回城Play_Interface/Main.Loading/Load.Open原新P-code调用序列已另外核对，入口顺序相同。原/新都先安排加载，再一起信春哥，再关闭菜单/更新成就任务；没有发现“原版根本不调用复活”的静态差异。

## Header9隔离探针（Adobe回城实测通过）

目录 `reverse/build/runtime-header9-probe-20261023T182311.123031Z/`，复制175702的全部164个SWF，只把Main/DataX第3字节的version14改为其原件version9。新Main SHA `2ef0f7f727b20333ace8bef046acdb5c73caac0853bc02341a83adc5bb754b1a`；新DataX SHA `05edda0bfbc0ded7bf046502152d445040305e626c21007f61984d0c4db1d8cb`。压缩签名和后续字节完整保留，不重压缩；解析后的全部SWF body、全部ABC哈希都不变，另外162文件完全不变。逐文件before/after摘要、版本及精确改动偏移见compatibility-probe.json。

这是header兼容实验，**不是源码重新编译，也不是strict assembly验收包**；未复制assembly.json，state明确experiment_unverified。它沿用基包的独立测试名yzlr2_rebuild_probe，无任何SOL读取/复制/写入；测试不能与基包同时运行。生成工具compatibility_header_probe.py不会启动播放器。

Main/DataX ABC均为major46/minor16，header补丁不改ABC。Main完整710个原/新P-code单元opcode名称集合无新增；DataX原292/新293单元新增名称callsuper、convert_s，它们未出现在本次原Main/DataX集合中，但都已列在Adobe 2007年5月《AVM2 Overview》的基础指令规范：callsuper=0x45，convert_s=0x70，非新版本专用opcode。规范原文镜像：https://jmendeth.com/snapshot/aa45ee3f904d62505f09ef2969d1885e8844859f/media/2014-05-17-reverse-engineering-flash/avm2overview.pdf 。完整清单与逐P-code哈希见opcode-census.json。这里没有发现需要新AVM2 ISA的指令证据；但指令集合不能证明API可见性、版本相关行为或整个程序等价，必须实际运行。

## 正式构建的最小方案（recipe已应用，尚未新编译）

若Adobe探针回城通过，Main可在build_main.py调用normalize之后、记录output_sha256和finish之前，读取原SWF的version并只替换新SWF byte3；DataX可在datax_build.py的normalize/restore_root之后、ABC/绑定检查及output_sha256之前做同样处理。记录version_before/version_after、原件SHA、除byte3外全部字节和ABC不变的检查。最终receipt output hash必须是恢复版本后的新文件，实际重新编译产生新input generation，不能追认旧receipt。

不建议先改共享probe_normalize_swf.py，因为它是全部162资源的指纹依赖；可在Main/DataX各自recipe内加入同一短小、明确校验的步骤，局部重编译两模块。162资源已经由root_timeline恢复各自原版header，应另做版本清单核对。编译器保留现有playerglobal及编译参数，版本恢复针对运行兼容规则；不是把所有现代库API保证变成FP9可用。尝试compiler -swf-version=9也可作后续独立实验，但不能未经输出核验就假设其与已验证header-only实验等价。探针通过后已按主任务指令最小修改两个正式recipe；尚未编译，不会为旧receipt追认新输入。

## Adobe实测闭环与已应用recipe

主任务确认三组结果：原版SWF9 direct control战斗后回城成功；Main928e/DataX02ab的SWF14严格包相同操作报2109；164文件包只修改Main/DataX版本字节为9后，机械试验场战斗及系统回城成功，无2109。成功截图 `reverse/logs/runtime/header9-returntown-success.png`，SHA-256 `fcd126085ffa190ab759ce981bd0eeacb6279a1efcf42ab4ac8256ff01037d01`。两文件同时改版本，未独立拆分哪个文件单独足够；因此严格因果范围是“这两处version恢复消除了本轮回城回归”，调用者版本解释另由Ruffle源码支撑。

build_main.py和datax_build.py各自加入preserve_original_swf_version：从对应原件读取版本，在最终normalize/根恢复之后、最终输出SHA及finish之前仅写byte3；复核文件其余字节和解压body完全相同。receipt新增swf_version_compatibility，包含原件SHA、前后SHA、版本、改动偏移及ABC/body不变依据。两个recipe本身已在各自capture的build_recipe集合中，原SWF也已是原输入，所以现有指纹机制覆盖这次规则。共享normalizer、canonical源码、旧receipt和immutable包均未改动。

在独立临时文件上执行两套helper，分别精确复现已实测探针Main2ef0/DataX05ed的完整SHA，第二次调用幂等且changed_offsets为空；见recipe-header-check.json。仅该局部函数检查，没有调用编译器，也不能宣称新正式构建已生成。Main其他循环修复和非Main修复完成后由主任务统一重新编译。

## FileAttributes与ScriptLimits的剩余差异（未改）

Main原0x48、新0x08差异仅UseDirectBlit=1→0；ActionScript3=1、UseNetwork=0都相同。Adobe [SWF规范](https://open-flash.github.io/mirrors/swf-spec-19.pdf) 定义该位为硬件blit，注明最低SWF10并影响独立播放器；原文件却标SWF9，因此不能未经实测假定保留此位在Player32的精确效果。它值得单独审查渲染/性能一致性，但不是本次只改version即消失的2109所必需的修复，不在这一补丁中盲改。

Main ScriptLimits原递归256/超时60，新1000/60；DataX原无ScriptLimits，新加入1000/60。规范描述递归/脚本超时保护，原缺省递归为256；这会使深递归出错阈值不同，不等于已发现正常玩法变化。若后续目标要求执行环境完全复原，可另做保留原root标签/删除额外标签的独立审计；本次不把它混入已经验证的header-only变化，也不提高阈值掩盖循环缺陷。
