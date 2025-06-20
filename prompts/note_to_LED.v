module note_to_LED (
  input      [4:0] note,
  input            rst_n,
  output reg [7:0] LED
);

  always @(*) begin
    if (!rst_n) LED = 0;
    else begin
      case (note)
        1:       LED = 8'b00000001;
        2:       LED = 8'b00000010;
        3:       LED = 8'b00000100;
        4:       LED = 8'b00001000;
        5:       LED = 8'b00010000;
        6:       LED = 8'b00100000;
        7:       LED = 8'b01000000;
        8:       LED = 8'b00000001;
        9:       LED = 8'b00000010;
        10:      LED = 8'b00000100;
        11:      LED = 8'b00001000;
        12:      LED = 8'b00010000;
        13:      LED = 8'b00100000;
        14:      LED = 8'b01000000;
        15:      LED = 8'b00000001;
        16:      LED = 8'b00000010;
        17:      LED = 8'b00000100;
        18:      LED = 8'b00001000;
        19:      LED = 8'b00010000;
        20:      LED = 8'b00100000;
        21:      LED = 8'b01000000;
        22:      LED = 8'b00000001;
        23:      LED = 8'b00000010;
        24:      LED = 8'b00000100;
        25:      LED = 8'b00001000;
        26:      LED = 8'b00010000;
        27:      LED = 8'b00100000;
        28:      LED = 8'b01000000;
        default: LED = 8'b00000000;
      endcase
    end
  end

endmodule
