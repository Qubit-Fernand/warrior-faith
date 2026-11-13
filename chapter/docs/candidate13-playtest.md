# 候选13实测与续接

这是一份未完成验收的实测记录，不是发布报告。正式入口已经运行此包；没有推送远端。

## 包与真实角色

- 运行包：`reverse/build/runtime-all-rebuilt-20261025T230927.541475Z`，严格组装164个重建模块、0原ABC回退。
- Main SHA-256：`026ded29e611d29045d9a99d037ee5ca7db540a16cffcff4a851f4793f5fb526`。
- Assembly SHA-256：`ace9e37e39e0fbc4956007404be4fa1807671a12b85aa53edc960dce4465b59a`。
- 当前新组槽1是明确生成的普通起点，85级、HP18627、MP8265、攻击约2017、防御约760、六件+10。主线前置由起点工具准备，新章探索与胜利全部由游戏操作取得。
- 本轮在原击杀点商店购买8瓶HP3000药水，司灯使用6瓶，霍根重试使用2瓶；没有改写角色属性、战斗血量、胜利或奖励标记。

## 已发生的玩法与画面

| 内容 | 当前包证据 | 边界 |
|---|---|---|
| 导师接取、头像与绢纸对白 | [125](../evidence/private/125-candidate13-normal-new-intro.png) | 已提交前置的起点可进入；未提交前置尚待本包复测 |
| 攻击破桥锁、渡桥开放、居民离开牢笼 | [128](../evidence/private/128-candidate13-bridge-dialogue.png)、[129](../evidence/private/129-candidate13-first-rescue-moving.png) | 演出实际发生；第二组用Enter跳过；完整失败/冷读覆盖另列 |
| 新司灯轮廓、真实切断两灯座、胜利 | [135](../evidence/private/135-candidate13-warden-open-core.png)、[145](../evidence/private/145-candidate13-warden-normal-victory.png) | 普通角色实际击败；明确成功跳波/横移的本包证据尚需补齐 |
| 新王座冠轮崩裂、独立第二血池 | [157](../evidence/private/157-candidate13-regent-transform-approach.png)、[173](../evidence/private/173-candidate13-regent-phase2-retry.png) | 首轮实际死亡，点击重试后重新击败两血池 |
| 绿环避难、锁定后横移 | [164](../evidence/private/164-candidate13-regent-refuge-survived.png)、[170](../evidence/private/170-candidate13-regent-lock-left.png) | 163→164生命17914不变；169→170生命17774不变。166文件名evaded不代表成功，该次实际掉血 |
| 最终Boss普通角色胜利 | [177](../evidence/private/177-candidate13-regent-normal-victory.png) | 使用原生技能，无胜利函数调用或完成标记注入 |
| 分歧前冷读、确认长明、仪式第一节点 | [179](../evidence/private/179-candidate13-beacon-choice.png)、[180](../evidence/private/180-candidate13-beacon-first-node.png) | 分歧前冷读已观察；节点1再次冷读遇到锁屏，尚未观察结果 |

旧Boss对照是[候选8原暗黑王子截图059](../evidence/private/059-candidate8-original-dark-prince.png)，只用于视觉比较，不作为候选13的原关卡回归证据。新司灯采用三足灯座和透镜灯核，新王座采用双靠背、输光臂和破冠部件；图形由新增Flash Graphics代码绘制，未使用暗黑王子的皮肤、时间轴或AI。仍复用原玩家、技能、地图碰撞和存档基础；场景背景属于本章新增资源。素材来源与兼容范围见[战斗模块说明](../../reverse/source/3_L4399Main_gamefile/src/epilogue/battle/README.md)及受控素材清单。并不宣称这些程序绘制部件是全新手绘动画。

按键与截图时间线保存在 `chapter/evidence/private/candidate13-direct-trace.json`。截图只呈现取样时刻，连续演出判断同时依赖当时操作记录，不能由单张静态图证明所有动画和恢复路径。

## 存档保留与下一步

当前使用独立 `yzlr2_rebuild_epilogue_v2.sol`。原8槽已经字节完整归档：

`chapter/evidence/private/checkpoints/save-groups/20261025T231829.260514Z-c9329aa50e37/outgoing.sol`

摘要 `3d12752c3a7a3a54cfd5b9ac5b5b857b038a0be405adf10f8483d65c0fc02e89`。这是旧组，不应覆盖新组已取得的游玩进度。组切换须完全退出播放器并用 `tests/switch_save_group.py` 做双向保留。

当前槽1的两个真实检查点：

- 分歧前：`private/checkpoints/candidate13-normal1-prechoice.sol`，SHA `5f2a8d3b6d0c0fa2ff77af95d430fe514975b54321be8da7037a17b8298250eb`。
- 长明仪式1/3：`private/checkpoints/candidate13-normal1-beacon-node1.sol`，SHA `7281c3bb0a7668835357ef4ba18c9a7f802ce12f3deece8a926168b8c9401b34`。

第二份检查点含两Boss胜利、两准备装置、`endingChoice=beacon`、`endingNodes=1`、结局空、金币10000、奖励记录空。槽2仍为未游玩的毕业起点，槽3–8空。语义比较证实只有槽1相对起点变化；四个受保护旧SOL哈希均未变。

2026-10-26约08:03，完全退出并经Finder正式入口重新启动后，Cua报告Mac已锁定且无法自动解锁。已请求用户手动解锁，没有修改安全设置。播放器进程存在不等于已经进入或读回角色。

解锁后的顺序：载入槽1核验仪式1/3 → 完成节点2/3、长明结局、回村后日谈与日志 → 完全退出并验证50000奖励仅发一次 → 毕业角色另一结局 → 司灯死亡后再次进入与明确躲避 → 未提交前置、未来格式、原普通战斗和保存回归。继续沿用本包，不能用历史候选通过替代。

本次611.784秒章节计数排除对白、暂停，包含故意死亡；不构成20–40分钟真实完整体验的测量。墙钟工作已经超过7小时，Goal仍未完成，锁屏后的空等不得计入有效工作。

私有截图与SOL不提交Git；本机链接用于复核，远端克隆不能仅凭这些链接取得原始证据。

## 2026-10-26解锁后的补测

09:31后用户恢复，普通槽1实测冷读回到长明仪式1/3，继续完成节点2/3、长明结局、守灯居民后日谈和奖励日志。完全退出再读回后依然60000金币（起点10000+谢礼50000），再次查看后日谈不重复发奖。截图181–192及`private/candidate13-normal1-beacon-complete.json`、`private/candidate13-normal1-beacon-cold.json`记录实际结果。上文锁屏状态是历史记录。

完成检查点SHA：`06d21bbf7f61413cf8e8faeeecda837dbb4d618960830dcf57024bd939c0322a`；冷读检查点SHA：`1159920d62455f4caba7ad823d5e5a24e88ace4788235751e01550e9fae2f7b9`。普通完整流程为候选13证据，不能自动移作后续包全部通过。

之后用户要求公告6.0/旧同人5.7及角色易辨认名称。候选14修改公告，候选15进一步让6.0保存保留角色显示名。用户明确授权的改名仅改变SOL元数据，私人回执`private/checkpoints/save-labels/20261026T015441.765451Z/receipt.json`逐项证明角色data与非名称字段均未改变。旧保护清单保留，不把改名后的文件SHA误报为与旧清单完全相同。
