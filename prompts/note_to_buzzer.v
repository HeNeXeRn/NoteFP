module LED_to_buzzer (
  input             clk,
  input             rst_n,
  input      [ 7:0] key,
  input      [ 7:0] LED,
  output reg        get,
  output reg [15:0] cnt,
  output reg        error_led
);


  reg [ 1:0] state;
  reg [24:0] error_cnt;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state     <= 0;
      error_led <= 0;
      error_cnt <= 0;
      cnt       <= 0;
    end else begin
      case (state)
        0: begin
          error_led <= 0;  // 关闭错误提示

          state     <= 1;  // 进入检测状态

          get       <= 0;
        end

        1: begin
          if (key != 8'b00000000) begin  // 有按键按下

            if (key == LED) begin  // 按下正确

              state <= 2;
            end else begin
              state <= 3;  // 错误：按键不匹配

            end
          end else state <= 1;
        end

        2: begin
          get   <= 1;  // 循环序列

          cnt   <= cnt + 1;
          state <= 0;  // 返回空闲状态，更新LED

        end

        3: begin
          get       <= 0;
          cnt       <= 0;
          error_led <= 1;  // 点亮错误提示

          error_cnt <= error_cnt + 1;
          if (error_cnt == 25'd2) begin  // 0.5秒后重置

            error_cnt <= 0;
            state     <= 0;  // 返回初始状态

          end
        end
      endcase
    end
  end


endmodule
