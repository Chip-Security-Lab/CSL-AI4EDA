`timescale 1ns/1ps
// Standalone known-answer checks. This file is not an input to the plugin.
module leaky_register_aes128_tb;
    reg clk = 1'b0;
    always #5 clk = ~clk;
    reg rst_n = 1'b0;
    reg start = 1'b0;
    reg [127:0] plaintext = 128'd0;
    reg [127:0] key = 128'd0;
    wire done;
    wire [127:0] ciphertext;

    leaky_register_aes128 dut (
        .clk(clk), .rst_n(rst_n), .start(start),
        .plaintext(plaintext), .key(key), .done(done), .ciphertext(ciphertext)
    );

    task check_block;
        input [127:0] block;
        input [127:0] secret_key;
        input [127:0] expected;
        integer cycle;
        begin
            @(negedge clk);
            plaintext = block;
            key = secret_key;
            start = 1'b1;
            @(posedge clk);
            #1;
            if (done) $fatal(1, "done asserted on start edge");
            @(negedge clk);
            start = 1'b0;
            // The current transaction must use the values captured on start.
            plaintext = ~block;
            key = ~secret_key;
            for (cycle = 1; cycle <= 10; cycle = cycle + 1) begin
                @(posedge clk);
                #1;
                if ((cycle < 10) && done) $fatal(1, "done asserted early");
            end
            if (!done) $fatal(1, "done missing after round 10");
            if (ciphertext !== expected)
                $fatal(1, "AES-128 mismatch: got %h expected %h", ciphertext, expected);
            @(posedge clk);
            #1;
            if (done) $fatal(1, "done did not clear after one clock");
            if (ciphertext !== expected) $fatal(1, "ciphertext did not hold");
        end
    endtask

    initial begin
        repeat (2) @(negedge clk);
        rst_n = 1'b1;
        // FIPS 197 Appendix C.1 AES-128 encryption example.
        check_block(128'h00112233445566778899aabbccddeeff,
                    128'h000102030405060708090a0b0c0d0e0f,
                    128'h69c4e0d86a7b0430d8cdb78070b4c55a);
        check_block(128'h00000000000000000000000000000000,
                    128'h00000000000000000000000000000000,
                    128'h66e94bd4ef8a2c3b884cfa59ca342b2e);
        // NIST SP 800-38A Appendix F.1.1 ECB-AES128 blocks 1 through 4.
        check_block(128'h6bc1bee22e409f96e93d7e117393172a,
                    128'h2b7e151628aed2a6abf7158809cf4f3c,
                    128'h3ad77bb40d7a3660a89ecaf32466ef97);
        check_block(128'hae2d8a571e03ac9c9eb76fac45af8e51,
                    128'h2b7e151628aed2a6abf7158809cf4f3c,
                    128'hf5d3d58503b9699de785895a96fdbaaf);
        check_block(128'h30c81c46a35ce411e5fbc1191a0a52ef,
                    128'h2b7e151628aed2a6abf7158809cf4f3c,
                    128'h43b1cd7f598ece23881b00e3ed030688);
        check_block(128'hf69f2445df4f9b17ad2b417be66c3710,
                    128'h2b7e151628aed2a6abf7158809cf4f3c,
                    128'h7b0c785e27e8ad3f8223207104725dd4);
        $display("PASS: six AES-128 blocks, latency, input capture and done pulse");
        $finish;
    end
endmodule
