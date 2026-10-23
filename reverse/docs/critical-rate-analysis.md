# 暴击面板 0.1 个百分点变化的静态追踪

本次仅读取源码、导出素材与既有截图，没有读取 SOL、修改游戏源码或启动游戏。结论已由主任务的运行图鉴确认：本次小蛇卡达到三星，获得暴击 20，其他属性为 0；冷重启后仍保留。这是原版随机集卡奖励导致的面板变化。

## 截图先后关系

`reverse/logs/runtime/full-initial-stats.png` 与 `original-initial-stats.png` 均为暴击 **24.3%**，HP 48848、攻击 7104、防御 3658、闪避 24.5%。`full-after-clear-stats.png` 在经验由 0 增至 1621 后为 **24.4%**，其他四项不变；`full-armor-removed.png` 为暴击 **23.5%**。不能把初始差异写成 full=24.4/original=24.3。

## 确定的计算路径

以下相对路径均从 `reverse/source/3_L4399Main_gamefile/` 起算。

1. `src/Player.as:503` 的 `LoadPlayerLvData` 初始化角色基础属性，`:516–517` 将等级表暴击与装备 `getAllCrit()` 相加，赋给 `baoji`；`:562–566` 再加入被动技能 d4 的数值。
2. `src/Player.as:659–689` 每次计算先从 `baoji` 重置 `use_baoji`，再应用装备技能、徽章、宠物、称号、精灵、卡片等增量与倍率。`:1247` 每帧调用这一重算，`:894` 倍率从 1 重新开始，不能直接把它解释成每帧累计增加。
3. `com/hotpoint/braveManIII/models/container/EquipSlot.as:308–337` 对有效装备槽求和并加入套装暴击；`models/equip/Equip.as:512–547` 汇总基础、强化、宝石及祝福属性。普通读取本身不调用随机函数。
4. `src/Player.as:973–982` 的 `cardjiacheng` 将 `int(CardPanel.monsterSlot.getAllCritup())` 加入 `use_baoji`；它在最终乘倍率之前执行。
5. `com/hotpoint/braveManIII/views/itemsPanel/BagItemsShow.as:176` 显示 `Math.pow(Number(use_baoji / 70), 0.8).toFixed(1) + "%"`。这是暴击属性经非线性转换后保留一位小数，并非直接把属性值当百分比。

## 小蛇集卡可以只增加暴击

- `src/Enemy.as:497–515`：敌人生命降到零时发放经验、金钱，更新任务／成就，并调用 `CardPanel.monsterSlot.addMonsterCard(id)`。
- `models/container/MonsterSlot.as:105–111`：`Math.random()*100 < 5` 时获得对应怪物卡，即每次调用有 5% 概率。
- 同文件 `:63–78`：已有卡则增加次数，没有则创建；`models/monsterCard/MonsterCard.as:19–38` 新卡从一次开始，已有卡只加到三次。
- `models/container/MonsterSlot.as:150–166`：只有卡片次数达到三次才累加其 `getCritup()`；未满三次不产生这项加成。
- 主游戏原始导出素材 `reverse/exports/3_L4399Main_gamefile/scripts/_assets/8633_src.Data2_monster.bin:3–14` 定义 **小蛇的卡片**，编号 0、怪物类型 1、暴击成长 **20**，攻击／防御／生命／魔法成长都是 **0**。`src/Data2_monster.as:5` 指向该素材，MonsterFactory 读取“暴击成长”到暴击属性。

因此通关途中若小蛇卡从一／二次达到三次，后续每帧会多加 20 点暴击，其他上述面板属性保持不变。卸下战甲不会移除图鉴加成，符合本次变化形态。随机抽卡也允许不同原版／重建试跑产生不同结果，不能将差异本身直接判为重建错误。

数值校验仅为公式演算，不反推实际内存值：让初始面板正好为 24.3 的暴击属性约为 3776.64，增加 20 后显示 24.4029，保留一位为 24.4；初始正好为 23.4 时属性约 3602.62，增加 20 后为 23.5039，显示 23.5。若还有暴击倍率，20 点会先受倍率影响；实际倍率仍需运行时观测。

## 排除与边界

- `models/player/PlayerData.as:677–684` 的 AddKillPoint 只增加击杀点；上述面板／Player 属性链没有直接读取 killPoint。击杀点和集卡都可随击杀变化，但不是同一个加成路径。
- `models/common/VT.as:115–130` 当前原始导出实现读取 `num-random`，赋值时 random=0；不能用“VT 随机遮罩浮点误差”解释此处变化。
- `src/HitXX.as:395–405` 的随机抽取决定一次攻击是否暴击，不改写 `use_baoji`，不能直接改变背包暴击面板。
- 与此追踪直接有关的 Player、Enemy、MonsterSlot、MonsterCard、BagItemsShow、VT、PlayerData 七个 canonical 文件均与本轮原始 FFDec 导出逐字节一致；构建兼容修复仍按各自台账执行。
- 未比较两种 SOL 重写的序列化语义，未读取私人存档，也没有凭“来自同一 preset”声称实际运行状态相等。

主任务已查看本次图鉴：小蛇三颗金星、获得属性暴击 20、攻击／防御／生命／魔法为 0，总星数 3/30，且冷重启后仍在。本子任务也已直接查看确认截图 `reverse/logs/runtime/full-snake-card-confirmed.png`，与静态链条吻合；此处无需修改暴击公式。原版此前未出现此加成的具体随机抽卡历史不作反推。

确认截图 SHA-256：`18e101368fae55983ca3c018cf211c3ea816cc2be424ff31179f7dd0f65d815b`。冷重启持续性的操作证据由主任务记录，本子任务未启动播放器。
