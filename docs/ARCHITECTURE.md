# Framework and plugin interfaces

[Home](../README.md) · [User guide](USER_GUIDE.md)

CSL_AI4EDA organizes four independently distributed plugins around the RTL design flow. The common repository provides documentation and examples; it is not a single runtime that automatically loads all four plugins.

| Plugin | Typical input | Output | Runtime and interfaces |
| --- | --- | --- | --- |
| Security Detection | RTL directory and module context | Findings, evidence, access analysis, optional repair suggestions | VS Code frontend or Vivado Tcl entry with shared Python runtime; VerilogLAVD and VeriPVD engines |
| Optimization & Repair | RTL, sensitive input or exact PART/XDC | Full candidates, functional/formal and RTL-TVLA or timing evidence | Windows VS Code with bundled backend; Windows and WSL tools; Vivado timing integration |
| Secure Generation | Requirements and general RTL / FSM workflow | Verilog draft, knowledge references and review | VS Code or Vivado companion; packaged Python runtime code and security knowledge |
| HDL Copilot | RTL, questions and design constraints | Explanation and reviewable change suggestions | VS Code or Vivado companion; model-backed Python backend |

The order is detection, optimization and repair, generation, then questions. Each plugin keeps its actual dependencies, version, and verification scope.

## Interaction

Users select a task, provide requirements or RTL, run the chosen interaction, inspect outputs and evidence, and validate changes in their hardware workflow. Model service configuration is specific to each plugin. The interfaces describe whether a proposed change is copied, exported, or applied after confirmation.

## Repository and release boundaries

- `plugins/` contains introductions, usage guides, version notes, notices, screenshots where provided, and example designs.
- `docs/` contains shared selection and download guidance.
- `assets/` contains the overview and lab identity.
- GitHub Releases contain installable packages and matching runtime/example attachments, with version notes and checksums.

The four release tags are independent. VS Code extension versions are recorded separately from companions that do not declare an independent version. Installation packages contain the runtime resources required by their distribution; development environments, personal settings, histories, and caches are not intended public content.
