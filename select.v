module select (
  input  wire       preMode,   /* 切换到上一个模式信号 */
  input  wire       nextMode,  /* 切换到下一个模式信号 */
  input  wire       confirm,   /* 确认信号 */
  input  wire       clk,       /* 时钟信号 */
  input  wire       rst_n,     /* 复位信号，低电平有效 */
  output reg        load,      /* 加载信号 */
  output reg  [2:0] nextState, /* 下一个状态 */
  output      [5:0] Seg1,      /* 第1段数码管输出 */
  output      [5:0] Seg2,      /* 第2段数码管输出 */
  output      [5:0] Seg3,      /* 第3段数码管输出 */
  output      [5:0] Seg4,      /* 第4段数码管输出 */
  output      [5:0] Seg5,      /* 第5段数码管输出 */
  output      [5:0] Seg6       /* 第6段数码管输出 */
);
  /* 定义模式数量 */
  parameter num_mode = 5;

  /* 当前模式寄存器 */
  reg [2:0] mode;
  /* 模式临时寄存器 */
  reg [2:0] mode_temp;

  /* 模式更新逻辑 */
  always @(negedge rst_n or posedge clk) begin
    if (!rst_n) mode <= 0; /* 复位时模式清零 */
    else mode <= mode_temp; /* 更新模式 */
  end

  /* 确认逻辑 */
  always @(negedge rst_n or posedge confirm) begin
    if (!rst_n) begin
      nextState <= 0; /* 复位时下一个状态清零 */
      load      <= 0; /* 复位时加载信号清零 */
    end else begin
      nextState <= mode; /* 设置下一个状态为当前模式 */
      load      <= 1;    /* 设置加载信号 */
    end
  end

  /* 模式切换逻辑 */
  always @(negedge rst_n or posedge preMode or posedge nextMode) begin
    if (!rst_n) mode_temp <= 0; /* 复位时模式临时寄存器清零 */
    else if (nextMode) begin
      if (mode_temp == 0) mode_temp <= num_mode - 1; /* 循环到最大模式 */
      else mode_temp <= mode_temp - 1; /* 切换到上一个模式 */
    end else if (preMode) begin
      if (mode_temp == num_mode - 1) mode_temp <= 0; /* 循环到最小模式 */
      else mode_temp <= mode_temp + 1; /* 切换到下一个模式 */
    end else mode_temp <= mode_temp; /* 保持当前模式 */
  end

  /* 数码管显示内容选择模块实例化 */
  select_content U1 (
    .enable(rst_n),  /* 启用信号 */
    .addr  (mode),   /* 地址（当前模式） */
    .data1 (Seg1),   /* 第1段显示数据 */
    .data2 (Seg2),   /* 第2段显示数据 */
    .data3 (Seg3),   /* 第3段显示数据 */
    .data4 (Seg4),   /* 第4段显示数据 */
    .data5 (Seg5),   /* 第5段显示数据 */
    .data6 (Seg6)    /* 第6段显示数据 */
  );

endmodule