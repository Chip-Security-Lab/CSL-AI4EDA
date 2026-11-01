module sca_leaky_aes_sbox (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        en,
    input  wire [7:0]  plaintext,
    input  wire [7:0]  key,
    output reg  [7:0]  sbox_out
);

    // AES S-Box 查找表（简化示例，只列一部分，实际需完整 256 项）
    function [7:0] aes_sbox;
        input [7:0] x;
        begin
            case (x)
                8'h00: aes_sbox = 8'h63;
                8'h01: aes_sbox = 8'h7c;
                8'h02: aes_sbox = 8'h77;
                8'h03: aes_sbox = 8'h7b;
                8'h04: aes_sbox = 8'hf2;
                8'h05: aes_sbox = 8'h6b;
                8'h06: aes_sbox = 8'h6f;
                8'h07: aes_sbox = 8'hc5;
                // ... 其余 248 项省略
                default: aes_sbox = 8'h00;
            endcase
        end
    endfunction

    // 关键：组合逻辑中直接做 key XOR plaintext
    wire [7:0] state_xor_key = plaintext ^ key;

    // 关键：S-Box 输出直接进寄存器，且使能由 en 控制
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            sbox_out <= 8'h00;
        else if (en)
            sbox_out <= aes_sbox(state_xor_key);
    end

endmodule
