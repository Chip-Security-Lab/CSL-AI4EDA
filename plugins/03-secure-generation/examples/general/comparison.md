# PowerSecV CSR case: static comparison

Source: *PowerSecV: LLM-Based Secure and Low-Power Verilog Generation via Hardware-CWE Knowledge Graph and Power Evolution*, Section IV.D, Figure 4 and its discussion on pages 11-12 of the supplied paper.

These files are completed, paper-adapted references. They are not new model outputs or a reproduction of the paper's physical experiments. At the user's request, no compilation, simulation, model call, security test or power evaluation was run for this replacement.

| Aspect | Paper | Included example |
| --- | --- | --- |
| CSR organization | 128 entries of 32 bits; index `csr_addr[6:0]` | Same array size and index |
| Write permission | `current_priv >= csr_addr[11:10]` | Same comparison; denied writes do not update the array |
| Secure structure, Fig. 4(b) | Every request updates `mask_0` with `write_data ^ 32'hA3EF63B2` | Same per-request auxiliary update, for permitted and denied requests |
| Low-power structure, Fig. 4(c) | Dummy buffering and conditional storage updates | Every request captures a lightweight buffer; only buffered, permitted requests commit to the array |
| Clock control | An enable called `gated_clk_en` in the abbreviated RTL | A conditional enable inside `always @(posedge clk...)`; no raw AND-gated clock |
| Reported current traces | Qualitative physical plots of permitted and denied access | Not reproduced or measured; `power_signature` is only a parity observation |

## Explicit completions and differences

- The figure omits the full ports and reset logic. The example supplies an active-low asynchronous reset that clears the array and control registers. A full-array reset can affect implementation, area and power, so physical equivalence is not assumed.
- The example adds a combinational read port, returning zero when the current privilege check fails. This interface policy is an explicit completion rather than a statement that the paper specified that port.
- The figure uses only the low seven address bits as a physical index and bits `[11:10]` for its privilege comparison. This is the paper's abstract convention, not a complete RISC-V CSR address decoder. An upstream decoder must ensure consistent permissions for addresses aliasing the same physical index. The fragment does not prove that arbitrary cross-privilege address aliases are safe.
- `illegal_access` is defined as a per-request result pulse. The abbreviated figure leaves the no-request behavior implicit.
- The low-power variant has one additional clock cycle of write-commit latency. It is not cycle-equivalent to the immediate-write secure variant.
- Figure 4(c) assigns `dummy_0` in one positive-edge block and consumes it in another while showing the current address and permission. With nonblocking assignments, the consumed dummy value is the previous value. The complete example therefore buffers address, data, authorization and request presence together; it commits that same transaction on the following edge.
- Authorization is sampled at acceptance and remains valid for that request. A policy allowing revocation before commit would require an additional, explicitly specified revalidation mechanism.
- During back-to-back requests, an earlier permitted request can commit while a new denied request is accepted. Array activity is controlled by the buffered transaction, not by the new request's permission alone.

## What can be concluded statically

The main RTL mechanisms resemble the secure and low-power variants in Figure 4: permission-gated CSR writes, an auxiliary path updated for all requests, and a buffered/conditionally enabled storage path. The supplied low-power code makes the abbreviated pipeline's transaction alignment explicit.

Both references already suppress denied array writes. Adding the request buffer does not itself reduce the number of permitted array writes; the paper's intended physical benefit depends on implementation and activity, which are not evaluated here.

A fixed XOR is not a source of random noise and does not force switching when repeated input data is unchanged. Similarly, a parity output does not measure physical power. This code alone cannot establish constant switching, indistinguishable current traces, side-channel resistance, a particular power saving, or the paper's aggregate benchmark results. Those remain unmeasured for this example.
