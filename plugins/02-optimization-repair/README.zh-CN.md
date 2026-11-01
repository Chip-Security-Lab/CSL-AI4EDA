# Optimization & Repair Plugin

[首页](../../README.zh-CN.md) · [English](README.md) · [完整使用手册](USER_GUIDE.zh-CN.md)

面向 RTL 侧信道缓解与时序优化，生成完整候选并展示功能、形式及任务对应的测量证据。

版本 **0.5.3**，安装包 `rtl-optimize-repair-0.5.3.vsix`；扩展标识 `rtl-research.rtl-optimize-repair`。正式入口为 **Windows 本地 VS Code 1.100+**。Vivado 通过 VS Code 设置接入工程与时序分析，不另提供原生 Vivado 插件安装包。

## 下载与上手

当前为试用分发版本。从 [optimization-repair-v0.5.3](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/optimization-repair-v0.5.3) 获取 VSIX，在 VS Code 扩展页选择“从 VSIX 安装”，重新加载后打开并信任自己的本地 RTL 文件夹。

VSIX 内含后端、手册、规则和示例；用户仍需准备 Windows Python（推荐 3.12 64 位）、Windows Icarus、已初始化的 WSL/Linux 验证环境与自己的模型服务。时序优化还需 Vivado、器件支持、精确 PART 和有效 XDC。依赖按钮按需创建专用环境，不替代系统软件安装。

进入 **CSL → 设置**检查工具环境、保存模型，然后从[示例](examples/README.md)开始。详细字段、Vivado 接入、候选查看和问题处理见[完整手册](USER_GUIDE.zh-CN.md)。

## 结果范围

侧信道任务确认真实敏感 input；时序任务读取 Vivado 工程或手动提供 PART/XDC。候选可查看、比较和另存，不自动覆盖源文件。运行完成、候选生成、指标改善、时序闭合、形式证明与物理安全分别判读。

- [类型支持与前提](SIDECHANNEL_TYPES.md)
- [结果与验收范围](ACCEPTANCE_CONTRACT.md)
- [验证状态](DELIVERY_STATUS.md)
- [版本说明](CHANGELOG.md)
- [研究组件与第三方说明](THIRD_PARTY.md) / [MIT 文本](LICENSE.txt)
