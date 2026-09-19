
module tb;

  reg [3:0] a;
  reg [3:0] b;
  reg       op;

  wire [3:0] result;

  reg [3:0] expected;

  integer errors;
  integer total;

  alu dut (
    .a(a),
    .b(b),
      .op(op),
    .result(result)
  );

     initial begin
    errors = 0;
    total = 0;

    op = 1'b0;

       for (integer i = 4; i < 8; i = i + 1) begin
      for (integer j = 4; j < 8; j = j + 1) begin
        a = i;
        b = j;
        #5;
          expected = i + j;
        total = total + 1;

        if (result !== expected) begin
          $display("FAIL: ADD a=%0d b=%0d got=%0d expected=%0d",
                   a, b, result, expected);
          errors = errors + 1;
        end
      end
    end

    op = 1'b1;

    for (integer i = 4; i < 8; i = i + 1) begin
      for (integer j = 4; j < 8; j = j + 1) begin
        a = i;
        b = j;
        #5;
        expected = i - j;
        total = total + 1;

         if (result !== expected) begin
          $display("FAIL: SUB a=%0d b=%0d got=%0d expected=%0d",
                   a, b, result, expected);
          errors = errors + 1;
          end
      end
    end

          a = 10;
    b = 3;

    op = 1'b0;
    #5;

    total = total + 1;
   
    if (result !== 13) begin
         $display("FAIL: op change test ADD got=%0d expected=13", result);
         errors = errors + 1;
    end

       op = 1'b1;
    #5;

    total = total + 1;

    if (result !== 7) begin
        $display("FAIL: op change test SUB got=%0d expected=7", result);
      errors = errors + 1;
    end

    if (errors == 0)
      $display("RESULT: %0d/%0d tests passed -- ALL TESTS PASSED",
               total, total);
    else
      $display("RESULT: %0d/%0d tests passed -- %0d FAILED",
               total - errors, total, errors);

    $finish;
  end

endmodule