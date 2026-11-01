# User guide

[Home](../README.md) · [简体中文](USER_GUIDE.zh-CN.md) · [Downloads](DOWNLOADS.md)

Choose a plugin first, then follow that plugin's environment and installation guide. System requirements differ between plugins and between their interfaces.

| Task | Installation and usage | Examples |
| --- | --- | --- |
| RTL vulnerability and access checks | [Security Detection](../plugins/01-security-detection/USER_GUIDE.md) | [Provided examples](../plugins/01-security-detection/examples/README.md) |
| Side-channel mitigation and timing optimization | [Optimization & Repair](../plugins/02-optimization-repair/USER_GUIDE.md) | [Provided examples](../plugins/02-optimization-repair/examples/README.md) |
| Verilog and FSM generation | [Secure Generation](../plugins/03-secure-generation/USER_GUIDE.md) | [Provided examples](../plugins/03-secure-generation/examples/README.md) |
| HDL questions and code discussion | [HDL Copilot](../plugins/04-hdl-copilot/USER_GUIDE.md) | [Provided examples](../plugins/04-hdl-copilot/examples/README.md) |

Configure your own model service and credentials where requested. The selected interface may send RTL, requirements, and relevant context to that service. Keep credentials out of RTL files, examples, and public reports.

Start from a copy of an example, inspect the candidate and returned evidence, and carry out the functional and hardware checks appropriate to your design. A generated answer, a completed task, or an exported RTL file does not by itself establish correctness or security.

Version-specific download formats and required attachments are listed in the [download guide](DOWNLOADS.md). The [framework](ARCHITECTURE.md) explains plugin boundaries and interfaces.
