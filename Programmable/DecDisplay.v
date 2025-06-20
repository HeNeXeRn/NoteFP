module DecDisplay (
  input  [31:0] data,
  input         clk,
  input         rst_n,
  output [ 5:0] Seg1,
  output [ 5:0] Seg2,
  output [ 5:0] Seg3,
  output [ 5:0] Seg4,
  output [ 5:0] Seg5,
  output [ 5:0] Seg6
);

  wire [3:0] Seg_sig[0:5];

  bin32_to_6bcd U1 (
    .bin (data),
    .bcd5(Seg_sig[0]),
    .bcd4(Seg_sig[1]),
    .bcd3(Seg_sig[2]),
    .bcd2(Seg_sig[3]),
    .bcd1(Seg_sig[4]),
    .bcd0(Seg_sig[5])
  );

  assign Seg1 = {2'b00, Seg_sig[0]};
  assign Seg2 = {2'b00, Seg_sig[1]};
  assign Seg3 = {2'b00, Seg_sig[2]};
  assign Seg4 = {2'b00, Seg_sig[3]};
  assign Seg5 = {2'b00, Seg_sig[4]};
  assign Seg6 = {2'b00, Seg_sig[5]};

endmodule

module bin32_to_6bcd (
  input  [31:0] bin,
  output [ 3:0] bcd5,
  output [ 3:0] bcd4,
  output [ 3:0] bcd3,
  output [ 3:0] bcd2,
  output [ 3:0] bcd1,
  output [ 3:0] bcd0
);

  wire [19:0] mod_result;
  wire [23:0] bcd;
  // 对输入取模1000000，得到0-999999的数值
  assign mod_result = bin % 20'd1000000;
  // 使用移位加3算法将20位二进制转换为6个BCD码
  bin2bcd u_bin2bcd (
    .bin(mod_result),
    .bcd(bcd)
  );
  // 将24位BCD码拆分为6个4位输出
  assign {bcd5, bcd4, bcd3, bcd2, bcd1, bcd0} = bcd;

endmodule

// 二进制转BCD模块（移位加3算法）




module bin2bcd (
  input      [19:0] bin,
  output reg [23:0] bcd
);
  reg     [43:0] shift_reg;  // 44位寄存器（24位BCD + 20位二进制）
  integer        i;
  always @(*) begin
    // 初始化移位寄存器
    shift_reg = {24'b0, bin};
    // 20次移位加调整
    for (i = 0; i < 20; i = i + 1) begin
      // 左移1位
      shift_reg = shift_reg << 1;
      // 对每个BCD位进行调整
      if (shift_reg[43:40] >= 4'd5) shift_reg[43:40] <= 3+shift_reg[43:40];  // 十万位
      if (shift_reg[39:36] >= 4'd5) shift_reg[39:36] <= 3+shift_reg[39:36];  // 万位
      if (shift_reg[35:32] >= 4'd5) shift_reg[35:32] <= 3+shift_reg[35:32];  // 千位
      if (shift_reg[31:28] >= 4'd5) shift_reg[31:28] <= 3+shift_reg[31:28];  // 百位
      if (shift_reg[27:24] >= 4'd5) shift_reg[27:24] <= 3+shift_reg[27:24];  // 十位
      if (shift_reg[23:20] >= 4'd5) shift_reg[23:20] <= 3+shift_reg[23:20];  // 个位
    end

    // 提取最终的BCD结果
    bcd = shift_reg[43:20];
  end

endmodule
