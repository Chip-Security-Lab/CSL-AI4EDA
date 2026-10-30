# User guide

[Home](../README.md) · [简体中文](USER_GUIDE.zh-CN.md)

This first publication contains documentation and figures. Source code, plugin engineering files, and installation packages will be published separately. This checkout does not provide an installable or runnable plugin; the workflows below explain how the plugin interfaces are used when their distributions are available.

## Choose a plugin

| Plugin | Purpose |
| --- | --- |
| **HDL Copilot Plugin** | Understand Verilog/SystemVerilog, discuss questions, and review suggested changes. |
| **Secure Generation Plugin** | Generate RTL and FSM drafts with hardware-security knowledge: **PowerSecV (CWE) + SecFSM**. |
| **Security Detection Plugin** | RTL vulnerability and multi-module access analysis: **VerilogLAVD (CWE)** and multi-module access checks. |
| **Optimization & Repair Plugin** | Side-channel and timing-issue repair. |

## Prepare the environment

The local HDL Copilot and Secure Generation implementations use Python 3.10+ and provide VS Code and Vivado interfaces. The VS Code interfaces require desktop VS Code 1.85+ and a trusted workspace. The Vivado interfaces use its Tcl Console and a companion window; the small mode picker requires Python's Tkinter support.

For model-backed use, configure a text model service compatible with the Chat Completions API:

| Setting | Meaning |
| --- | --- |
| API base URL | The provider's base URL, such as `https://api.example.com/v1` (format example only). Do not append `/chat/completions`. |
| Model name | The model identifier accepted by that provider. |
| API key | The provider's credential, if required. |

Questions, relevant RTL, and conversation or generation context are sent to the configured model service. Use source material you are permitted to send to that service.

## HDL Copilot Plugin

1. Open the relevant RTL file and describe the expected behavior or the question.
2. Send the question, read the response, and continue in the same conversation for follow-up questions.
3. Request a modification proposal when a change is needed, then inspect the difference before adopting it.

Example: “Explain this counter's reset and wraparound behavior. Suggest a minimal change while preserving the ports.”

| Interface | Code context | Adopting a suggestion |
| --- | --- | --- |
| VS Code | Current editor buffer, including unsaved edits | Preview the difference, then explicitly apply it. Applying does not automatically save the file. |
| Vivado | Selected RTL file's saved disk content | Save before asking; preview and copy the suggestion into your editing workflow. The assistant does not write back to the project. |

## Secure Generation Plugin

1. Select the general RTL or FSM workflow and describe the design's ports, reset, behavior, and constraints.
2. Generate a draft and review the code alongside its security-knowledge references and review report.
3. Review the target file and differences before confirming a write or project import in the relevant interface.
4. Compile and simulate the resulting RTL and perform the checks required by the design.

Example: “Generate a synchronous counter with an enable input and active-low reset. Specify the wraparound behavior.”

Generated code remains a draft. A model review does not establish functional correctness or the absence of vulnerabilities.

## Security Detection and Optimization & Repair

The overview introduces their functional roles and technical groupings. Installation, supported inputs, result interpretation, and operating instructions will accompany their respective distributions; this documentation snapshot does not provide executable workflows for them.
