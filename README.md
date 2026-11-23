<div align="center">

<img src="assets/csl-ai4eda-emblem.png" alt="CSL_AI4EDA project emblem: an AI circuit shield on a microchip with a plugin module" width="144">

<h1>CSL_AI4EDA</h1>

<p><strong>AI Plugins for Chip Design</strong></p>

RTL security, optimization, Verilog generation and HDL Q&A — inside VS Code.

[![Download Plugins](assets/icons/button-download-plugins.svg)](docs/DOWNLOADS.md)
[![Watch Demos](assets/icons/button-watch-demos.svg)](#plugin-demos)
[![Documentation](assets/icons/button-documentation.svg)](docs/README.md)

[![Releases · Preview](assets/icons/button-releases-preview.svg)](docs/DOWNLOADS.md)
[![VS Code Plugins](assets/icons/button-vscode-plugins.svg)](docs/USER_GUIDE.md)

[English](README.md) · [简体中文](README.zh-CN.md)

<img src="assets/overview-plugins-color-icons.en.png" alt="CSL_AI4EDA: Security Detection, Optimization and Repair, Secure Generation, and HDL Copilot, followed by an ellipsis for additional plugins in development." width="960">

</div>

> **Preview releases:** environment requirements and validation scope vary by plugin. See the linked installation guide and release notes.

<a name="plugins"></a>

## 🧩 Plugins

Choose a plugin for your task. Each has its own version and installation requirements.

| Plugin | What you can do | Download | Guide |
| --- | --- | --- | --- |
| [**Security Detection**](#1-security-detection-plugin) | Review RTL vulnerabilities and module access permissions | [Release](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/security-detection-v0.1.1-r2) | [Install & use](plugins/01-security-detection/USER_GUIDE.md) |
| [**Optimization & Repair**](#2-optimization--repair-plugin) | Mitigate side-channel leakage and address timing issues | [Release](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/optimization-repair-v0.5.5) | [Install & use](plugins/02-optimization-repair/USER_GUIDE.md) |
| [**Secure Generation**](#3-secure-generation-plugin) | Generate Verilog and FSMs with knowledge support | [Release](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/secure-generation-v0.3.16) | [Install & use](plugins/03-secure-generation/USER_GUIDE.md) |
| [**HDL Copilot**](#4-hdl-copilot-plugin) | Ask HDL questions and review code explanations and suggestions | [Release](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/hdl-copilot-v0.4.0) | [Install & use](plugins/04-hdl-copilot/USER_GUIDE.md) |

**Security Detection needs both its VSIX and matching runtime ZIP.** The Optimization & Repair VSIX includes its backend. Exact files, versions and companion interfaces are listed in the [download guide](docs/DOWNLOADS.md).

<a name="getting-started"></a>

## 🚀 Getting started

1. **Download:** choose a plugin above and get the required attachments from its Release.
2. **Install:** in desktop VS Code, open Extensions → `…` → **Install from VSIX…**. Follow the plugin guide for its runtime and system dependencies.
3. **Configure and try:** configure your model service where required, open an [included example](plugins/README.md), and review the output and validation status.

[Installation and configuration guide](docs/USER_GUIDE.md) · [Download details](docs/DOWNLOADS.md)

<a name="plugin-demos"></a>

## 🎬 Plugin demos

[Security Detection](#1-security-detection-plugin) · [Optimization & Repair](#2-optimization--repair-plugin) · [Secure Generation](#3-secure-generation-plugin) · [HDL Copilot](#4-hdl-copilot-plugin)

Original plugin interfaces with demo or sample data. Verification results, where available, are shown in the interface.

<a name="1-security-detection-plugin"></a>

### <img src="assets/icons/security-detection.svg" alt="" width="24" height="24" align="middle"> 01 Security Detection Plugin

Scan RTL, review reported findings, and locate affected modules in the dependency graph.

**In this demo:** select RTL → review a finding → locate the affected module.

<p align="center">
<img src="assets/demos/01-security-detection.gif" alt="Security Detection Plugin: select RTL, review a sample access-control finding, and locate the highlighted module." width="960" height="750">
</p>

[**Download**](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/security-detection-v0.1.1-r2) · [User guide](plugins/01-security-detection/USER_GUIDE.md) · [Examples](plugins/01-security-detection/examples/README.md)

<a name="2-optimization--repair-plugin"></a>

### <img src="assets/icons/optimization-repair.svg" alt="" width="24" height="24" align="middle"> 02 Optimization & Repair Plugin

Choose a repair workflow and inspect its candidate code and evidence.

**In this demo:** choose a sensitive input → review the unverified candidate status → locate the Diff entry.

<p align="center">
<img src="assets/demos/02-optimization-repair.gif" alt="Optimization and Repair Plugin: configure a workflow, review an unverified sample candidate, and locate the Diff button." width="960" height="750">
</p>

[**Download**](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/optimization-repair-v0.5.5) · [User guide](plugins/02-optimization-repair/USER_GUIDE.md) · [Examples](plugins/02-optimization-repair/examples/README.md)

<a name="3-secure-generation-plugin"></a>

### <img src="assets/icons/secure-generation.svg" alt="" width="24" height="24" align="middle"> 03 Secure Generation Plugin

Describe design requirements and inspect generated Verilog and FSM logic.

**In this demo:** run the built-in FSM example → inspect state transitions → review default-state recovery.

<p align="center">
<img src="assets/demos/03-secure-generation.gif" alt="Secure Generation Plugin: run the built-in FSM demo and inspect state transitions and default recovery in the Verilog code." width="960" height="750">
</p>

[**Download**](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/secure-generation-v0.3.16) · [User guide](plugins/03-secure-generation/USER_GUIDE.md) · [Examples](plugins/03-secure-generation/examples/README.md)

<a name="4-hdl-copilot-plugin"></a>

### <img src="assets/icons/hdl-copilot.svg" alt="" width="24" height="24" align="middle"> 04 HDL Copilot Plugin

Ask about RTL behavior, read the explanation, and review a suggested code change.

**In this demo:** ask about an incomplete assignment → read the explanation → review the proposed default assignment.

<p align="center">
<img src="assets/demos/04-hdl-copilot.gif" alt="HDL Copilot Plugin: ask about an incomplete assignment and review an explanation and suggested default assignment." width="960" height="750">
</p>

[**Download**](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/hdl-copilot-v0.4.0) · [User guide](plugins/04-hdl-copilot/USER_GUIDE.md) · [Examples](plugins/04-hdl-copilot/examples/README.md)

<a name="latest-updates"></a>

## 📰 Latest updates

- **2026-11-22** — Added four interface demo GIFs with zoom and highlights; refreshed homepage navigation and quick start.
- **2026-11-04** — Updated the four preview distributions, download entries, examples and user guides.

[Update history](docs/CHANGELOG.md)

<a name="documentation"></a>

## 📚 Documentation

| Start here | Details |
| --- | --- |
| [Downloads](docs/DOWNLOADS.md) | Per-plugin packages, versions and required attachments |
| [User guide](docs/USER_GUIDE.md) / [中文使用说明](docs/USER_GUIDE.zh-CN.md) | Installation, environment setup and plugin selection |
| [Plugin introductions and examples](plugins/README.md) | Plugin pages and provided example designs |
| [Framework](docs/ARCHITECTURE.md) | Interfaces, repository structure and distribution details |
| [Distribution notices](DISTRIBUTION_NOTICES.md) | Component attribution and distribution information |

[All documentation](docs/README.md)

<a name="contact"></a>

## ✉️ Contact

<div align="center">

<p><strong>Chip Security Lab · Hangzhou Dianzi University</strong></p>

<p>
<img src="assets/hangzhou-dianzi-university-emblem.png" alt="Hangzhou Dianzi University — 杭州电子科技大学" width="140" align="middle">
&nbsp;&nbsp;
<img src="assets/chip-security-lab.jpg" alt="Chip Security Lab — 芯片与安全实验室" width="220" align="middle">
</p>

<p><strong>WeChat Official Account:</strong> 芯片与安全实验室</p>
<p>Search for 芯片与安全实验室 in WeChat for lab news and plugin updates.</p>
<p><a href="mailto:zitenghu@hdu.edu.cn">zitenghu@hdu.edu.cn</a></p>

</div>
