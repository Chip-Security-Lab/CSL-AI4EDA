# Secure Generation Plugin 使用说明

[插件介绍](README.zh-CN.md) · [English](USER_GUIDE.md) · [示例](examples/README.md)

## VS Code 安装

使用桌面 VS Code 1.85+。扩展页 → `…` → **从 VSIX 安装**，选择 `CSL_HDLGen-VSCode-0.3.15.vsix`，按提示重新加载，打开可信的本地项目文件夹。点击活动栏 G 图标。首次打开会显示四步引导，可跳过或用右上角 **?** 重看。

预置演示无需 Python 或模型配置。自定义生成需要 Python 3.10+；必要时在用户设置 `cslHdlgen.pythonPath` 指定解释器。知识库已内置，无需 Neo4j 或额外 Python 包。

## 模型和生成

模型设置中一次保存接口基础地址、模型名和 API Key。常见基础地址以 `/v1` 结尾，不追加 `/chat/completions`；远端使用 HTTPS，本机服务可使用 HTTP。VS Code 密钥由安全存储保存。实际生成会向所选服务发送需求及相应知识上下文，附加文件仅在允许引用时发送。

选择**通用安全生成**或 **FSM 安全生成**，描述端口、行为、时钟复位和安全要求；FSM 还需状态、转移及输出。点击生成或 `Ctrl+Enter`，依次审阅代码、安全知识与安全报告。通用 RTL 可继续低功耗优化；多版本 FSM 通过选择器比较，确认功能修正建议与意图一致后再采用。

复制或“打开为文件”可保存当前选中的版本。替换已有文件采用 **绑定文件 → 生成 → 查看写入差异 → 写入绑定文件**，确认后备份并写入；只有勾选“允许模型引用绑定文件”才把其内容送入请求。

## 离线演示和案例

点击**运行演示**查看预置结果；FSM 提供常规案例和不可达状态功能修正案例。也可解压 `CSL_HDLGen-Demos.zip`，双击其中三个 HTML，或从仓库的[离线演示说明](examples/demos/README.md)进入；无需安装或网络，这些固定预览不调用模型或运行 HDL 验证。

[案例总说明](examples/README.md)区分三类案例：CSR 安全与低功耗参考、常规 FSM，以及 FSM 原版/功能修正版。CSR 仅静态对照；FSM 保存以前的有限检查与日志。25 个案例文件保持原样，可从 VSIX、Vivado 配套包或独立 Examples ZIP 获取。常规 FSM 与功能修正案例可按各自 README 使用 Icarus 重跑，CSR 不含 testbench 或通过记录。

## Vivado

完整解压 `CSL_HDLGen-for-Vivado.zip`，保留目录结构。按照[Vivado 详细说明](VIVADO_GUIDE.zh-CN.md)设置 Python 并 source 安装脚本。G 按钮支持 Tcl 和独立浏览器窗口；Tkinter 仅用于可选模式选择框。

模型配置在服务内存中保存，Vivado 退出后丢失。当前文件指工程 Sources 中选择、与结果绑定的磁盘 HDL，写入前先保存编辑器、核对完整路径和差异。确认写入会备份原始字节并进行整文件替换；切换工程/文件或外部修改会阻止过时结果覆盖。写入后重新加载编辑器，避免旧缓冲覆盖。

## 范围

本次整理未新增真实模型、Vivado GUI、全新机器安装或独立 HDL 仿真验证；已有验证记录按原样保留。生成结果仍是草稿，安全报告不构成证明，低功耗优化未自动完成等价性或功耗测量。当前每个结果提取一个完整 Verilog-2005 模块，多个 FSM 版本分别展示。
