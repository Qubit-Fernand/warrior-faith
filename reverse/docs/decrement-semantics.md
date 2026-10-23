# 五个方法中的减一语义复核

结论：此前按opcode数量标出的五个方法包含七处 `pushbyte 1; subtract` → `decrement` 替换。对这七处局部表达式，原操作和重建操作均执行Number减一，未引入int32截断、自减写回或额外求值。现有证据支持它们是合法的编译降级选择，不是已发现的反编译算术错误。**这不证明五个完整方法的控制流、属性绑定或游戏行为等价**；下文保留边界及未运行项。

## 固定输入与复现

本次选择保留的 `reverse/build/main-probe/run-39691ycz/normalized.swf`，SHA-256：`96ce6635d3ad0868d83f0fcbe74890a3ef7dedbcf4046d5619b417a0b7b458ba`。工作目录的 current main 已是928e…，本报告不把96ce结论无条件转移到后续版本。

只从96ce重新导出 `src.Player` 和 `com.hotpoint.braveManIII.models.equip.Equip` 的P-code，输出在 `reverse/build/decrement-audit/rebuilt96ce/scripts/`；两份均与此前 main-audit/rebuilt 文件逐字相同，SHA分别为 `41dd96a20c7456efeec386254e87f54274502fc59ef715a55ca758dc3b12ec2f` 和 `fda0eae59ec5d448da96ac2a97697928f4ff17072ad16523a5cbbd939af851bb`。原版P-code仍用此前 original 样本，原始文件SHA和每处原文上下文进入新清单。

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/audit_decrement_semantics.py
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/build_decrement_harness.py
```

第一条生成 `reverse/manifests/decrement-semantics.json`，固定五个方法、七个位置，保存完整未简写的指令上下文、文件哈希及19个预期数值向量。它验证原push1/subtract连续且中间没有跳转标签；不是通用符号执行器，不通过忽略所有控制流差异来制造“相等”。第二条仅编译和检查独立探针，不启动播放器。

## 为什么Number减一相同

Adobe的 [AVM2 Overview（2007原规范镜像）](https://burgerlib.readthedocs.io/en/latest/avm2overview.pdf) 的 decrement/subtract条目定义：普通decrement先ToNumber再减1；普通subtract把两操作数转Number再相减。右操作数已经是常数1，因此这两个局部栈变换均为 `x → ToNumber(x)-1`。与此不同，`decrement_i` 是int32路径。指令编码及Number/int区别亦可核对 [FFDec作者指令表](https://jindrapetrik.github.io/as3_pcode_instructions.en.html)。本例没有使用 `_i` 版本。

所有七处的左操作数都来自既有Array.length或数值局部/参数；读取和方法调用仍先于减法，原常数1不具有可观察副作用。原push1/subtract之间没有跳转入口，不存在从中途跳入而改变栈状态的证据。重建decrement只改变栈顶；有些编译出的其他循环自减会另外setlocal，但不能把那些写回与此七处混为一谈。

## 精确七处

以下源码均位于 `reverse/source/3_L4399Main_gamefile/`。P-code行号为 `reverse/build/main-audit/{original,rebuilt}/scripts/` 下相应文件；重建与fresh96ce逐字一致。表中local编号是字节码寄存器，和FFDec的AS局部变量命名不必相同。

| 方法/源码位置 | 原→重建P-code行 | 操作数及后续用途 | 局部结论 |
|---|---:|---|---|
| Player.runPower，src/Player.as:2193 | 9237→9641 | `runArr.length - 1`；runArr声明为Array（264），结果coerce_a并存入扫描索引；原local9对应新local5 | 空数组0得到-1；不是uint下溢成最大值 |
| Player.runPower，2210 | 9302→9715 | `param3 - 1`，param3为int；getlocal3后减一，继续multiply/divide，组成第一个位移系数分母 | 不写回param3；没有convert_i，结果保持Number |
| Player.runPower，2211 | 9321→9734 | 同一子表达式用于第二个系数分母 | 同上；两个param3读取各自保留 |
| Player.MoveData，2218 | 9377→9791 | `int(runArr.length - 1)`；减一结果随后传给int调用 | int转换在两版都位于减一之后，未提前截断 |
| Player.MoveRun，2282 | 9652→10065 | `_loc5_ - 1`作为MapData.hitTestPoint第二参数；原getlocal5，新getlocal12；随后pushtrue、callproperty | 只计算探测坐标，没有把y位置减一写回 |
| Equip.setRemainingTime，models/equip/Equip.as:361 | 1796→1804 | 解析月份 `_loc8_:int` 减1；原getlocal8，新getlocal9；随后读取日并constructprop Date(3) | 保持Date所需的零起始月份；月份变量不变 |
| Equip.setSysTime，同文件:389 | 1929→1927 | 同样的月份int减1；两版getlocal8；随后读取日并构造Date | 同上；不涉及改变Date时区或历法算法 |

runPower的两个系数是 `paramN*(1-parabola)/(param3*param3-param3*(param3-1)/2)`。原 `1-parabola` 和外层减法仍是subtract；被替换的只是在该公式内的 `param3-1`。param3≤3分支在公式前返回；局部算术边界探针不把负param3当作真实公式路径可达输入。

MoveRun的 `_loc5_:*` 虽标为动态类型，进入该段时以 `int(this.y)` 初始化（2266），后续只进行加减数字。原字段/局部读写的namespace形式仍有更广泛差异；这里核对的是已读取数值的减一和传参，不据此证明hitTestPoint绑定等价。

Equip两方法从日期数字字符串的第4–5位取月份并转int（355–359、385–389），随后减一交给Date。正常月1和12分别变0和11；非法日期的规范化、时区、夏令时以及“按24小时计算剩余天数”的原有逻辑没有在本轮执行。setSysTime中原setproperty/新initproperty的局部之外差异也未被本次算术证明覆盖。

## 已有循环自减不是新发现的减法变化

原五方法中另有 declocal 等循环索引操作，重建常变为 `getlocal; decrement; coerce_a; setlocal`。这也是Number路径的表示差异，但不是上述减法计数减少的七个位置。MoveData的 `--runArr[index][2]` 在原P-code已是decrement；它不是重建新增的自减。本报告没有把这些周边操作全部纳入等价证明。

## 可证伪数值探针：已编译，未运行

源文件 `reverse/experiments/decrement-harness/DecrementHarness.as`，产物 `reverse/build/decrement-harness/DecrementHarness.swf`，SHA-256为 `10a0c1e47f913d5925c879ccdf0872155dfc92c90b73c52363cdc9cfffbc46ae`。build.json保存编译命令、源/输出/P-code哈希及关键方法指令。编译产物仅含DecrementHarness类；没有SharedObject/getLocal/Loader/URLLoader/URLRequest引用，也不接入游戏目录或SO。

探针对比两条真实不同的编译路径：`value - one()` 编译含subtract，`--value` 编译含非 `_i` 的decrement，构建器断言这点，避免优化器把两侧都变成同一个opcode。one()为只返回常数1的纯方法，用于保留subtract；因此它是局部AVM算术测试，不是原游戏方法的复制运行。

19个向量覆盖±Infinity、NaN、±0、小数、Array.length代表边界、int32两端和2^53。比较包含NaN判等与零符号检查。额外断言 `-2147483648 → -2147483649`；若误用int32减法则可能得到2147483647，能暴露不同降级。源码中的Number输出预期不等于运行结果；清单里主机IEEE-754计算也只是预期向量。

由根任务另行打开这个独立SWF时，屏幕和trace显示逐项结果及Failures。当前只完成编译和P-code验证，**未有AVM执行结果**。即使探针全部通过，也只验证播放器这两个opcode的数值行为，不证明碰撞、运动曲线、装备到期业务完整无差异。

因此可以将之前“七处算术可能因减一降级改变语义”的疑点收窄为：局部Number操作有规范与实际操作数/用途证据支持等价；五方法全CFG、属性绑定、实际运动和装备日期回归仍需要自己的证据。游戏源码及原资源未修改。
