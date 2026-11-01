// Illustrative risk fixture. Not a secure primitive or verified repair.
module t02_fixture(input wire clk,rst_n,start,
 input wire [7:0] key,plaintext,mask_a,mask_b,
 output reg done,output wire [7:0] ciphertext);
(* keep *) wire [7:0] sbox_value /* verilator public_flat */ = key & {key[6:0],key[7]};
reg [7:0] state;
always @(posedge clk or negedge rst_n) begin
 if(!rst_n) begin state<=0; done<=0; end
 else begin done<=start; if(start) state<=sbox_value ^ plaintext; end
end
assign ciphertext=state;
endmodule
