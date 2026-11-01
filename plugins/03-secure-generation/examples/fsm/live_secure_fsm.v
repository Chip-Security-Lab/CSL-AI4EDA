module live_secure_fsm (
    input wire clk,
    input wire rst_n,
    output reg busy,
    output reg done,
    output reg alarm
);

    // V7: Unique, width-representable state encodings.
    localparam [2:0] IDLE = 3'b000;
    localparam [2:0] RUN  = 3'b001;
    localparam [2:0] DONE = 3'b010;

    // State register is explicitly 3 bits so an illegal encoding can be injected.
    reg [2:0] state;
    reg [2:0] next_state;

    // V15: Explicit combinational default next-state handling for illegal encodings.
    // The specified recovery target is IDLE on the next rising clock edge.
    // V12/V13 findings are rejected and retained as specified; no transition is altered.
    always @(*) begin
        next_state = IDLE;
        case (state)
            IDLE: begin
                next_state = RUN;
            end
            RUN: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // V9: Single sequential writer for the state register, nonblocking assignment,
    // with asynchronous active-low reset priority as required.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // V15: Complete combinational defaults and explicit default case prevent latches.
    // Illegal encodings immediately drive busy=0, done=0, alarm=1.
    always @(*) begin
        busy  = 1'b0;
        done  = 1'b0;
        alarm = 1'b0;

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