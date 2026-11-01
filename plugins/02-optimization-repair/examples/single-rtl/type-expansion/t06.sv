// Illustrative risk fixture. Not a secure primitive or verified repair.
module t06_fixture(input wire clk,rst_n,start,
 input wire [7:0] key,plaintext,mask_a,mask_b,
 output reg done,output wire [7:0] ciphertext);
(* keep *) wire [7:0] state_s0 /* verilator public_flat */ = key ^ mask_a;
(* keep *) wire [7:0] state_s1 /* verilator public_flat */ = mask_a;
(* keep *) wire [7:0] mixed /* verilator public_flat */ = state_s0 & state_s1;
reg [7:0] state;
always @(posedge clk or negedge rst_n) begin
 if(!rst_n) begin state<=0; done<=0; end
 else begin done<=start; if(start) state<=mixed ^ plaintext; end
end
assign ciphertext=state;
endmodule
