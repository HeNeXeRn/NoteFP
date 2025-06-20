module comparator_8bit (
  input      [7:0] A,
  input      [7:0] B,
  input      [2:0] opcode,
  input            enable,
  output reg       result
);

  localparam OP_GT = 3'b000;
  localparam OP_GTE = 3'b001;
  localparam OP_EQ = 3'b010;
  localparam OP_LT = 3'b011;
  localparam OP_LTE = 3'b100;
  localparam OP_NEVER = 3'b101;
  localparam OP_ALWAYS = 3'b110;
  localparam OP_NEQ = 3'b111;

  always @(*) begin
    if (enable) begin
      case (opcode)
        OP_GT:     result = (A > B);
        OP_GTE:    result = (A >= B);
        OP_EQ:     result = (A == B);
        OP_LT:     result = (A < B);
        OP_LTE:    result = (A <= B);
        OP_NEVER:  result = 1'b0;
        OP_ALWAYS: result = 1'b1;
        OP_NEQ:    result = (A != B);
        default:   result = 1'b0;
      endcase
    end else begin
      result = 1'b0;
    end
  end

endmodule
