`timescale 1ns/1ps
module tb;
  // Compile the unchanged bench with -Ptb.EXPECT_REPAIRED=0 or =1.
  parameter integer EXPECT_REPAIRED = 0;
  reg clk;
  reg rst_n;
  reg [2:0] injected_encoding;
  wire busy;
  wire done;
  wire alarm;
  integer cycle;
  integer unused_code;

  live_functional_fsm dut (
    .clk(clk), .rst_n(rst_n), .busy(busy), .done(done), .alarm(alarm)
  );

  task tick;
    begin
      clk = 1'b0; #4;
      clk = 1'b1; #1;
      clk = 1'b0; #1;
    end
  endtask

  task check;
    input [2:0] expected_state;
    input expected_busy;
    input expected_done;
    input expected_alarm;
    input [767:0] label;
    begin
      if (dut.state !== expected_state ||
          {busy, done, alarm} !== {expected_busy, expected_done, expected_alarm}) begin
        $display("FAIL FUNCTIONAL FSM: %0s expected state=%b outputs=%b%b%b actual state=%b outputs=%b%b%b",
                 label, expected_state, expected_busy, expected_done, expected_alarm,
                 dut.state, busy, done, alarm);
        $finish;
      end
    end
  endtask

  task reset_to_idle;
    begin
      clk = 1'b0; #1; rst_n = 1'b0; #1;
      check(3'b000, 1'b0, 1'b0, 1'b0, "asynchronous reset enters IDLE");
      rst_n = 1'b1;
    end
  endtask

  task check_illegal_encoding;
    begin
      clk = 1'b0;
      force dut.state = injected_encoding;
      #1;
      check(injected_encoding, 1'b0, 1'b0, 1'b1, "unused encoding immediately produces safe outputs and alarm");
      release dut.state;
      tick;
      check(3'b000, 1'b0, 1'b0, 1'b0, "unused encoding recovers to IDLE on the next clock");
      tick;
      check(3'b001, 1'b1, 1'b0, 1'b0, "normal operation resumes after illegal-state recovery");
    end
  endtask

  initial begin
    clk = 1'b0;
    rst_n = 1'b1;
    injected_encoding = 3'b000;
    if (EXPECT_REPAIRED != 0 && EXPECT_REPAIRED != 1) begin
      $display("FAIL FUNCTIONAL FSM: invalid test configuration");
      $finish;
    end

    reset_to_idle;
    for (cycle = 0; cycle < 5; cycle = cycle + 1) begin
      tick; check(3'b001, 1'b1, 1'b0, 1'b0, "IDLE -> RUN");
      tick; check(3'b010, 1'b0, 1'b1, 1'b0, "RUN -> DONE");
      tick; check(3'b000, 1'b0, 1'b0, 1'b0, "DONE -> IDLE, no normal entry to MAINT");
    end

    // The deliberately unreachable declared state is the distinguishing check.
    // Force it only for fault injection; do not add an incoming functional edge.
    clk = 1'b0;
    injected_encoding = 3'b011;
    force dut.state = injected_encoding;
    #1;
    check(3'b011, 1'b0, 1'b0, 1'b1, "MAINT or removed-MAINT encoding produces alarm");
    release dut.state;
    tick;
    if (EXPECT_REPAIRED == 0) begin
      check(3'b001, 1'b1, 1'b0, 1'b0, "original version preserves MAINT -> RUN");
      tick; check(3'b010, 1'b0, 1'b1, 1'b0, "original version resumes RUN -> DONE");
      tick; check(3'b000, 1'b0, 1'b0, 1'b0, "original version resumes DONE -> IDLE");
    end else begin
      check(3'b000, 1'b0, 1'b0, 1'b0, "removal proposal treats 011 as illegal and recovers to IDLE");
      tick; check(3'b001, 1'b1, 1'b0, 1'b0, "repaired version resumes IDLE -> RUN");
    end

    // All remaining unused three-bit encodings, including mandatory 3'b111.
    for (unused_code = 4; unused_code < 8; unused_code = unused_code + 1) begin
      injected_encoding = unused_code;
      check_illegal_encoding;
    end

    reset_to_idle;
    tick; check(3'b001, 1'b1, 1'b0, 1'b0, "first post-reset transition has no added latency");
    reset_to_idle;
    tick; check(3'b001, 1'b1, 1'b0, 1'b0, "operation resumes after mid-operation reset");

    if (EXPECT_REPAIRED == 0)
      $display("PASS FUNCTIONAL FSM ORIGINAL: reset, cycles, outputs, MAINT -> RUN, all unused encodings and recovery");
    else
      $display("PASS FUNCTIONAL FSM REPAIRED: reset, cycles, outputs, removed MAINT -> IDLE, all unused encodings and recovery");
    $finish;
  end

  initial begin
    #20000;
    $display("FAIL FUNCTIONAL FSM: simulation timeout");
    $finish;
  end
endmodule
