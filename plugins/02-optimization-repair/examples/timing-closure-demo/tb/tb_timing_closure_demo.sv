module tb_timing_closure_demo;
    reg clk = 0, rst_n = 0, start = 0;
    reg [31:0] plaintext = 0, key = 0, mask_i = 0;
    wire done;
    wire [31:0] ciphertext;
    integer cycles;
    reg [31:0] expected;
    timing_closure_demo dut (.*);
    always #5 clk = ~clk;

    function automatic [31:0] step;
        input [31:0] value;
        input [31:0] k;
        reg [31:0] a, b, c, d;
        begin
            a = value ^ {k[30:0], k[31]};
            b = (a + 32'h9e3779b9) ^ (a << 7);
            c = (b + {b[15:0], b[31:16]}) ^ (b >> 3);
            d = (c * 32'h00010003) ^ {c[7:0], c[31:8]};
            step = (d + c) ^ (d << 11) ^ (d >> 5);
        end
    endfunction

    task automatic run_case;
        input [31:0] p;
        input [31:0] k;
        input integer expected_cycles;
        integer index;
        begin
            plaintext = p; key = k; mask_i = 32'h5a5aa5a5;
            expected = p ^ k;
            for (index = 0; index < 4; index = index + 1) expected = step(expected, k);
            @(negedge clk); start = 1;
            @(negedge clk); start = 0;
            cycles = 0;
            while (!done && cycles < expected_cycles + 2) begin @(posedge clk); cycles = cycles + 1; end
            if (!done) $fatal(1, "done did not assert");
            if (cycles != expected_cycles) $fatal(1, "unexpected latency %0d expected %0d", cycles, expected_cycles);
            if (ciphertext !== expected) $fatal(1, "ciphertext mismatch %h expected %h", ciphertext, expected);
        end
    endtask

    initial begin
        repeat (2) @(posedge clk); rst_n = 1;
`ifdef PIPELINED
        run_case(32'h01234567, 32'h89abcdef, 17);
        run_case(32'h76543210, 32'h13579bdf, 17);
`else
        run_case(32'h01234567, 32'h89abcdef, 5);
        run_case(32'h76543210, 32'h13579bdf, 5);
`endif
        $display("FUNCTIONAL_PASS");
        $finish;
    end
endmodule
