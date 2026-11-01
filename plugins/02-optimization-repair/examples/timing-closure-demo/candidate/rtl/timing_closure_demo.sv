module timing_closure_demo (
    input wire clk, input wire rst_n, input wire start,
    input wire [31:0] plaintext, input wire [31:0] key, input wire [31:0] mask_i,
    output reg done, output reg [31:0] ciphertext
);
    reg [31:0] state_reg, stage1_reg, stage2_reg, stage3_reg;
    reg [31:0] key_reg, mask_reg;
    reg [3:0] round_reg;
    reg [1:0] phase_reg;
    wire [31:0] mix0 = state_reg ^ {key_reg[30:0], key_reg[31]};
    wire [31:0] stage1_next = (mix0 + 32'h9e3779b9) ^ (mix0 << 7);
    wire [31:0] stage2_next = (stage1_reg + {stage1_reg[15:0], stage1_reg[31:16]}) ^ (stage1_reg >> 3);
    wire [31:0] stage3_next = (stage2_reg * 32'h00010003) ^ {stage2_reg[7:0], stage2_reg[31:8]};
    wire [31:0] state_next = ((stage3_reg + stage2_reg) ^ (stage3_reg << 11) ^ (stage3_reg >> 5)) ^ mask_reg ^ mask_reg;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_reg <= 0; stage1_reg <= 0; stage2_reg <= 0; stage3_reg <= 0;
            key_reg <= 0; mask_reg <= 0; round_reg <= 0; phase_reg <= 0; ciphertext <= 0; done <= 0;
        end else begin
            done <= 0;
            if (start) begin
                state_reg <= plaintext ^ key; key_reg <= key; mask_reg <= mask_i;
                round_reg <= 0; phase_reg <= 0;
            end else if (round_reg < 4) begin
                case (phase_reg)
                    0: begin stage1_reg <= stage1_next; phase_reg <= 1; end
                    1: begin stage2_reg <= stage2_next; phase_reg <= 2; end
                    2: begin stage3_reg <= stage3_next; phase_reg <= 3; end
                    default: begin
                        state_reg <= state_next; phase_reg <= 0; round_reg <= round_reg + 1'b1;
                        if (round_reg == 3) begin ciphertext <= state_next; done <= 1; end
                    end
                endcase
            end
        end
    end
endmodule
