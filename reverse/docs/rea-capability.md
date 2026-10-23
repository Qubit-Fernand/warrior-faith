# REA 对本游戏的实际能力与边界

验证日期：2026-10-24（北京时间）。本轮没有执行游戏、修改存档、逆向播放器 EXE、注册全局 MCP 或更改第三方 REA 仓库。

## 结论

**当前 REA 不能替代 FFDec 来反编译本包的 SWF/AVM2/ActionScript。** 实际对 `3_L4399Main_gamefile.swf` 调用 `inspect-artifact`，发布包和本地源码编译版都返回 `target_unavailable / unsupported_target / file_format_rejected`，原因是 `unsupported binary format`。

REA 本地源码版的 `inspect-byte-entropy` 能读取 SWF 作为普通文件，提供完整 SHA-256、长度、分块熵和可追溯 Evidence。这是字节特征和来源核对工具，**不产生脚本、类依赖、时间轴或可编译工程**。

因此实际分工是：

- FFDec：SWF/ABC 结构、脚本和资源导出，ActionScript 恢复与替换实验。
- REA：经过实际调用确认的格式边界、普通文件特征和 Evidence；借鉴其“静态结果不等于运行等价”的验收约束。
- 项目自己的清单和构建脚本：关联 SWF、导出文件、修复及运行验证结果。不会把自行提取的数据冒称为 REA 的 SWF 分析能力。

## 版本陷阱：同为 6.7.0，不代表同一实现

第三方源码仓库提交是 `2452efa9211d09e0acdf8cf9bfbf82a96f5a3522`，`package.json` 声明 `6.7.0`。本轮也安装了 npm 的精确发布版本 `rea-agents@6.7.0`，但它没有 `inspect-byte-entropy` 命令；命令返回 `COMMAND_NOT_FOUND`。源码树中存在该命令，隔离构建后实际调用成功。

所以本报告同时记录 **源码提交、npm 完整性摘要和实际命令行为**，不单凭版本号认定功能相同。npm 发布包 SHA-512：

```text
sha512-yhIx2ioJYYT1C/tONfYeitC6LhnKmCh+ZwRUOgYuhSc733lGhkkt73zhug9WmLgxoMdKuqIYGCoBfD4fXkOhFw==
```

安装与运行使用 mise 管理的 Node `26.11.1`，源码构建通过，日志显示 3/3 个构建任务成功。npm 安装关闭生命周期脚本；没有安装 Hopper/Ghidra，也没有运行 `rea setup`。源码构建只有动态导入不分包的警告，不影响这些命令。

## 已运行的探测

完整命令、退出状态、耗时、文件摘要及 Evidence ID 见 `reverse/manifests/rea-probe.json`。完整原始响应保留在该清单指向的忽略目录 `reverse/logs/rea-probe-*/`。

| 命令与输入 | 结果 | 可得结论 |
|---|---|---|
| 发布包 `inspect-artifact`，原版主 SWF | 退出 1，不支持格式 | 发布包不能通过此入口解析 SWF |
| 发布包 `inspect-byte-entropy`，原版主 SWF | 退出 1，无该命令 | 发布包落后于本地同版本号源码 |
| 源码版 `capabilities`、`providers` | 退出 0，保留原响应 | 当前环境的能力与 provider 目录 |
| 源码版 `inspect-artifact`，原版主 SWF | 退出 1，不支持格式 | 编译本地源码也未获得 SWF 解析器 |
| 源码版 `inspect-byte-entropy`，原版主 SWF | 退出 0，27,160,482 字节，7.8775 bits/byte | 文件完整摘要和统计特征 |
| 源码版 `inspect-byte-entropy`，`Map1.swf` | 退出 0，1,982,378 字节，7.9975 bits/byte | CWS 容器字节特征 |
| 源码版 `inspect-byte-entropy`，解压后的 Map1 FWS | 退出 0，2,241,238 字节，7.9090 bits/byte | 仅解压后的容器字节特征 |

主 SWF 是 **FWS**，并非 CWS；162 个其他 SWF 是 CWS，全包还有另一个 FWS。首次探测脚本曾错误假设主程序为 CWS，在读取签名后立即拒绝并退出，没有生成错误转换产物。随后改为对真正的 CWS `Map1.swf` 做对照。

Map1 转换仅由 Python `zlib.decompress` 解压偏移 8 后的 CWS 内容，修改签名为 FWS，并验证输出长度等于头部声明长度；没有反编译或重编译。原文件在调用前后的 SHA-256 一致。

高熵不能证明加密，更不能证明需要破解保护。REA 自己也明确报告该限制；压缩素材和容器本来就可能高熵。以上测试不构成玩法、脚本完整性或重建等价的证据。

## 复现

当前可直接运行：

```sh
cd ~/Games/勇者的信仰-逆向
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/rea_probe.py
```

它使用 `.runtime/rea/source/scripts/rea.mjs`，生成新的时间戳日志并刷新 `rea-probe.json`。不会执行 SWF 或写存档。

从空缓存准备同一版本时，用新的目录保留已有产物，不覆盖原第三方仓库：

```sh
cd ~/Games/勇者的信仰-逆向
mkdir -p .runtime/rea/source
git -C ~/Documents/Code/第三方/rea archive 2452efa9211d09e0acdf8cf9bfbf82a96f5a3522 | tar -x -C .runtime/rea/source
mise exec node@26.11.1 -- npm ci --prefix .runtime/rea/source --cache .runtime/rea/npm-cache --ignore-scripts --no-audit --no-fund
cd .runtime/rea/source
mise exec node@26.11.1 -- npm run build:cached
```

以上源码副本来自确切 Git 提交；原第三方仓库保持干净。构建和依赖文件都在忽略的 `.runtime/rea/` 内。`npm run build:cached` 是该仓库提供的构建命令；重建时它会管理自己副本中的生成缓存，因此只在隔离副本中运行。

## 源码与契约证据

以下路径相对于 REA 源码提交 `2452efa`：

- `src/cliCommandNames.ts`：完整 CLI 名称目录，无 Flash、SWF、AVM2、ActionScript、FFDec 命令。
- `src/artifacts/ArtifactReader.ts:167`：容器读接口支持 directory、ZIP 系列、ASAR、Godot PCK、PyInstaller 和普通 file；没有 SWF 容器读接口。
- `src/cli/coreNativeCommands.ts:25`：`search-bytes` 针对 provider 初始化后的原生内存，不是无需 provider 的任意文件字符串扫描器。
- `src/cli/coreNativeCommands.ts:75`：`read-bytes` 同样要求原生分析地址；不能直接解释 SWF 的 ABC 地址。
- `src/cli/binaryDiagnosticsCommands.ts:60`：通用字节熵工具；`docs/binary-diagnostics.md:219` 明确其能力和非加密证明限制。
- `src/domain/reconstructionObligationLedgerSchemas.ts:445`：REA 有 Evidence 驱动的重建义务清单，但需要有来源的 Evidence、审阅后的义务及绑定；不会自动从不支持的 SWF 生成完整重建需求。未为展示工具而制造“已验证”的虚假绑定。
- `.agents/skills/reverse-engineer-anything/SKILL.md`：采用其 CLI fallback 和区分静态/运行证据的工作方式；没有执行全局配置流程。

对 `src/` 和 `docs/` 的 `SWF|AVM2|ActionScript|FFDec|\.swf` 搜索无匹配。该负结果仅限定上述提交和搜索范围；更强的边界证据是两个实际 `inspect-artifact` 的格式拒绝。未来版本或外部插件支持状况不在本轮验证范围内。

## 后续建议

继续以 FFDec、ABC 清单、Flex 编译及隔离运行测试推进本游戏。不要把安装新的原生反汇编器或逆向 Flash Player 当成恢复游戏源码的前提。若以后需要 REA 统一消费 FFDec 结果，应先设计显式记录 SWF 摘要、ABC/脚本标识和导出工具版本的独立适配器，不能把 AS3 假装成 JavaScript 后宣称已分析。
