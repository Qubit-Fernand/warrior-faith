# 逐文件索引

[项目 README](../../../README.md) · [文件手册](../developer-files.md) · [源码指南](../developer-source.md) · [工具手册](../developer-tools.md)

这份索引让每个受版本控制的文件都有查找入口；它不是把19,910个AS文件都逐方法人工逆向过的声明。核心业务职责在源码指南中展开，生成索引中的 `evidence_basis` 明确区分已定位的职责、声明提取、路径归类和待进一步确认。

| 文件 | 用途 |
| --- | --- |
| [modules.md](modules.md) | 全部164个SWF、对应canonical源码目录、AS文件数量与模块用途。 |
| [files.tsv](files.tsv) | 每个文件独立一行；制表符分隔，可用编辑器搜索或表格软件导入后筛选。 |
| [source-families.md](source-families.md) | 模块家族数量与常见跨包重复类；帮助避免改错副本。 |
| [coverage.json](coverage.json) | 索引数量、覆盖边界、缺失文件列表、canonical AS整树摘要。 |
| [generate.py](generate.py) | 文档维护脚本。只读项目文本／Git列表，在本目录更新上述四个输出，不执行游戏或构建工具。 |

## files.tsv的列

- `path`：相对仓库根目录的完整路径。极少数文件名中的控制字符以 `\r`、`\n`、`\t` 显示，例如Finder自定义图标文件；不是可直接照抄的普通路径。
- `module`：该源码所属SWF，不是仅按类名合并后的逻辑模块。
- `purpose`：具体已知职责或有边界的类别说明；未人工确认的业务不从名字强行猜测。
- `evidence_basis`：说明描述的证据程度。
- `package`、`class`、`extends`：实际AS声明的包、类、基类。
- `methods_or_json_keys`：AS/Python方法或类名与行号（`名称@行号`）；JSON则列顶层键，帮助识别报告用途。
- `embed`：AS `[Embed]` 声明，包括素材路径／symbol；配合exports中的 `_assets` 使用。
- `imports`：实际import列表，用于继续追踪依赖；通配符不是解析后的完整调用图。
- `text_lines`：读取为文本时的行数。
- `git_state_at_generation`：生成时已跟踪或新增。索引不包含运行环境／个人存档；四个自身生成文件避免自引用，单列在coverage中。

AS元数据通过声明文本提取，未构造完整语法树／控制流图。方法行号用于导航，修改后会变；不能拿方法名数量当语义覆盖率。JSON报告的顶层键只描述结构，不意味着报告中的结论已针对当前包重测。

## 搜索例子

从项目根目录运行：

```sh
# 按具体类／功能定位，表中保留所属模块，别只挑第一条结果
rg 'LocalSaveManager|TaskData|SuppliesXML' reverse/docs/catalog/files.tsv
# 查全部Map1源码条目
rg '^reverse/source/Map1/' reverse/docs/catalog/files.tsv
# 打开所定位的AS，再以方法名定位
rg -n 'function (GameStart|Save2)' reverse/source/3_L4399Main_gamefile/src/Main.as
```

表格软件打开时选择UTF-8、制表符分隔，建议将列按文本导入。更适合代码阅读的方式是编辑器全文搜索与按路径跳转。

## 更新索引

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/docs/catalog/generate.py
```

覆盖Git已跟踪文件及 `reverse/source`、`reverse/tools`、`reverse/docs` 的非忽略新增文件。忽略的素材、构建包、工具链、日志和私人存档数量会随运行变化，不逐文件扫描；它们的固定目录结构和用途见文件手册。修改源码后重新生成；无需改运行配方或重新编译来更新文档。
