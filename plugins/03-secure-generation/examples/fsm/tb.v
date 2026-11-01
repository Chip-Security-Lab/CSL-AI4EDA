`timescale 1ns/1ps
module tb;
  reg clk;
  reg rst_n;
  wire busy;
  wire done;
  wire alarm;
  integer i;

  live_secure_fsm dut (
    .clk(clk), .rst_n(rst_n), .busy(busy), .done(done), .alarm(alarm)
  );

  task tick;
    begin
      clk = 1'b0; #4;
      clk = 1'b1; #1;
      clk = 1'b0; #1;
    end
  endtask

  task check_outputs;
    input expected_busy;
    input expected_done;
    input expected_alarm;
    input [511:0] label;
    begin
      if ({busy, done, alarm} !== {expected_busy, expected_done, expected_alarm}) begin
        $display("FAIL FSM: %0s expected=%b%b%b actual=%b%b%b", label,
                 expected_busy, expected_done, expected_alarm, busy, done, alarm);
        $finish;
      end
    end
  endtask

  initial begin
    clk = 1'b0; rst_n = 1'b1;
    #1; rst_n = 1'b0; #1;
    check_outputs(1'b0, 1'b0, 1'b0, "asynchronous reset enters IDLE");
    rst_n = 1'b1;

    for (i = 0; i < 5; i = i + 1) begin
      tick; check_outputs(1'b1, 1'b0, 1'b0, "IDLE to RUN");
      tick; check_outputs(1'b0, 1'b1, 1'b0, "RUN to DONE");
      tick; check_outputs(1'b0, 1'b0, 1'b0, "DONE to IDLE");
    end

    clk = 1'b0;
    force dut.state = 3'b111;
    #1;
    check_outputs(1'b0, 1'b0, 1'b1, "illegal encoding drives safe outputs");
    release dut.state;
    tick;
    check_outputs(1'b0, 1'b0, 1'b0, "illegal encoding recovers to IDLE");
    tick;
    check_outputs(1'b1, 1'b0, 1'b0, "normal operation resumes after recovery");

    clk = 1'b0; #1; rst_n = 1'b0; #1;
    check_outputs(1'b0, 1'b0, 1'b0, "mid-operation asynchronous reset");
    rst_n = 1'b1;
    tick;
    check_outputs(1'b1, 1'b0, 1'b0, "first post-reset transition has no extra latency");
    $display("PASS FSM: reset, cyclic transitions, outputs, illegal encoding and recovery");
    $finish;
  end

  initial begin
    #20000;
    $display("FAIL FSM: simulation timeout");
    $finish;
  end
endmodule
