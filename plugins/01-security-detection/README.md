# Security Detection Plugin

[Home](../../README.md) · [简体中文](README.zh-CN.md) · [User guide](USER_GUIDE.md)

Inspect RTL structural vulnerability patterns and multi-module permission flows through a VS Code frontend, with a shared Python backend and an optional Vivado Tcl entry.

| Item | Distribution details |
| --- | --- |
| Installed name | CSL_RTL_SecCheck |
| VS Code frontend | 0.1.1; VS Code 1.85+ |
| Backend snapshot | Supplied with this candidate; FastAPI metadata remains 0.1.0 |
| Documented environment | Windows, separate Python environments, Icarus; Neo4j for LAVD |
| Analysis engines | VerilogLAVD structural checks and VeriPVD permission analysis |
| Installation | VSIX **plus matching runtime ZIP** |

[Download entry: security-detection-v0.1.1](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/security-detection-v0.1.1) — preview distribution. Download both files; the VSIX alone has no backend.

1. Prepare the runtime and three dependency environments using the [user guide](USER_GUIDE.md).
2. Install the VSIX and set `cslRtlSeccheck.projectRoot` to the extracted runtime root.
3. Configure your engine interpreters, dedicated Neo4j instance, and model credentials.
4. Scan the included [demo_soc example](examples/README.md), then review the report, engine warnings, and dependency graph.

**LAVD rebuilds graphs by clearing the connected Neo4j database. Use a dedicated empty database.** Its pyverilog parser also requires Icarus preprocessing.

<img src="assets/seccheck_report_merged.png" alt="Security Detection Plugin report panel" width="900">

The sample and interface illustration are retained from the supplied plugin files. The illustrated report is not verification evidence from this preparation. Real engine, Neo4j, model, and VS Code integration checks remain to be performed. This preview distribution is not a claim of a clean-machine installation or measured detection accuracy. Review [third-party notices](THIRD_PARTY_NOTICES.md) before redistribution; upstream license documents are incomplete in the supplied archive.

- [Detailed guide](USER_GUIDE.md) / [中文使用说明](USER_GUIDE.zh-CN.md)
- [Examples](examples/README.md)
- [Version notes](CHANGELOG.md)
- [Third-party notices](THIRD_PARTY_NOTICES.md)
