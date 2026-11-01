# Third-party source notices

This distribution contains source trees under `third_party/` so a user can run RTL-SecCheck without cloning the two analysis projects separately.

## VerilogLAVD

- Upstream: <https://github.com/Chip-Security-Lab/VerilogLAVD>
- Purpose: RTL parsing, Neo4j graph construction and CWE-oriented detection.
- License: the upstream README identifies the project as MIT licensed. The upstream checkout included here does not contain a separate `LICENSE` file, and the applicable license text remains pending maintainer confirmation.

## VeriPVD

- Upstream: <https://github.com/anwen0724/VeriPVD>
- Purpose: permission and information-flow analysis.
- License: follow the license and attribution terms published by the upstream repository. The applicable terms remain pending maintainer confirmation; the included checkout does not provide a separate license file.

The dependency lists in `requirements-lavd.txt` and `requirements-pvd.txt` are maintained separately because each engine uses its own virtual environment. The root `requirements.txt` is only for the RTL-SecCheck FastAPI backend.

## Distribution status

The supplied archive contains no separate complete license text for RTL-SecCheck, VerilogLAVD, or VeriPVD. A README or package-manifest license label does not substitute for the missing license documents. This preparation does not grant a new license or establish redistribution rights. The applicable license texts and terms for the bundled components and retained examples/screenshots remain pending maintainer confirmation. This publication does not grant a new license.

The local runtime candidate omits the VerilogLAVD research datasets, their duplicate ZIP, and the experiment notebook. The ordinary plugin bridge analyzes the user's selected RTL directory and does not read those datasets. Python/Tcl runtime source remains included because the plugin needs it. A supplied hardcoded Neo4j password is removed; a personal config example path and a Tcl usage-comment path are generalized. All other retained upstream runtime source is preserved.

The original source-provided upstream notices above are retained as provenance statements; their assertions have not been independently verified during this local preparation. The bundled VerilogLAVD README's broken LICENSE link is replaced with an explicit missing-license note pointing here.
