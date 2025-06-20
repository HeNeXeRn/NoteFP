module DIG(
input clk,
input [5:0] dig_in1,
input [5:0] dig_in2,
input [5:0] dig_in3,
input [5:0] dig_in4,
input [5:0] dig_in5,
input [5:0] dig_in6,
input rst_n,
input switch,
output reg [7:0] dig_out,
output reg [5:0] digCS_out
);

reg [17:0] cnt;
reg [26:0] cnt_k;
parameter T=50000;
parameter F=20000000;
reg [3:0] num;
reg state;
reg clk_m;
reg [5:0] CS;
reg [5:0] mid_CS;
reg [5:0] code_data;
wire [7:0] mid_dig_out;

always@(posedge clk)begin
    if(!rst_n)begin
        cnt<=0;
        clk_m<=0;
    end
    else if(cnt<T-1)begin
        cnt<=cnt+1;
        clk_m<=clk_m;
    end
    else begin
        cnt<=0;
        clk_m<=~clk_m;
    end
end

always@(posedge clk_m)begin
    if(!state)
        num<=7;
    else if(num<5)
        num<=num+1;
    else
        num<=0;
end

always@(posedge clk_m or negedge rst_n)begin
    if(!rst_n)begin
        mid_CS<=6'b111111;
    end
    else begin
        case(num)
        0:begin
            mid_CS<=6'b011111;
        end
        1:begin
            mid_CS<=6'b101111;
        end
        2:begin
            mid_CS<=6'b110111;
        end
        3:begin
            mid_CS<=6'b111011;
        end
        4:begin
            mid_CS<=6'b111101;
        end
        5:begin
            mid_CS<=6'b111110;
        end
        default:begin
            mid_CS<=6'b111111;
        end
        endcase
    end
end

always@(*) begin
    CS=~mid_CS;
end

always@(*) begin
    digCS_out=mid_CS;
end

always@(posedge clk_m) begin
    if(!rst_n)begin
        code_data<=0;
    end
    else begin
        case(CS)
        6'b100000:code_data<=dig_in2;
        6'b010000:code_data<=dig_in3;
        6'b001000:code_data<=dig_in4;
        6'b000100:code_data<=dig_in5;
        6'b000010:code_data<=dig_in6;
        6'b000001:code_data<=dig_in1;
        default:code_data<=0;
        endcase
    end
end

char_set U1(code_data,mid_dig_out);

always@(*)begin
    dig_out={mid_dig_out[0],mid_dig_out[1],mid_dig_out[2],mid_dig_out[3],mid_dig_out[4],mid_dig_out[5],mid_dig_out[6],mid_dig_out[7]};
end

always@(posedge clk)begin
    if(switch)begin
        state<=1;
    end
    else begin
        if(!rst_n)begin
            state<=0;
            cnt_k<=0;
        end
        else if(cnt_k<F-1)begin
            cnt_k<=cnt_k+1;
            state<=state;
        end
        else begin
            state<=~state;
            cnt_k<=0;
        end
    end
end

endmodule