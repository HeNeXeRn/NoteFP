module counter_10bit (
  input        cnt,
  input        rst_n,
  input        stop,
  output [5:0] Seg1,
  output [5:0] Seg2,
  output [5:0] Seg3,
  output [5:0] Seg4,
  output [5:0] Seg5,
  output [5:0] Seg6
);
  reg [5:0] flow;
  reg [5:0] num1;
  reg [5:0] num2;
  reg [5:0] num3;
  reg [5:0] num4;
  reg [5:0] num5;
  reg [5:0] num6;

  parameter multi = 10000;

  reg [31:0] unit;
  reg        temp;

  always @(negedge rst_n or posedge cnt) begin
    if (!rst_n) unit <= 0;
    else if (unit >= multi - 1) begin
      unit <= 0;
      temp <= 1;
    end else begin
      temp <= 0;
      unit <= unit + 1;
    end
  end

  always @(negedge rst_n or posedge temp) begin
    if (!rst_n) begin
      num1    <= 0;
      flow[0] <= 0;
    end else if (num1 == 9) begin
      num1    <= 0;
      flow[0] <= 1;
    end else begin
      num1    <= num1 + 1;
      flow[0] <= 0;
    end
  end

  always @(negedge rst_n or posedge flow[0]) begin
    if (!rst_n) begin
      num2    <= 0;
      flow[1] <= 0;
    end else if (num2 == 9) begin
      num2    <= 0;
      flow[1] <= 1;
    end else begin
      num2    <= num2 + 1;
      flow[1] <= 0;
    end
  end

  always @(negedge rst_n or posedge flow[1]) begin
    if (!rst_n) begin
      num3    <= 0;
      flow[2] <= 0;
    end else if (num3 == 9) begin
      num3    <= 0;
      flow[2] <= 1;
    end else begin
      num3    <= num3 + 1;
      flow[2] <= 0;
    end
  end

  always @(negedge rst_n or posedge flow[2]) begin
    if (!rst_n) begin
      num4    <= 0;
      flow[3] <= 0;
    end else if (num4 == 9) begin
      num4    <= 0;
      flow[3] <= 1;
    end else begin
      num4    <= num4 + 1;
      flow[3] <= 0;
    end
  end

  always @(negedge rst_n or posedge flow[3]) begin
    if (!rst_n) begin
      num5    <= 0;
      flow[4] <= 0;
    end else if (num5 == 9) begin
      num5    <= 0;
      flow[4] <= 1;
    end else begin
      num5    <= num5 + 1;
      flow[4] <= 0;
    end
  end

  always @(negedge rst_n or posedge flow[4]) begin
    if (!rst_n) begin
      num6    <= 0;
      flow[5] <= 0;
    end else if (num6 == 9) begin
      num6    <= 0;
      flow[5] <= 1;
    end else begin
      num6    <= num6 + 1;
      flow[5] <= 0;
    end
  end


  assign Seg1 = num6 > 9 ? num6 + 1 : num6;
  assign Seg2 = num5 > 9 ? num5 + 1 : num5;
  assign Seg3 = num4 > 9 ? num4 + 1 : num4;
  assign Seg4 = num3 > 9 ? num3 + 1 : num3;
  assign Seg5 = num2 > 9 ? num2 + 1 : num2;
  assign Seg6 = num1 > 9 ? num1 + 1 : num1;

endmodule
