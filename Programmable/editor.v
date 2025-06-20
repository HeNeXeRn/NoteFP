module editor (
  input  wire        clk,
  input  wire        rst_n,
  input  wire        confirm,
  input  wire        revise,
  input  wire        nextPart,
  input  wire        read,
  input  wire [ 3:0] switch,
  input  wire [31:0] data_in,
  output reg  [31:0] data_out,
  output      [ 7:0] twinkle,   /* 高电平有效 */
  output reg  [ 5:0] Seg1,
  output reg  [ 5:0] Seg2,
  output reg  [ 5:0] Seg3,
  output reg  [ 5:0] Seg4,
  output reg  [ 5:0] Seg5,
  output reg  [ 5:0] Seg6
);

  always @(posedge confirm) begin
    if (!rst_n) data_out <= 0;
    else begin
      if (1) begin
        case (part)
          2'b00:   data_out <= {temp, data_in[23:0]};
          2'b01:   data_out <= {data_in[31:24], temp, data_in[15:0]};
          2'b10:   data_out <= {data_in[31:16], temp, data_in[7:0]};
          2'b11:   data_out <= {data_in[31:8], temp};
          default: data_out <= data_in;
        endcase
      end else data_out <= data_in;
    end
  end

  always @(posedge clk) begin
    if (!rst_n) begin
      Seg5 <= 10;
      Seg6 <= 10;
    end else begin
      if (!read) begin
        Seg5 <= temp[7:4] < 10 ? {2'b00, temp[7:4]} : {2'b00, temp[7:4]} + 1;
        Seg6 <= temp[3:0] < 10 ? {2'b00, temp[3:0]} : {2'b00, temp[3:0]} + 1;
      end else begin
        case (part)
          2'b00: begin
            Seg5 <= data_in[31:28] < 10 ? {2'b00, data_in[31:28]} : {2'b00, data_in[31:28]} + 1;
            Seg6 <= data_in[27:24] < 10 ? {2'b00, data_in[27:24]} : {2'b00, data_in[27:24]} + 1;
          end
          2'b01: begin
            Seg5 <= data_in[23:20] < 10 ? {2'b00, data_in[23:20]} : {2'b00, data_in[23:20]} + 1;
            Seg6 <= data_in[19:16] < 10 ? {2'b00, data_in[19:16]} : {2'b00, data_in[19:16]} + 1;
          end
          2'b10: begin
            Seg5 <= data_in[15:12] < 10 ? {2'b00, data_in[15:12]} : {2'b00, data_in[15:12]} + 1;
            Seg6 <= data_in[11:8] < 10 ? {2'b00, data_in[11:8]} : {2'b00, data_in[11:8]} + 1;
          end
          2'b11: begin
            Seg5 <= data_in[7:4] < 10 ? {2'b00, data_in[7:4]} : {2'b00, data_in[7:4]} + 1;
            Seg6 <= data_in[3:0] < 10 ? {2'b00, data_in[3:0]} : {2'b00, data_in[3:0]} + 1;
          end
          default: begin
            Seg5 <= data_in[7:4] < 10 ? {2'b00, data_in[7:4]} : {2'b00, data_in[7:4]} + 1;
            Seg6 <= data_in[3:0] < 10 ? {2'b00, data_in[3:0]} : {2'b00, data_in[3:0]} + 1;
          end
        endcase
      end
    end
  end

  /* op */
  /* d1 */
  /* d2 */
  /* d3 */
  reg [1:0] part;
  reg [7:0] temp;
  reg       revise_data;

  always @(posedge nextPart or negedge rst_n) begin
    if (!rst_n) revise_data <= 0;
    else revise_data <= ~revise_data;
  end

  always @(posedge clk) begin
    if (!rst_n) temp[7:4] <= 0;
    else if (!revise) begin
      temp[7:4] <= switch;
      temp[3:0] <= temp[3:0];
    end else begin
      temp[7:4] <= temp[7:4];
      temp[3:0] <= switch;
    end
  end

  always @(posedge nextPart) begin
    if (!rst_n) part <= 0;
    else part <= part + 1;

  end

  always @(posedge clk) begin
    if (!rst_n) begin
      Seg3 <= 10;
      Seg4 <= 10;
    end else begin
      case (part)
        2'b00: begin
          Seg3 <= 6'b000000;
          Seg4 <= 6'b011010;
        end
        2'b01: begin
          Seg3 <= 6'b001110;
          Seg4 <= 6'b000001;
        end
        2'b10: begin
          Seg3 <= 6'b001110;
          Seg4 <= 6'b000010;
        end
        2'b11: begin
          Seg3 <= 6'b001110;
          Seg4 <= 6'b000011;
        end
        default: begin
          Seg3 <= 10;
          Seg4 <= 10;
        end
      endcase
    end
  end
  
endmodule
