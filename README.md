# FPGA 音乐项目

这个FPGA项目实现了多种音乐演奏与学习功能，通过硬件按钮、开关、LED和数码管提供交互式体验。项目包含五个核心功能模块，通过状态机进行模式切换。

**目录**

[toc]

## 代码结构


```
fpga_music_project/
├── Buzzer.v                   // 蜂鸣器驱动模块
├── char_set.v                 // 数码管字符集定义
├── counter_10bit.v            // 10位计数器
├── counter_16bit.v            // 16位计数器
├── debouncing.v               // 单按键消抖模块
├── debouncing_all.v           // 多按键消抖模块
├── DIG.v                      // 数码管显示驱动
├── get_notes.v                // 音符获取模块
├── key_beep.v                 // 自主弹奏功能模块
├── player.v                   // 通用播放器模块
├── select.v                   // 模式选择模块
├── select_content.v           // 模式内容选择
├── suspend.v                  // 暂停功能模块
├── top.v                      // 系统顶层模块
├── README.md                  // 项目文档
│
├── autoPlay/                  // 自动播放功能
│   ├── auto.v                // 自动播放顶层模块
│   ├── auto_music1.v         // 预置乐曲1
│   ├── auto_music3.v         // 预置乐曲3
│   ├── auto_music4.v         // 预置乐曲4
│   └── auto_select.v         // 自动播放选择控制
│
├── Programmable/              // 可编程功能
│   ├── alu32bit.v            // 32位ALU单元
│   ├── calculator.v          // 可编程模式顶层
│   ├── comparator_8bit.v     // 8位比较器
│   ├── DecDisplay.v          // 十进制显示模块
│   ├── editor.v              // 程序编辑器
│   ├── processor.v           // 指令处理器
│   ├── program_reg.v         // 程序寄存器
│   └── reg_8bit.v            // 8位寄存器
│
└── prompts/                  // 提示弹奏功能
    ├── get_notes_spec.v     // 特定乐曲音符获取
    ├── note_to_buzzer.v     // 音符到蜂鸣器转换
    ├── note_to_LED.v        // 音符到LED转换
    ├── prompt.v             // 提示弹奏顶层
    ├── prompt_select.v      // 提示曲目选择
    ├── songbook.v           // 曲库存储
    └── tip_music1.v         // 预置提示乐曲1
```

## 主要功能模块

### 1. 选择模式 (select.v)
- 系统初始状态，用于选择其他功能
- 数码管显示当前模式选项
- 通过按钮切换和确认模式选择

### 2. 自主弹奏功能 (key_beep.v)
- 实时响应按键输入并播放对应音符
- 支持音调调节(switch[7:6])
- 数码管显示当前音调信息

### 3. 自动播放功能 (autoPlay/)
- 预置多首乐曲(auto_music1.v, auto_music3.v, auto_music4.v)
- 支持曲目选择(auto_select.v)
- 播放控制(暂停/继续/上一首/下一首)
- 数码管显示当前播放状态

### 4. 提示弹奏功能 (prompts/)
- LED提示需要按下的按键(note_to_LED.v)
- 音符到蜂鸣器转换(note_to_buzzer.v)
- 曲库管理(songbook.v)
- 支持暂停和继续功能

### 5. 可编程功能 (Programmable/)
- 简易编程环境(editor.v)
- 32位ALU处理单元(alu32bit.v)
- 程序存储(program_reg.v)
- 指令执行(processor.v)
- 数码管显示编程界面(DecDisplay.v)

## 公共模块

### 显示驱动
- **DIG.v**: 数码管显示驱动
- **char_set.v**: 数码管字符集定义

### 输入处理
- **debouncing.v**: 单按键消抖
- **debouncing_all.v**: 多按键消抖

### 音频处理
- **Buzzer.v**: 蜂鸣器驱动
- **get_notes.v**: 音符频率生成

### 系统控制
- **suspend.v**: 暂停功能
- **player.v**: 通用播放器
- **counter_10bit.v/counter_16bit.v**: 通用计数器

## 顶层模块 (top.v)
集成所有功能模块，通过状态机(state[2:0])切换不同工作模式：
- state 0: 选择模式
- state 1: 自主弹奏
- state 2: 自动播放
- state 3: 提示弹奏
- state 4: 可编程模式

## 使用说明
1. 上电后自动进入选择模式(状态0)
2. 使用按钮选择功能模式：
   - Key[0]: 上一个模式
   - Key[7]: 确认进入当前模式
3. 各模式操作：
   - 自主弹奏：直接按下音符按钮
   - 自动播放：使用按钮控制播放
   - 提示弹奏：按照LED提示按下按钮
   - 可编程：使用开关和按钮创建音乐程序
4. 任何时候按下switch[0]返回选择模式

# script辅助脚本

这个文件夹包含多个用于处理字符编码、数码管显示和歌曲录入的实用脚本工具。

## 项目结构

```bash
.
├── input.txt           # 主程序通用输入文件
├── output.txt          # 主程序通用输出文件
│
├── build/              # 编译生成的可执行文件
│   ├── Encode.exe
│   └── Record_the_Song.exe
│
├── in/                 # 测试输入文件
│   ├── in0.txt
│   └── in1.txt
│
├── out/                # 测试输出文件
│   ├── out0.txt
│   └── out1.txt
│
└── src/                # 源代码文件
    ├── 字符编码.cpp      # 字符编码转换工具
    ├── 数码管.html      # 数码管显示编码转换器
    ├── 数码管编码.cpp    # 数码管编码生成器
    └── 歌曲录入.cpp      # 歌曲信息录入系统
```

## 工具说明

### 1. 字符编码转换工具 (`字符编码.cpp`)
将输入的字符转换成char_set.v中定义的二进制编码

### 2. 数码管编码生成器 (`数码管编码.cpp`)
将存有数码管对应显示段的编码集按顺序转换成char_set编码的代码

### 3. 数码管显示转换器 (`数码管.html`)
点击对应7段数码管的灯段可让该灯段亮灭，页面底端会显示该显示内容灯段的编码

### 4. 歌曲录入系统 (`歌曲录入.cpp`)
将歌曲简谱转换成verilog代码




