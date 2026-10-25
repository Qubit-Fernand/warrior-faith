# Main 关闭优化后的重复编译实验

**`-compiler.optimize=false` 没有消除编译器非确定性。** 本次只做两次实际编译，没有改变正式 build_main.py、canonical 源码、固定 source staging、正式 build receipt 或任何运行包，也没有执行游戏。

`reverse/tools/main_optimize_probe.py` 读取当时 `reverse/build/main-probe/build-all.json` 的完整 command，保留 include 类集合、主文件、源码绝对路径及其余选项，仅指定两个独立输出并增加 optimize=false。首编译成功后，分析器的单 ABC 假设失败；修正为多 ABC 后直接复用已完成的 run-1 原始文件，继续第二次编译，没有为了得到相同哈希重试。

输出目录：`reverse/build/main-optimize-false-npji611t/`。两次归一化 SHA-256：

- run-1：`aa488dfe6fd3e08b28fbdbe321261d8d22948a91a6bbe75a875c3f3c6369e430`
- run-2：`0ffcda8ab8c2ef1480d9ddd36d95e9c075fdbaf1b35e40ab23cb356b32830f47`

两份均为 710 个 DoABC、712 类、7,148 方法。关闭优化改变了链接布局，优化版则合并为单个 ABC；本实验版本不替换正式候选。

## 已解析差异

- 710 个 ABC 的名称／顺序相同，全部非 ABC 标签的 payload 相同。
- 305 个 ABC 字节不同。其中 296 个只在有序字符串池的 `.as$数字` 编译器序号不同：字符串池以前的字节及池以后全部字节精确相同，没有把命名空间池合并或改写。
- 其余 9 类：AutoAlphaPlugin、EndArrayPlugin、RoundPropsPlugin、ShortRotationPlugin、VisiblePlugin、VolumePlugin、src.EnemyLife、src.Skin_ZhuangBei、src.tool.ZhuFuMC。
- 对这 9 类分别实际 FFDec 导出 p-code。仅在文本比较时忽略文件私有编译序号、将分支偏移标签对应到指令位置；剩余差异都是 script 初始化时选择目标对象的 `getscopeobject 0` 与 `findpropstrict <目标类名>`。EndArrayPlugin 还包含私有 ArrayTweenInfo 的相同变化。
- 对应 script class trait slot 从显式 1（及 ArrayTweenInfo 的 2）变成 0。忽略私有序号后，class / method metadata 一致；9 个 script initializer 的代码哈希不同，**其余所有方法体的代码哈希一致**。

这与资源代理对正式优化版 `96ce…`／`928e…` 的观察同类，但差异类数不同。可以说这对实验未发现业务方法体变化，不能宣称已证明所有运行行为等价，更不能因此改写／合并 private namespace 获得伪造的确定哈希。

## 凭据

精简记录：`reverse/experiments/main-optimize-false.json`。完整实验目录含 command、编译日志、归一化记录、ABC 清单、逐块字符串池对照、method/script 对照、9 类双份 p-code 及 diff。`audit_main_repeat.py` 没有可传参 CLI 且有固定目录写入，因此未直接运行；只复用其纯 p-code 比较函数进行只读分析，未改该脚本及原审计结果。

正式构建仍应保留每次真实产物的输入指纹和唯一 generation。字节确定构建尚未实现，不继续无界重复编译；后续若调查 Flex 编译器调度／名称分配机制，应单独记录证据并维持运行验收边界。
