// CSL_HDLChat example
// Demo only: contains an intentional off-by-one bug.
// Expected behavior: count cycles from 0 to 9, then returns to 0.

module counter(input wire clk, input wire rst_n, output reg [3:0] count);
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) count <= 0;
  else if (count == 10) count <= 0;
  else count <= count + 1'b1;
end
endmodule
