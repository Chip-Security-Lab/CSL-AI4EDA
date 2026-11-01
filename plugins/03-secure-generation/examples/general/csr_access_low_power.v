// Paper-adapted reference: PowerSecV, Section IV.D, Figure 4(c), pp. 11-12.
// Address, data and permission are buffered together to complete the pipeline.
// Upstream decoding must prevent different privilege addresses from aliasing
// the same low-7-bit storage index. This is not a complete RISC-V CSR decoder.
// Static illustration only: compilation, simulation and physical evaluation were not run.
module csr_access_low_power (
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
    reg [31:0] dummy_0;
    reg [6:0]  addr_q;
    reg        allow_q;
    reg        pending_q;
    wire is_valid;
    wire gated_clk_en;
    integer i;

    assign is_valid = (current_priv >= csr_addr[11:10]);
    // Clock-enable style; no combinational AND is inserted into the clock path.
    assign gated_clk_en = pending_q && allow_q;
    assign csr_rdata = is_valid ? csr_mem[csr_addr[6:0]] : 32'b0;
    // This parity observation is not a power or side-channel security metric.
    assign power_signature = ^dummy_0;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 128; i = i + 1)
                csr_mem[i] <= 32'b0;
            dummy_0 <= 32'b0;
            addr_q <= 7'b0;
            allow_q <= 1'b0;
            pending_q <= 1'b0;
            illegal_access <= 1'b0;
        end else begin
            illegal_access <= 1'b0;

            // Nonblocking assignments use the previous accepted transaction here.
            // Permission is sampled at acceptance and remains valid for that request.
            if (gated_clk_en)
                csr_mem[addr_q] <= dummy_0;

            pending_q <= csr_we;
            if (csr_we) begin
                // Both permitted and denied requests update the lightweight buffer.
                dummy_0 <= write_data;
                addr_q <= csr_addr[6:0];
                allow_q <= is_valid;
                illegal_access <= !is_valid;
            end
        end
    end
endmodule
