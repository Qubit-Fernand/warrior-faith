# DataX 的 11 份 XML

这些 XML 从原版 ABC 的字符串池逐字节提取，映射和摘要见 `reverse/experiments/datax-recovery/recovery.json`。请保持 UTF-8；无需重新格式化文件才能编辑。

常规构建读取 `reverse/source/DataX_v76/` 中的 AS，不自动读取这里，以免覆盖用户手改的 InData。编辑这里的 XML 后显式运行：

```sh
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/datax_source.py import-xml
/opt/miniconda3/envs/Qubit/bin/python reverse/tools/datax_build.py
```

import-xml 仅更新 InData 中对应的字符串字面量，保留其他 AS 代码并将修改前文件归档到忽略的构建目录。也可直接编辑 InData；此时不要再用未同步的 XML 文件覆盖它。当前构建验证器允许 XML 数据改变，方法调用结构改变需要另行更新语义验证。
