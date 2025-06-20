module songbook (
  input  wire       clk,
  input  wire       pause,
  input  wire       rst_n,
  input  wire [7:0] key,
  input  wire [7:0] index,
  output wire  [7:0] LED,
  output reg        buzzer,
  output reg        over
);
  /* 总歌数-1 */
  parameter sum_songs = 7;

  wire over_wire  [0:sum_songs];
  wire buzzer_wire[0:sum_songs];

  always @(*) begin
    case (index)
      0: begin
        over   = over_wire[0];
        buzzer = buzzer_wire[0];
      end
      2: begin
        over   = over_wire[2];
        buzzer = buzzer_wire[2];
      end
      3: begin
        over   = over_wire[3];
        buzzer = buzzer_wire[3];
      end
      default: begin
        over   = 0;
        buzzer = 0;
      end
    endcase
  end

  reg [sum_songs:0] Dec;
  always @(*) begin
    if (!rst_n) Dec <= 0;
    else Dec = 1 << index;
  end

  tip_music1 U1 (
    .clk       (clk),
    .key       (key),
    .rst_n     (Dec[0]),
    .over      (),
    .buzzer    (buzzer_wire[0]),
    .LED       (LED),
    .count     (),
    .error_led (),
    .get       (),
    .get_return(over_wire[0])
  );


endmodule
