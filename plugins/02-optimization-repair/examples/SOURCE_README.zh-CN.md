# 内置示例：先从这里开始

这是随插件分发的示例副本。没有 API Key，也没有历史运行。

## 第一次侧信道任务

1. 打开 `single-rtl/register_toggle_two_hotspots.v`。
2. 在 RTL 插件新建侧信道任务，选择本地文件，选中这份文件。
3. 敏感输入选 `key` 并确认；先保持默认 T01/T04，不用填写实验资源。
4. 选择你自己的模型，点击“生成候选”。先核对功能、形式与实测热点，再看是否改善。

该文件是故意植入两个热点的教学电路，带 clk/rst_n/start/done 和已有 mask_i 输入；不是标准密码算法。`single-rtl/leaky_register_aes128.v` 是更复杂 AES 样例，其说明和测试平台在同目录；有完整算法不意味着任意模型候选能被修复成功。

## 八类实验

`sidechannel-online/` 下是 T02/T03/T05/T06/T07/T08/T09/T10 的代表性输入；`specs.json` 保存每个输入需要的真实资源注释和补充要求。默认自动分析全部类型；出现缺项后按该文件补充，不要凭空宣称随机资源独立。

曾实测部分改善仅适用于记录的候选与条件，不保证每次在线生成都改善，也不代表物理功耗安全。

## 时序样例

`timing-closure-demo/baseline/` 是时序分析输入，配套 XDC 位于 `timing-closure-demo/` 中。需要选择你实际安装器件支持中的精确 PART，并核对 XDC 的端口与时钟。也可放入自己的纯 RTL Vivado 工程，再自动连接读取约束。

`timing-closure-demo/candidate/` 是历史显式变延迟测试夹具，不能当作当前“保持可见周期行为”的合格优化结果。详细契约见该目录 README。

`single-rtl/type-expansion/` 保留早期类型用例，不代表这些输入都已经修复。

完整安装、模型配置与输入说明见插件命令“RTL：使用手册”。
