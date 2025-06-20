module debouncing (
  input      key_in,
  input      clk,
  input      rst_n,
  output reg key_out
);

  reg        state;
  reg [20:0] cnt;
  parameter T = 750000;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state   <= 0;
      cnt     <= 0;
      key_out <= 1;
    end else begin
      case (state)
        0: begin
          if (key_in == 0) begin
            if (cnt < T - 1) begin
              cnt     <= cnt + 1;
              state   <= 0;
              key_out <= 1;
            end else begin
              cnt     <= 0;
              state   <= 1;
              key_out <= 0;
            end
          end else begin
            cnt     <= 0;
            state   <= 0;
            key_out <= 1;
          end
        end
        1: begin
          if (key_in == 1) begin
            if (cnt < T - 1) begin
              cnt     <= cnt + 1;
              state   <= 1;
              key_out <= 0;
            end else begin
              cnt     <= 0;
              state   <= 0;
              key_out <= 1;
            end
          end else begin
            cnt     <= 0;
            state   <= 1;
            key_out <= 0;
          end
        end
        default: state <= 0;
      endcase
    end
  end

endmodule
