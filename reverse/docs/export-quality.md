# 全量 FFDec 导出质量审计

审计对象是根目录 164 个原版 SWF，以及 `reverse/exports/<模块>/scripts/` 的本次完整导出。结果支持“类/脚本声明覆盖完整、源码已有 Embed 引用均可解析”的结构性结论，不支持所有方法、所有帧已经语义等价的结论。原始 SWF、用户存档和播放器均未被本审计修改或执行。

复现：`python reverse/tools/audit_export_quality.py`。完整逐模块、逐引用、逐调用证据见 `reverse/manifests/export-quality.json`；每个原模块、assets 容器均记录 SHA-256。164 个原模块的当前哈希均与原始 inventory 一致。

## 覆盖与资源结果

| 检查 | 结果 |
|---|---:|
| 原 ABC 脚本 / 导出 AS 文件 | 19,910 / 19,910 |
| 原 ABC 类记录 / 源码类与接口声明 | 20,158 / 20,158 |
| 缺少/额外类声明的模块 | 0 |
| 每脚本类组与源文件声明组不一致 | 0 |
| 显式反编译错误标记 | 0 |
| Embed 引用 | 2,141，全部目标存在 |
| Embed 指定符号缺失 | 0 |
| 被引用 assets SWF 容器 | 163 |
| 容器内原 ABC 或旧 AS 脚本标签 | 0，递归检查嵌套 DefineSprite |
| addFrameScript 调用 / 帧回调绑定 | 294 / 333 |
| 帧数未知、越界、缺少对应源码方法 | 全部 0 |

计数包括 `interface`，以及 FFDec 用 `§...§` 表示的合法 AVM2、非法 AS 源码标识符。197 个 private helper 类的原命名空间带有 `SkillPanel.as$164` 一类编译器 URI；只有读取 ABC 后确认 namespace kind 为 5 的名字才归一为 helper 短名。逐脚本类组也单独核对，避免只比较总量时遗漏 helper 归属。该核对不等同于证明所有 private namespace 身份完全不变；主程序的专门检查另见 `main-semantic-audit.md`。

资源检查读取 Embed 元数据对应的实际容器，验证 source 路径、ExportAssets/SymbolClass 符号、DefineSprite 帧数，并递归拒绝 DoAction(12)、DoInitAction(59)、DoABC(72/82)。所以这些 `assets.swf` 是图形/时间轴容器，不能用“仍在执行嵌入的原 ABC”解释源码构建能启动。这里仅覆盖被源码实际引用的资源；没有把未引用文件作为导出成功的依据。

帧回调索引是从 0 开始。示例：`PlayerMc_X0_v10/scripts/src/Skin/Skin_player0.as` 的最大绑定索引为 405，资源有 413 帧；X1 为 284/340，X2 为 302/310；`Enemy81_v3/scripts/大门.as` 为 343/600。这说明绑定索引与容器帧数相容，不能证明每帧的图形、攻击判定和播放顺序已经运行正确。

## 真实构建风险与处理边界

1. **145 处 FFDec 空块加分号。** 分布于各模块的 `Player.as`（97 处）和 `Player2.as`（48 处）。这类 `{};` 经常导致 mxmlc 语法失败；可在编译副本中改成空语句，并保存修复记录。它本身不是逻辑丢失证据，不应擅自为其补写战斗逻辑。
2. **13 个文件含 26 处 § 标识符。** 例如 `Enemy201_v2/scripts/§FT M JQ§.as` 和 `§run chen mc§.as`、`ChongWu_v8/scripts/§BigShot A§.as`。源码需临时合法化名字，然后把最终 ABC 字符串池和 linkage 名恢复为原始名字。现有 `probe_source_repairs.py` 已有这一流程；须验证恢复后的输出，不能交付只改过类名而未恢复绑定的 SWF。
3. **名称解析不能只看编译成功。** 主程序曾因 `strict=false` 下的完全限定 `com.hotpoint...XMLAsset` 调用编译成 `getlex com` 链而在读档时抛 1065。稳定修复应使用经 P-code 确认的显式 import 和短类名。全模块探针的旧修复路线也使用完全限定 XMLAsset/JSON 调用，已通知负责代理修复；最终绑定验证必须按产物哈希记录。历史主程序修复结果见 `main-semantic-audit.md`。
4. **成功导出没有排除无标记的控制流误译。** 搜索不到 Not decompiled、Decompilation error、UnknownJump、§§ 或 timeout/decompiler 字样，只排除显式失败 stub。主程序抽样仍有原 subtract 路线重编译成 decrement 等差异；动态类型、数值强制转换、异常边界和脚本初始化顺序仍需 P-code 与运行对照。
5. **同名代码在很多资源模块内重复。** 它们可能运行于不同 ApplicationDomain；不能因为某个主程序类修好了，就认定资源模块的同名类自动继承修复。也不能据此直接删除看起来重复的类。

## 可执行验收界线

本检查自身没有发现缺失声明、无法解析的已有 Embed 或越界帧绑定；后续根时间轴/原 SymbolClass 对照另发现真实修复阻塞，见下文。可优先修改被证据覆盖的业务源码，再构建、检查最终 ABC 和资源绑定、运行隔离存档回归。最小行为路径见 `behavior-expectations.md`：读档→村庄→任务 110001/110002→地图 1 小怪/Boss→保存→重启；角色各方向动作、帧回调攻击和装备皮肤仍须独立运行覆盖。

本报告未运行所有地图、角色、Boss 或所有动画，不将“19,910 文件齐全”“编译通过”或“标题能启动”称为完整行为等价。

## 修复后模块定点绑定复核

已在修复完成后重新导出 Enemy105 的最终产物 P-code，SHA-256 为 `aa015df8c1e526d073a2e7261dad5b0d0fb4f183ad92f474eb4dbe3a185e362d`。证据见 `export-quality-binding-sample.json`，提取脚本为 `audit_main_bindings.py`。

- Shop_LiBao、Shop_LiBao2 的 4 处 XMLAsset 查找均直接查短类名，命名空间集包含 `com.hotpoint.braveManIII.Tool`、不包含 `src.tool`。
- TiaoShi 的 JSON 调用直接查 `JSON`，命名空间集包含 `com.adobe.serialization.json`；JSON 类定义的包名和类名已恢复。抽查文件没有临时 `REA_LegacyJSON_` 名字残留，也没有 `getlex/findpropstrict com` 属性链。
- 原版 TiaoShi 的 JSON 查找同样使用含默认空包与 Adobe 包的宽命名空间集；新产物仍属这种形式。这里确认消除了已知 `com` 错绑路线，没有证明该调试功能在现代播放器中的 JSON 调用已经跑通。该功能含 HTTP 调用，本审计没有触发它。

这些结论只适用于记录的 Enemy105 哈希，不自动推广到其他尚未重建或未抽查的模块。

## 后续原 SymbolClass / 根时间轴核对的补充边界

`application-domain-audit.md` 和 `module-roots.json` 补充了本检查不覆盖的两个层面。FFDec 已有 Embed 全部可解析，并不代表原 SWF 的全部 class→character 绑定都生成了 Embed：21 个非空 NPC/任务按钮及7个空遮罩的源码缺少 Embed，初次重建因此丢失原 SymbolClass 绑定。另 Enemy5 根时间轴的未绑定 Shape2 与两个小 bitmap 未进入 assets 容器；Enemy16 根放置和 Music 根流头也未自然保留。构建代理正在/已经按逐产物记录修复，最终状态看 module-roots manifest 的当前哈希。不能把此前的 0 Embed 问题解释为所有原资源均已无损重建。

附加的 AVM1 内嵌动作检查由资源构建代理实现并记录于 `reverse/experiments/module-probe/asset-action-audit.json`：163 个原导出 assets 中350个 DefineButton2 的 ActionOffset 均为0，64,061个 PlaceObject2 和12,303个 PlaceObject3 的 ClipActions 标志均为0。这补足仅检查独立 DoAction/DoABC 标签不能排除按钮/放置记录内嵌动作的边界。构建器对这些入口也做 fail-closed 检查。
