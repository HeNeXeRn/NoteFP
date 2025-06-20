module char_set (
    input  [5:0] addr,
    output [7:0] out
);
  reg [7:0] data;
  always @(*) begin
    case (addr)
      6'd0: data = 8'b11111100;
      6'd1: data = 8'b01100000;
      6'd2: data = 8'b11011010;
      6'd3: data = 8'b11110010;
      6'd4: data = 8'b01100110;
      6'd5: data = 8'b10110110;
      6'd6: data = 8'b10111110;
      6'd7: data = 8'b11100000;
      6'd8: data = 8'b11111110;
      6'd9: data = 8'b11110110;
      6'd10: data = 8'b00000000;
      6'd11: data = 8'b11101110;
      6'd12: data = 8'b00111110;
      6'd13: data = 8'b10011100;
      6'd14: data = 8'b01111010;
      6'd15: data = 8'b10011110;
      6'd16: data = 8'b10001110;
      6'd17: data = 8'b10111100;
      6'd18: data = 8'b01101110;
      6'd19: data = 8'b11110000;
      6'd20: data = 8'b01110000;
      6'd21: data = 8'b10101110;
      6'd22: data = 8'b00011100;
      6'd23: data = 8'b11101100;
      6'd24: data = 8'b00101010;
      6'd25: data = 8'b00111010;
      6'd26: data = 8'b11001110;
      6'd27: data = 8'b11100110;
      6'd28: data = 8'b10001100;
      6'd29: data = 8'b10110110;
      6'd30: data = 8'b00011110;
      6'd31: data = 8'b01111100;
      6'd32: data = 8'b00111000;
      6'd33: data = 8'b01111110;
      6'd34: data = 8'b00100110;
      6'd35: data = 8'b01110110;
      6'd36: data = 8'b01011010;
      default: data = 8'b00000000;
    endcase
  end
  assign out = data;
endmodule