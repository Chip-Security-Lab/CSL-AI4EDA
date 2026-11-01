// Synthetic secret-controlled register update, not a cryptographic algorithm.
module t03_online(input wire clk,rst_n,start,
 input wire [7:0] key,plaintext,mask_a,mask_b,
 output reg done,output wire [7:0] ciphertext);
(* keep *) reg [7:0] state /* verilator public_flat */;
always @(posedge clk or negedge rst_n) begin
 if(!rst_n)begin state<=0;done<=0;end
 else begin done<=start;if(start && key[0])state<=key^plaintext;end
end
assign ciphertext=state;
endmodule
