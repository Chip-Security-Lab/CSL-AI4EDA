// Synthetic four-bit conversion test; modulo-16 arithmetic, not a cipher.
module t08_online(input wire clk,rst_n,start,
 input wire [7:0] key,plaintext,mask_a,mask_b,
 output reg done,output wire [7:0] ciphertext);
(* keep *) wire [3:0] bool_share0 /* verilator public_flat */ = key[3:0]^mask_a[3:0];
(* keep *) wire [3:0] bool_share1 /* verilator public_flat */ = mask_a[3:0];
(* keep *) wire [3:0] arithmetic_value /* verilator public_flat */ = (bool_share0^bool_share1)-mask_a[3:0];
reg [3:0] state;
always @(posedge clk or negedge rst_n) begin
 if(!rst_n)begin state<=0;done<=0;end
 else begin done<=start;if(start)state<=arithmetic_value+mask_a[3:0]+plaintext[3:0];end
end
assign ciphertext={4'b0,state};
endmodule
