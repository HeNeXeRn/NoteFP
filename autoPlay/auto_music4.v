module auto_music4 (
  input      clk,
  input      pause,
  input      rst_n,
  input      over,
  output     buzzer,
  output reg get_pause,
  output reg get_return
);

  parameter N = 3125000;

  reg [21:0] cnt;

  reg        clk_spec;

  reg [31:0] j;

  reg [26:0] counter;


  always @(posedge clk) begin
    if (counter < N) begin
      counter  <= counter + 1;
      clk_spec <= clk_spec;
    end else begin
      counter  <= 0;
      clk_spec <= ~clk_spec;
    end
  end


  reg [31:0] j_;

  always @(posedge clk_spec or posedge pause) begin
    if (pause) begin
      j_        <= j_;
      get_pause <= 1;
    end else if (j_ < 128) begin
      j_        <= j_ + 1;
      get_pause <= 0;
    end else begin
      j_        <= 0;
      get_pause <= 0;
    end
  end

  always @(*) begin
    if (pause) j = 1 << 30;
    else if (!rst_n) j = 1 << 30;
    else j = j_;
  end

  reg [4:0] note;

  always @(*) begin
    case (j)
      0:       note = 5'b01010;
      1:       note = 5'b01010;
      2:       note = 5'b01010;
      3:       note = 5'b01010;
      4:       note = 5'b01011;
      5:       note = 5'b01011;
      6:       note = 5'b01100;
      7:       note = 5'b01100;
      8:       note = 5'b01100;
      9:       note = 5'b01100;
      10:      note = 5'b01011;
      11:      note = 5'b01011;
      12:      note = 5'b01010;
      13:      note = 5'b01010;
      14:      note = 5'b01001;
      15:      note = 5'b01001;
      16:      note = 5'b01000;
      17:      note = 5'b01000;
      18:      note = 5'b01000;
      19:      note = 5'b01000;
      20:      note = 5'b01001;
      21:      note = 5'b01001;
      22:      note = 5'b01010;
      23:      note = 5'b01010;
      24:      note = 5'b01010;
      25:      note = 5'b01010;
      26:      note = 5'b01001;
      27:      note = 5'b01001;
      28:      note = 5'b01001;
      29:      note = 5'b01001;
      30:      note = 5'b01001;
      31:      note = 5'b01001;
      32:      note = 5'b01010;
      33:      note = 5'b01010;
      34:      note = 5'b01010;
      35:      note = 5'b01010;
      36:      note = 5'b01011;
      37:      note = 5'b01011;
      38:      note = 5'b01100;
      39:      note = 5'b01100;
      40:      note = 5'b01100;
      41:      note = 5'b01100;
      42:      note = 5'b01011;
      43:      note = 5'b01011;
      44:      note = 5'b01010;
      45:      note = 5'b01010;
      46:      note = 5'b01001;
      47:      note = 5'b01001;
      48:      note = 5'b01000;
      49:      note = 5'b01000;
      50:      note = 5'b01000;
      51:      note = 5'b01000;
      52:      note = 5'b01001;
      53:      note = 5'b01001;
      54:      note = 5'b01010;
      55:      note = 5'b01010;
      56:      note = 5'b01001;
      57:      note = 5'b01001;
      58:      note = 5'b01000;
      59:      note = 5'b01000;
      60:      note = 5'b01000;
      61:      note = 5'b01000;
      62:      note = 5'b01000;
      63:      note = 5'b01000;
      64:      note = 5'b01001;
      65:      note = 5'b01001;
      66:      note = 5'b01001;
      67:      note = 5'b01001;
      68:      note = 5'b01010;
      69:      note = 5'b01010;
      70:      note = 5'b01000;
      71:      note = 5'b01000;
      72:      note = 5'b01001;
      73:      note = 5'b01001;
      74:      note = 5'b01010;
      75:      note = 5'b01011;
      76:      note = 5'b01010;
      77:      note = 5'b01010;
      78:      note = 5'b01000;
      79:      note = 5'b01000;
      80:      note = 5'b01001;
      81:      note = 5'b01001;
      82:      note = 5'b01010;
      83:      note = 5'b01011;
      84:      note = 5'b01010;
      85:      note = 5'b01010;
      86:      note = 5'b01001;
      87:      note = 5'b01001;
      88:      note = 5'b01000;
      89:      note = 5'b01000;
      90:      note = 5'b01001;
      91:      note = 5'b01001;
      92:      note = 5'b00101;
      93:      note = 5'b00101;
      94:      note = 5'b00101;
      95:      note = 5'b00101;
      96:      note = 5'b01010;
      97:      note = 5'b01010;
      98:      note = 5'b01010;
      99:      note = 5'b01010;
      100:     note = 5'b01011;
      101:     note = 5'b01011;
      102:     note = 5'b01100;
      103:     note = 5'b01100;
      104:     note = 5'b01100;
      105:     note = 5'b01100;
      106:     note = 5'b01011;
      107:     note = 5'b01011;
      108:     note = 5'b01010;
      109:     note = 5'b01010;
      110:     note = 5'b01001;
      111:     note = 5'b01001;
      112:     note = 5'b01000;
      113:     note = 5'b01000;
      114:     note = 5'b01000;
      115:     note = 5'b01000;
      116:     note = 5'b01001;
      117:     note = 5'b01001;
      118:     note = 5'b01010;
      119:     note = 5'b01010;
      120:     note = 5'b01001;
      121:     note = 5'b01001;
      122:     note = 5'b01000;
      123:     note = 5'b01000;
      124:     note = 5'b01000;
      125:     note = 5'b01000;
      126:     note = 5'b01000;
      127:     note = 5'b01000;
      default: note = 0;
    endcase
  end

  always @(*) begin
    if (over) get_return <= 1;
    else get_return <= 0;
  end


  get_notes U1 (
    clk,
    clk_spec,
    note,
    buzzer
  );

endmodule
