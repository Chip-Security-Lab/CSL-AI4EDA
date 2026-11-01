# HDL Copilot Plugin — user guide

**CSL_HDLChat is a VS Code assistant that helps RTL engineers understand, debug, and refine Verilog/SystemVerilog through concise, multi-turn Q&A and reviewed code changes.**

[Plugin](README.md) · [中文](USER_GUIDE.zh-CN.md) · [Examples](examples/README.md)

The installed extension retains CSL_HDLChat for compatibility. The sections below describe VS Code 0.3.4; the Vivado interface is documented separately below.

## Interface

![CSL_HDLChat interface with the top input box, M1–M4 progress, highlighted RTL, and change-preview button](assets/hdlchat-interface.png)

*User-provided screenshot of the current interface. Interface language and answer language can differ, as shown.*

## Examples

| Example | Try it |
| --- | --- |
| [Counter boundary](examples/vscode/01_counter_boundary.v) | Find and fix an off-by-one error in a counter that should wrap every 10 clock cycles. |
| [Combinational latch](examples/vscode/02_combinational_latch.v) | Add the missing assignment so disabled combinational logic outputs zero. |

Open an example in VS Code, start a new chat, and use the prompts in the [Examples guide](examples/vscode/README.md). Both files contain intentional bugs for debugging practice; expected fixes and usage steps are provided in the guide.

## 1. Requirements and Installation

### Requirements Checklist

- [ ] Desktop VS Code **1.85.0 or later**.
- [ ] Python **3.10 or later**.
- [ ] The extension package: `CSL_HDLChat-0.3.4.vsix`.
- [ ] A model service compatible with the **Chat Completions API**.
- [ ] The service's API base URL, model name, and API key (if required).
- [ ] Network access to the configured model service.
- [ ] A trusted project folder opened in VS Code.

Local Windows is the validated environment. macOS, Linux, and Remote SSH have not yet been validated.

The package includes the Python backend and uses the Python standard library. No additional `pip install`, Node.js, Vivado, or GitHub Copilot account is required for normal use.

Check your Python version:

```text
python --version
```

If Python cannot be found, set `trustrtl.pythonPath` in VS Code Settings to your Python executable, for example `C:\Python311\python.exe`. Replace this example with your actual path.

### Install the Extension

1. Open VS Code and press **Ctrl+Shift+P**.
2. Select **Extensions: Install from VSIX...**.
3. Choose `CSL_HDLChat-0.3.4.vsix` and reload VS Code if prompted.
4. Open your project folder and trust it if appropriate.
5. Click the **C icon** in the activity bar to open CSL_HDLChat.

## 2. Quick Start

On first open, a four-step tour highlights Model settings, the top input box, the answer area, and Demos. Finish or skip to dismiss it for future opens. Use **Quick tour** at the top to replay it. The tour does not call the model.

### Configure Your Model

Click **Model settings**, fill in all three fields in the same form, and click **Save settings**.

| Field | What to enter |
| --- | --- |
| API base URL | Your provider's base URL, such as `https://api.example.com/v1` (format example only). Do not append `/chat/completions`. |
| Model name | The exact model ID supported by your provider. |
| API Key | Paste the key without quotation marks. Leave blank to keep an existing key, or enter `-` to clear it for a service that needs no key. |

Keys are stored in VS Code SecretStorage. Questions, attached code, and conversation context are sent to your configured model service. Saving settings does not test the connection; send a question to check it.

### Ask a Question

1. Open a `.v`, `.sv`, `.vh`, or `.svh` file and confirm the current filename in the assistant.
2. Enter your question in the **top input box**, for example:

   > Check whether this counter resets to zero every 10 cycles. Keep the ports and reset behavior unchanged, and suggest a minimal fix.

3. Click **Send** or press **Ctrl+Enter**.
4. View the M1–M4 progress and answer below the input box.

The assistant reads the current file, including unsaved edits. You can also paste code or ask general questions. Continue in the same chat for follow-up questions, or use **New chat** and **History** to manage conversations.

### Review and Apply Changes

1. Analyze the current file, then click **Generate changes and preview**.
2. Review the original and proposed code in the VS Code diff view.
3. Click **Apply changes** only when satisfied.
4. Save the file yourself. Use **Undo** to restore the previous content if needed.

Changes are not applied or saved automatically. If the file changes after analysis, analyze it again before applying a proposal.

### Demos and Language

- Click **Demos** to try a counter boundary issue, a combinational latch, or a nonblocking-assignment pipeline. Each demo opens an unsaved file; click **Send** to run it.
- Select **中文 / English** at the top to switch the interface language. The choice is remembered. Existing answers and code are unchanged; ask in English for English answers.

The assistant currently analyzes one file at a time. It does not run compilation, simulation, or synthesis. Verify proposed RTL changes using your normal development workflow.


## Vivado companion interface

1. Extract `CSL_HDLChat-for-Vivado.zip` with its complete `HDLChat-for-Vivado` directory. Use Vivado Project Mode, Python 3.10+, and saved RTL sources. Tkinter is needed only for the optional mode picker.
2. In Vivado Tcl Console, source the actual absolute path to `HDLChat-for-Vivado/tcl/hdlchat.tcl`, then run `hdlchat::open`. Use braces around paths containing spaces.
3. Alternatively use **CSL_HDLChat: Choose Mode**, `hdlchat::launch`, or the console entry `hdlchat::ask {your question}`.
4. Configure your own model endpoint, identifier, and key in the companion interface. This interface holds model configuration in process memory; re-enter it after restarting Vivado or the backend.
5. Confirm the project and selected saved file. The window follows Sources selection unless you pin a file; it refreshes context before each question and isolates conversations by project.
6. Review an answer and generated diff. Copy reviewed code to your editor manually; this interface has no project-write endpoint. It reads saved disk content, so save before asking.

The optional `HDLCHAT_PYTHON` environment variable selects the Python interpreter before starting Vivado. The complete original quick-start and usage documents are included in the Vivado ZIP. The [Vivado example](examples/vivado/README.md) is also included. A separate numeric Vivado package version is not declared; its files match the current source snapshot.

## Distribution verification scope

This local packaging update checks source/package byte equality, archive integrity, examples, metadata and documentation links. It does not add a new live-model, VS Code GUI, Vivado GUI or clean-machine installation claim. Supplied example validation notes describe the maintainer's earlier reviewed fixes; new model outputs still need independent checking.
