module processor (
  input         clk,
  input         rst_n,
  input  [ 7:0] operate,
  input  [ 7:0] in,
  input  [ 7:0] addr1,
  input  [ 7:0] addr2,
  input  [ 7:0] addr3,
  input  [31:2] SystemTime,
  output        jump,
  output [ 7:0] out
);

  parameter order_num = 6;
  parameter op_IMMD = 4'b0000;
  parameter op_ALU = 4'b0001;
  parameter op_CONF = 4'b0010;
  parameter op_COPY = 4'b0011;
  parameter op_RESET = 4'b0100;
  parameter op_GET = 4'b0100;

  reg [order_num-1:0] Dec;
  always @(*) begin
    if (!rst_n) Dec <= 0;
    else Dec = 1 << operate[7:4];
  end

  wire [7:0] ALU_out;
  wire       CONF_result;

  alu32bit ALU (
    .a       (bus1),
    .b       (bus2),
    .op      (operate[3:0]),
    .enable  (Dec[1]),
    .result  (ALU_out),
    .overflow(),
    .error   ()
  );

  comparator_8bit CONF (
    .A     (bus1),
    .B     (bus2),
    .opcode(operate[3:0]),
    .enable(Dec[2]),
    .result(CONF_result)
  );

  assign jump = CONF_result;

  /* reset */
  assign reg_rst[0] = rst_n && !((operate[7:4] == op_RESET) && (addr1 == 0));
  assign reg_rst[1] = rst_n && !((operate[7:4] == op_RESET) && (addr1 == 1));
  assign reg_rst[2] = rst_n && !((operate[7:4] == op_RESET) && (addr1 == 2));
  assign reg_rst[3] = rst_n && !((operate[7:4] == op_RESET) && (addr1 == 3));
  assign reg_rst[4] = rst_n && !((operate[7:4] == op_RESET) && (addr1 == 4));
  assign reg_rst[5] = rst_n && !((operate[7:4] == op_RESET) && (addr1 == 5));
  assign reg_rst[6] = rst_n && !((operate[7:4] == op_RESET) && (addr1 == 6));
  assign reg_rst[7] = rst_n && !((operate[7:4] == op_RESET) && (addr1 == 7));

  /* read */
  assign reg_read[0] = (Dec[1] && addr1 == 0) || (Dec[2] && addr1 == 0) || (Dec[3] && addr1 == 0)||(Dec[1] && addr2 == 0) || (Dec[2] && addr2 == 0)|| (Dec[2] && addr3 == 0);
  assign reg_read[1] = (Dec[1] && addr1 == 1) || (Dec[2] && addr1 == 1) || (Dec[3] && addr1 == 1)||(Dec[1] && addr2 == 1) || (Dec[2] && addr2 == 1)|| (Dec[2] && addr3 == 1);
  assign reg_read[2] = (Dec[1] && addr1 == 2) || (Dec[2] && addr1 == 2) || (Dec[3] && addr1 == 2)||(Dec[1] && addr2 == 2) || (Dec[2] && addr2 == 2)|| (Dec[2] && addr3 == 2);
  assign reg_read[3] = (Dec[1] && addr1 == 3) || (Dec[2] && addr1 == 3) || (Dec[3] && addr1 == 3)||(Dec[1] && addr2 == 3) || (Dec[2] && addr2 == 3)|| (Dec[2] && addr3 == 3);
  assign reg_read[4] = (Dec[1] && addr1 == 4) || (Dec[2] && addr1 == 4) || (Dec[3] && addr1 == 4)||(Dec[1] && addr2 == 4) || (Dec[2] && addr2 == 4)|| (Dec[2] && addr3 == 4);
  assign reg_read[5] = (Dec[1] && addr1 == 5) || (Dec[2] && addr1 == 5) || (Dec[3] && addr1 == 5)||(Dec[1] && addr2 == 5) || (Dec[2] && addr2 == 5)|| (Dec[2] && addr3 == 5);
  assign reg_read[6] = (Dec[1] && addr1 == 6) || (Dec[2] && addr1 == 6) || (Dec[3] && addr1 == 6)||(Dec[1] && addr2 == 6) || (Dec[2] && addr2 == 6)|| (Dec[2] && addr3 == 6);
  assign reg_read[7] = (Dec[1] && addr1 == 7) || (Dec[2] && addr1 == 7) || (Dec[3] && addr1 == 7)||(Dec[1] && addr2 == 7) || (Dec[2] && addr2 == 7)|| (Dec[2] && addr3 == 7);

  /* write */
  assign reg_write[0] = (Dec[1] && addr3 == 0) || (Dec[0] && addr3 == 0) || (Dec[3] && addr3 == 0);
  assign reg_write[1] = (Dec[1] && addr3 == 1) || (Dec[0] && addr3 == 1) || (Dec[3] && addr3 == 1);
  assign reg_write[2] = (Dec[1] && addr3 == 2) || (Dec[0] && addr3 == 2) || (Dec[3] && addr3 == 2);
  assign reg_write[3] = (Dec[1] && addr3 == 3) || (Dec[0] && addr3 == 3) || (Dec[3] && addr3 == 3);
  assign reg_write[4] = (Dec[1] && addr3 == 4) || (Dec[0] && addr3 == 4) || (Dec[3] && addr3 == 4);
  assign reg_write[5] = (Dec[1] && addr3 == 5) || (Dec[0] && addr3 == 5) || (Dec[3] && addr3 == 5);
  assign reg_write[6] = (Dec[1] && addr3 == 6) || (Dec[0] && addr3 == 6) || (Dec[3] && addr3 == 6);
  assign reg_write[7] = (Dec[1] && addr3 == 7) || (Dec[0] && addr3 == 7) || (Dec[3] && addr3 == 7);

  /* 寄存器组 */
  reg  [7:0] bus1;
  reg  [7:0] bus2;
  reg  [7:0] bus3;

  wire [7:0] reg_read;
  wire [7:0] reg_write;

  wire [7:0] reg_rst;
  wire [7:0] reg_wire  [0:7];
  wire [7:0] bus1_wire [0:7];
  wire [7:0] bus2_wire [0:7];
  wire [7:0] bus3_wire [0:7];

  assign bus1_wire[7] = in;
  assign bus2_wire[7] = in;
  assign out          = bus3;

  /* bus3 assign */
  always @(posedge clk) begin
    if (!rst_n) bus3 <= 0;
    else begin
      case (operate[7:4])

        4'd0: bus3 <= addr1;

        4'd1: bus3 <= ALU_out;

        4'd2: begin
          if (CONF_result) begin
            case (addr3)
              3'd0:    bus3 <= bus3_wire[0];
              3'd1:    bus3 <= bus3_wire[1];
              3'd2:    bus3 <= bus3_wire[2];
              3'd3:    bus3 <= bus3_wire[3];
              3'd4:    bus3 <= bus3_wire[4];
              3'd5:    bus3 <= bus3_wire[5];
              3'd6:    bus3 <= bus3_wire[6];
              3'd7:    bus3 <= bus3_wire[7];
              default: bus3 <= 0;
            endcase
          end else bus3 <= 0;
        end

        4'd3: begin
          case (addr1)
            3'd0:    bus3 <= bus1_wire[0];
            3'd1:    bus3 <= bus1_wire[1];
            3'd2:    bus3 <= bus1_wire[2];
            3'd3:    bus3 <= bus1_wire[3];
            3'd4:    bus3 <= bus1_wire[4];
            3'd5:    bus3 <= bus1_wire[5];
            3'd6:    bus3 <= bus1_wire[6];
            3'd7:    bus3 <= bus1_wire[7];
            default: bus3 <= 0;
          endcase
        end
        default: bus3 <= 0;
      endcase
    end
  end

  assign bus1_wire[0] = reg_wire[0];
  assign bus1_wire[1] = reg_wire[1];
  assign bus1_wire[2] = reg_wire[2];
  assign bus1_wire[3] = reg_wire[3];
  assign bus1_wire[4] = reg_wire[4];
  assign bus1_wire[5] = reg_wire[5];
  assign bus1_wire[6] = reg_wire[6];

  assign bus2_wire[0] = reg_wire[0];
  assign bus2_wire[1] = reg_wire[1];
  assign bus2_wire[2] = reg_wire[2];
  assign bus2_wire[3] = reg_wire[3];
  assign bus2_wire[4] = reg_wire[4];
  assign bus2_wire[5] = reg_wire[5];
  assign bus2_wire[6] = reg_wire[6];

  assign bus3_wire[0] = reg_wire[0];
  assign bus3_wire[1] = reg_wire[1];
  assign bus3_wire[2] = reg_wire[2];
  assign bus3_wire[3] = reg_wire[3];
  assign bus3_wire[4] = reg_wire[4];
  assign bus3_wire[5] = reg_wire[5];
  assign bus3_wire[6] = reg_wire[6];


  /* bus1 assign */
  always @(*) begin
    if (!rst_n) bus1 <= 0;
    else
      case (operate[7:4])

        4'd0: bus1 <= addr1;

        4'd1: begin
          case (addr1)
            3'd0:    bus1 <= bus1_wire[0];
            3'd1:    bus1 <= bus1_wire[1];
            3'd2:    bus1 <= bus1_wire[2];
            3'd3:    bus1 <= bus1_wire[3];
            3'd4:    bus1 <= bus1_wire[4];
            3'd5:    bus1 <= bus1_wire[5];
            3'd6:    bus1 <= bus1_wire[6];
            3'd7:    bus1 <= bus1_wire[7];
            default: bus1 <= 0;
          endcase
        end

        4'd2: begin
          case (addr1)
            3'd0:    bus1 <= bus1_wire[0];
            3'd1:    bus1 <= bus1_wire[1];
            3'd2:    bus1 <= bus1_wire[2];
            3'd3:    bus1 <= bus1_wire[3];
            3'd4:    bus1 <= bus1_wire[4];
            3'd5:    bus1 <= bus1_wire[5];
            3'd6:    bus1 <= bus1_wire[6];
            3'd7:    bus1 <= bus1_wire[7];
            default: bus1 <= 0;
          endcase
        end

        4'd3: begin
          case (addr1)
            3'd0:    bus1 <= bus1_wire[0];
            3'd1:    bus1 <= bus1_wire[1];
            3'd2:    bus1 <= bus1_wire[2];
            3'd3:    bus1 <= bus1_wire[3];
            3'd4:    bus1 <= bus1_wire[4];
            3'd5:    bus1 <= bus1_wire[5];
            3'd6:    bus1 <= bus1_wire[6];
            3'd7:    bus1 <= bus1_wire[7];
            default: bus1 <= 0;
          endcase
        end

        default: bus1 <= 0;
      endcase
  end

  /* bus2 assign */
  always @(*) begin
    if (!rst_n) bus2 <= 0;
    else
      case (operate[7:4])

        4'd1: begin
          case (addr2)
            3'd0:    bus2 <= bus2_wire[0];
            3'd1:    bus2 <= bus2_wire[1];
            3'd2:    bus2 <= bus2_wire[2];
            3'd3:    bus2 <= bus2_wire[3];
            3'd4:    bus2 <= bus2_wire[4];
            3'd5:    bus2 <= bus2_wire[5];
            3'd6:    bus2 <= bus2_wire[6];
            3'd7:    bus2 <= bus2_wire[7];
            default: bus2 <= 0;
          endcase
        end

        4'd2: begin
          case (addr2)
            3'd0:    bus2 <= bus2_wire[0];
            3'd1:    bus2 <= bus2_wire[1];
            3'd2:    bus2 <= bus2_wire[2];
            3'd3:    bus2 <= bus2_wire[3];
            3'd4:    bus2 <= bus2_wire[4];
            3'd5:    bus2 <= bus2_wire[5];
            3'd6:    bus2 <= bus2_wire[6];
            3'd7:    bus2 <= bus2_wire[7];
            default: bus2 <= 0;
          endcase
        end

        default: bus2 <= 0;
      endcase
  end

  reg_8bit reg0 (
    .clk  (clk),
    .rst_n(reg_rst[0]),
    .read (reg_read[0]),
    .write(reg_write[0]),
    .data (bus3),
    .value(reg_wire[0])
  );

  reg_8bit reg1 (
    .clk  (clk),
    .rst_n(reg_rst[1]),
    .read (reg_read[1]),
    .write(reg_write[1]),
    .data (bus3),
    .value(reg_wire[1])
  );

  reg_8bit reg2 (
    .clk  (clk),
    .rst_n(reg_rst[2]),
    .read (reg_read[2]),
    .write(reg_write[2]),
    .data (bus3),
    .value(reg_wire[2])
  );

  reg_8bit reg3 (
    .clk  (clk),
    .rst_n(reg_rst[3]),
    .read (reg_read[3]),
    .write(reg_write[3]),
    .data (bus3),
    .value(reg_wire[3])
  );

  reg_8bit reg4 (
    .clk  (clk),
    .rst_n(reg_rst[4]),
    .read (reg_read[4]),
    .write(reg_write[4]),
    .data (bus3),
    .value(reg_wire[4])
  );

  reg_8bit reg5 (
    .clk  (clk),
    .rst_n(reg_rst[5]),
    .read (reg_read[5]),
    .write(reg_write[5]),
    .data (bus3),
    .value(reg_wire[5])
  );

  reg_8bit reg6 (
    .clk  (clk),
    .rst_n(reg_rst[6]),
    .read (reg_read[6]),
    .write(reg_write[6]),
    .data (bus3),
    .value(reg_wire[6])
  );

endmodule
