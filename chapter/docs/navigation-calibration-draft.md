# 航标观察校准：已授权组件与接入合同

2026-10-26：原草案经主任务授权进入实现。本文件保留原路径以维护既有链接。已新增场景组件与两组救援线索；Controller 输入、State 保存及真实运行验收由主任务接入，不能仅凭组件存在宣称流程已通过。

## 三步可见观察

| 顺序 | 操作点 | 持续可见线索 | 正确 turn 与效果 |
| --- | --- | --- | --- |
| 1 回潮方向 | x520，nav0 | x420 木桩上的潮痕与左向箭头；短字“潮痕向左” | turn=3，盘针向左，与潮痕方向一致；亮绿并锁定 |
| 2 运输船号 | x930，nav1 | x164–211 的接应船高挂信号帆上三条实物短纹；船边标明这是接应船帆纹 | turn=2，盘上显示 turn+1=3 条横纹；亮绿并锁定 |
| 3 神殿回光 | x1200，nav2 | x1380 的原罗盘圆环接收口；前两步完成后出现细参考光 | turn=1，回光镜向右，出光线实际抵达罗盘圆环；三盘连光 |

方向盘编码为 0上、1右、2下、3左。第二盘不是方位，而是 1／2／3／4 道帆纹。`ChapterNavigation.correct(index,turn)` 是唯一公开判定函数，答案为 `[3,2,1]`；无随机猜测、答错伤害或等待时长。线索同时以形状、短文字和盘面变化表达，不只靠颜色。

## API 与所有权

新文件：`reverse/source/3_L4399Main_gamefile/src/epilogue/scene/ChapterNavigation.as`。

```actionscript
var nav:ChapterNavigation = new ChapterNavigation(1600, 450);
worldBackLayer.addChild(nav);
nav.setProgress(state);
var points:Array = nav.interactionPoints();
// Controller 验证当前位置与 id，然后旋转当前尚未锁定的盘：
state.navigationTurns[index] = (int(state.navigationTurns[index]) + 1) % 4;
if(ChapterNavigation.correct(index, int(state.navigationTurns[index]))) state.navigationSteps++;
nav.setProgress(state);
// Controller 在每次旋转／锁定后保存；steps==3 后仍需原 compass 交互确认。
nav.dispose();
```

- `setProgress` 复制 `navigationTurns` 的三项、`navigationSteps`、`rescuedGroups`、`calibrationDone`，不修改传入对象或数组。首次／冷读都直接显示保存状态，没有重复演出。
- `interactionPoints()` 仅在救援两组之后返回**当前步骤的一个点**。锁定点和未来点仍可见但不可操作；steps=3 或 calibrationDone 后返回空数组。
- 交互半径 70、y=ground。x 按设计固定，不随 width 缩放；必须使用共同世界坐标，不把摄像机平移加两次。
- 主任务拥有剧情、点击防抖、存档和最终 `calibrationDone`。本组件不自动校准、不写原罗盘碎片、不发奖。
- 不监听舞台、不拥有碰撞、不需要 update，不遮全屏、不阻止玩家移动；dispose 幂等并从父容器移除。

## 内容改动

`rescue_one` 新增潮痕方向线索；`rescue_two` 新增船帆与回光线索，均仍在 2–5 句范围。`rescue` 日志常驻记下观察方法；`calibration` 的成功句明确三座航标已接通。主任务须重新 import 正式内容，生成物不能手改。

## 验收与时长边界

需实测：先救两组才可转盘；错误方向不会锁定；两种方向与帆纹能清楚辨认；每步旋转及锁定冷读不丢；原 compass 在steps<3时拒绝完成，steps=3时确认后才前往司灯；Back层高挂信号帆在原船帆上方可见，船与航标盘不遮挡原角色。

本轮不承诺增加固定分钟数。记录真实观察、往返和解题时长；不能通过无交互等待凑到 20–40 分钟。此实现替代旧的“一次 E 直接完成校准”设计，完整可玩状态以主任务导入／编译／实测为准。
