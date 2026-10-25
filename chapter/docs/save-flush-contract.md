# 本地保存 flush 状态契约

`Main.Save2(param1:Boolean=true):*` 现在返回 String；`Main.Save(...)` 也传回这个结果。角色、背包/金币、主线任务和 `ChapterState` 仍放在同一个 save 对象、同一个槽位、同一次 SharedObject flush，不拆分结局奖励与章节记录。

| 返回值 | 含义 | Controller 应对 |
| --- | --- | --- |
| `flushed` | Flash 的 `flush()` 已明确返回 `SharedObjectFlushStatus.FLUSHED`。 | 可以确认本次检查点完成。 |
| `pending` | Flash 返回 `PENDING`，正在等待本地存储许可。 | 尚未成功。保留当前流程，通过下面的只读状态等待。 |
| `blocked` | 原 `noSave` / `DuoKai_Info._noSave` 保护阻止保存，或此前已有 pending。当前请求没有提交。 | 不推进“已保存”的业务；旧 pending 结束后，当前请求必须自行重试。 |
| `failed` | 打开本地存储、序列化、flush 抛错，或返回异常状态。 | 保留游戏内状态，提示重试，不宣称持久化成功。 |

## 只读状态与异步通知

```actionscript
LocalSaveManager.lastStatus; // 启动时 idle，随后 flushed/pending/blocked/failed
LocalSaveManager.lastError;  // 失败/阻止原因；成功时清空
LocalSaveManager.isPending; // 明确表示仍有一笔在途 flush
```

`lastStatus` 描述已受理保存操作的状态；**如果已有 pending，此时新请求被 blocked，不覆盖旧操作的 pending 状态**。`lastError` 会说明新请求未提交。Controller 必须保留本次 `Save2` 返回值，不能把旧事务随后变为 flushed 当成被拒绝的新请求也保存了。

底层接口为：

```actionscript
LocalSaveManager.saveSlot(slot:int, title:String, data:Object,
                          onResolved:Function=null):String;
// onResolved(status:String,error:String)
```

回调仅用于此前返回 pending 的请求，收到 `SharedObject.Flush.Success` / `SharedObject.Flush.Failed` 后调用一次；同步 flushed/failed/blocked 不调用。通知前先清除 pending 状态与回调引用，允许回调中发起新的保存。其他 NetStatus 消息不被误当成成功。

`reportBlocked(reason)` 和 `reportFailed(reason)` 是 Main 在原保存保护或构造 save 对象失败时更新状态的入口；不要用它们伪造 flush 成功。

## 数据与提示

- 保存前先用 AMF 对完整槽位对象做快照，避免许可等待期间的金币、背包或章节后续变化混入这笔保存。
- LocalSaveManager 在 pending 未解决时不接受下一笔写入、不覆盖原 pending。Controller 另设显式合并队列：记录“当前角色还有更新未写入”，等在途操作结束后再保存当时最新的整份角色状态；不是让底层偷偷替换待写快照。
- 初始化空槽位不再无结果地调用 flush。
- `loadSlot()` 返回已确认槽位的独立快照；`getSlotTitles()` 只显示已确认的槽位标题。失败会把 SharedObject 的内存槽位恢复为上一份已确认数据；这不是额外的磁盘写入，也不声称能代替播放器自身的持久化保证。
- 只有确认 flushed 后才调用 `Main.SaveFun()` 与原“保存成功”效果。异步完成会同时检查原保存槽位、PlayerData 对象和 ChapterState.value 对象身份，避免玩家切换角色后把另一个角色标记为已保存。
- pending 会显示明确的“尚未保存，请允许写入”提示；failed/blocked 显示实际原因。反馈层异常只记录诊断，不把已确认的 flushed 改写为 failed。
- 仍保留 `SO_NAME="yzlr2_saves"` 源占位符，由既有构建规则替换成隔离的 `yzlr2_rebuild_*` 测试存储；没有弱化原保护或指向用户旧存档。

## 本轮验证边界

2026-10-26：完成源码静态检查：原保护仍位于 save 构造前；Save2 所有出口有明确结果；只有同步 FLUSHED/异步 Success 分支写成功状态；异步回调先解除在途锁；源文件保持 CRLF。未执行构建、播放器或真实存档写入。主集成任务应在隔离存档验证同步成功、存储禁止/异常、pending 允许与拒绝、pending 时重复保存、等待期间角色数据变化及角色切换。

## Controller 跨场景与跨槽位队列接口

主集成任务已扩展当前源码；异步回调链为：

```actionscript
// Main.Save2 接受请求时捕获：
var chapterSaveOwner:Object = ChapterState.value;
// LocalSaveManager 的 pending 回调内，完成准确提示后：
ChapterController.onSaveResolved(resolved, chapterSaveOwner);
// 静态接口签名：onSaveResolved(status:String, completedOwner:Object):void
```

- Controller 的 `saveOwner`、`saveStatus`、`saveQueued`、`awaitingFlush` 是静态状态，跨地图销毁/创建 Controller 仍能跟踪同一角色。新 Controller 发现 `ChapterState.value` 身份改变时才重置所属角色的队列状态。
- `checkpoint()` 遇到 LocalSaveManager 已 pending，不提交第二笔保存；设置 `saveQueued=true`、`awaitingFlush=true`、`saveStatus="pending"`。多次请求合并为“保存最新完整状态”。
- `onSaveResolved()` 只有当前等待且队列所属角色仍为当前 `ChapterState.value` 才处理；同一 owner 成功后，有队列就调用 `Main.Save2(false)` 补写最新状态。同一 owner 失败时不自动无限重试，保留失败状态供暂停菜单“重试保存”。
- 若完成的是另一个 slot/owner，不能把它的 flushed 记作当前角色成功；Controller 先标记 blocked，再在有队列时发起当前角色保存。旧 slot 的成功只意味着磁盘锁释放。
- 补写由静态回调驱动，不依赖当前地图是否仍有可见的章节 Controller。Controller 的 `snapshot()` 暴露 `saveStatus` 和 `saveQueued` 供只读诊断。
- 队列保存取补写时的最新角色状态，不承诺把每个中间演出节点分别写入磁盘；金币与章节字段仍属于一份完整快照。

## 队列回归要求与未验证项

本轮只核对上述源码接口。**尚未在真实播放器触发 SharedObject 的 pending，因此异步许可、队列与跨槽位行为没有运行验证结论。** 不能把同步 flushed 路径跑通写成 pending 已验证。

需要在隔离测试存档检查：

1. A 角色进入 pending，发生多个检查点并跨地图；允许写入后先确认旧快照完成，再确认最新完整状态被补写，队列最终清空。
2. A pending 后读取 B 并产生 B 检查点；A 的成功或失败不得给 B 显示“保存成功”，但应释放在途锁并唤醒 B 的明确排队请求。
3. A pending 被拒绝时不无限自动重试；重试保存可以重新提交当前完整快照，结局奖励不重复发放。
4. pending 时关闭/重建章节 Controller，静态回调仍可处理当前角色队列；切换 owner 后旧回调不推进错误角色。
5. 同步 flushed、异常、原保护 blocked 仍保持此前语义；成功提示只绑定实际完成的 owner，不能吞掉另一角色尚未保存的提示。
