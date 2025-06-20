/*---------------------------------------*/
/* 该模块内除 rst_n 和 exit 都是高电平有效 */
/*---------------------------------------*/
module suspend (
  input  wire       rst_n,
  input  wire       preMode,
  input  wire       nextMode,
  input  wire       confirm,
  input  wire       clk,
  output reg        exit,
  output reg        reSelect,
  output reg        reStart,
  output reg        Continue,
  output reg  [5:0] Seg1,
  output reg  [5:0] Seg2,
  output reg  [5:0] Seg3,
  output reg  [5:0] Seg4,
  output reg  [5:0] Seg5,
  output reg  [5:0] Seg6
);

  reg [1:0] mode;

  always @(negedge rst_n or posedge nextMode) begin
    if (!rst_n) mode <= 0;
    else begin
      if (mode == 3) mode <= 0;
      else mode <= mode + 1;
    end
  end

  always @(negedge rst_n or posedge confirm) begin
    if (!rst_n) begin
      exit     <= 1;
      reStart  <= 0;
      Continue <= 0;
      reSelect <= 0;
    end else
      case (mode)
        /* exit */
        2'd0: begin
          exit     <= 0;
          reStart  <= 0;
          Continue <= 0;
          reSelect <= 0;
        end
        /* reStart */
        2'd1: begin
          exit     <= 1;
          reStart  <= 1;
          Continue <= 0;
          reSelect <= 0;
        end
        /* continue */
        2'd2: begin
          exit     <= 1;
          reStart  <= 0;
          Continue <= 1;
          reSelect <= 0;
        end
        /* reSelect */
        2'd3: begin
          exit     <= 1;
          reStart  <= 0;
          Continue <= 1;
          reSelect <= 1;
        end
        default: begin
          exit     <= 1;
          reStart  <= 0;
          Continue <= 0;
          reSelect <= 0;
        end
      endcase
  end

  /*显示部分*/
  always @(posedge clk) begin
    case (mode)
      2'd0: begin
        /* END */
        Seg1 <= 6'b001010;
        Seg2 <= 6'b001010;
        Seg3 <= 6'b001111;
        Seg4 <= 6'b011000;
        Seg5 <= 6'b001110;
        Seg6 <= 6'b001010;
      end
      /* RSTR */
      2'd1: begin
        Seg1 <= 6'b001010;
        Seg2 <= 6'b011100;
        Seg3 <= 6'b011101;
        Seg4 <= 6'b011110;
        Seg5 <= 6'b011100;
        Seg6 <= 6'b001010;
      end
      /* CONT */
      2'd2: begin
        Seg1 <= 6'b001010;
        Seg2 <= 6'b001101;
        Seg3 <= 6'b000000;
        Seg4 <= 6'b011000;
        Seg5 <= 6'b011110;
        Seg6 <= 6'b001010;
      end
      /* RESEL */
      2'd3: begin
        Seg1 <= 6'b001010;
        Seg2 <= 6'b011100;
        Seg3 <= 6'b001111;
        Seg4 <= 6'b011101;
        Seg5 <= 6'b001111;
        Seg6 <= 6'b010110;
      end
      /* PAUSE */
      default: begin
        Seg1 <= 6'b001010;
        Seg2 <= 6'b011010;
        Seg3 <= 6'b001011;
        Seg4 <= 6'b011111;
        Seg5 <= 6'b011101;
        Seg6 <= 6'b001111;
      end
    endcase
  end


endmodule
