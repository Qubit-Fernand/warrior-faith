# Main 显式扩展清单

`chapter/content/extensions.json` 声明本章相对原 FFDec `RAW/scripts` 新增的 AS 类及三张受控背景资源。`reverse/tools/chapter_source.py` 在生成、验证和构建调用的 overlay 路径上执行检查。它不扫描到新增文件后自动认可、不自动修改其他 canonical 源码。

## 基线与新增的区分

- Main 原始导出为 **710 个 AS 文件**，以 `reverse/manifests/recovered-sources.json` 的 Main 条目为准。清单固定该来源账本的 SHA、源目录、RAW 目录和脚本数量。
- 当前 canonical 是 **725 个 AS 文件**，相对 RAW 新增 **15 个**，逐个列出路径、完整类名、类型和用途。`authored` 是手写新增类，`generated` 是受控生成类，`compatibility` 是本章新增兼容支持。
- `mx/core/IFlexAsset.as` 与 `mx/core/ByteArrayAsset.as` 已在原始 710 个文件中，不能重复列成新增。`mx/core/BitmapAsset.as` 原导出没有，是为本章 PNG Embed 增加的最小兼容类，须明确列出。
- 允许修改 canonical 中的原类来接入新章，不要求其内容与 RAW 字节相同；原类不得缺失。实际编译仍由原有 build input/source hash ledger 固定源码内容，本清单不会替代该检查。

## 检查内容

1. 原 Main SWF 摘要、原来源账本摘要、710 个 RAW AS 的完整集合与逐文件 SHA，以及原任务资产 SHA 均须与保存的来源一致。
2. canonical 必须保留全部原 AS；actual canonical−RAW 集合必须与新增清单完全一致。遗漏、重复、虚构多列或把已有兼容类列成新增均拒绝。
3. 新类路径必须与公开包名／类名一致。文档根仍为 `src.Main`：同时核对 canonical 声明与原导出的 SymbolClass 0 绑定。
4. 路径必须是规范 POSIX 相对路径，拒绝绝对路径、`..`、`.`、双斜线、反斜线、驱动器冒号、NUL、解析后越出允许根的路径及扫描树内符号链接。根目录字段只能取固定的本工程路径。
5. 背景清单必须正好包含 dock／warden／regent 三项，source 与 overlay 路径按场景严格对应。原背景 manifest 中的图片／prompt SHA、PNG 签名、尺寸、比例、透明度和字节数检查保留。额外背景数据输入与额外 overlay 文件均拒绝；背景目录中的 `.md` 说明文件不作为资源生成输入。
6. 生成输出集合固定为两个生成 AS、三张背景 PNG 和现有任务 XML overlay。两个生成 AS 是 `ChapterContent.as`、`scene/ChapterBackdrop.as`。导入收据记录扩展验证结果，verify 继续逐字节及摘要检查生成输出。
7. 原任务检查保留，并补强“原任务被删除”情况：原 167 条任务必须全部存在且内容不变；只允许新任务 190001–190003，保留原有保留类型与零金币／经验要求。

根类、源码指纹、SWF 头、脚本资产与原 ABC 不复用等构建／组装检查仍由既有工具执行；没有为新章放宽或替换。

## 使用方式

只读检查声明、原任务、来源和已有扩展资源，不改收据或生成物：

```sh
PYTHONDONTWRITEBYTECODE=1 /opt/miniconda3/envs/Qubit/bin/python reverse/tools/chapter_source.py validate-extensions
```

新增／移除类时，人工审阅后同时修改 `extensions.json`。新增背景类型还需修改 importer 的固定生成合同；不能仅在 JSON 中放任意路径就写入文件。

正常 `import` 会验证清单再生成受控输出，并把清单 SHA 纳入 canonical 输入收据。`verify` 要求所有生成文件已经存在且正确。只有在 import 的预生成检查中，允许缺少明确声明的两个生成 AS／已声明 overlay，由 importer 重建它们；缺失手写类、未知类或额外 overlay 在任何模式下均拒绝。生成内容过期须经显式 import 重新生成，verify 不会修复；类声明或路径已越出合同的文件仍会被拒绝，不会被静默认可。

本次新增 extensions.json 后，旧 import receipt 必然过期，主任务需要显式重新 import，再正常构建。此次子任务没有执行 import、构建、播放器或 Git 操作。

## 检验记录

2026-10-26：当前树只读正例通过，识别 710 原 AS＋15 新增 AS、3 背景及 `src.Main` 根类。41 个变体检查通过（39 个预期拒绝、2 个允许已声明生成物在 import 前缺失）。检查使用内存对象／mock，不改写真实源码或 RAW；覆盖清单漏项／多项／重复、误列已有兼容类、实际新增集合缺失或混入、类声明错误、源路径越界、链接目录、背景与 overlay 多项／缺项／改字节、来源哈希变更、根类变更、原任务删除／改写。另验证仅允许明确声明的生成物在 import 前缺失，严格验证拒绝缺失。

这些是导入边界检查，不代表游戏玩法、画面或运行兼容验证；实际构建验收由主任务完成。
