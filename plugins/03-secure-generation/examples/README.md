# CSL_HDLGen Examples

The general CSR case is adapted from the PowerSecV paper. The two FSM cases contain saved real CSL_HDLGen outputs generated on November 1, 2026 with DeepSeek `deepseek-flash`. All source files use Verilog-2005.

| Folder | Design | Status |
| --- | --- | --- |
| `general/` | CSR access control: secure and low-power references | Static comparison only; no compilation, simulation, power measurement or side-channel validation |
| `fsm/` | IDLE → RUN → DONE → IDLE controller | Previously passed finite checks for reset, cyclic transitions, outputs, illegal-encoding safe outputs and recovery |
| [`fsm-functional/`](fsm-functional/README.md) | An unreachable maintenance state, with original and function-corrected versions | Both versions passed compilation and finite checks for normal behavior and their different recovery behavior |

## General CSR case

- `requirement.txt`: the interface and behavior for the paper-based case.
- `csr_access_secure.v`: the secure reference inspired by Figure 4(b).
- `csr_access_low_power.v`: the buffered write-enable reference inspired by Figure 4(c).
- `comparison.md`: the static comparison, assumptions and differences.
- `verification.json`: provenance and explicit `not_run` verification status.

Source: *PowerSecV: LLM-Based Secure and Low-Power Verilog Generation via Hardware-CWE Knowledge Graph and Power Evolution*, Section IV.D, Figure 4, pages 11–12.

The secure reference uses privilege-controlled writes and updates an auxiliary mask on every request. The low-power reference uses a lightweight buffer and storage write enable, with address, data and authorization captured for the same transaction. It adds one cycle of write-commit latency. Reset and read behavior complete the schematic interface. These adaptations resemble the paper's architecture but do not establish equal switching activity, physical side-channel resilience or measured power savings. No new model call or test was performed for these CSR files.

## FSM case

`fsm/` contains `requirement.txt`, the saved `live_secure_fsm.v`, independent `tb.v`, and the previously recorded `verification.json`, `compile.log` and `simulation.log`. These existing records apply only to this FSM case.

## FSM functional-correction case

[`fsm-functional/`](fsm-functional/README.md) contains two real-model versions of a controller with an unreachable `MAINT` state. The original keeps `MAINT → RUN`; the corrected proposal removes the unused state under an explicit assumption permitted by the requirement. The normal cycle and ports remain unchanged. Requirements, both source files, the security report, supporting knowledge, code differences, testbench and verification records are included. See the case guide for comparison and optional run commands.

## Try generation in CSL_HDLGen

Open the extension, configure your model, and select **General secure RTL** for `general/` or **Secure FSM** for either FSM folder. Paste the corresponding `requirement.txt`, turn off **Demo template**, and click **Generate**. Use the version selector when two FSM versions are offered. Model outputs may differ between runs. To view the predefined CSR references without a model, choose **Run demo**, followed by **Optimize power** for its low-power reference.

## Optionally rerun the saved FSM

Install Icarus Verilog and put `iverilog` and `vvp` on your PATH. No model configuration or Neo4j is needed for the saved FSM testbenches. The CSR references do not include a testbench or pass record.

From the `examples/` directory:

```sh
cd fsm
iverilog -g2005 -s tb -o simulation.vvp live_secure_fsm.v tb.v
vvp simulation.vvp
cd ..
```

A successful run prints `PASS FSM:` with no `FAIL` message. To run the two functional-correction versions, follow the [case guide](fsm-functional/README.md#run-the-saved-code). These finite simulations are not formal verification or proof of complete security. The CSR case remains untested.

The same files are bundled in the VS Code extension's `examples/` directory and distributed as `CSL_HDLGen-Examples.zip`.
