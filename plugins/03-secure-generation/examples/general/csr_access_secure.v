// Paper-adapted reference: PowerSecV, Section IV.D, Figure 4(b), pp. 11-12.
// Completed interface/reset/read behavior is documented in comparison.md.
// Upstream decoding must prevent different privilege addresses from aliasing
// the same low-7-bit storage index. This is not a complete RISC-V CSR decoder.
// Static illustration only: compilation, simulation and physical evaluation were not run.
module csr_access_secure (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        csr_we,
    input  wire [1:0]  current_priv,
    input  wire [11:0] csr_addr,
    input  wire [31:0] write_data,
    output wire [31:0] csr_rdata,
    output reg         illegal_access,
    output wire        power_signature
);
    reg [31:0] csr_mem [0:127];
    reg [31:0] mask_0;
    wire is_valid;
    integer i;

    assign is_valid = (current_priv >= csr_addr[11:10]);
    // The read port is an explicit completion of the paper's abbreviated module.
    assign csr_rdata = is_valid ? csr_mem[csr_addr[6:0]] : 32'b0;
    // Observation of the auxiliary register, not a physical power measurement.
    assign power_signature = ^mask_0;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 128; i = i + 1)
                csr_mem[i] <= 32'b0;
            mask_0 <= 32'b0;
            illegal_access <= 1'b0;
        end else begin
            illegal_access <= 1'b0;
            if (csr_we) begin
                if (is_valid)
                    csr_mem[csr_addr[6:0]] <= write_data;
                illegal_access <= !is_valid;
                // Match Figure 4(b): update the auxiliary path for every request,
                // including denied writes. A fixed XOR does not guarantee toggling.
                mask_0 <= write_data ^ 32'hA3EF63B2;
            end
        end
    end
endmodule
