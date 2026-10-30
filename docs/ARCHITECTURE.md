# Framework and plugin interfaces

[Home](../README.md) · [User guide](USER_GUIDE.md)

CSL_AI4EDA organizes four plugin capabilities around the RTL design flow. Each plugin has an independent introduction page and scope. This publication establishes documentation and directory boundaries; it does not include implementation modules or installation packages.

## Capability map

| Plugin | Typical input | Intended output | Technical context |
| --- | --- | --- | --- |
| HDL Copilot Plugin | RTL code, a question, and design constraints | Explanation, discussion, and reviewable change suggestions | Multi-turn HDL assistance |
| Secure Generation Plugin | Functional requirements and the selected RTL or FSM workflow | RTL draft, supporting security knowledge, and a review report | PowerSecV (CWE) + SecFSM |
| Security Detection Plugin | RTL and relevant module-access context | Vulnerability locations and access-control analysis | VerilogLAVD (CWE) + multi-module access checks |
| Optimization & Repair Plugin | RTL, side-channel or timing concerns, and design constraints | Repair candidates and analysis of the proposed changes | Side-channel + timing repair |

The overview's synthesis and implementation stage is part of the wider design-flow context. Concrete synthesis, timing and hardware-verification steps remain documented by the relevant development environment and implementation release.

## Interaction framework

The plugin guides describe five user-facing steps: select a task, provide requirements or code context, run the relevant interaction, review the returned explanation or candidate, and validate changes in the hardware development workflow.

Model-backed integrations need a configured service endpoint and model identifier. Provider-specific authentication and editor requirements belong to each implementation's installation guide. Users should be able to inspect a proposed code change before deciding whether to apply it.

## Directory conventions

- `plugins/` contains one introduction per plugin. Each directory is represented by a README so it is visible in GitHub.
- `docs/` holds shared guidance and framework explanations.
- `assets/` holds the overview illustration and its description.
- The English README is the repository landing page, with a Chinese counterpart.

Future implementation entries can extend the matching plugin directory without changing these documentation links. Their release documentation should identify dependencies, supported environments, installation steps, model configuration, storage behavior, and verification scope.
