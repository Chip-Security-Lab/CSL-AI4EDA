# CSL_HDLChat Examples

Two small examples for trying RTL analysis and reviewed code changes. Both files contain **intentional bugs**. They are starting points for the assistant, not production-ready designs.

## How to use

1. Extract this folder and open it in VS Code.
2. Open CSL_HDLChat using the **C icon**, then configure your model.
3. Open one example file and confirm its name in the assistant.
4. Click **New chat**, paste the matching prompt below, and click **Send**.
5. Click **Generate changes and preview**, review the diff, then choose **Apply changes** if correct. Save manually.
6. Use a new chat for the second example.

### 1. Counter boundary — `01_counter_boundary.v`

**Prompt:**

> Check whether this counter returns to zero every 10 clock cycles. Identify the bug and suggest the smallest fix. Preserve the ports and asynchronous active-low reset.

**中文提问：**

> 请检查计数器是否每 10 拍回到 0，定位错误并给出最小修改。保留端口与异步低有效复位方式。

**Expected result:** The original counter cycles through 0–10, taking 11 cycles. Change the comparison from `count == 10` to `count == 9`. After reset, the first 12 rising edges should produce `1,2,3,4,5,6,7,8,9,0,1,2`.

### 2. Combinational latch — `02_combinational_latch.v`

**Prompt:**

> Explain why this combinational block may infer a latch. Modify it so y equals a when en is 1 and equals zero when en is 0. Keep the module interface unchanged.

**中文提问：**

> 为什么这段组合逻辑可能推断出锁存器？要求 en 为 1 时 y 等于 a，en 为 0 时 y 输出 0，请保持接口不变并给出修改。

**Expected result:** The original code does not assign `y` when `en` is 0. Add an `else` assignment such as `y = 8'b0`, or an equivalent default assignment. No previous value should be retained when disabled.

## Validation

These two cases were tested through the CSL_HDLChat backend with the real `deepseek-flash` API on 2026-11-01. The generated fixes compiled and passed independent Icarus Verilog simulations:

- Counter: 32 clock cycles and asynchronous reset checks.
- Combinational logic: all 256 input values with enable on and off.

The files supplied here are the original buggy inputs. The validation applies to the reviewed fixes from that test; new model outputs can differ and should be checked. CSL_HDLChat does not automatically compile or simulate the code.
