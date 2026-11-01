# Optimization & Repair examples

[Plugin](../README.md) · [Usage](../USER_GUIDE.md)

The supplied sample files are preserved from version 0.5.3. Their original root guide is retained as [SOURCE_README.zh-CN.md](SOURCE_README.zh-CN.md). The same examples are included in the VSIX; **RTL: open built-in examples** copies them to editable user storage.

| Example | How to start | Scope |
| --- | --- | --- |
| [Register toggle](single-rtl/register_toggle_two_hotspots.v) | Side-channel task; sensitive input `key`; automatic type analysis | Deliberately leaky teaching input |
| [AES register example](single-rtl/leaky_register_aes128.md) | Read the supplied instructions and testbench | More complex input; no universal repair guarantee |
| [Conditional type examples](sidechannel-online/README.md) | Read `specs.json` and confirm only actual random/share resources | Synthetic experimental inputs |
| [Earlier type inputs](single-rtl/type-expansion/README.md) | Diagnostic study | Not all types have proven repair results |
| [Timing baseline](timing-closure-demo/README.md) | Use baseline RTL and `constraints/timing_closure_demo.xdc`; choose actual device PART | Candidate fixture changes latency under an explicit historical contract; it is not a general successful optimizer output |

Work on a copy and inspect actual tool results. The current plugin starts with automatic T01–T10 analysis; older text mentioning a T01/T04 default is retained only as part of the supplied source notes. Tests and fixtures do not establish physical security or guarantee that each generated candidate succeeds.
