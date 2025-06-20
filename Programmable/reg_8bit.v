module reg_8bit (
  input  wire       clk,
  input  wire       rst_n,
  input  wire       read,
  input  wire       write,
  input  wire [7:0] data,
  output reg  [7:0] value
);

  reg [7:0] record;

  always @(posedge clk) begin
    if (read) value <= record;
    else value <= 0;
  end

  always @(posedge clk) begin
    if (!rst_n) record <= 0;
    else if (write) record <= data;
    else record <= record;
  end


endmodule
