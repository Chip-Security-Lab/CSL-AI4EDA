// Illustrative risk fixture. Not a secure primitive or verified repair.
module t10_fixture(input wire clk,rst_n,start,
 input wire [7:0] key,plaintext,mask_a,mask_b,
 output reg done,output wire [7:0] ciphertext);
(* keep *) wire [7:0] deep0 /* verilator public_flat */ = plaintext + key;
(* keep *) wire [7:0] deep1 /* verilator public_flat */ = (deep0 * 8'd3) ^ (deep0 >> 2);
(* keep *) wire [7:0] selected /* verilator public_flat */ = key[0] ? deep1 : plaintext;
reg [7:0] state;
always @(posedge clk or negedge rst_n) begin
 if(!rst_n) begin state<=0; done<=0; end
 else begin done<=start; if(start) state<=selected; end
end
assign ciphertext=state;
endmodule
