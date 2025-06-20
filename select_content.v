module select_content (
  input  wire       enable,
  input  wire [2:0] addr,
  output reg  [5:0] data1,
  output reg  [5:0] data2,
  output reg  [5:0] data3,
  output reg  [5:0] data4,
  output reg  [5:0] data5,
  output reg  [5:0] data6
);
  always @(*) begin
    if (enable) begin
      case (addr)
        /* select */
        3'd0: begin
          data1 <= 6'b011101;
          data2 <= 6'b001111;
          data3 <= 6'b010110;
          data4 <= 6'b001111;
          data5 <= 6'b001101;
          data6 <= 6'b011110;
        end
        /* manual */
        3'd1: begin
          data1 <= 6'b010111;
          data2 <= 6'b001011;
          data3 <= 6'b011000;
          data4 <= 6'b011111;
          data5 <= 6'b001011;
          data6 <= 6'b010110;
        end
        /* auto */
        3'd2: begin
          data1 <= 6'b001010;
          data2 <= 6'b001011;
          data3 <= 6'b011111;
          data4 <= 6'b011110;
          data5 <= 6'b000000;
          data6 <= 6'b001010;
        end
        /* PROMPT */
        3'd3: begin
          data1 <= 6'b011010;
          data2 <= 6'b011100;
          data3 <= 6'b011001;
          data4 <= 6'b010111;
          data5 <= 6'b011010;
          data6 <= 6'b011110;
        end
        /* PRGMBL */
        3'd4: begin
          data1 <= 6'b011010;
          data2 <= 6'b011100;
          data3 <= 6'b010001;
          data4 <= 6'b010111;
          data5 <= 6'b001100;
          data6 <= 6'b010110;
        end
        3'd5: begin
          data1 <= 6'b001010;
          data2 <= 6'b001010;
          data3 <= 6'b001010;
          data4 <= 6'b001010;
          data5 <= 6'b001010;
          data6 <= 6'b000110;
        end
        3'd6: begin
          data1 <= 6'b001010;
          data2 <= 6'b001010;
          data3 <= 6'b001010;
          data4 <= 6'b001010;
          data5 <= 6'b001010;
          data6 <= 6'b000111;
        end
        3'd7: begin
          data1 <= 6'b001010;
          data2 <= 6'b001010;
          data3 <= 6'b001010;
          data4 <= 6'b001010;
          data5 <= 6'b001010;
          data6 <= 6'b001000;
        end
        default: begin
          data1 <= 6'd10;
          data2 <= 6'd10;
          data3 <= 6'd10;
          data4 <= 6'd10;
          data5 <= 6'd10;
          data6 <= 6'd10;
        end
      endcase
    end else begin
      data1 <= 6'd10;
      data2 <= 6'd10;
      data3 <= 6'd10;
      data4 <= 6'd10;
      data5 <= 6'd10;
      data6 <= 6'd10;
    end
  end


endmodule
