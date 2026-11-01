# Downloads and installation formats

[Home](../README.md) · [User guide](USER_GUIDE.md)

Use the release for the plugin you need. Versions are independent; there is no shared four-plugin version number. The links below point to this distribution set's per-plugin preview releases.

| Plugin | Release entry | Files / installation format |
| --- | --- | --- |
| [Security Detection](../plugins/01-security-detection/README.md) | [security-detection-v0.1.1](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/security-detection-v0.1.1) | VSIX plus matching runtime ZIP; the VSIX alone does not include the detection engines |
| [Optimization & Repair](../plugins/02-optimization-repair/README.md) | [optimization-repair-v0.5.3](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/optimization-repair-v0.5.3) | `rtl-optimize-repair-0.5.3.vsix`; backend, examples and manuals are included |
| [Secure Generation](../plugins/03-secure-generation/README.md) | [secure-generation-v0.3.15](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/secure-generation-v0.3.15) | VS Code VSIX, Vivado companion ZIP, provided examples archive, and optional browser demos ZIP |
| [HDL Copilot](../plugins/04-hdl-copilot/README.md) | [hdl-copilot-v0.3.4](https://github.com/Chip-Security-Lab/CSL-AI4EDA/releases/tag/hdl-copilot-v0.3.4) | VS Code VSIX, Vivado companion ZIP, and provided examples archive |

Release notes list the exact assets, supported environment, change scope, and verification limits. `SHA256SUMS.txt` records the SHA-256 checksum of every downloadable file for that release. Follow the plugin guide before installing system dependencies or configuring a model service.

In desktop VS Code, use Extensions → `…` → **Install from VSIX…**, select the `.vsix`, and reload when prompted. A VSIX is an extension package, not a replacement for Python, Vivado, WSL, Neo4j, or other system software named in a plugin's guide.

The generation and Copilot Vivado archives provide Tcl launchers and companion interfaces. The optimization plugin integrates Vivado through its VS Code settings. Detection uses a shared external runtime for both its VS Code and Tcl entry points.

Secure Generation additionally provides a standalone browser demos ZIP for the saved CSR, FSM, and FSM functional-correction cases. Open its HTML files locally; model configuration is not needed to view these saved examples.

Examples are preserved under each [plugin directory](../plugins/README.md) and in the applicable package or examples attachment. Follow the example README; teaching inputs and test fixtures are not production-ready security designs.

GitHub's automatically generated **Source code (zip/tar.gz)** downloads contain the repository tree at a tag. Download the explicitly named release attachments for installable plugins. Each plugin page links to its own release, rather than using the repository-wide latest-release link.

References: [GitHub Releases](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases) · [VS Code VSIX packaging](https://code.visualstudio.com/api/working-with-extensions/publishing-extension)
