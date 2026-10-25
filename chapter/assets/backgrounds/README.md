# 归光之约 · 场景背景

三张不透明宽幅背景，供终章的 1600×580 世界使用。使用内置 `image_gen.imagegen` 分别生成；不是原作导出素材。生成前查看原作运行截图 `chapter/evidence/private/004-fixed-mentor-marker.png`，只参考深蓝石墙、青色辉光、金色饰边和描线笔触。没有编辑该截图，也没有把它的 UI、人物或文字拼入背景。

| 文件 | 场景与辨识元素 | 当前检查 |
| --- | --- | --- |
| `dock-v1.png` | 归航码头：海皇城外港、暗色城墙、海面、远航灯、运输船远景。 | 全幅覆盖，无人物/文字；近地带留白。 |
| `warden-v1.png` | 司灯遗址：青蓝日光、海蚀拱廊、墙体潮汐透镜、水道和残破穹顶。 | 与码头明显不同；透镜属于远景建筑，前景无交互机器。 |
| `regent-v1.png` | 破冠王座厅：空圆厅、深紫阴影、金属肋骨、破冠穹顶和远处束光。 | 中下部开阔，无王座/Boss/人物，程序层可绘制王座首领。 |
| `manifest.json` | 实际宽高、文件 SHA-256、提示词 SHA-256、生成方式与接入状态。 | 读取原始 PNG 头得到尺寸，未修改图像。 |
| `prompts/*.txt` | 三次独立生成的完整原文提示词。 | 与生成调用对应，可用于下一轮修订。 |

所有图片实际尺寸均为 **2081×755**，比例 2.7563；目标 1600×580 比例为 2.7586。可在 AS3 的 Bitmap 显示对象上设置 `width=1600; height=580`，像素尺寸差异带来的纵横比例变化约 0.1%。保留这些原始生成文件，不需要先破坏性缩放。

## 接入建议

- 背景放在世界坐标 `(0,0)`、程序场景层与地板之下，覆盖完整世界宽度，随世界滚动。
- 这三张图是完整背景，原 Map81 的旧背景若还露在上层，应由主集成任务确定隐藏/替换层次。
- 游戏地板保持原定 `y=450`；底部暗带作为铺地的底图。码头实际平坦近地带开始得更高，不改变程序碰撞。
- 图内建筑、水面、透镜均无碰撞和交互；锁链、继电器、救援居民、Boss 与仪式节点由程序独立绘制。
- 司灯遗址比另外两张明亮，建议运行时检查青色/紫色预警和金色地波在其上是否足够清楚；不要仅凭背景缩略图宣称战斗对比度合格。
- 在相机最左与最右、Boss 两阶段、对白和结局仪式场景分别取图，确认无右侧灰底、边缘漏出、过度拉伸或前景混淆。

## 验证与来源

2026-10-26：已经逐张检查内置工具的真实成品，并把原始 PNG 复制到本目录；提示词、原始尺寸与 SHA-256 已保存。当前美术子任务**未改动 canonical 源码、未构建、未控制播放器**，因此这里表示“资产已生成并完成目视检查”，不表示“游戏内接入已验收”。

内置工具同时保留了其默认输出；项目实际使用应引用本目录的副本，不依赖用户机器上的缓存目录。

## 受控导入与 AS3 接口

`reverse/tools/chapter_source.py` 现在将背景纳入显式 `import` / `verify`：校验 manifest 版本、固定三种 scene、固定文件与提示词路径、PNG 文件和提示词 SHA-256、文件大小及 IHDR 实际尺寸。导入凭据的 canonical 哈希覆盖 manifest、三张 PNG、三份提示词及原故事/任务数据。原任务逐条不变、167 条基线和三个专用任务的校验仍保留。

显式运行 `python3 reverse/tools/chapter_source.py import` 后，会写入：

- `chapter/generated/overlay/_assets/chapter/dock.png`
- `chapter/generated/overlay/_assets/chapter/warden.png`
- `chapter/generated/overlay/_assets/chapter/regent.png`
- `reverse/source/3_L4399Main_gamefile/src/epilogue/scene/ChapterBackdrop.as`
- 原有故事类、任务 overlay 与 `chapter/generated/import.json`

`ChapterBackdrop.as` 是生成文件。其 Embed 路径引用上述 overlay 进入编译 staging 后的 `/_assets/chapter/*.png`，不引用用户缓存或项目外路径。要修改生成代码，在 `chapter_source.py` 的 `background_outputs()` 修改模板再导入。

```actionscript
import src.epilogue.scene.ChapterBackdrop;
var backdrop:ChapterBackdrop = new ChapterBackdrop("dock"); // 或 warden / regent
Main.world.moveChild_Back.addChildAt(backdrop, 0);
// 背景 Bitmap 启用 smoothing，并显示为 1600×580；类本身不改变世界或地板。
// 世界销毁时可调用 backdrop.dispose()，不拥有 Controller 的生命周期。
```

未知 scene 会抛出 `ArgumentError`，避免错误场景悄悄使用另一张图。类不接收输入、不自带碰撞、不注册逐帧监听。构建 overlay 只复制 import receipt 中声明的产物，不再复制未登记的残留文件。

接入任务已经对 `expected()` 进行只读验证，并用内存模拟验证四种错误会被拒绝：PNG 单字节篡改、提示词改变、manifest 越界路径、重复 scene。**尚未由美术子任务执行完整 import 或构建**。主集成任务应先导入，再用其完整构建/指纹流程验证；已在 canonical `mx/core/BitmapAsset.as` 新写最小兼容支撑类，继承 `flash.display.Bitmap` 并实现现有空标记接口 `IFlexAsset`；这不是原作复原代码，也不是完整 Flex 框架。其构造器保持 BitmapData / pixelSnapping / smoothing 签名，供 Flex 生成的 PNG Embed 子类调用。

构建链核查：`build_main.py --all-definitions` 自动枚举 staging 中所有 `.as` 作为 `-includes`，新增 ChapterBackdrop 与 BitmapAsset 会进入该枚举；本次未找到另一份独立扩展类允许名单，也没有削弱任何检查。主任务负责将 `chapter/assets/backgrounds` 加入构建输入树；generated overlay 本身已在原有 `chapter/generated` 指纹中。

## 主任务接入复核（候选3）

三张背景已通过受控导入并编入严格包；司灯实际冷读、战斗、第二阶段与死亡重试截图见 evidence/private/012–016。玩家已置于首领机器前景；司灯场景无右侧灰底。另两场景尚待实际运行检查，不能将此局部证据当最终验收。新增类与背景现另有 `chapter/content/extensions.json` 显式清单，import/verify 检查精确集合，不再只有自动枚举。
