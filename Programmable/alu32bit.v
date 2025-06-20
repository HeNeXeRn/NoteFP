module alu32bit #(
  parameter WIDTH = 32
) (
  input  wire [WIDTH-1:0] a,
  input  wire [WIDTH-1:0] b,
  input  wire [      3:0] op,
  input  wire             enable,
  output reg  [WIDTH-1:0] result,
  output reg              overflow,
  output reg              error
);

  localparam ADD = 4'b0000;
  localparam SUB = 4'b0001;
  localparam MUL = 4'b0010;
  localparam DIV = 4'b0011;
  localparam MOD = 4'b0100;
  localparam AND = 4'b0101;
  localparam OR = 4'b0110;
  localparam XOR = 4'b0111;
  localparam NOT = 4'b1000;
  localparam LAND = 4'b1001;
  localparam LOR = 4'b1010;
  localparam LXOR = 4'b1011;
  localparam NOR = 4'b1100;
  localparam XNOR = 4'b1101;

  always @(*) begin
    error    = 0;
    overflow = 0;
    result   = {WIDTH{1'b0}};

    if (enable) begin
      case (op)
        ADD: begin
          result = a + b;
          if ((a[WIDTH-1] == b[WIDTH-1]) && (result[WIDTH-1] != a[WIDTH-1])) overflow = 1;
          else overflow = 0;
        end

        SUB: begin
          result = a - b;
          if ((a[WIDTH-1] != b[WIDTH-1]) && (result[WIDTH-1] != a[WIDTH-1])) overflow = 1;
          else overflow = 0;
        end

        MUL: begin
          result = a * b;
          if ((a != 0) && (b != 0) && (result == 0)) overflow = 1;
          else overflow = 0;
        end

        DIV: begin
          if (b == 0) error = 1;
          else result = a / b;
        end

        MOD: begin
          if (b == 0) error = 1;
          else result = a % b;
        end

        AND: begin
          result = a & b;
        end

        OR: begin
          result = a | b;
        end

        XOR: begin
          result = a ^ b;
        end

        NOT: begin
          result = ~a;
        end

        LAND: begin
          result = (a != 0) && (b != 0) ? {WIDTH{1'b1}} : {WIDTH{1'b0}};
        end

        LOR: begin
          result = (a != 0) || (b != 0) ? {WIDTH{1'b1}} : {WIDTH{1'b0}};
        end

        LXOR: begin
          result = ((a != 0) ^ (b != 0)) ? {WIDTH{1'b1}} : {WIDTH{1'b0}};
        end

        NOR: begin
          result = ~(a | b);
        end

        XNOR: begin
          result = ~(a ^ b);
        end

        default: begin
          error = 1;
        end
      endcase
    end else begin
      result = {WIDTH{1'b0}};
    end
  end

endmodule
