# HDL Copilot Plugin

[Home](../../README.md) · [简体中文](README.zh-CN.md) · [User guide](USER_GUIDE.md) · [Examples](examples/README.md)

Understand, debug, and refine Verilog/SystemVerilog through multi-turn HDL questions and reviewed code changes. The installed interface, extension ID `trustrtl-local.trustrtl`, and package names retain **CSL_HDLChat** for compatibility.

![HDL Copilot current VS Code interface](assets/hdlchat-interface.png)

The supplied interface screenshot shows English controls and a Chinese answer. Interface and answer languages can differ.

| Distribution | Version / environment | Package |
| --- | --- | --- |
| VS Code | **0.3.4**; desktop VS Code 1.85+; Python 3.10+; trusted workspace. Local Windows is the documented validation environment. | `CSL_HDLChat-0.3.4.vsix` |
| Examples | The two intentional-bug inputs and bilingual prompts are now included in the VSIX; also offered separately. | `CSL_HDLChat-Examples.zip` |
| Vivado companion | Project Mode and Python 3.10+; optional mode picker needs Tkinter. No separate numeric version is declared. | `CSL_HDLChat-for-Vivado.zip` |

[Preview release and downloads](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/hdl-copilot-v0.3.4) — preview distribution. The release tag follows the VS Code version and does not assign a separate Vivado version.

## What is updated

Version 0.3.4 adds Chinese/English interface selection, a replayable four-step quick tour, the current interface documentation and screenshot, and packaged example inputs. The tour is local UI guidance and does not call a model. The model configuration form stores credentials in VS Code SecretStorage; saving does not test the connection.

Install the VSIX using **Install from VSIX…**, open a trusted folder and your RTL, configure your model, then ask a question. The [full guide](USER_GUIDE.md) covers setup, current-file questions, history, demos, difference preview, and applying a change.

VS Code reads the current buffer, including unsaved edits. Apply a reviewed proposal explicitly and save manually. Vivado reads saved project files and offers preview/copy without writing back. Its current source files match the supplied companion ZIP, so this staging pass keeps that archive unchanged.

The backend is bundled and uses Python's standard library; ordinary use needs no pip installation or Node.js. Questions, RTL and conversation context are sent to your configured Chat Completions service. The plugin does not automatically compile, simulate, synthesize or measure PPA.

[Example inputs and prompts](examples/README.md) · [Change notes](CHANGELOG.md) · [Distribution status](DISTRIBUTION_NOTES.md)
