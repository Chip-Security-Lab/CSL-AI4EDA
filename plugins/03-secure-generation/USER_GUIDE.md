# Secure Generation Plugin — user guide

[Plugin](README.md) · [简体中文](USER_GUIDE.zh-CN.md)

CSL_HDLGen generates security-focused Verilog-2005 from design requirements. It supports general RTL generation, optional low-power optimization, and FSM generation. Results include `.v` code, supporting security knowledge, and a security report. The interface supports Chinese and English.

## 1. Requirements and Installation

- **VS Code 1.85+**
- **Python 3.10+** and a model API account for custom generation

The knowledge library is included. No Neo4j or additional Python packages are required. Preset demos work without Python or model configuration.

1. In VS Code, open **Extensions → … → Install from VSIX…**.
2. Select `CSL_HDLGen-VSCode-0.3.15.vsix` from the matching release and reload if prompted.
3. Open a trusted local project folder and click the **G icon** in the Activity Bar.
4. For custom generation, set `cslHdlgen.pythonPath` in **User Settings** if `python` does not point to your Python installation.

On first open, a four-step guide points out model settings, the requirement input, the output area, and the demo button. You can skip it or replay it using **?** in the top-right toolbar.

## 2. Quick Start

### Configure your model

Click **Model settings** and save these three fields together:

- **API endpoint:** a Chat Completions-compatible base URL, usually ending in `/v1`; omit `/chat/completions`.
- **Model name:** the model ID supplied by your provider.
- **API Key:** your access key, stored securely by VS Code.

Remote endpoints use HTTPS; local services may use HTTP.

### Generate and save RTL

1. Choose **General secure RTL** or **Secure FSM** below the input box.
2. Describe the interfaces, behavior, clock/reset, and security requirements. For FSMs, include states, transitions, and outputs.
3. Click **Generate** or press `Ctrl+Enter` (`Cmd+Enter` on macOS).
4. Review **Code → Knowledge → Security report**. If multiple FSM versions are offered, use the version selector to compare them.
5. For general RTL, optionally click **Optimize power**. Use **Copy** or **Open as file** to save the result.

To replace an existing workspace file, use **Attach file → Generate → Review diff → Write to file**. Writing asks for confirmation and creates a backup. Enable **Allow model to reference attached file** only when you want its contents included in the model request.

### Try a demo

Click **Run demo** for a preset example. The FSM page offers a regular example and an example with a proposed functional correction. The `examples/` directory includes CSR references, a saved regular FSM, and a real-model FSM case with original and function-repaired code, reports, knowledge, and verification records.

For a browser-only preview, use the [offline HTML demos](examples/demos/README.md) or extract the separate `CSL_HDLGen-Demos.zip`, then double-click an HTML file. These fixed demos need no installation or model configuration.

Generated code requires verification before use. Security reports describe proposed measures; power optimization does not include power measurements.


## 3. Vivado companion

Keep the complete extracted `CSL_HDLGen-for-Vivado` directory. In the Tcl Console, replace the path placeholders:

```tcl
set ::env(HDL_SECURITY_PYTHON) {<python-executable>}
source {<extracted-folder>/CSL_HDLGen-for-Vivado/vivado_plugin/install.tcl}
```

The G toolbar command offers a Tcl Console entry or a separate browser-based assistant. The optional mode selector needs Tkinter. The two entries share backend state and model configuration; keys remain in service memory, and are lost when Vivado exits.

Read the [complete Vivado guide](VIVADO_GUIDE.zh-CN.md) for file selection, confirmed writes, backups, lifecycle and uninstall steps. Save the Vivado editor before binding a file: the integration reads on-disk HDL, not unsaved buffers. Review the diff, selected Sources file and full target path before a confirmed whole-file replacement. Reload afterward. Changes in project, selection or target contents can reject a write; generation does not automatically synthesize, simulate or implement.

## 4. Examples and verification scope

The [provided examples](examples/README.md) preserve the source materials and their saved records. The CSR secure/low-power references are static and untested; the regular and functional-correction FSMs carry previous finite-check results. No new model, GUI or independent HDL simulation was executed during this packaging refresh. Saved records are not claims that a current arbitrary generation succeeds.

Low-power optimization is part of the generation workflow, separate from the Optimization & Repair Plugin. Report statements, fixed demos and finite examples do not establish functional equivalence, physical power savings or security.
