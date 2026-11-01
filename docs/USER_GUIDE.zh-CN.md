# 使用说明

[首页](../README.zh-CN.md) · [English](USER_GUIDE.md) · [下载说明](DOWNLOADS.md)

先选择插件，再按照该插件自己的环境要求和安装说明操作。四个插件以及不同交互入口的依赖并不相同。

| 任务 | 安装与使用 | 示例 |
| --- | --- | --- |
| RTL 漏洞及多模块权限检查 | [Security Detection](../plugins/01-security-detection/USER_GUIDE.zh-CN.md) | [示例入口](../plugins/01-security-detection/examples/README.md) |
| 侧信道缓解与时序优化 | [Optimization & Repair](../plugins/02-optimization-repair/USER_GUIDE.zh-CN.md) | [示例入口](../plugins/02-optimization-repair/examples/README.md) |
| Verilog / FSM 生成 | [Secure Generation](../plugins/03-secure-generation/USER_GUIDE.zh-CN.md) | [示例入口](../plugins/03-secure-generation/examples/README.md) |
| HDL 问答与代码讨论 | [HDL Copilot](../plugins/04-hdl-copilot/USER_GUIDE.zh-CN.md) | [示例入口](../plugins/04-hdl-copilot/examples/README.md) |

需要模型服务的流程应配置自己的接口、模型名和凭据。相关 RTL、需求与上下文可能发送到所选服务；不要把密钥写入 RTL、示例或公开报告。

从示例副本开始，检查候选和实际证据，再进行设计所需的功能、时序及安全验证。生成回答、运行完成或可以导出 RTL，本身都不代表结果已经正确或安全。

各版本的下载文件和组合方式见[下载说明](DOWNLOADS.md)，插件之间的边界和交互入口见[框架说明](ARCHITECTURE.md)。
