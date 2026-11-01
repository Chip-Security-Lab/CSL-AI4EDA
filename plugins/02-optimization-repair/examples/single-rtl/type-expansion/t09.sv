// Illustrative risk fixture. Not a secure primitive or verified repair.
module t09_fixture(input wire clk,rst_n,start,
 input wire [7:0] key,plaintext,mask_a,mask_b,
 output reg done,output wire [7:0] ciphertext);
wire gated_clk /* verilator public_flat */ = clk & key[0];
reg [7:0] state;
always @(posedge gated_clk or negedge rst_n) begin
 if(!rst_n) state<=0; else if(start) state<=key ^ plaintext;
end
always @(posedge clk or negedge rst_n) begin
 if(!rst_n) done<=0; else done<=start;
end
assign ciphertext=state;
endmodule
