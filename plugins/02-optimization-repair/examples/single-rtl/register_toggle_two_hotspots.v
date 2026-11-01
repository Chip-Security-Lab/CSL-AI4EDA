// Deliberately leaky teaching example. This is not a cryptographic primitive.
// Assert start for one clock edge; ciphertext and done update on that edge.
// Select key as the sensitive input in the plugin.
module register_toggle_two_hotspots (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       start,
    input  wire [7:0] plaintext,
    input  wire [7:0] key,
    input  wire [7:0] mask_i,
    output reg        done,
    output wire [7:0] ciphertext
);
    // Hotspot 1: transitions from the previous value to the raw key.
    (* keep = "true" *) reg [7:0] key_latch;
    // Hotspot 2: transitions depend on the key and public plaintext.
    (* keep = "true" *) reg [7:0] mixed_latch;

    // Rotation keeps both registers observable without cancelling the key.
    assign ciphertext = key_latch ^ {mixed_latch[6:0], mixed_latch[7]};

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            key_latch   <= 8'h00;
            mixed_latch <= 8'h00;
            done        <= 1'b0;
        end else begin
            done <= 1'b0;
            if (start) begin
                key_latch   <= key;
                mixed_latch <= plaintext ^ key;
                done        <= 1'b1;
            end
        end
    end
    // mask_i is independent randomness supplied by the test driver. It is
    // intentionally unused in this baseline, available for candidate repairs.
endmodule
