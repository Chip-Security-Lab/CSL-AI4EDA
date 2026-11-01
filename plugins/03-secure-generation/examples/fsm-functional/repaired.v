module live_functional_fsm (
    input wire clk,
    input wire rst_n,
    output reg busy,
    output reg done,
    output reg alarm
);

    // function_repaired variant.
    //
    // Functional repair V4/V5: the unused MAINT branch is removed in this
    // repaired variant because MAINT has no incoming transition and is
    // unreachable from reset. This changes declared functionality with respect
    // to original_function_secure: MAINT and MAINT -> RUN are intentionally
    // not present here. No maintenance input is added, and MAINT is not inserted
    // into the normal IDLE/RUN/DONE cycle.
    //
    // Assumption: removing the unused MAINT branch is permitted by the original
    // requirement's explicit functional-repair allowance. Encoding 3'b011 is
    // therefore treated as unused/illegal in this variant and recovers to IDLE.
    //
    // Coding constraints:
    // V7: IDLE/RUN/DONE keep unique 3-bit encodings.
    // V9: single sequential writer for state; nonblocking assignment for state,
    //     blocking assignments in combinational logic.
    // V15: complete combinational defaults; illegal/unused encodings output
    //      busy=0, done=0, alarm=1 and recover to IDLE on the next rising edge.
    //
    // Rejected V12/V13 findings are not used to alter the intentionally
    // unconditional normal transitions.
    //
    // This comment does not claim functional equivalence, verified behavior,
    // or elimination of all vulnerabilities.

    localparam [2:0] IDLE = 3'b000;
    localparam [2:0] RUN  = 3'b001;
    localparam [2:0] DONE = 3'b010;

    reg [2:0] state;
    reg [2:0] next_state;

    // Combinational next-state logic with explicit default recovery.
    // The retained normal transitions remain unconditional.
    always @* begin
        next_state = IDLE;

        case (state)
            IDLE: next_state = RUN;
            RUN:  next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Single sequential state writer with active-low asynchronous reset.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Outputs depend on current state. Default handling covers unused/illegal
    // encodings, including 3'b011 after removal of MAINT.
    always @* begin
        busy  = 1'b0;
        done  = 1'b0;
        alarm = 1'b1;

        case (state)
            IDLE: begin
                busy  = 1'b0;
                done  = 1'b0;
                alarm = 1'b0;
            end
            RUN: begin
                busy  = 1'b1;
                done  = 1'b0;
                alarm = 1'b0;
            end
            DONE: begin
                busy  = 1'b0;
                done  = 1'b1;
                alarm = 1'b0;
            end
            default: begin
                busy  = 1'b0;
                done  = 1'b0;
                alarm = 1'b1;
            end
        endcase
    end

endmodule
