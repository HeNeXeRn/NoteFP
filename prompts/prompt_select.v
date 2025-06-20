module prompt_select (
  input  wire       preMode,
  input  wire       nextMode,
  input  wire       confirm,
  input  wire       clk,
  input  wire       rst_n,
  input  wire       enable,
  output reg  [7:0] index,
  output reg  [5:0] Seg1,
  output reg  [5:0] Seg2,
  output reg  [5:0] Seg3,
  output reg  [5:0] Seg4,
  output reg  [5:0] Seg5,
  output reg  [5:0] Seg6
);

  reg [7:0] current;
  parameter sum_songs = 1;


  always @(negedge rst_n or posedge nextMode) begin
    if (!rst_n) current <= 0;
    else begin
      if (enable) begin
        if (current == sum_songs - 1) current <= 0;
        else current <= current + 1;
      end else begin
        current <= current;
      end
    end
  end

  always @(negedge rst_n or posedge confirm) begin
    if (!rst_n) index <= 0;
    else begin
      if (enable) index <= current;
      else index <= index;
    end
  end

  /* 歌曲名单 */
  always @(posedge clk) begin
    case (current)
    /* LSTAR */
      7'd0: begin
        Seg1 <= 6'b001010;
        Seg2 <= 6'b010110;
        Seg3 <= 6'b011101;
        Seg4 <= 6'b011110;
        Seg5 <= 6'b001011;
        Seg6 <= 6'b011100;
      end
      /* error */
      default: begin
        Seg1 <= 6'b001010;
        Seg2 <= 6'b001111;
        Seg3 <= 6'b011100;
        Seg4 <= 6'b011100;
        Seg5 <= 6'b000000;
        Seg6 <= 6'b011100;
      end
    endcase
  end

endmodule
