module toy_cipher (
    input wire clk, input wire rst_n, input wire start,
    input wire [7:0] plaintext, input wire [7:0] key, input wire [7:0] mask_i,
    output reg done, output reg [7:0] ciphertext
);
    // Intentional T04 regression stimulus: the read address depends on key.
    reg [7:0] lookup_table [0:3];
    initial begin
        lookup_table[0] = 8'h00;
        lookup_table[1] = 8'h03;
        lookup_table[2] = 8'h3c;
        lookup_table[3] = 8'hff;
    end
    // start gates the lookup transition into the RTL-TVLA active window.
    wire [1:0] secret_addr = start ? (plaintext[1:0] ^ key[1:0]) : 2'b00;
    wire [7:0] table_data /* verilator public_flat */ = lookup_table[secret_addr];
    wire unused_mask = ^mask_i;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            done <= 1'b0;
            ciphertext <= 8'h00;
        end else begin
            done <= 1'b0;
            if (start) begin
                ciphertext <= table_data;
                done <= 1'b1;
            end
        end
    end
endmodule
