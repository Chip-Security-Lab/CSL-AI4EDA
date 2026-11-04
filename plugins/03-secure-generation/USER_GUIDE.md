# Secure Generation Plugin — user guide

[Plugin](README.md) · [简体中文](USER_GUIDE.zh-CN.md)

CSL_HDLGen generates security-focused Verilog-2005 from design requirements. It supports general RTL generation, optional low-power optimization, and FSM generation. Results include `.v` code, supporting security knowledge, and a security report. The interface supports Chinese and English.

## 1. Requirements and Installation

- **VS Code 1.85+**
- **Python 3.10+** and a model API account for custom generation

The knowledge library is included. No Neo4j or additional Python packages are required. Preset demos work without Python or model configuration.

1. In VS Code, open **Extensions → … → Install from VSIX…**.
2. Select `CSL_HDLGen-VSCode-0.3.16.vsix` from the matching release and reload if prompted.
3. Open a trusted local project folder and click the **G icon** in the Activity Bar.
4. For custom generation, set `cslHdlgen.pythonPath` in **User Settings** if `python` does not point to your Python installation.

On first open, a four-step guide points out model settings, the requirement input, the output area, and the demo button. You can skip it or replay it using **?** in the top-right toolbar.

## 2. Quick Start

### Language and model settings

Click the gear in the top-right toolbar to open **Settings**. Choose Chinese or English under **Interface language**; the change takes effect immediately and does not require model configuration.

For custom generation, save these three model fields together:

- **API endpoint:** a Chat Completions-compatible base URL, usually ending in `/v1`; omit `/chat/completions`.
- **Model name:** the model ID supplied by your provider.
- **API Key:** your access key, stored securely by VS Code.

Remote endpoints use HTTPS; local services may use HTTP.

### Generate and save RTL

1. Choose **General secure RTL** or **Secure FSM** below the input box.
2. Describe the interfaces, behavior, clock/reset, and security requirements. For FSMs, include states, transitions, and outputs.
3. Click **Generate** or press `Ctrl+Enter` (`Cmd+Enter` on macOS).
4. After successful generation, the requirement input collapses to give results more space. Review **Code → Knowledge → Security report**, and click **Edit requirements** to expand the input again. If multiple FSM versions are offered, use the version selector to compare them.
5. For general RTL, optionally click **Optimize power**. Use **Copy** or **Open as file** to save the result.

To replace an existing workspace file, use **Attach file → Generate → Review diff → Write to file**. Writing asks for confirmation and creates a backup. Enable **Allow model to reference attached file** only when you want its contents included in the model request.

Click the **History** clock icon to restore a result using VS Code's Quick Pick list. Each mode keeps its eight most recent results in the current window. Starting an empty task does not add a history entry.

### Try a demo

Click **Run demo** for a preset example. Loading a demo also collapses the requirement input; use **Edit requirements** to expand it. The FSM page offers a regular example and an example with a proposed functional correction. The `examples/` directory includes CSR references, a saved regular FSM, and a real-model FSM case with original and function-repaired code, reports, knowledge, and verification records.

For a browser-only preview, use the [offline HTML demos](examples/demos/README.md) or extract `CSL_HDLGen-Demos.zip` and double-click an HTML file. These fixed demos need no installation or model configuration.

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

The [provided examples](examples/README.md) retain earlier saved records. Local installed VS Code checks covered settings, draft preservation, preset demos, automatic collapse and native history; they made no model requests. The independent HTML demos were checked offline. Vivado and clean-machine workflows were not retested. The static CSR reference has no compile, simulation, physical security, equivalence, or power measurements. Verify generated HDL in your own workflow.
