# CSL_AI4EDA

<div align="center">

**AI Plugins for RTL Design**

[English](README.md) · [简体中文](README.zh-CN.md)

[Plugin Overview](#plugins) · [User Guide](docs/USER_GUIDE.md) · [Framework](docs/ARCHITECTURE.md)

<img src="assets/overview-plugins-minimal.en.png" alt="CSL_AI4EDA plugin overview: Security Detection, Optimization and Repair, Secure Generation, and HDL Copilot, followed by an ellipsis for additional plugins in development." width="1200">

</div>

CSL_AI4EDA presents AI-assisted plugins for RTL design, covering RTL vulnerability checks, optimization and repair, knowledge-assisted generation, and design questions. The plugins are organized around familiar stages of the hardware design flow.

This first publication contains **documentation, the repository framework, and illustrations**. Source code, plugin engineering files, and installation packages are outside the scope of this documentation release.

## Plugins

| Plugin | Main purpose | Design stage |
| --- | --- | --- |
| [**Security Detection Plugin**](plugins/01-security-detection/README.md) | Locate RTL vulnerabilities and analyze multi-module access permissions. | Checks and verification |
| [**Optimization & Repair Plugin**](plugins/02-optimization-repair/README.md) | Address side-channel and timing issues. | Optimization and refinement |
| [**Secure Generation Plugin**](plugins/03-secure-generation/README.md) | Generate RTL and FSM drafts from requirements with security knowledge. | RTL coding |
| [**HDL Copilot Plugin**](plugins/04-hdl-copilot/README.md) | Understand RTL, answer design questions, and review suggested changes. | Across the design flow |

Each plugin page describes its purpose, scope, and documentation.

## Getting started

1. **Choose a plugin** according to your design task using the table above.
2. **Read the [user guide](docs/USER_GUIDE.md)** for the interaction flow and model configuration concepts.
3. **Review the [framework](docs/ARCHITECTURE.md)** to understand how the plugin guides and future implementation entries are organized.

The guide introduces the existing VS Code and Vivado interaction patterns for Secure Generation and HDL Copilot. Installation downloads and executable entry points will be documented alongside implementation releases.

## Repository structure

```text
CSL-AI4EDA/
├── README.md
├── README.zh-CN.md
├── assets/
│   └── overview-plugins-minimal.en.png
├── docs/
│   ├── README.md
│   ├── ARCHITECTURE.md
│   ├── USER_GUIDE.md
│   └── USER_GUIDE.zh-CN.md
└── plugins/
    ├── README.md
    ├── 01-security-detection/README.md
    ├── 02-optimization-repair/README.md
    ├── 03-secure-generation/README.md
    └── 04-hdl-copilot/README.md
```

## Documentation

- [Documentation index](docs/README.md)
- [User guide](docs/USER_GUIDE.md) / [中文使用说明](docs/USER_GUIDE.zh-CN.md)
- [Framework and plugin interfaces](docs/ARCHITECTURE.md)
- [Plugin directory](plugins/README.md)

## Contact

<div align="center">

<img src="assets/chip-security-lab.jpg" alt="Chip Security Lab — 芯片与安全实验室" width="220">

<p><strong>WeChat Official Account:</strong> 芯片与安全实验室</p>
<p>Search for 芯片与安全实验室 in WeChat to follow our lab.</p>
<p><strong>Email:</strong> <a href="mailto:zitenghu@hdu.edu.cn">zitenghu@hdu.edu.cn</a></p>

</div>
