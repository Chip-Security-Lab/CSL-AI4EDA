// Illustrative risk fixture. Not a secure primitive or verified repair.
module t03_fixture(input wire clk,rst_n,start,
 input wire [7:0] key,plaintext,mask_a,mask_b,
 output reg done,output wire [7:0] ciphertext);
reg [7:0] state /* verilator public_flat */;
always @(posedge clk or negedge rst_n) begin
 if (!rst_n) begin state<=0; done<=0; end
 else begin done<=start; if(start && key[0]) state<=plaintext; end
end
assign ciphertext=state;
endmodule
