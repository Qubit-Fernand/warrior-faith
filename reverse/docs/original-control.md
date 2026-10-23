# 原版隔离运行对照包

2026-10-24 已准备 `reverse/build/runtime-original-control/`，**没有启动播放器，没有访问或修改实时存档，也没有运行 fixture 种子脚本**。

这是原版的存档隔离补丁，不是源码重建；用途是与源码重建版本进行运行对照。

## 包含内容与唯一修改

基于 `reverse/manifests/original-files.json` 中 166 个原始文件：164 个 SWF 和 2 个 Windows 附带文件。先检查所有原始 SHA-256，再复制到独立输出目录。

只把主程序 `3_L4399Main_gamefile.swf` 的 ABC 字符串池第 8917 项从 `yzlr2_saves` 改为 `yzlr2_original_probe`：

- 替换字符串长度由 11 增至 20，净增 9 字节。
- 正确更新 ABC 字符串的 U30 长度、DoABC 标签长度、SWF 头部总长度。
- 不改变字符串池索引，不重新编译或修改方法指令。
- ABC 中除这一字符串记录外的前缀、后缀逐字节一致。
- 全部 7,147 个方法体的哈希、方法元信息、类和脚本声明保持一致。
- 46,171 个递归标签中仅该 DoABC payload 变化，其余标签 payload 全部一致。
- 其余 163 个 SWF 和 2 个附带文件全部与基线 SHA-256 相同。

主程序校验：

```text
原始 b362fd3035995e63998de714cec9eb2fbe5216b4ee078182d48e30f5e1474b32
对照 77ba138c038cb454d2324149d9afe1b99fcbdaeb69ce96ffe03eb107b27273f9
```

完整收据在输出目录的 `control-manifest.json`。还验证了同一输入再次生成的字节完全一致，以及一个 130 字节新名称跨越单字节 U30 长度边界的内存测试；后者没有写入文件。

本轮检查了全部 164 个 SWF 对应的 ABC 字符串清单，精确的 `yzlr2_saves` 仅出现在主 SWF。导出源码 `src/LocalSaveManager.as:10,25` 对应 `SO_NAME` 和 `SharedObject.getLocal(SO_NAME)`。未改动在线接口、剧情、战斗数值、键盘事件、地图或资源加载。

## 重新准备

```sh
cd ~/Games/勇者的信仰-逆向
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/original_control_prepare.py
```

工具拒绝基线哈希变化，拒绝覆盖已被修改的对照文件。输出必须在忽略的 `reverse/build/` 下。默认名称是 `yzlr2_original_probe`，可以用 `--name` 指定另一个测试名称，但禁止原版、终章等受保护的现有名称。

该命令不启动游戏；之后测试时应通过对照目录中的主 SWF 打开，不能误用相邻原版启动器。

## 存档 fixture：脚本已提供，但尚未运行

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/original_control_seed.py \
  --source presets/毕业体验档.sol \
  --name yzlr2_original_probe
```

默认只在 `reverse/build/runtime-original-control/fixtures/` 写出 `yzlr2_original_probe.sol`。这个位置不会自动被 Flash 读取；准备文件和安装为实时测试存档是两个步骤。

如果根任务已确认测试播放器的实际 SharedObject 目录，可用 `--directory '/明确选择的目录'` 安装。脚本不会查找或猜测当前播放器目录，不会自动读取个人实时存档；源文件默认是仓库预设。目标若已存在，直接失败，不覆盖。

种子转换只修改 SOL 头部的存储名称、名称长度和文件长度，**AMF3 payload 字节完全保留**。它输出原/新摘要及不变 payload 摘要，便于原版和重建版使用同一角色初始状态。脚本目前仅通过语法检查，尚未执行种子写入或验证 Flash 能加载它。

## 对照观测：尽量少介入，双方一致

推荐分两层，先保留一轮没有额外 wrapper 的对照：

1. 同一播放器版本、同样的窗口大小和输入步骤，拍摄启动、村庄、普通关卡、Boss、技能、任务等可见状态。退出游戏后只读取明确测试名称对应的 SOL，比较角色/任务/物品等保存字段。预先固定 fixture 摘要，记录测试存档名称及实际路径，不能把随机掉落和随机伤害当作严格逐帧相等。
2. 如果需要坐标、HP、地图号、异常事件等机器可读快照，可给双方加载**同一个编译产物**的独立观测 wrapper。它以相同 ApplicationDomain 策略加载同名游戏入口，按同一节奏读取已存在的公开静态字段；异常处理监听只记录，不阻止默认事件，不吞掉异常。日志写另一个明确测试专用 SharedObject，不能写角色存档或调用 Save/Loading/技能方法。

第二层只是建议，尚未实现或运行。Wrapper 会改变加载关系和额外事件开销，即使双方一致，也需要先确认它没有引入只在测试中出现的行为；不能把“读字段”直接宣称为完全无干扰。避免改变 stage.frameRate、拦截键盘、创建覆盖游戏区域的交互控件、修改全局 `mm.cfg`。

数据记录至少注明：目标 SWF 摘要、对照/重建标识、播放器版本、fixture 摘要、场景步骤、游戏时间/采样顺序、异常原文，以及哪些字段未就绪。未能取得的字段记录 unknown，不能转成 0 或假通过。
