# Player 辅助帧计时器暂停修复

2026-10-26，仅修改 Main 包 `reverse/source/3_L4399Main_gamefile/src/Player.as`。本轮未修改 Controller、存档代码、战斗模块或 UI；未运行编译、Flash、Git。以下为静态核对，不是运行验收结果。

## 缺陷与最小修复

章节暂停已使 `Player.onENTER_FRAME()` 早退，但另外注册的 `ENTER_FRAME` 回调仍独立运行。MovieClip 的 `stop()` 只停止时间轴，不能取消这些回调。因此阶段对白或暂停可能消耗保命无敌／复活保护时间，或让套装效果冷却提前结束。

给每个遗漏回调的第一条语句加入现有同式保护：

```actionscript
if(ChapterController.paused) return;
```

使用文件原本已有的 `ChapterController` import，没有增加或重排 import。暂停期间回调不累积计数、不更改状态、不移除自身监听；恢复后从原计数继续。非暂停路径的条件、阈值、数值与移除监听行为不变。

| 回调 | 修复后 guard 行号 | 原行为保留 |
|---|---:|---|
| `wudi` | 1437 | `timeTemp > 81` 后结束保命无敌、移除效果并重置触发标记 |
| `timeLimitBJ` | 1451 | `timeTemp > 54` 后重置相应触发标记 |
| `timeLimitSJ` | 1463 | `timeTemp > 351` 后重置相应触发标记 |
| `timeLimitSY` | 1475 | `timeTemp > 284` 后重置相应触发标记 |
| `timeLimitXL` | 1487 | `timeTemp > 284` 后重置相应触发标记 |
| `timeLimitMP` | 1499 | `timeTempmp > 216` 后重置免蓝耗触发标记 |
| `NewLife` | 2053 | 保留VT增量、闪烁与超过 `InitData.BuyNum_80` 后结束复活保护 |

`onENTER_FRAME()` 原本已有保护，未再次插入。连击计时、技能/物品CD由该主回调推进，因而已有保护。键盘输入的原保护也未改动。

## 静态验证证据

- 枚举本文件全部 `addEventListener(Event.ENTER_FRAME, callback)`，得到8个唯一回调：`onENTER_FRAME`、`wudi`、`timeLimitBJ/SJ/SY/XL/MP`、`NewLife`。修改后8个回调均在第一条语句检查章节暂停。
- 搜索本文件没有额外 `Timer`、`setInterval`、`setTimeout` 或字符串形式的 enterFrame 注册。
- 只插入7条 guard。脚本将7处精确逆替换后，整个文件字节与修改前完全相同，证明没有更改阈值、分支、注册、清理或其他逻辑。
- 修改前2819个CRLF；修改后2826个CRLF；裸LF数量始终0。
- 修改前 SHA-256：`a6d0ad34ff44575934e66fad004af2e8bc777a26729e932df1ff5101e0f89c14`
- 修改后 SHA-256：`3d95afeaa4116bd229391e113da1c530429180955b3aae9569514cb1c80e7c3b`

## 后续运行验收

父任务在下一候选中触发一个保命／复活保护效果，再暂停超过其原持续时间；恢复后应继续余下时间，而不是立即过期。另检查套装触发冷却在暂停时不推进、恢复后正常到期，以及无暂停时行为未改变。

此次检查覆盖 `Player.as` 的注册回调，不宣称所有游戏类的计时器都已暂停。保存失败反馈、结局奖励上限属于此前独立审查发现，不在本轮文件权限范围内。
