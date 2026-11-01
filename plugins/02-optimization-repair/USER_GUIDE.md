# Installation and quick guide

[Plugin](README.md) · [中文完整手册](USER_GUIDE.zh-CN.md)

## Prepare

Use Windows desktop VS Code 1.100+ in a trusted local folder. Install Windows Python (3.12 64-bit recommended), Windows Icarus (`iverilog`, `vvp` in PATH), and initialize WSL with Ubuntu/Debian. Both workflows need the WSL verification tools. Timing additionally requires Vivado with the target device, Windows timing dependencies, exact PART, and valid XDC. Remote WSL/SSH/container extension hosts are outside this version's supported entry point.

## Install and configure

1. Install `rtl-optimize-repair-0.5.3.vsix` with **Install from VSIX…**, then reload.
2. Open the local RTL folder and choose **CSL → settings → tool environment**. Check existing tools; use the dependency buttons where needed. Inspect terminal errors if preparation fails.
3. Add your own compatible model endpoint, model identifier, and API key. Save and select the configuration. The API key is held in VS Code SecretStorage. Relevant RTL and context are sent to that service during tasks.
4. Use **open examples** in settings or open the [repository example copy](examples/README.md).

## Side-channel task

Start with `single-rtl/register_toggle_two_hotspots.v`. Create a side-channel task, select the complete file, choose the real sensitive input `key`, and confirm it. Keep automatic analysis enabled; provide only resources actually present when a type requires additional annotations. Generate, then inspect the candidate, functional and formal status, and same-condition RTL-TVLA evidence.

## Timing task

Configure Vivado integration in settings while Vivado is closed, restart Vivado, and connect the correct saved project. Check the exact PART, top, sources, and XDC. Alternatively provide exact PART and XDC manually for the documented module-level scope. Select timing optimization, provide complete RTL, and run. WNS improvement does not imply closure if WNS remains negative.

## Review and export

The editor shows the best full candidate; review evidence, open Diff, copy or save as needed. Original source files are not automatically overwritten. A candidate can remain exportable when unverified or unimproved. Formal timeout is not a proof of equivalence. RTL-TVLA does not establish physical power or glitch security.

See the [Chinese manual](USER_GUIDE.zh-CN.md) for complete fields, recovery, troubleshooting and uninstall instructions; [supported types](SIDECHANNEL_TYPES.md) and [result interpretation](ACCEPTANCE_CONTRACT.md) define the evidence limits.
