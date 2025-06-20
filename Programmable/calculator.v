module calculator (
  input        clk,           /* 时钟信号 */
  input        rst_n,         /* 复位信号，低电平有效 */
  input        edit_run,      /* 编辑/运行模式控制，0为编辑，1为运行 */
  input        revise,        /* 修订信号 */
  input        confirm,       /* 确认信号 */
  input        nextLine,      /* 下一行信号 */
  input        nextPart,      /* 下一部分信号 */
  input        READ,          /* 读取信号 */
  input  [3:0] switch,        /* 开关输入 */
  output [5:0] Seg1,          /* 第1段数码管输出 */
  output [5:0] Seg2,          /* 第2段数码管输出 */
  output [5:0] Seg3,          /* 第3段数码管输出 */
  output [5:0] Seg4,          /* 第4段数码管输出 */
  output [5:0] Seg5,          /* 第5段数码管输出 */
  output [5:0] Seg6          /* 第6段数码管输出 */
);

  /* 根据 edit_run 信号选择数码管显示内容 */
  assign Seg1 = ((edit_run == 1) ? Seg1_sig[0] : Seg1_sig[1]);
  assign Seg2 = ((edit_run == 1) ? Seg2_sig[0] : Seg2_sig[1]);
  assign Seg3 = ((edit_run == 1) ? Seg3_sig[0] : Seg3_sig[1]);
  assign Seg4 = ((edit_run == 1) ? Seg4_sig[0] : Seg4_sig[1]);
  assign Seg5 = ((edit_run == 1) ? Seg5_sig[0] : Seg5_sig[1]);
  assign Seg6 = ((edit_run == 1) ? Seg6_sig[0] : Seg6_sig[1]);

  /* 数码管显示信号数组 */
  wire [5:0] Seg1_sig[0:2];
  wire [5:0] Seg2_sig[0:2];
  wire [5:0] Seg3_sig[0:2];
  wire [5:0] Seg4_sig[0:2];
  wire [5:0] Seg5_sig[0:2];
  wire [5:0] Seg6_sig[0:2];

  /* 数码管显示内容定义 */
  assign Seg1_sig[0] = 6'b011100; /* 运行模式下第1段显示内容 */
  assign Seg2_sig[0] = 6'b011111; /* 运行模式下第2段显示内容 */
  assign Seg3_sig[0] = 6'b010111; /* 运行模式下第3段显示内容 */
  assign Seg4_sig[0] = 10;        /* 运行模式下第4段显示内容 */
  assign Seg5_sig[0] = CPU_out[7:4] < 10 ? {2'b00, CPU_out[7:4]} : {2'b00, CPU_out[7:4]} + 1; /* 运行模式下第5段显示内容 */
  assign Seg6_sig[0] = CPU_out[3:0] < 10 ? {2'b00, CPU_out[3:0]} : {2'b00, CPU_out[3:0]} + 1; /* 运行模式下第6段显示内容 */

  /* 编辑模式下数码管显示内容 */
  assign Seg1_sig[1] = _index[7:4] < 10 ? {2'b00, _index[7:4]} : {2'b00, _index[7:4]} + 1;
  assign Seg2_sig[1] = _index[3:0] < 10 ? {2'b00, _index[3:0]} : {2'b00, _index[3:0]} + 1;

  /* 程序寄存器实例化 */
  program_reg progm (
    .clk   (clk),          /* 时钟信号 */
    .rst_n (),             /* 复位信号 */
    .read  (!(confirm && !edit_run)), /* 读取使能 */
    .write (confirm),      /* 写入使能 */
    .index (index[0]),     /* 索引 */
    .length(),             /* 长度 */
    .data  (data),         /* 数据 */
    .order (order),        /* 指令 */
    .len   ()              /* 长度 */
  );

  /* 指令和数据信号 */
  wire [31:0] order;
  wire [31:0] data;

  /* 索引信号定义 */
  reg  [ 7:0] index  [0:3]; /* 索引数组 */
  wire [ 7:0] _index;       /* 当前索引 */
  assign _index = index[0];

  /* 处理器实例化 */
  processor CPU (
    .clk       (clk),       /* 时钟信号 */
    .rst_n     (1),         /* 复位信号 */
    .operate   (oper),      /* 操作码 */
    .in        (),          /* 输入 */
    .addr1     (addr1),     /* 地址1 */
    .addr2     (addr2),     /* 地址2 */
    .addr3     (addr3),     /* 地址3 */
    .SystemTime(),          /* 系统时间 */
    .out       (CPU_out),   /* 输出 */
    .jump      (jump)       /* 跳转信号 */
  );

  /* 处理器输出信号 */
  wire [ 7:0] CPU_out;
  wire        jump;

  /* 操作码和地址寄存器 */
  reg  [ 7:0] oper;
  reg  [ 7:0] addr1;
  reg  [ 7:0] addr2;
  reg  [ 7:0] addr3;

  /* 时钟分频器 */
  reg  [31:0] temp;
  reg         clk_show4time;
  always @(posedge clk) begin
    if (!rst_n) begin
      clk_show4time <= 0; /* 复位时清零 */
      temp          <= 0; /* 复位时清零 */
    end else if (temp == 2000_000 - 1) begin
      temp          <= 0; /* 计数溢出清零 */
      clk_show4time <= ~clk_show4time; /* 翻转时钟 */
    end else temp <= temp + 1; /* 计数递增 */
  end

  /* 索引更新逻辑 */
  always @(*) begin
    if (rst_n) begin
      if (edit_run) index[0] <= index[1]; /* 编辑模式下索引更新 */
      else index[0] <= index[2];          /* 运行模式下索引更新 */
    end else index[0] <= 0; /* 复位时索引清零 */
  end

  /* 索引1更新逻辑 */
  always @(posedge clk_show4time or negedge rst_n) begin
    if (!rst_n) index[1] <= 0; /* 复位时清零 */
    else if (jump) index[1] <= CPU_out; /* 处理器跳转 */
    else if (index[1] != 10) index[1] <= index[1] + 1; /* 自动递增 */
    else index[1] <= index[1]; /* 达到上限保持 */
  end

  /* 索引2更新逻辑 */
  always @(posedge nextLine or negedge rst_n) begin
    if (!rst_n) index[2] <= 0; /* 复位时清零 */
    else if (index[2] != 127) index[2] <= index[2] + 1; /* 自动递增 */
    else index[2] <= index[2]; /* 达到上限保持 */
  end

  /* 编辑器实例化 */
  editor U4 (
    .clk     (clk),         /* 时钟信号 */
    .rst_n   (rst_n && !edit_run), /* 复位信号 */
    .revise  (revise),      /* 修订信号 */
    .nextPart(nextPart),    /* 下一部分信号 */
    .confirm(confirm),      /* 确认信号 */
    .switch  (switch),      /* 开关输入 */
    .data_in (order),       /* 数据输入 */
    .data_out(data),        /* 数据输出 */
    .read(READ),            /* 读取信号 */
    .twinkle (),            /* 闪烁信号 */
    .Seg1    (),            /* 第1段数码管 */
    .Seg2    (),            /* 第2段数码管 */
    .Seg3    (Seg3_sig[1]), /* 第3段数码管 */
    .Seg4    (Seg4_sig[1]), /* 第4段数码管 */
    .Seg5    (Seg5_sig[1]), /* 第5段数码管 */
    .Seg6    (Seg6_sig[1])  /* 第6段数码管 */
  );

  /* 测试指令 */
  always @(posedge clk) begin
    case (index[1])
    /* immd 5 reg0 */
      0: begin
        oper  <= 8'h00; /* 操作码 */
        addr1 <= 8'h05; /* 地址1 */
        addr2 <= 0;     /* 地址2 */
        addr3 <= 8'h00; /* 地址3 */
      end
      /* immd 9 reg6 */
      1: begin
        oper  <= 8'h00;
        addr1 <= 8'h09;
        addr2 <= 0;
        addr3 <= 8'h06;
      end
      /* immd 1 reg1 */
      2: begin
        oper  <= 8'h00;
        addr1 <= 8'h01;
        addr2 <= 0;
        addr3 <= 8'h01;
      end
      /* immd 1 reg2 */
      3: begin
        oper  <= 8'h00;
        addr1 <= 8'h01;
        addr2 <= 0;
        addr3 <= 8'h02;
      end
      /* immd 0 reg3 */
      4: begin
        oper  <= 8'h00;
        addr1 <= 8'h00;
        addr2 <= 0;
        addr3 <= 8'h03;
      end
      /* add reg3 reg2 reg4 */
      5: begin
        oper  <= 8'h10;
        addr1 <= 8'h02;
        addr2 <= 8'h03;
        addr3 <= 8'h04;
      end
      /* copy reg4 reg3 */
      6: begin
        oper  <= 8'h30;
        addr1 <= 8'h04;
        addr2 <= 8'h00;
        addr3 <= 8'h03;
      end
      /* add reg1 reg2 reg5 */
      7: begin
        oper  <= 8'h10;
        addr1 <= 8'h01;
        addr2 <= 8'h02;
        addr3 <= 8'h05;
      end
      /* copy reg5 reg2 */
      8: begin
        oper  <= 8'h30;
        addr1 <= 8'h05;
        addr2 <= 8'h00;
        addr3 <= 8'h02;
      end
      /* NEP reg2 reg6 reg0 */
      9: begin
        oper  <= 8'h27;
        addr1 <= 8'h02;
        addr2 <= 8'h06;
        addr3 <= 8'h00;
      end
      /* copy reg4 out */
      10: begin
        oper  <= 8'h30;
        addr1 <= 8'h04;
        addr2 <= 8'h00;
        addr3 <= 8'h07;
      end
      default: begin
        oper  <= 0; /* 默认操作码 */
        addr1 <= 0; /* 默认地址1 */
        addr2 <= 0; /* 默认地址2 */
        addr3 <= 0; /* 默认地址3 */
      end
    endcase
  end

endmodule