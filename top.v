module top (
    /* 输入信号：8 位按钮信号 */
    input      [ 7:0] button,
    /* 输入信号：8 位开关信号 */
    input      [ 7:0] switch,
    /* 输入信号：时钟信号 */
    input             CLK,
    /* 输出信号：16 位 LED 信号 */
    output     [15:0] Led,
    /* 输出信号：蜂鸣器信号，寄存器类型 */
    output reg        buzzer,
    /* 输出信号：数码管显示信号 */
    output     [ 7:0] Digitron,
    /* 输出信号：数码管选通信号 */
    output     [ 5:0] DigitronCS
);

  /*---------------------------------------------------------------------------*/
  /*                      状态相关的信号和逻辑                                  */
  /*---------------------------------------------------------------------------*/
  /* 当前状态 */
  reg  [2:0] state;
  /* 下一个状态 */
  reg  [2:0] next_state;
  /* 状态线信号 */
  wire [2:0] wire_state;
  /* 重置状态信号 */
  wire [3:0] rst_state;
  /* 加载信号 */
  wire       load;
  /* 重置后的状态信号 */
  reg        rst_n_state;

  /* 更新 rst_n_state 信号，当开关 0 未按下且 rst_state 信号全为 1 时，rst_n_state 为 1 */
  always @(posedge CLK) begin
    rst_n_state = 1 & rst_state[0] & rst_state[1] & rst_state[2];
  end

  /* 在时钟下降沿更新状态 */
  always @(negedge CLK) begin
    /* 如果开关 0 被按下或 rst_n_state 为 0，状态复位为 0 */
    if (!switch[0] || !rst_n_state) state <= 0;
    /* 否则更新为下一个状态 */
    else
      state <= next_state;
  end

  /* 更新下一个状态 */
  always @(posedge CLK) begin
    /* 如果开关 0 被按下或 rst_n_state 为 0，下一个状态复位为 0 */
    if (!switch[0] || !rst_n_state) next_state <= 0;
    /* 如果加载信号有效，更新为 wire_state 指定的状态 */
    else if (load) next_state <= wire_state;
    /* 否则保持当前状态 */
    else
      next_state <= next_state;
  end

  /* 定义一个 8 位寄存器 Dec，用于控制模块的工作状态 */
  reg [7:0] Dec;

  /* 根据开关 0 的状态更新 Dec 的值 */
  always @(*) begin
    if (!switch[0]) Dec <= 0;  /* 开关 0 被按下时，Dec 为 0 */
    else
      Dec = 1 << state;     /* 开关 0 未按下时，Dec 根据状态设置为对应位为 1 的值 */
  end
  /*---------------------------------------------------------------------------*/
  /*                      LED 显示相关的信号和逻辑                              */
  /*---------------------------------------------------------------------------*/

  /* 将 Dec 的值赋给 Led 的高 8 位，控制 LED 显示 */
  assign Led[15:8] = Dec;

  /*---------------------------------------------------------------------------*/
  /*                      按键消抖部分                                          */
  /*---------------------------------------------------------------------------*/
  /* 定义消抖后的按键信号 */
  wire [7:0] Key_sig;

  /* 实例化按键消抖模块 */
  debouncing_all DeBounce (
      .clk    (CLK),     /* 时钟信号 */
      .key_in (button),  /* 输入按键信号 */
      .key_out(Key_sig)  /* 输出消抖后的按键信号 */
  );

  /*---------------------------------------------------------------------------*/
  /*                      数码管显示部分                                        */
  /*---------------------------------------------------------------------------*/
  /* 定义数码管闪烁信号 */
  wire       twinkle_wire[0:5];
  /* 定义各个数码管显示信号 */
  wire [5:0] Seg1_sig    [0:5];
  wire [5:0] Seg2_sig    [0:5];
  wire [5:0] Seg3_sig    [0:5];
  wire [5:0] Seg4_sig    [0:5];
  wire [5:0] Seg5_sig    [0:5];
  wire [5:0] Seg6_sig    [0:5];

  /* 定义数码管显示寄存器 */
  reg        twinkle;
  reg  [5:0] Seg1;
  reg  [5:0] Seg2;
  reg  [5:0] Seg3;
  reg  [5:0] Seg4;
  reg  [5:0] Seg5;
  reg  [5:0] Seg6;

  /* 根据状态更新 twinkle 信号 */
  always @(posedge CLK) begin
    case (state)
      3'b010:  twinkle = twinkle_wire[1];  /* 状态为 010 时，使用 twinkle_wire[1] 信号 */
      3'b011:  twinkle = twinkle_wire[0];  /* 状态为 011 时，使用 twinkle_wire[0] 信号 */
      default: twinkle = 0;  /* 其他状态时，twinkle 为 0 */
    endcase
  end

  /* 根据状态更新各个数码管显示信号 */
  always @(posedge CLK) begin
    case (state)
      3'b000: begin
        Seg1 <= Seg1_sig[0];
        Seg2 <= Seg2_sig[0];
        Seg3 <= Seg3_sig[0];
        Seg4 <= Seg4_sig[0];
        Seg5 <= Seg5_sig[0];
        Seg6 <= Seg6_sig[0];
      end
      3'b001: begin
        Seg1 <= Seg1_sig[1];
        Seg2 <= 0;
        Seg3 <= 0;
        Seg4 <= 0;
        Seg5 <= 0;
        Seg6 <= 0;
      end
      3'b010: begin
        Seg1 <= Seg1_sig[2];
        Seg2 <= Seg2_sig[2];
        Seg3 <= Seg3_sig[2];
        Seg4 <= Seg4_sig[2];
        Seg5 <= Seg5_sig[2];
        Seg6 <= Seg6_sig[2];
      end
      3'b011: begin
        Seg1 <= Seg1_sig[3];
        Seg2 <= Seg2_sig[3];
        Seg3 <= Seg3_sig[3];
        Seg4 <= Seg4_sig[3];
        Seg5 <= Seg5_sig[3];
        Seg6 <= Seg6_sig[3];
      end
      3'b100: begin
        Seg1 <= Seg1_sig[4];
        Seg2 <= Seg2_sig[4];
        Seg3 <= Seg3_sig[4];
        Seg4 <= Seg4_sig[4];
        Seg5 <= Seg5_sig[4];
        Seg6 <= Seg6_sig[4];
      end
      default: begin
        Seg1 <= 6'd1;
        Seg2 <= 6'd2;
        Seg3 <= 6'd3;
        Seg4 <= 6'd4;
        Seg5 <= 6'd5;
        Seg6 <= 6'd6;
      end
    endcase
  end

  /* 实例化数码管显示模块 */
  DIG Seg_DIG (
      .clk      (CLK),        /* 时钟信号 */
      .dig_in1  (Seg1),       /* 第 1 个数码管输入信号 */
      .dig_in2  (Seg2),       /* 第 2 个数码管输入信号 */
      .dig_in3  (Seg3),       /* 第 3 个数码管输入信号 */
      .dig_in4  (Seg4),       /* 第 4 个数码管输入信号 */
      .dig_in5  (Seg5),       /* 第 5 个数码管输入信号 */
      .dig_in6  (Seg6),       /* 第 6 个数码管输入信号 */
      .rst_n    (switch[0]),  /* 重置信号，开关 0 未按下时有效 */
      .switch   (~twinkle),   /* 闪烁控制信号 */
      .dig_out  (Digitron),   /* 数码管显示输出信号 */
      .digCS_out(DigitronCS)  /* 数码管选通信号 */
  );


  /*---------------------------------------------------------------------------*/
  /*                      蜂鸣器控制部分                                        */
  /*---------------------------------------------------------------------------*/
  /* 定义蜂鸣器控制信号 */
  wire buzzer_wire[0:3];
  /* 根据状态更新蜂鸣器信号 */
  always @(*) begin
    case (state)
      3'd0: buzzer <= 0;  /* 状态为 0 时，蜂鸣器关闭 */
      3'd1:
      buzzer <= buzzer_wire[1];  /* 状态为 1 时，蜂鸣器信号由 buzzer_wire[1] 控制 */
      3'd2:
      buzzer <= buzzer_wire[2];  /* 状态为 2 时，蜂鸣器信号由 buzzer_wire[2] 控制 */
      3'd3:
      buzzer <= buzzer_wire[3];  /* 状态为 3 时，蜂鸣器信号由 buzzer_wire[3] 控制 */
      default: buzzer <= 0;  /* 其他状态时，蜂鸣器关闭 */
    endcase
  end


  /*---------------------------------------------------------------------------*/
  /*                      各功能模块实例化                                      */
  /*---------------------------------------------------------------------------*/
  /* 实例化选择功能模块 */
  select select_inst (
      .preMode  (~Key_sig[0]),          /* 上一个模式信号 */
      .nextMode (0),                    /* 下一个模式信号 */
      .confirm  (~Key_sig[7]),          /* 确认信号 */
      .clk      (CLK),                  /* 时钟信号 */
      .rst_n    (Dec[0] && switch[0]),  /* 重置信号 */
      .load     (load),                 /* 加载信号 */
      .nextState(wire_state),           /* 下一个状态信号 */
      .Seg1     (Seg1_sig[0]),          /* 第 1 个数码管显示信号 */
      .Seg2     (Seg2_sig[0]),          /* 第 2 个数码管显示信号 */
      .Seg3     (Seg3_sig[0]),          /* 第 3 个数码管显示信号 */
      .Seg4     (Seg4_sig[0]),          /* 第 4 个数码管显示信号 */
      .Seg5     (Seg5_sig[0]),          /* 第 5 个数码管显示信号 */
      .Seg6     (Seg6_sig[0])           /* 第 6 个数码管显示信号 */
  );

  /* 实例化按键蜂鸣模块 */
  key_beep key_beep_inst (
      .key       (Key_sig),              /* 按键信号 */
      .pitch     (switch[7:6]),          /* 音调信号 */
      .clk       (CLK),                  /* 时钟信号 */
      .rst_n     (Dec[1] && switch[0]),  /* 重置信号 */
      .return    (switch[1]),            /* 返回信号 */
      .beep      (buzzer_wire[1]),       /* 蜂鸣器信号 */
      .dig_pitch (Seg1_sig[1]),          /* 数码管音调显示信号 */
      .get_return(rst_state[0])          /* 返回状态信号 */
  );

  /* 实例化自动模式模块 */
  auto auto_inst (
      .preMode  (~Key_sig[3]),      /* 上一个模式信号 */
      .nextMode (~Key_sig[0]),      /* 下一个模式信号 */
      .confirm  (~Key_sig[1]),      /* 确认信号 */
      .clk      (CLK),              /* 时钟信号 */
      .rst_n    (switch[0]),        /* 重置信号 */
      .enable   (Dec[2]),           /* 使能信号 */
      .pause    (~Key_sig[2]),      /* 暂停信号 */
      .twinkle  (twinkle_wire[1]),  /* 闪烁信号 */
      .buzzer   (buzzer_wire[2]),   /* 蜂鸣器信号 */
      .rst_state(rst_state[1]),     /* 重置状态信号 */
      .Seg1     (Seg1_sig[2]),      /* 第 1 个数码管显示信号 */
      .Seg2     (Seg2_sig[2]),      /* 第 2 个数码管显示信号 */
      .Seg3     (Seg3_sig[2]),      /* 第 3 个数码管显示信号 */
      .Seg4     (Seg4_sig[2]),      /* 第 4 个数码管显示信号 */
      .Seg5     (Seg5_sig[2]),      /* 第 5 个数码管显示信号 */
      .Seg6     (Seg6_sig[2])       /* 第 6 个数码管显示信号 */
  );

  /* 实例化提示模块 */
  prompt prompt_inst (
      .clk      (CLK),              /* 时钟信号 */
      .rst_n    (switch[0]),        /* 重置信号 */
      .enable   (Dec[3]),           /* 使能信号 */
      .pause    (switch[7]),        /* 暂停信号 */
      .key      (~Key_sig),         /* 按键信号 */
      .twinkle  (twinkle_wire[0]),  /* 闪烁信号 */
      .buzzer   (buzzer_wire[3]),   /* 蜂鸣器信号 */
      .rst_state(rst_state[2]),     /* 重置状态信号 */
      .LED      (Led[7:0]),         /* LED 显示信号 */
      .Seg1     (Seg1_sig[3]),      /* 第 1 个数码管显示信号 */
      .Seg2     (Seg2_sig[3]),      /* 第 2 个数码管显示信号 */
      .Seg3     (Seg3_sig[3]),      /* 第 3 个数码管显示信号 */
      .Seg4     (Seg4_sig[3]),      /* 第 4 个数码管显示信号 */
      .Seg5     (Seg5_sig[3]),      /* 第 5 个数码管显示信号 */
      .Seg6     (Seg6_sig[3])       /* 第 6 个数码管显示信号 */
  );

  /* 实例化可编程模块 */
  calculator MCU (
      .clk     (CLK),                  /* 时钟信号 */
      .rst_n   (Dec[4] && switch[0]),  /* 重置信号 */
      .edit_run(switch[1]),            /* 编辑运行信号 */
      .revise  (switch[2]),            /* 修订信号 */
      .confirm (~Key_sig[2]),          /* 确认信号 */
      .READ    (switch[3]),            /* 读取信号 */
      .nextLine(~Key_sig[1]),          /* 下一行信号 */
      .nextPart(~Key_sig[0]),          /* 下一部分信号 */
      .switch  (switch[7:4]),          /* 开关信号 */
      .Seg1    (Seg1_sig[4]),          /* 第 1 个数码管显示信号 */
      .Seg2    (Seg2_sig[4]),          /* 第 2 个数码管显示信号 */
      .Seg3    (Seg3_sig[4]),          /* 第 3 个数码管显示信号 */
      .Seg4    (Seg4_sig[4]),          /* 第 4 个数码管显示信号 */
      .Seg5    (Seg5_sig[4]),          /* 第 5 个数码管显示信号 */
      .Seg6    (Seg6_sig[4])           /* 第 6 个数码管显示信号 */
  );

endmodule

