# Optimization & Repair Plugin

[Home](../../README.md) · [简体中文](README.zh-CN.md) · [User guide](USER_GUIDE.md)

Generate and inspect RTL candidates for side-channel mitigation and timing optimization, with functional checks and task-specific evidence.

| Item | Distribution |
| --- | --- |
| VS Code package | `rtl-optimize-repair-0.5.3.vsix` |
| Version / extension ID | `0.5.3` / `rtl-research.rtl-optimize-repair` |
| Installed display name | CSL · RTL Side-Channel Mitigation and Timing Optimization |
| Host | Windows desktop VS Code 1.100+; trusted local workspace |
| Vivado interface | Project and timing integration from VS Code; no separate native Vivado plugin package |

## Download and start

This is a preview distribution. Get the VSIX from [optimization-repair-v0.5.3](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/optimization-repair-v0.5.3). Install it using **Install from VSIX…**, reload, and open your local RTL folder. The VSIX includes the backend, manuals, rules, and examples; system software is installed separately.

Use **CSL → settings** to check the environment and save your own model configuration. Start with the [provided examples](examples/README.md). Detailed steps are in the [English quick guide](USER_GUIDE.md) and [Chinese manual](USER_GUIDE.zh-CN.md).

## Environment and scope

Both workflows need Windows Python (3.12 64-bit recommended), Windows Icarus (`iverilog` and `vvp`), initialized WSL/Linux verification tools, and your model service. Timing optimization additionally needs Vivado with target-device support, exact PART, valid XDC, and the Windows timing dependencies. The extension can prepare dedicated dependency environments after a user action; it does not bundle the system tools, API credentials, or a local model.

Inputs can be an editor selection with complete context, pasted RTL, or a local file. Side-channel tasks require confirmation of a real sensitive input. Timing tasks obtain project context from Vivado or use explicit PART/XDC input. Outputs include a full candidate, Diff, export, and actual verification evidence; original files are not automatically overwritten.

New side-channel types retain conditional experimental support. Timing improvement, timing closure, formal proof, and physical security are separate claims. See [supported types](SIDECHANNEL_TYPES.md), [result interpretation](ACCEPTANCE_CONTRACT.md), and [validation status](DELIVERY_STATUS.md).

## Documentation

- [Examples](examples/README.md)
- [Change notes](CHANGELOG.md)
- [Third-party boundary](THIRD_PARTY.md) / [MIT text](LICENSE.txt)
