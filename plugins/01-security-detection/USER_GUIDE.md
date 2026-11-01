# Security Detection Plugin — User guide

[Plugin overview](README.md) · [中文使用说明](USER_GUIDE.zh-CN.md)

## Distribution and scope

Install the VS Code frontend **and** unpack its matching runtime directory. The VSIX alone does not contain the Python backend or analysis engines. This preview distribution pairs VSIX **0.1.1** with the supplied backend snapshot; the FastAPI application still reports **0.1.0**. These component versions are recorded, not silently changed.

The runtime includes VerilogLAVD-based structural checks, VeriPVD-based permission analysis, and a Vivado Tcl entry. It does not supply an independent browser application. Source-dependent Python and Tcl runtime files remain readable in the runtime ZIP. The VSIX candidate omits only an internal development handover document; all retained frontend files and version metadata are unchanged.

This is a preview distribution. Archive integrity and example preservation have been checked. Real VS Code interaction, Neo4j/engine scans, and model requests have not been validated by this preparation. Third-party redistribution notices still require completion; see [third-party notices](THIRD_PARTY_NOTICES.md).

## Required environment

| Component | Requirement |
| --- | --- |
| VS Code | Desktop VS Code 1.85+; Windows is the documented workflow |
| Backend Python | Python 3.10+; use its own virtual environment |
| VerilogLAVD | Python 3.12+ environment and its dependency list |
| VeriPVD | Separate Python 3.10 environment following the supplied setup |
| Icarus Verilog | Required for VerilogLAVD's pyverilog preprocessing; also used for optional repair compilation checks |
| Neo4j | A dedicated disposable database for VerilogLAVD, with your own connection and password |
| Model account | Your own compatible provider/model credentials for model-backed permission analysis and repair suggestions |
| Vivado | Needed only when using the Tcl entry |

**VerilogLAVD clears the connected Neo4j database while rebuilding each file's graph. Use a dedicated empty database; do not point it at a database containing other work.** Python packages, Neo4j, Icarus, and Vivado are not bundled. Dependency installation and model-backed use need network access. No GPU or local model weights are included or required by the documented API workflow.

## Install the runtime

Download both `csl-rtl-seccheck-0.1.1.vsix` and `csl-rtl-seccheck-runtime-0.1.1.zip` from the corresponding release. Extract the ZIP to a writable directory and open a terminal at the extracted `RTL-SecCheck-runtime` root. Keep `backend/`, `third_party/`, `requirements*.txt`, `examples/`, and `tcl/` together.

The Windows commands below create three separate environments. Install the required Python versions before using the `py` launcher.

```bat
py -3.12 -m venv backend\.venv
backend\.venv\Scripts\python.exe -m pip install -r requirements.txt

py -3.12 -m venv third_party\VerilogLAVD\.venv
third_party\VerilogLAVD\.venv\Scripts\python.exe -m pip install -r requirements-lavd.txt

py -3.10 -m venv third_party\VeriPVD\.venv
third_party\VeriPVD\.venv\Scripts\python.exe -m pip install -r requirements-pvd.txt
```

The root dependency list installs only the FastAPI backend; it does not install the engines. No Git, Node.js, npm, or extension compilation is needed to use the provided VSIX. The dependency lists are supplied upstream ranges rather than a fully pinned environment, so compatibility on a clean machine remains to be checked.

## Install and configure VS Code

1. Open VS Code's Extensions view, choose **… → Install from VSIX…**, and select the VSIX.
2. Reload when prompted. The installed display name is **CSL_RTL_SecCheck**, extension ID `csl-local.csl-rtl-seccheck`.
3. Set `cslRtlSeccheck.projectRoot` to the extracted runtime root containing `backend/main.py` and `start.bat`. This explicit setting is important because the runtime is outside the extension installation directory.
4. Keep `cslRtlSeccheck.backendUrl` at `http://127.0.0.1:8321` for local use, unless you intentionally configured a different local endpoint.
5. Open the plugin panel and its connection/scan settings. Verify the two engine locations and Python interpreter paths. Relative engine and interpreter paths are resolved from the runtime root. The scan target uses the backend process's working directory for relative paths, so select the RTL directory with the picker or provide its absolute path.

The backend creates `backend/settings.json` on first start. `backend/settings.example.json` contains empty credentials, relative engine paths, and an empty `rtl_dir` scan target. Choose your target with the directory picker or enter its absolute path; do not rely on a relative scan target. Enter your own Neo4j connection, password, model name, and API key through the settings panel or local settings file. The historical field spelling `verilavlvd_path` / `verilavlvd_python` is intentional because the supplied backend uses it.

Use a model identifier supported by the supplied provider routing. The backend has provider-specific routes; do not assume every arbitrary model label or gateway works. Without a model key, VeriPVD runs only its structural stage and model-backed analysis/repair is reduced. Key entry and connection checks can contact the configured service. RTL and relevant analysis context are sent to the selected model service when those stages run.

`backend/settings.json` stores credentials on the local machine. Keep that file, generated `scans/`, and logs out of shared packages.

## Start and scan the included example

The extension checks the backend and can start it from the configured runtime. For a visible backend terminal, run this command at the runtime root and keep the window open:

```bat
backend\.venv\Scripts\python.exe -m uvicorn --app-dir backend main:app --host 127.0.0.1 --port 8321
```

1. Confirm Icarus is on PATH and the dedicated Neo4j service is running if selecting LAVD.
2. Use the directory picker to select the runtime's `examples/demo_soc` directory, or enter that directory's absolute path as the scan target. Keep all six `.v` files together.
3. Choose **both**, **LAVD**, or **PVD**, then start a scan.
4. Read findings together with the engine logs and warnings. Open the module dependency view for design context.
5. Request a repair suggestion for one finding if needed. Review the suggestion and any compilation result before adopting it.

The [example directory](examples/README.md) is copied byte-for-byte from the supplied RTL sample. It is an example input, not a testbench or an assertion of a specific detection count. No paid model call is needed merely to inspect these example files.

## Vivado Tcl entry

The same runtime provides `tcl/seccheck.tcl`; it uses the backend rather than being a second self-contained installation package. In Vivado's Tcl Console, substitute the actual extracted path:

```tcl
source {/path/to/RTL-SecCheck-runtime/tcl/seccheck.tcl}
seccheck help
seccheck scan {/path/to/RTL-SecCheck-runtime/examples/demo_soc} both
seccheck status
seccheck report
```

Other commands include `seccheck start`, `seccheck fix <finding_id>`, and `seccheck graph`. The graph command exports JSON; use the VS Code panel for the interactive dependency view.

## Interpret results and update

Structural matches and model suggestions require engineering review. Empty findings with engine errors or missing model stages do not establish a clean design. A compiled repair is not a functional, formal, or physical-security proof. This snapshot does not promise the full upstream paper's pattern set or reproduce its evaluation results.

When updating, install a matching frontend/runtime pair and restart the backend so it does not retain old Python modules. Back up your local settings and useful results separately; they are not part of this distribution. This runtime excludes the upstream research datasets and notebook; default dataset-based paper experiments are outside this user package. Ordinary scans target the user's selected RTL directory through `backend/lavd_bridge.py`.
