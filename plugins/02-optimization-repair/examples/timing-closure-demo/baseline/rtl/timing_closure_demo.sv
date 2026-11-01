module timing_closure_demo (
    input wire clk, input wire rst_n, input wire start,
    input wire [31:0] plaintext, input wire [31:0] key, input wire [31:0] mask_i,
    output reg done, output reg [31:0] ciphertext
);
    reg [31:0] state_reg;
    reg [3:0] round_reg;
    wire [31:0] mix0 = state_reg ^ {key[30:0], key[31]};
    wire [31:0] mix1 = (mix0 + 32'h9e3779b9) ^ (mix0 << 7);
    wire [31:0] mix2 = (mix1 + {mix1[15:0], mix1[31:16]}) ^ (mix1 >> 3);
    wire [31:0] mix3 = (mix2 * 32'h00010003) ^ {mix2[7:0], mix2[31:8]};
    wire [31:0] mix4 = (mix3 + mix2) ^ (mix3 << 11) ^ (mix3 >> 5);
    wire [31:0] next_state = mix4 ^ mask_i ^ mask_i;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin state_reg <= 0; round_reg <= 0; ciphertext <= 0; done <= 0; end
        else begin
            done <= 0;
            if (start) begin state_reg <= plaintext ^ key; round_reg <= 0; end
            else if (round_reg < 4) begin
                state_reg <= next_state; round_reg <= round_reg + 1'b1;
                if (round_reg == 3) begin ciphertext <= next_state; done <= 1; end
            end
        end
    end
endmodule
