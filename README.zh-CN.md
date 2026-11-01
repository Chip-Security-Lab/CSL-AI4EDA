# CSL_AI4EDA

<div align="center">

**面向芯片设计的 AI 插件 · AI Plugins for Chip Design**

[English](README.md) · [简体中文](README.zh-CN.md)

[插件概览](#插件概览) · [下载说明](docs/DOWNLOADS.md) · [使用说明](docs/USER_GUIDE.zh-CN.md) · [框架说明](docs/ARCHITECTURE.md)

<img src="assets/overview-plugins-minimal.en.png" alt="CSL_AI4EDA 按漏洞检查、优化、生成、问答顺序展示四类插件，末尾省略号表示还有新插件在开发。" width="1200">

</div>

CSL_AI4EDA 汇集 RTL 漏洞检查、优化与修复、Verilog 生成和 HDL 问答插件。各插件独立维护版本，环境要求以各自使用说明为准。

**当前提供试用分发版本。** 完整新机器及安装版真实 VS Code 端到端验收仍待完成，已验证范围见各插件说明。

仓库提供插件介绍、安装与使用说明、示例设计；安装包通过各插件对应的 GitHub Releases 分发。开发工程另行维护，安装包内可能包含可读的运行脚本及第三方组件。

## 插件概览

| 插件 | VS Code 包版本 | 主要用途 | 交互入口 |
| --- | --- | --- | --- |
| [Security Detection Plugin](plugins/01-security-detection/README.zh-CN.md) | 0.1.1 | RTL 漏洞检查与多模块权限分析 | VS Code＋配套运行目录；Vivado Tcl 入口 |
| [Optimization & Repair Plugin](plugins/02-optimization-repair/README.zh-CN.md) | 0.5.3 | 侧信道缓解与时序优化 | Windows 本地 VS Code；时序流程连接 Vivado |
| [Secure Generation Plugin](plugins/03-secure-generation/README.zh-CN.md) | 0.3.15 | 知识辅助 Verilog / FSM 生成 | VS Code；Vivado 配套界面 |
| [HDL Copilot Plugin](plugins/04-hdl-copilot/README.zh-CN.md) | 0.3.4 | HDL 问答、代码解释与修改建议 | VS Code；Vivado 配套界面 |

具体下载文件、依赖、示例入口和验证范围见各插件页面。检测插件需要 VSIX 与配套后端运行包；优化插件的 VSIX 已包含后端。Vivado 桥接和配套界面的安装方式分别说明。

## 开始使用

1. 按任务选择插件，先确认其系统和工具要求。
2. 根据[下载说明](docs/DOWNLOADS.md)获取该插件对应版本的文件。
3. 按插件手册安装，并在需要时配置自己的模型服务。
4. 先运行随附示例，审阅候选代码和实际验证结果后再用于设计。

## 仓库结构

```text
CSL-AI4EDA/
├── README.md
├── README.zh-CN.md
├── DISTRIBUTION_NOTICES.md
├── assets/                       总览图与实验室标识
├── docs/                         下载导航、使用导航、框架说明
└── plugins/
    ├── 01-security-detection/
    ├── 02-optimization-repair/
    ├── 03-secure-generation/
    └── 04-hdl-copilot/
```

各插件目录保留中英文介绍、使用说明、版本记录、分发说明和已有示例。安装包作为 Release 附件，不放入上述仓库目录。

## 文档入口

- [文档索引](docs/README.md)
- [下载与安装格式](docs/DOWNLOADS.md)
- [中文使用说明](docs/USER_GUIDE.zh-CN.md) / [English user guide](docs/USER_GUIDE.md)
- [框架说明](docs/ARCHITECTURE.md)
- [分发与来源说明](DISTRIBUTION_NOTICES.md)

## 联系我们

<div align="center">

<img src="assets/chip-security-lab.jpg" alt="芯片与安全实验室 · Chip Security Lab" width="220">

<p><strong>微信公众号：</strong>芯片与安全实验室</p>
<p>在微信中搜索“芯片与安全实验室”，关注实验室动态。</p>
<p><strong>联系邮箱：</strong><a href="mailto:zitenghu@hdu.edu.cn">zitenghu@hdu.edu.cn</a></p>

</div>
