# CSL_AI4EDA

<div align="center">

**面向 RTL 设计流程的实用 AI 插件**

[English](README.md) · [简体中文](README.zh-CN.md)

[插件概览](#插件概览) · [使用说明](docs/USER_GUIDE.zh-CN.md) · [框架说明](docs/ARCHITECTURE.md)

<img src="assets/overview-plugins.en.png" alt="CSL_AI4EDA 由 HDL Copilot、安全生成、安全检测、优化与修复四类插件组成。" width="1200">

</div>

CSL_AI4EDA 围绕 RTL 设计流程组织 AI 辅助能力，涵盖设计问答、知识辅助生成、安全分析，以及优化与修复。

本次先发布**目录框架、使用说明、首页介绍和总览图**。具体实现代码、插件工程文件及安装包将在后续实现发布时提供。

## 插件概览

| 插件 | 主要用途 | 对应设计阶段 |
| --- | --- | --- |
| [**HDL Copilot Plugin**](plugins/hdl-copilot/README.md) | 理解 RTL、解答设计问题、审查修改建议。 | 贯穿设计流程 |
| [**Secure Generation Plugin**](plugins/secure-generation/README.md) | 结合安全知识，按需求生成 RTL 与 FSM 草稿。 | RTL 编写 |
| [**Security Detection Plugin**](plugins/security-detection/README.md) | 定位 RTL 漏洞，分析多模块访问权限。 | 检查与验证 |
| [**Optimization & Repair Plugin**](plugins/optimization-repair/README.md) | 处理侧信道与时序问题。 | 优化与完善 |

总览图中的流程条提供设计阶段背景，包含综合与实现阶段。各插件的能力范围和文档由对应介绍页分别说明。

## 如何阅读和使用

1. **选择插件**：根据当前设计任务，从上表进入相应介绍页。
2. **阅读[使用说明](docs/USER_GUIDE.zh-CN.md)**：了解交互方式、模型配置和结果审阅流程。
3. **查看[框架说明](docs/ARCHITECTURE.md)**：了解各插件文档及后续实现入口的组织方式。

使用说明介绍 HDL Copilot 和 Secure Generation 已有的 VS Code / Vivado 交互方式；安装下载及可执行入口会随具体实现一同发布。

## 仓库结构

```text
CSL-AI4EDA/
├── README.md
├── README.zh-CN.md
├── assets/                       总览图与图片说明
├── docs/                         使用说明与框架文档
└── plugins/
    ├── README.md
    ├── hdl-copilot/README.md
    ├── secure-generation/README.md
    ├── security-detection/README.md
    └── optimization-repair/README.md
```

## 文档入口

- [文档索引](docs/README.md)
- [中文使用说明](docs/USER_GUIDE.zh-CN.md) / [English user guide](docs/USER_GUIDE.md)
- [框架与插件接口说明](docs/ARCHITECTURE.md)
- [插件目录](plugins/README.md)

问题和文档建议可通过仓库的 [Issues](https://github.com/Chip-Security-Lab/CSL-AI4EDA/issues) 反馈。
