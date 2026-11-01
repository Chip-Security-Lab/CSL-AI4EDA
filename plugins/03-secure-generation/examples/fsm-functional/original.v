module live_functional_fsm (
    input wire clk,
    input wire rst_n,
    output reg busy,
    output reg done,
    output reg alarm
);

    // original_function_secure variant:
    // Preserve the declared original functional graph, including MAINT and
    // MAINT -> RUN. MAINT has no incoming transition and is unreachable from
    // IDLE, but the V4/V5 functional repairs are intentionally not applied in
    // this original-function variant. Those original-function issues are
    // retained and only documented here.
    //
    // V7: state encodings are unique and width-representable.
    // V9: one sequential writer for state; combinational logic uses blocking
    //     assignments and nonblocking assignment is used for the state register.
    // V15: illegal encodings recover to IDLE with safe outputs
    //      busy=0, done=0, alarm=1. MAINT=3'b011 remains a declared legal state.
    // No additional input, maintenance interface, protected state, permission
    // check, arithmetic operation, or cross-clock interaction is introduced.
    // Reset is active-low asynchronous, and IDLE outputs are produced
    // combinationally immediately after reset.

    localparam [2:0] IDLE  = 3'b000;
    localparam [2:0] RUN   = 3'b001;
    localparam [2:0] DONE  = 3'b010;
    localparam [2:0] MAINT = 3'b011;

    reg [2:0] state;
    reg [2:0] next_state;

    // Combinational next-state logic with complete defaults.
    always @* begin
        next_state = IDLE; // Default recovery for unused/illegal encodings.

        case (state)
            IDLE:  next_state = RUN;
            RUN:   next_state = DONE;
            DONE:  next_state = IDLE;
            MAINT: next_state = RUN;
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

    // Outputs depend on the current state.
    // The default branch gives illegal encodings busy=0, done=0, alarm=1.
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
            MAINT: begin
                busy  = 1'b0;
                done  = 1'b0;
                alarm = 1'b1;
            end
            default: begin
                busy  = 1'b0;
                done  = 1'b0;
                alarm = 1'b1;
            end
        endcase
    end

endmodule
