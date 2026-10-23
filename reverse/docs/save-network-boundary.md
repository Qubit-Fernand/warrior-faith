# 存档结构与联网入口的源码边界

本审计只读取 `reverse/source/3_L4399Main_gamefile/` 源码，没有读取任何游戏SO、登录4399或调用服务。`audit_save_network_boundary.py` 生成 `reverse/manifests/save-network-boundary.json`，保存相关源哈希、字段行号、42个AMF别名和47处边界调用/构造位置。它是源码清单，不是存档修复器、协议验证器或全程序“无网络”证明。

## 本地存档的实际结构与现有检查

`src/LocalSaveManager.as:19–36` 初始化SharedObject，默认名称 `yzlr2_saves`，不存在slots时创建8个null槽并立即flush。每个槽由 `saveSlot():39–54` 写入 `{index,title,datetime,data}`；非法写入索引回落0，`loadSlot():57–65`则对非法读取索引返回null。现有init只检查slots是否为真值，没有确认其为Array或长度为8；标题读取也只判meta为null，没有检查title/datetime类型。

`src/Strat.as:289–302` 从按钮名取槽号；meta和meta.data为真即调用 `Main.applySaveObject(meta.data)`，随后无条件startGame。applySaveObject返回void，不能向调用方表达“结构验证失败”；若它因版本/账号条件提前返回，调用点仍继续startGame。若访问不合结构字段抛异常，也没有该处统一恢复处理。这是原源码现状，不是本次逆向新引入的行为。

`src/Main.as:201–357` 的恢复逻辑主要是字段选择和旧版本兼容，不是完整schema验证：

- 开头只判save为null；var直接用于旧版本判断。JiaoYan():580–592比较版本，JiaoYan2():594–610处理历史账号/NoLog条件；XiuZheng():613–627会修改NoLogInfo，因此这些检查并非纯粹只读校验。
- NoLogInfo显式检查是否Array，不合类型时会把输入对象该字段改为null；lingQueArr/lingQueArr2检查长度11。未发现对所有保存字段统一的类型/范围检查。
- guanKa按0–150索引访问，缺项置0，Boolean转0/1；仅guanKa[1]有1/2/3范围归一化。它没有先确认save.guanKa存在且可索引。
- p1/p2按P1P2选取并 `as PlayerData`。这依赖AMF类型别名；不匹配可能得到null，后续路径仍假设玩家数据有效。`regAllClass():652`注册42个类型别名，具体清单在manifest。
- RenWu直接交给TaskData.saveArr；其 `views/taskPanel/TaskData.as:107–168` 按任务ID读取五元素数组，模型 `Task.setGoodsed()/setEneSave()`恢复计数数组，没有按新任务需求长度重建旧值。

Save2():379–446写32个字面字段以及动态p1/p2；applySaveObject同样读取32个字面字段。数量相同不代表每字段通过同样验证。verify只是保存的随机数，不是内容校验和；版本和账号旧逻辑仍保留，不能概括成“毫无校验”。VT、Bag、Equip等对象的AMF类型及引用身份也不能由普通JSON替代。

正式加入章节时，建议先在独立模块实现明确的schema版本和检查/迁移，生成通过验证的新对象再交给恢复路径；应让失败以可观察结果阻止startGame。至少检查slot元信息、var、P1P2、guanKa、PlayerData、任务五元素记录、需求数组长度，以及新章节字段的缺省。该验证器和原子恢复流程**尚未实现**。本审计没有读真实档、改原行为或擅自调整账号条件。

## 诊断SO路径实测修正

资源探针两包均调用默认 `SharedObject.getLocal("yzlr2_resource_probe")`。macOS官方projector实测它们共享 `localhost/yzlr2_resource_probe.sol`，不能因SWF目录不同就推断SO目录不同。此次原版先导出JSON及SOL哈希，关闭后再跑重建；两版runId/mode/manifestId都已验证。游戏测试仍应使用明确不同的专用名称，实际核对创建位置；设置目录或HOME不能单独作为隔离证据。

历史探针包未变；源码屏幕和未来收据已移除“package-local”承诺。不同包同时运行仍可能互相覆盖这个专用诊断SO，当前按顺序运行。更完善的runId/mode名称隔离属于后续改进。

## 本地加载不等于全部联网功能已删除

正常保存路径 `Main.Save2 → LocalSaveManager.saveSlot` 不调用4399云存档；Main.setHold():633–636只保存宿主对象。本地启动不注入宿主时，绝大多数远程业务无法正常使用，但部分路径仍存在：

| 边界 | 直接源码依据 | 可确认与不能确认的内容 |
|---|---|---|
| 资源加载 | ClassLoader.as:43 `loader.load(new URLRequest(url),context)`；TempData/Load构造本地资源名 | 当前资源清单为同目录SWF；不能把URLRequest出现都当成公网请求 |
| 宿主服务调用 | Api_4399_All.as的Main.serviceHold调用，包括余额/付费/道具/排名/用户数据 | 部分函数有null guard（308等），排名和用户数据部分没有（507、512、536、541、557）；无宿主时可能报错，不等于安全降级实现完整 |
| 旧活动HTTP | src/tool/X61_LingQue.as:22–24构造URLLoader/URLRequest；onLingQue():47–71在点击后load | 目标是原源码里的huodong2.4399.com活动PHP，附带输入兑换码；构造URLRequest本身不发请求。没有联系或验证现时服务 |
| 浏览器跳转 | Strat.as:144–151、JiHua_Interface.as:137–138、TitelPanel.as:615–616、JiFenLingQue.as:100–107 | 原论坛/活动链接通过navigateToURL打开；和URLLoader读取响应是不同边界 |
| 历史刷新链接 | Main.as:748、Strat.as:362、tool/Restart.as:23 | javascript:location.reload通过navigateToURL，独立播放器与浏览器行为可能不同，未实测 |

X61_LingQue在主模块中没有找到显式new调用，但它有Embed绑定，不能只凭文本搜索宣判不可达；本轮没有做其整个时间轴实例引用图。尤其 `X61_LingQueBtn` 实际new的是JiFenLingQue，并非类名相近就能认定触发旧HTTP。区分可见类、声明链接、可达入口和实际已发请求。

当前主源码扫描未找到直接Socket/NetConnection/ExternalInterface调用；这只是主模块的字面调用结果。通过宿主对象的方法可在当前代码外执行服务访问，其他模块动态行为也不由此清单排除。构建的FileAttributes保留本地文件模式；是否联网还受播放器沙箱/信任配置与宿主环境影响，本审计没有做网络抓包，不能作“零外连”断言。

以后新增本地章节无需重新接入这些在线能力。验收本地任务、战斗与存档时应继续不注入serviceHold、不点击在线兑换/充值/论坛，记录本地资源及测试SO路径。若另行希望恢复云存档或在线活动，应作为明确的新需求研究协议和授权；本次源码恢复不包含该接入。
