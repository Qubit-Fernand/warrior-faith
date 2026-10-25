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
- pending 未解决时不接受下一笔写入，既不覆盖原 pending，也不偷偷排队。
- 初始化空槽位不再无结果地调用 flush。
- `loadSlot()` 返回已确认槽位的独立快照；`getSlotTitles()` 只显示已确认的槽位标题。失败会把 SharedObject 的内存槽位恢复为上一份已确认数据；这不是额外的磁盘写入，也不声称能代替播放器自身的持久化保证。
- 只有确认 flushed 后才调用 `Main.SaveFun()` 与原“保存成功”效果。异步完成会检查原保存槽位与角色对象，避免玩家切换角色后把另一个角色标记为已保存。
- pending 会显示明确的“尚未保存，请允许写入”提示；failed/blocked 显示实际原因。反馈层异常只记录诊断，不把已确认的 flushed 改写为 failed。
- 仍保留 `SO_NAME="yzlr2_saves"` 源占位符，由既有构建规则替换成隔离的 `yzlr2_rebuild_*` 测试存储；没有弱化原保护或指向用户旧存档。

## 本轮验证边界

2026-10-26：完成源码静态检查：原保护仍位于 save 构造前；Save2 所有出口有明确结果；只有同步 FLUSHED/异步 Success 分支写成功状态；异步回调先解除在途锁；源文件保持 CRLF。未执行构建、播放器或真实存档写入。主集成任务应在隔离存档验证同步成功、存储禁止/异常、pending 允许与拒绝、pending 时重复保存、等待期间角色数据变化及角色切换。
