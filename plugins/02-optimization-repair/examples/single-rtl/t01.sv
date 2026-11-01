module t01_demo(input wire clk,input wire rst_n,input wire start,
    input wire [7:0] plaintext,input wire [7:0] key,input wire [7:0] mask_i,
    output reg done,output wire [7:0] ciphertext);
    reg [7:0] key_reg;
    reg [7:0] data_reg;
    assign ciphertext = key_reg ^ data_reg;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin key_reg <= 8'd0; data_reg <= 8'd0; done <= 0; end
        else begin done <= 0; if (start) begin key_reg <= key; data_reg <= plaintext; done <= 1; end end
    end
endmodule
