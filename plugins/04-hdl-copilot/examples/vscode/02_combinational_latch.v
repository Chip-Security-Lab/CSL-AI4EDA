// CSL_HDLChat example
// Demo only: contains an intentional incomplete assignment.
// Expected behavior: y equals a when en is 1, otherwise y is 0.

module select_data(input wire en, input wire [7:0] a, output reg [7:0] y);
always @(*) begin
  if (en) y = a;
end
endmodule
