# 最终章节 v2 · 开发记录

启动：2026-10-25 23:23:17 Asia/Shanghai。至少7小时有效工作，最早时间门槛为2026-10-26 06:23:17，还须扣除无效等待并满足全部验收。

## 当前状态

基线文档已分别checkpoint；旧终章标签 final-chapter-v1-before-v2-20261025；独立分支 codex/final-chapter-v2。原作核实、UI与战斗由互不重叠子任务推进；主任务负责导入/状态机/构建/Flash验收。未启动新游戏或修改旧存档。

## 所有权

- 主任务：受控任务/剧情/素材、Controller、存档、构建/组装/启动、Git与Flash操作。
- combat_system：Main/src/epilogue/battle 新文件。
- chapter_ui：Main/src/epilogue/ui 新文件。
- story_research：chapter/docs/story-*.md、content/story.json、Main/src/epilogue/scene。

## 下一步

独立缓存已准备；受控内容导入、Main生命周期、独立章节状态已接入。正在第二轮编译，未完成运行验收。详见 evidence/README.md。子任务不能在输入尚变动时私自构建。
