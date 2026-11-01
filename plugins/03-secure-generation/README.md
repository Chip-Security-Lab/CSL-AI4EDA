# Secure Generation Plugin

[Home](../../README.md) · [简体中文](README.zh-CN.md) · [User guide](USER_GUIDE.md) · [Examples](examples/README.md)

Generate security-focused **Verilog-2005** from requirements using general RTL or FSM workflows. Outputs include code, supporting security knowledge and a report; general RTL also supports a low-power follow-up. The installed name remains **CSL_HDLGen**, extension ID `csl-local.csl-hdlgen`.

![CSL_HDLGen offline CSR demo interface](assets/csl-hdlgen-vscode.png)

*Provided interface capture showing a fixed offline CSR example, not evidence of a new live-model run.*

| Distribution | File | Environment |
| --- | --- | --- |
| VS Code 0.3.15 | `CSL_HDLGen-VSCode-0.3.15.vsix` | Desktop VS Code 1.85+, trusted local folder; Python 3.10+ and model account for custom generation |
| Vivado companion | `CSL_HDLGen-for-Vivado.zip` | Vivado and Python 3.10+; Tkinter for the optional mode selector |
| Saved examples | `CSL_HDLGen-Examples.zip` | CSR references, regular FSM, and original/function-corrected FSM with saved records |
| Offline previews | `CSL_HDLGen-Demos.zip` | Three self-contained HTML previews; open in a browser without installation or network |

**[Preview release and downloads](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/secure-generation-v0.3.15)** — preview distribution. The tag follows the VS Code version and does not assert a separate numeric Vivado version.

## Start

1. Install the VSIX and open a trusted folder. First use shows a four-step guide; skip it or replay it through **?**.
2. Use a fixed **Run demo** immediately, or configure your own endpoint, model and key for new generation.
3. Select **General secure RTL** or **Secure FSM**, describe the design, and generate. Review **Code → Knowledge → Security report**.
4. Compare FSM versions where offered; functional-correction proposals can change behavior and require agreement with design intent.
5. Copy/save the selected result, or attach a file, review its diff and confirm a backed-up write.

The backend and SQLite knowledge snapshot are included; no Neo4j, Node.js or additional Python packages are needed. Preset VS Code demos do not require Python or a model. New model requests require a compatible service and network.

## Examples and previews

- [CSR secure / low-power references](examples/README.md#general-csr-case): paper-adapted static references; no compile, simulation, power or side-channel validation is claimed.
- [Regular FSM](examples/README.md#fsm-case): saved RTL, testbench and prior finite-check records.
- [FSM functional correction](examples/fsm-functional/README.md): original and corrected versions, requirements, report, knowledge, diff, testbench and saved records.
- [Browser previews](examples/demos/README.md): general CSR, regular FSM and functional-correction FSM.

All 25 supplied example files are preserved in the repository, VSIX, Vivado archive and examples ZIP. The browser previews are separately available in the demos ZIP. Generated RTL requires validation; a report is guidance, and the low-power reference does not include measured power savings.

[Usage](USER_GUIDE.md) · [中文使用说明](USER_GUIDE.zh-CN.md) · [Changes](CHANGELOG.md) · [Distribution notes](DISTRIBUTION_NOTES.md)
