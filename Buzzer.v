module Buzzer (
    input        CLK,
    input        RSTn,
    input  [7:0] note,
    input  [1:0] pitch,
    input        enable,
    output       buzzer
);

  parameter c0 = 20'd764500;
  parameter d0 = 20'd681000;
  parameter e0 = 20'd606700;
  parameter f0 = 20'd572700;
  parameter g0 = 20'd510200;
  parameter a0 = 20'd454500;
  parameter b0 = 20'd405000;
  parameter c1 = 20'd382200;
  parameter d1 = 20'd340500;
  parameter e1 = 20'd303400;
  parameter f1 = 20'd286300;
  parameter g1 = 20'd255100;
  parameter a1 = 20'd227300;
  parameter b1 = 20'd202500;
  parameter c2 = 20'd191100;
  parameter d2 = 20'd170300;
  parameter e2 = 20'd151700;
  parameter f2 = 20'd143200;
  parameter g2 = 20'd127600;
  parameter a2 = 20'd113599;
  parameter b2 = 20'd101200;

  reg [19:0] cnt;
  reg [19:0] target;
  reg        plus;

  always @(posedge CLK or negedge RSTn) begin
    if (!RSTn) begin
      cnt  = 0;
      plus = 0;
      case ({
        pitch[1:0], note[7:0]
      })

        default: target = 0;
      endcase
    end
  end


endmodule
