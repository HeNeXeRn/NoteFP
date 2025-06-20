module debouncing_all (
  input        clk,
  input  [7:0] key_in,
  output [7:0] key_out
);

  debouncing U1 (
    key_in[7],
    clk,
    1'b1,
    key_out[7]
  );
  debouncing U2 (
    key_in[6],
    clk,
    1'b1,
    key_out[6]
  );
  debouncing U3 (
    key_in[5],
    clk,
    1'b1,
    key_out[5]
  );
  debouncing U4 (
    key_in[4],
    clk,
    1'b1,
    key_out[4]
  );
  debouncing U5 (
    key_in[3],
    clk,
    1'b1,
    key_out[3]
  );
  debouncing U6 (
    key_in[2],
    clk,
    1'b1,
    key_out[2]
  );
  debouncing U7 (
    key_in[1],
    clk,
    1'b1,
    key_out[1]
  );
  debouncing U8 (
    key_in[0],
    clk,
    1'b1,
    key_out[0]
  );

endmodule
