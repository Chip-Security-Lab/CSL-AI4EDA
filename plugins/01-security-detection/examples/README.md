# Security Detection Plugin examples

[Plugin overview](../README.md) · [使用说明](../USER_GUIDE.zh-CN.md)

The six RTL files in `demo_soc/` are preserved byte-for-byte from the supplied detection archive. Keep them together and select the **whole `demo_soc` directory** as the scan target so multi-module connections remain available.

| File | Example role |
| --- | --- |
| [top.v](demo_soc/top.v) | Top-level connections |
| [access_ctrl.v](demo_soc/access_ctrl.v) | Access-control RTL |
| [crypto_core.v](demo_soc/crypto_core.v) | Example core RTL |
| [dbg_bridge.v](demo_soc/dbg_bridge.v) | Debug bridge RTL |
| [decoder.v](demo_soc/decoder.v) | Decoder RTL |
| [lock_ctrl.v](demo_soc/lock_ctrl.v) | Lock-control RTL |

These files are scan inputs, not a simulation testbench or an assertion that a particular count of vulnerabilities will be reported. No real scan was run during publication preparation. Follow the plugin guide to prepare dependencies, select engines, and interpret warnings.

中文：以上为原包现有六个 RTL 示例，保持原文。扫描时选择整个 `demo_soc` 文件夹；本次整理没有为它们新增预期检出数量或实验结论。LAVD 需要 Icarus 与专用 Neo4j 数据库，模型阶段需要用户自己的配置。
