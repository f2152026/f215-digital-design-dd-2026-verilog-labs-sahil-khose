
module tb;

  reg  [1:0] t_a;
  reg  [1:0] t_b;
  wire       t_gt;
    wire       t_lt;
  wire       t_eq;

   reg exp_gt;
  reg exp_lt;
    reg exp_eq;

  integer errors;
  integer total;
  integer passed;

    comp2 dut (
    .A(t_a),
    .B(t_b),
    .GT(t_gt),
     .LT(t_lt),
    .EQ(t_eq)
  );

  initial begin
      errors = 0;
    total = 0;

        for (integer a = 0; a < 4; a = a + 1) begin
      for (integer b = 0; b < 4; b = b + 1) begin
        t_a = a;
          t_b = b;
        #5;

        if (a > b) begin
            exp_gt = 1;
          exp_lt = 0;
          exp_eq = 0;
        end
        else if (a < b) begin
          exp_gt = 0;
          exp_lt = 1;
          exp_eq = 0;
        end
        else begin
          exp_gt = 0;
            exp_lt = 0;
          exp_eq = 1;
        end

           total = total + 1;

        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
             $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b,
                   t_gt, t_lt, t_eq,
                   exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

       passed = total - errors;
    $write("RESULT: %0d/%0d tests passed", passed, total);
    if (errors == 0)
         $write(" - ALL TESTS PASSED\n");
    else
      $write(" - %0d TESTS FAILED\n", errors);
    $finish;
  end

endmodule