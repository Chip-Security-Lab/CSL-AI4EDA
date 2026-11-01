// Synthetic unequal-depth path selector. Both branches are the same function
// evaluated at plaintext and 1, allowing an equivalent common datapath.
module t10_online(input wire clk,rst_n,start,
 input wire [7:0] key,plaintext,mask_a,mask_b,
 output reg done,output wire [7:0] ciphertext);
(* keep *) wire [7:0] deep0 /* verilator public_flat */ = plaintext+8'd3;
(* keep *) wire [7:0] deep1 /* verilator public_flat */ = deep0*8'd5;
(* keep *) wire [7:0] selected /* verilator public_flat */ = key[0]?deep1:8'd20;
reg [7:0] state;
always @(posedge clk or negedge rst_n) begin
 if(!rst_n)begin state<=0;done<=0;end
 else begin done<=start;if(start)state<=selected;end
end
assign ciphertext=state;
endmodule
