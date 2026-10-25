# 勇士的信仰 · 同人终章《归光之约》

《归光之约》是基于《勇士的信仰》5.6 源码重建的非官方续写：从奥加之后尚未归家的居民出发，沿亡海罗盘与运输航标的线索进入神殿，阻止霍根夺取女神之灵，再决定如何守护归航之路。内容包括码头救援、可观察的航标校准、两场新 Boss 和两种有村庄变化及后日谈的结局。

**当前仍待最终运行包验收。** 已有候选的实测与失败记录保留在[运行记录](chapter/evidence/session.json)，最终交付以[章节验收表](chapter/evidence/acceptance.json)为准。正式快捷方式已接入新启动脚本，最终包通过及20–40分钟体验目标仍待验证；本次没有推送远端。开发进度见[章节维护记录](chapter/README.md)。

新章逻辑位于重建 Main 的 `src/epilogue/` 内，随源码编译进游戏；不再通过旧 `mod/` 的外层加载器推进剧情。原游戏事实与同人新增设定分列于[剧情依据](chapter/docs/story-evidence.md)，不是官方隐藏章节或原作者遗失结局。

## 三个版本与本机入口

保留原来的三个分支、工作树和 Games 快捷方式名称：

| 版本 | 分支 | 本机目录（相对 `~/Games`） | Games 快捷方式 |
| --- | --- | --- | --- |
| 原版 5.6 | `5.6` | `勇者的信仰/` | `勇士的信仰·原版5.6.app` |
| 同人终章 | `codex/final-chapter` | `勇者的信仰-终章/` | `勇士的信仰·同人终章.app` |
| 源码重建版 | `codex/reverse-engineering` | `勇者的信仰-逆向/` | `勇士的信仰·源码重建.app` |

`codex/final-chapter-v2` 与 `勇者的信仰-终章开发/` 是本次实现和验收用的开发分支／工作树，不是第四个正式游玩入口。进入对应目录即可使用其分支，无需日常 checkout；不同工作树的修改不会自动同步。

新版终章的启动脚本是 **`启动同人终章.command`**；正式快捷方式应调用此脚本，切换完成情况以验收记录为准。在持有当前严格运行包的终章工作树根目录执行：

```sh
./启动同人终章.command --check
./启动同人终章.command
```

`--check` 校验运行包而不启动播放器。入口不会自动编译；它检查源码／素材与包的一致性、精确保存名及已有播放器签名，检测到其他 Flash 播放器实例时拒绝重复启动。切换版本前先在游戏内保存，再用 **⌘Q 完全退出**。

旧 `启动游戏.command`、仓库内旧 `勇士的信仰.app`、`终章入口.swf` 及直接双击根目录 Main SWF，都不是新版启动方式；源码重建版继续使用其自己的 `启动源码重建版.command`。新 clone 不包含所有本机工具、导出资源和运行包，不能仅凭脚本存在便直接开玩。

## 怎样开始游玩

正常前置是完成并提交原作 **【主线70】再战奥加（110117）**，回村寻找奥古斯汀身旁的新信标；只击败奥加但没交任务不会开放终章。当前仅支持单人。新 Boss 尚未接入宠物、精灵自动寻敌和依赖原敌人逻辑的部分装备／套装被动，不能按原版效果预期；详见[战斗兼容边界](reverse/source/3_L4399Main_gamefile/src/epilogue/battle/README.md)。

操作、路线、两种装置与结局、死亡重试及金币上限处理，集中见[游玩说明](chapter/docs/player-guide.md)。每角色本章谢礼应得一次 50,000 金币；金币空间不足时余额保留待领，后日谈不以全部领完为前提。

没有合适角色时，可明确生成独立体验起点：

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/chapter_fixture.py
```

这只生成 `chapter/fixtures/归光之约-起点.sol` 和回执，不安装到实时存档。两名起点角色都是 85 级，普通起点使用正常基础属性和六件 +10 装备，毕业起点使用更高固定属性倍率；原主线前置已由工具准备，**没有本章接取、胜利、结局或奖励进度**。它们是人工体验起点，不是自然养成记录，也不是 4399 云存档。

安装另需明确使用 `--install` 指定新保存名的全空实时 SOL，并先退出所有播放器；工具拒绝覆盖已有角色。不要直接复制预设覆盖整份实时存档。操作细节和各测试工具职责见[开发手册](chapter/docs/development-guide.md)及[测试工具说明](chapter/tests/README.md)。

## 独立存档与旧版恢复

新版使用 **`yzlr2_rebuild_epilogue_v2.sol`**；章节状态 `fanChapterReturnLight` 与当前角色一起保存。原版 `yzlr2_saves.sol`、旧终章 `yzlr2_final.sol`／`yzlr2_epilogue.sol`、源码重建版 `yzlr2_rebuild_probe.sol` 保持独立，不自动迁移到新版。

Flash 实时存档位于本机 `~/Library/Preferences/Macromedia/Flash Player/#SharedObjects/<随机目录>/localhost/` 下。随机路径应实际查找；Git checkout、切换工作树和回滚提交不会回滚角色。重要测试前另存备份，私人 SOL、截图和诊断不随 Git 分发。

旧《归来的曙光》的 `mod/story.json`、`mod/src/Epilogue.as`、旧构建与入口属于可恢复历史，不是《归光之约》的修改入口。迁移前快照记录为 `final-chapter-v1-before-v2-20261025`；旧版运行和存档说明可从该历史版本的 README 查阅。恢复历史代码仍需其对应工具与存档备份，不应将两个版本的保存文件混用。

## 二次开发从哪里读

| 内容 | 入口 |
| --- | --- |
| 章节文件职责、修改与构建顺序 | [开发手册](chapter/docs/development-guide.md) |
| 章节模块与原程序接入点 | [实现文件图](chapter/docs/implementation-map.md) |
| 对白与日志的可编辑输入 | [story.json](chapter/content/story.json) |
| 原作证据、续写边界与剧情设计 | [剧情依据](chapter/docs/story-evidence.md) · [剧情设计](chapter/docs/story-design.md) |
| Main 任务表与新增类／资源许可清单 | [main-tasks.xml](chapter/content/main-tasks.xml) · [extensions.json](chapter/content/extensions.json) · [清单约束](chapter/docs/extensions-manifest.md) |
| 本章 AS | [src/epilogue/](reverse/source/3_L4399Main_gamefile/src/epilogue/) |
| 两场 Boss 的实际机制 | [战斗模块说明](reverse/source/3_L4399Main_gamefile/src/epilogue/battle/README.md) |
| 全工程目录、源码与工具职责 | [文件手册](reverse/docs/developer-files.md) · [源码手册](reverse/docs/developer-source.md) · [工具手册](reverse/docs/developer-tools.md) |
| 按模块／文件查找 | [164 模块目录](reverse/docs/catalog/modules.md) · [索引说明](reverse/docs/catalog/README.md) |

基线恢复了 164 个 SWF 模块、19,910 个 AS3 文件和 11 份 DataX XML 配置；它不是原作者的 FLA 工程。不同 SWF 中的同名类可能处于不同加载域，不能简单合并。根目录原始 SWF 是基线，真正运行的重建包位于 `reverse/build/runtime-all-rebuilt-<UTC>/`。索引及旧重建报告的范围以各自记录版本为准，不代替新终章验收。

修改章节受控输入后，在当前工作树根目录执行：

```sh
PY=/opt/miniconda3/envs/Qubit/bin/python
"$PY" reverse/tools/chapter_source.py import
"$PY" reverse/tools/build_main.py --all-definitions --save-name yzlr2_rebuild_epilogue_v2
"$PY" reverse/tools/rebuild_project.py assemble
./启动同人终章.command --check
```

`ChapterContent.as` 和 `ChapterBackdrop.as` 是生成物，不手改；新增类及受控资源需进入显式清单。以上流程针对 Main／章节修改，其他模块按[完整构建文档](reverse/docs/build-project.md)重建对应部分。严格 assemble 不允许原代码回退，混合诊断包不能当完整源码包交付。

本机依赖包括 Qubit Python、Java 21、FFDec、Flex、playerglobal 和 Adobe Mac Debugger；具体工具路径及准备方法见构建文档。REA 的已测能力与限制另见[能力实测](reverse/docs/rea-capability.md)，不将通用字节分析称为已完成 Flash 语义恢复。

## 验收与维护

以[章节验收表](chapter/evidence/acceptance.json)记录最终同包的入口、完整流程、双结局、冷读、正常／毕业角色、奖励和原功能回归；以[运行记录](chapter/evidence/session.json)保留各候选摘要、失败与修复。历史候选通过不能自动移作最新包通过。原始重建阶段的结果另见[重建报告](reverse/docs/final-report.md)。

正式分支和既有快捷方式已完成整合。10b 直开暴露 SWF 9 暂停 API 错误，候选11仍有技能时间轴积累问题；候选12采用播放命令追踪，31项原生隔离测试已通过，严格游戏包已构建，正式入口毕业档已通关，普通档与剩余回归仍在复验。此前诊断入口的证据不代替正式入口通过。实际完整游玩时长尚须独立计时，不把测试等待、存档排查或原关卡游玩算作终章内容时长。长篇开发过程、已解决问题与剩余工作维护在 [chapter/README.md](chapter/README.md)，根页面只保留使用入口与重要边界。提交、合并、安装和推送分别以实际记录为准。

## 来源与许可

基于《勇士的信仰》5.6 离线包的非官方本地研究与修改。原游戏、角色、美术、音乐及第三方工具的权利归各自权利人所有；本仓库未对这些内容授予新的许可。[原下载说明](https://www.bilibili.com/opus/1144775248772595719)。源码恢复与本章创作不代表官方续作。
