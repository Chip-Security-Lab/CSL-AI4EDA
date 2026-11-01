// Synthetic two-stage nonlinear test; not a cryptographic algorithm.
module t02_online(input wire clk,rst_n,start,
 input wire [7:0] key,plaintext,mask_a,mask_b,
 output reg done,output wire [7:0] ciphertext);
(* keep *) reg [1:0] secret_pair /* verilator public_flat */;
(* keep *) wire sbox_and /* verilator public_flat */ = secret_pair[0] & secret_pair[1];
(* keep *) reg [7:0] state /* verilator public_flat */;
always @(posedge clk or negedge rst_n) begin
 if(!rst_n) begin secret_pair<=0;state<=0;done<=0;end
 else begin done<=start;if(start)begin secret_pair<=key[1:0];state<=plaintext^{7'b0,sbox_and};end end
end
assign ciphertext=state;
endmodule
