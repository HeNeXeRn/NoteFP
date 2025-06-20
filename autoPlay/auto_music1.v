module auto_music1 (
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

  reg [ 31:0] j;

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
    end else if (j_ < 240) begin
      j_        <= j_ + 1;
      get_pause <= 0;
    end else begin
      j_        <= 0;
      get_pause <= 0;
    end
  end

  always @(*) begin
    if (pause) j = 1<<30;
    else if (!rst_n) j = 1<<30;
    else j = j_;
  end

  reg [4:0] note;

  always @(*) begin
    case (j)
      0:       note = 5'b01010;
      1:       note = 5'b01010;
      2:       note = 5'b01010;
      3:       note = 5'b01010;
      4:       note = 5'b01010;
      5:       note = 5'b01010;
      6:       note = 5'b01010;
      7:       note = 5'b01010;
      8:       note = 5'b01001;
      9:       note = 5'b01001;
      10:      note = 5'b01001;
      11:      note = 5'b01001;
      12:      note = 5'b01001;
      13:      note = 5'b01001;
      14:      note = 5'b01001;
      15:      note = 5'b01001;
      16:      note = 5'b01000;
      17:      note = 5'b01000;
      18:      note = 5'b01000;
      19:      note = 5'b01000;
      20:      note = 5'b01000;
      21:      note = 5'b01000;
      22:      note = 5'b01000;
      23:      note = 5'b01000;
      24:      note = 5'b00111;
      25:      note = 5'b00111;
      26:      note = 5'b00111;
      27:      note = 5'b00111;
      28:      note = 5'b00111;
      29:      note = 5'b00111;
      30:      note = 5'b00111;
      31:      note = 5'b00111;
      32:      note = 5'b00110;
      33:      note = 5'b00110;
      34:      note = 5'b00110;
      35:      note = 5'b00110;
      36:      note = 5'b00110;
      37:      note = 5'b00110;
      38:      note = 5'b00110;
      39:      note = 5'b00110;
      40:      note = 5'b00101;
      41:      note = 5'b00101;
      42:      note = 5'b00101;
      43:      note = 5'b00101;
      44:      note = 5'b00101;
      45:      note = 5'b00101;
      46:      note = 5'b00101;
      47:      note = 5'b00101;
      48:      note = 5'b00110;
      49:      note = 5'b00110;
      50:      note = 5'b00110;
      51:      note = 5'b00110;
      52:      note = 5'b00110;
      53:      note = 5'b00110;
      54:      note = 5'b00110;
      55:      note = 5'b00110;
      56:      note = 5'b00111;
      57:      note = 5'b00111;
      58:      note = 5'b00111;
      59:      note = 5'b00111;
      60:      note = 5'b00111;
      61:      note = 5'b00111;
      62:      note = 5'b00111;
      63:      note = 5'b00111;
      64:      note = 5'b01010;
      65:      note = 5'b01010;
      66:      note = 5'b01010;
      67:      note = 5'b01010;
      68:      note = 5'b01010;
      69:      note = 5'b01010;
      70:      note = 5'b01000;
      71:      note = 5'b01000;
      72:      note = 5'b01001;
      73:      note = 5'b01001;
      74:      note = 5'b01001;
      75:      note = 5'b01001;
      76:      note = 5'b01001;
      77:      note = 5'b01001;
      78:      note = 5'b00111;
      79:      note = 5'b00111;
      80:      note = 5'b01000;
      81:      note = 5'b01000;
      82:      note = 5'b01000;
      83:      note = 5'b01000;
      84:      note = 5'b01000;
      85:      note = 5'b01000;
      86:      note = 5'b00110;
      87:      note = 5'b00110;
      88:      note = 5'b00111;
      89:      note = 5'b00111;
      90:      note = 5'b00111;
      91:      note = 5'b00111;
      92:      note = 5'b00111;
      93:      note = 5'b00111;
      94:      note = 5'b00101;
      95:      note = 5'b00101;
      96:      note = 5'b00110;
      97:      note = 5'b00110;
      98:      note = 5'b00110;
      99:      note = 5'b00110;
      100:     note = 5'b00110;
      101:     note = 5'b00110;
      102:     note = 5'b00100;
      103:     note = 5'b00100;
      104:     note = 5'b00101;
      105:     note = 5'b00101;
      106:     note = 5'b00101;
      107:     note = 5'b00101;
      108:     note = 5'b00101;
      109:     note = 5'b00101;
      110:     note = 5'b00011;
      111:     note = 5'b00011;
      112:     note = 5'b00110;
      113:     note = 5'b00110;
      114:     note = 5'b00110;
      115:     note = 5'b00110;
      116:     note = 5'b00110;
      117:     note = 5'b00110;
      118:     note = 5'b01000;
      119:     note = 5'b01000;
      120:     note = 5'b00111;
      121:     note = 5'b00111;
      122:     note = 5'b00111;
      123:     note = 5'b00111;
      124:     note = 5'b01000;
      125:     note = 5'b01000;
      126:     note = 5'b01001;
      127:     note = 5'b01001;
      128:     note = 5'b01010;
      129:     note = 5'b01010;
      130:     note = 5'b01001;
      131:     note = 5'b01001;
      132:     note = 5'b01010;
      133:     note = 5'b01010;
      134:     note = 5'b01011;
      135:     note = 5'b01011;
      136:     note = 5'b01100;
      137:     note = 5'b01100;
      138:     note = 5'b01001;
      139:     note = 5'b01001;
      140:     note = 5'b01100;
      141:     note = 5'b01100;
      142:     note = 5'b01011;
      143:     note = 5'b01011;
      144:     note = 5'b01010;
      145:     note = 5'b01010;
      146:     note = 5'b01101;
      147:     note = 5'b01101;
      148:     note = 5'b01100;
      149:     note = 5'b01100;
      150:     note = 5'b01011;
      151:     note = 5'b01011;
      152:     note = 5'b01100;
      153:     note = 5'b01100;
      154:     note = 5'b01011;
      155:     note = 5'b01011;
      156:     note = 5'b01010;
      157:     note = 5'b01010;
      158:     note = 5'b01001;
      159:     note = 5'b01001;
      160:     note = 5'b01000;
      161:     note = 5'b01000;
      162:     note = 5'b00110;
      163:     note = 5'b00110;
      164:     note = 5'b01101;
      165:     note = 5'b01101;
      166:     note = 5'b01110;
      167:     note = 5'b01110;
      168:     note = 5'b01111;
      169:     note = 5'b01111;
      170:     note = 5'b01110;
      171:     note = 5'b01110;
      172:     note = 5'b01101;
      173:     note = 5'b01101;
      174:     note = 5'b01100;
      175:     note = 5'b01100;
      176:     note = 5'b01011;
      177:     note = 5'b01011;
      178:     note = 5'b01010;
      179:     note = 5'b01010;
      180:     note = 5'b01001;
      181:     note = 5'b01001;
      182:     note = 5'b01101;
      183:     note = 5'b01101;
      184:     note = 5'b01100;
      185:     note = 5'b01100;
      186:     note = 5'b01101;
      187:     note = 5'b01101;
      188:     note = 5'b01100;
      189:     note = 5'b01100;
      190:     note = 5'b01011;
      191:     note = 5'b01011;
      192:     note = 5'b01100;
      193:     note = 5'b01100;
      194:     note = 5'b01010;
      195:     note = 5'b01011;
      196:     note = 5'b01100;
      197:     note = 5'b01100;
      198:     note = 5'b01010;
      199:     note = 5'b01011;
      200:     note = 5'b01100;
      201:     note = 5'b00101;
      202:     note = 5'b00110;
      203:     note = 5'b00111;
      204:     note = 5'b01000;
      205:     note = 5'b01001;
      206:     note = 5'b01010;
      207:     note = 5'b01011;
      208:     note = 5'b01010;
      209:     note = 5'b01010;
      210:     note = 5'b01000;
      211:     note = 5'b01001;
      212:     note = 5'b01010;
      213:     note = 5'b01010;
      214:     note = 5'b00011;
      215:     note = 5'b00100;
      216:     note = 5'b00101;
      217:     note = 5'b00110;
      218:     note = 5'b00101;
      219:     note = 5'b00100;
      220:     note = 5'b00101;
      221:     note = 5'b00011;
      222:     note = 5'b00100;
      223:     note = 5'b00101;
      224:     note = 5'b00100;
      225:     note = 5'b00100;
      226:     note = 5'b00110;
      227:     note = 5'b00101;
      228:     note = 5'b00100;
      229:     note = 5'b00100;
      230:     note = 5'b00011;
      231:     note = 5'b00010;
      232:     note = 5'b00011;
      233:     note = 5'b00010;
      234:     note = 5'b00001;
      235:     note = 5'b00010;
      236:     note = 5'b00011;
      237:     note = 5'b00100;
      238:     note = 5'b00101;
      239:     note = 5'b00110;
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
