# CSL_AI4EDA

<div align="center">

**AI Plugins for Chip Design**

[English](README.md) · [简体中文](README.zh-CN.md)

[Plugins](#plugins) · [Downloads](docs/DOWNLOADS.md) · [User guide](docs/USER_GUIDE.md) · [Framework](docs/ARCHITECTURE.md)

<img src="assets/overview-plugins-minimal.en.png" alt="CSL_AI4EDA: Security Detection, Optimization and Repair, Secure Generation, and HDL Copilot, followed by an ellipsis for additional plugins in development." width="1200">

</div>

CSL_AI4EDA brings together AI plugins for RTL vulnerability checks, optimization and repair, Verilog generation, and HDL questions. Each plugin has its own installation requirements and release version.

**Preview distributions:** packages are offered for trial use. Full fresh-machine and installed-VS Code end-to-end acceptance remains pending; see each plugin's validation scope.

This repository contains introductions, installation and user guides, and example designs. Installable distributions are organized as separate GitHub Releases; development engineering trees are maintained separately. Installation packages may contain readable runtime scripts and third-party components.

## Plugins

| Plugin | VS Code package version | Main purpose | Interfaces |
| --- | --- | --- | --- |
| [**Security Detection Plugin**](plugins/01-security-detection/README.md) | 0.1.1 | RTL vulnerabilities and module access permissions | VS Code; shared runtime; Vivado Tcl entry |
| [**Optimization & Repair Plugin**](plugins/02-optimization-repair/README.md) | 0.5.3 | Side-channel mitigation and timing optimization | Windows VS Code; Vivado integration for timing |
| [**Secure Generation Plugin**](plugins/03-secure-generation/README.md) | 0.3.15 | Knowledge-assisted Verilog and FSM generation | VS Code; Vivado companion interface |
| [**HDL Copilot Plugin**](plugins/04-hdl-copilot/README.md) | 0.3.4 | HDL questions, explanations, and change suggestions | VS Code; Vivado companion interface |

Open a plugin page for its download files, environment requirements, examples, and validation scope. The detection distribution uses a VSIX with a matching external runtime; the optimization distribution includes its backend in the VSIX. A Vivado bridge or companion interface is described separately from an installable VS Code extension.

## Getting started

1. Choose a plugin and read its environment requirements.
2. Download the files listed in the [download guide](docs/DOWNLOADS.md) for that plugin and version.
3. Follow its installation guide and configure your own model service where required.
4. Start with the included examples and inspect the returned code and evidence before using a result in a design.

## Repository structure

```text
CSL-AI4EDA/
├── README.md
├── README.zh-CN.md
├── DISTRIBUTION_NOTICES.md
├── assets/                       Overview and lab identity
├── docs/                         Downloads, selection guide, framework
└── plugins/
    ├── 01-security-detection/
    ├── 02-optimization-repair/
    ├── 03-secure-generation/
    └── 04-hdl-copilot/
```

Each plugin directory contains English and Chinese introductions, usage guides, version notes, distribution notices, and the examples provided for that plugin. Installation packages are attached to Releases rather than committed to this tree.

## Documentation

- [Documentation index](docs/README.md)
- [Downloads and installation formats](docs/DOWNLOADS.md)
- [User guide](docs/USER_GUIDE.md) / [中文使用说明](docs/USER_GUIDE.zh-CN.md)
- [Framework and plugin interfaces](docs/ARCHITECTURE.md)
- [Distribution and attribution notices](DISTRIBUTION_NOTICES.md)

## Contact

<div align="center">

<img src="assets/chip-security-lab.jpg" alt="Chip Security Lab — 芯片与安全实验室" width="220">

<p><strong>WeChat Official Account:</strong> 芯片与安全实验室</p>
<p>Search for 芯片与安全实验室 in WeChat to follow our lab.</p>
<p><strong>Email:</strong> <a href="mailto:zitenghu@hdu.edu.cn">zitenghu@hdu.edu.cn</a></p>

</div>
