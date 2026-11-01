module timing_closure_demo (
    input wire clk, input wire rst_n, input wire start,
    input wire [31:0] plaintext, input wire [31:0] key, input wire [31:0] mask_i,
    output reg done, output reg [31:0] ciphertext
);
    reg [31:0] state_reg;
    reg [3:0] round_reg;

    // Stage A: mix0 and mix1 (mix1 = (mix0 + K) ^ (mix0 << 7))
    wire [31:0] mix0 = state_reg ^ {key[30:0], key[31]};
    wire [31:0] mix1 = (mix0 + 32'h9e3779b9) ^ (mix0 << 7);

    // Stage B: mix2 = (mix1 + rot16(mix1)) ^ (mix1 >> 3)
    // rot16(mix1) = {mix1[15:0], mix1[31:16]}
    // Use half-word identity: for x={H,L}, x + rot16(x) mod 2^32 = {hi, lo}
    //   s0 = {0,H} + {0,L}  (16-bit add, no cross carry into upper half)
    //   lo = s0[15:0]
    //   s1 = H + L + 1  (parallel 16-bit add)
    //   hi = s0[16] ? s1 : s0[15:0]
    wire [15:0] m1_H = mix1[31:16];
    wire [15:0] m1_L = mix1[15:0];
    wire [16:0] s0   = {1'b0, m1_H} + {1'b0, m1_L};
    wire [16:0] s1   = {1'b0, m1_H} + {1'b0, m1_L} + 17'd1;
    wire [15:0] sum_lo = s0[15:0];
    wire [15:0] sum_hi = s0[16] ? s1[15:0] : s0[15:0];
    wire [31:0] rot16_sum = {sum_hi, sum_lo};
    wire [31:0] mix2 = (rot16_sum) ^ (mix1 >> 3);

    // Stage C: mix3 = (mix2 * 0x00010003) ^ ror8(mix2)
    // 0x00010003 = 2^16 + 3, so mix2*0x00010003 = (mix2<<16) + 3*mix2
    // 3*mix2 = (mix2<<1) + mix2, computed as a balanced 3-operand carry-save
    //   cs = mix2 ^ (mix2<<1) ^ (mix2<<16)
    //   cc = ((mix2 & (mix2<<1)) | (mix2 & (mix2<<16)) | ((mix2<<1) & (mix2<<16))) << 1
    //   mix2*0x00010003 = cs + cc  (mod 2^32)
    wire [31:0] t1 = mix2 << 1;
    wire [31:0] t2 = mix2 << 16;
    wire [31:0] cs = mix2 ^ t1 ^ t2;
    wire [31:0] cc = ((mix2 & t1) | (mix2 & t2) | (t1 & t2)) << 1;
    wire [31:0] mul3 = cs + cc;
    wire [31:0] mix3 = mul3 ^ {mix2[7:0], mix2[31:8]};

    // Stage D: mix4 = (mix3 + mix2) ^ (mix3 << 11) ^ (mix3 >> 5)
    wire [31:0] mix4 = (mix3 + mix2) ^ (mix3 << 11) ^ (mix3 >> 5);

    // mask_i ^ mask_i == 0, so next_state = mix4 (preserve exact behavior)
    wire [31:0] next_state = mix4;

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