// Secret gate enable is captured on the falling edge; no arbitrary mid-high gate changes.
// Synthetic clock-gating test, not a cryptographic algorithm.
module t09_online(input wire clk,rst_n,start,
 input wire [7:0] key,plaintext,mask_a,mask_b,
 output reg done,output wire [7:0] ciphertext);
(* keep *) reg gate_enable /* verilator public_flat */;
(* keep *) wire gated_clk /* verilator public_flat */ = clk & gate_enable;
(* keep *) reg [7:0] state /* verilator public_flat */;
always @(negedge clk or negedge rst_n) begin
 if(!rst_n)gate_enable<=0;else gate_enable<=key[0];
end
always @(posedge gated_clk or negedge rst_n) begin
 if(!rst_n)state<=0;else if(start)state<=key^plaintext;
end
always @(posedge clk or negedge rst_n) begin
 if(!rst_n)done<=0;else done<=start;
end
assign ciphertext=state;
endmodule
