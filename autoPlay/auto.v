module auto (
  input  wire       preMode,
  input  wire       nextMode,
  input  wire       confirm,
  input  wire       clk,
  input  wire       rst_n,
  input  wire       enable,
  input  wire       pause,
  output wire       twinkle,
  output wire       buzzer,
  output wire       rst_state,
  output wire [5:0] Seg1,
  output wire [5:0] Seg2,
  output wire [5:0] Seg3,
  output wire [5:0] Seg4,
  output wire [5:0] Seg5,
  output wire [5:0] Seg6
);

  assign twinkle = Dec[0];

  /* 00 选歌 */
  /* 01 播放 */
  /* 10 暂停 */
  reg [1:0] state;
  reg [1:0] next_state;

  always @(posedge clk) begin
    if (!rst_n || !enable) state <= 0;
    else state <= next_state;
  end


  always @(negedge clk) begin
    if (!rst_n | !enable) next_state <= 0;
    else begin
      case (state)
        2'b00: begin
          if (confirm) next_state <= 2'b01;
          else next_state <= next_state;
        end
        2'b01: begin
          if (pause) next_state <= 3'b10;
          else next_state <= next_state;
        end
        2'b10: begin
          if (reselect_wire) next_state <= 2'b00;
          else if (continue_wire) next_state <= 2'b01;
          else if (reStart_wire) next_state <= 2'b01;
          else next_state <= next_state;
        end
        default: next_state <= next_state;
      endcase
    end
  end

  reg [3:0] Dec;

  always @(*) begin
    Dec = 1 << state;
  end

  wire       continue_wire;
  wire       reselect_wire;
  wire       reStart_wire;

  wire [5:0] Seg1_wire     [0:1];
  wire [5:0] Seg2_wire     [0:1];
  wire [5:0] Seg3_wire     [0:1];
  wire [5:0] Seg4_wire     [0:1];
  wire [5:0] Seg5_wire     [0:1];
  wire [5:0] Seg6_wire     [0:1];

  assign Seg1 = (state == 2'b10) ? Seg1_wire[1] : Seg1_wire[0];
  assign Seg2 = (state == 2'b10) ? Seg2_wire[1] : Seg2_wire[0];
  assign Seg3 = (state == 2'b10) ? Seg3_wire[1] : Seg3_wire[0];
  assign Seg4 = (state == 2'b10) ? Seg4_wire[1] : Seg4_wire[0];
  assign Seg5 = (state == 2'b10) ? Seg5_wire[1] : Seg5_wire[0];
  assign Seg6 = (state == 2'b10) ? Seg6_wire[1] : Seg6_wire[0];

  wire [7:0] index_song;

  auto_select U1 (
    .preMode (0),
    .nextMode(nextMode),
    .confirm (confirm),
    .clk     (clk),
    .rst_n   (enable),
    .enable  (Dec[0]),
    .index   (index_song),
    .Seg1    (Seg1_wire[0]),
    .Seg2    (Seg2_wire[0]),
    .Seg3    (Seg3_wire[0]),
    .Seg4    (Seg4_wire[0]),
    .Seg5    (Seg5_wire[0]),
    .Seg6    (Seg6_wire[0])
  );

  player U2 (
    .clk   (clk),
    .pause (~Dec[1]),
    .rst_n (enable & !reStart_wire),
    .index (index_song),
    .buzzer(buzzer),
    .over  ()
  );

  suspend U3 (
    .rst_n   (Dec[2]),
    .preMode (0),
    .nextMode(nextMode),
    .confirm (preMode),
    .clk     (clk),
    .exit    (rst_state),
    .reSelect(reselect_wire),
    .reStart (reStart_wire),
    .Continue(continue_wire),
    .Seg1    (Seg1_wire[1]),
    .Seg2    (Seg2_wire[1]),
    .Seg3    (Seg3_wire[1]),
    .Seg4    (Seg4_wire[1]),
    .Seg5    (Seg5_wire[1]),
    .Seg6    (Seg6_wire[1])
  );

endmodule
