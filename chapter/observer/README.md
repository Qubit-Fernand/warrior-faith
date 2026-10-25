# 被动运行诊断

`Source.as` 是开发用包装入口，加载同一严格包中未改动的 Main；每秒读取实际玩家/地图/章节/首领/码头快照，最多保留20帧样本与10条错误。它不注入胜利、不发送按键、不改生命/装备/剧情标记。错误仍交官方Debugger显示，不调用 preventDefault 隐藏异常。

`reverse/tools/chapter_observer.py build` 编译包装；`install <严格包目录>` 验证包为本章隔离存档后加入 ChapterObserver.swf 和独立摘要。Main及164模块字节不改。所有真实操作仍由播放器完成。

只写诊断SO `yzlr2_rebuild_epilogue_diag_v2`，与角色SO `yzlr2_rebuild_epilogue_v2` 分开。本机Flash曾把诊断长名称映射为 `localhost/yzl#/r2_rebuild_epilogue_diag_v2.sol`；read命令允许该文件名但仍核验SOL内部完整名称，不能用猜测路径代替文件检查。

采集：角色坐标/血量/攻防/碰撞框/金币/槽位/按键配置；地图碰撞与相机；章节状态、Boss真实命中和危险区/打断统计；可见UI短文本；NPC按钮类型与包摘要。截屏和录像必须另从真实播放器取得，诊断数值不能冒充截图。

包装会改变顶层加载关系，因此它只用于定位问题，不能代替最终不带wrapper的快捷方式直开、连续通关和冷读验收。诊断原始记录与截图保存在忽略目录 evidence/private；对外描述只引用明确候选摘要与实际观察。
