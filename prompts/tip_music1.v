module tip_music1 (
  input             clk,
  input      [ 7:0] key,
  input             rst_n,
  input             over,
  output            buzzer,
  output     [ 7:0] LED,
  output     [15:0] count,
  output            error_led,
  output            get,
  output reg        get_return
);

  parameter N = 4686914;

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


  note_to_LED U1 (
    note,
    rst_n,
    LED
  );

  LED_to_buzzer U2 (
    clk_spec,
    rst_n,
    key,
    LED,
    get,
    count,
    error_led
  );

  reg [31:0] j_;

  always @(posedge get or negedge rst_n) begin
    if (!rst_n) j_ <= 0;
    else begin
      if (j_ < 28) begin
        j_ <= j_ + 1;
      end else begin
        j_ <= 0;
      end
    end
  end

  always @(*) begin
    if (!rst_n) j = 500;
    else j = j_;
  end

  reg [4:0] note;

  always @(posedge clk_spec) begin
    case (j)
      0:  note <= 5'b01000;
      1:  note <= 5'b01000;
      2:  note <= 5'b01100;
      3:  note <= 5'b01100;
      4:  note <= 5'b01101;
      5:  note <= 5'b01101;
      6:  note <= 5'b01100;
      7:  note <= 5'b01011;
      8:  note <= 5'b01011;
      9:  note <= 5'b01010;
      10: note <= 5'b01010;
      11: note <= 5'b01001;
      12: note <= 5'b01001;
      13: note <= 5'b01000;
      14: note <= 5'b01100;
      15: note <= 5'b01100;
      16: note <= 5'b01011;
      17: note <= 5'b01011;
      18: note <= 5'b01010;
      19: note <= 5'b01010;
      20: note <= 5'b01001;
      21: note <= 5'b01100;
      22: note <= 5'b01100;
      23: note <= 5'b01011;
      24: note <= 5'b01011;
      25: note <= 5'b01010;
      26: note <= 5'b01010;
      27: note <= 5'b01001;

      default: note <= 0;
    endcase
  end

  always @(*) begin
    if (over) get_return <= 1;
    else get_return <= 0;
  end


  get_notes_spec U8 (
    clk,
    get,
    note,
    buzzer
  );

endmodule

