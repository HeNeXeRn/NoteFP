module key_beep(
    input [7:0] key,
    input [1:0] pitch,
    input clk,
    input rst_n,
    input return,
    output beep,
     output reg [5:0] dig_pitch,
    output reg get_return

);

wire n;
reg [20:0] origin;
reg beep_get;

assign n=1;

always @(*)
begin
    case(pitch)
    2'b00:begin
        case(key)
            8'b11111110:origin='d95565;  //low
            8'b11111101:origin='d85120;
            8'b11111011:origin='d75849;
            8'b11110111:origin='d71591;
            8'b11101111:origin='d63775;
            8'b11011111:origin='d56817;
            8'b10111111:origin='d50617;
            8'b01111111:origin='d47773;  //middle
            default:origin=0;
        endcase
          dig_pitch=6'd22;
          
    end
    2'b01:begin
        case(key)
            8'b11111110:origin='d47773;  //middle
            8'b11111101:origin='d42567;
            8'b11111011:origin='d37918;
            8'b11110111:origin='d35790;
            8'b11101111:origin='d31887;
            8'b11011111:origin='d28408;
            8'b10111111:origin='d25308;
            8'b01111111:origin='d23820;  //high
            default:origin=0;
        endcase
          dig_pitch=6'd12;
    end
    2'b11:begin
        case(key)
            8'b11111110:origin='d23820;  //high
            8'b11111101:origin='d21281;
            8'b11111011:origin='d18960;
            8'b11110111:origin='d17896;
            8'b11101111:origin='d15943;
            8'b11011111:origin='d14204;
            8'b10111111:origin='d12654;
            8'b01111111:origin='d11949;  //higher
            default:origin=0;
        endcase
          dig_pitch=6'd18;
    end
    default:begin
        case(key)
            8'b11111110:origin='d47773;  //middle
            8'b11111101:origin='d42567;
            8'b11111011:origin='d37918;
            8'b11110111:origin='d35790;
            8'b11101111:origin='d31887;
            8'b11011111:origin='d28408;
            8'b10111111:origin='d25308;
            8'b01111111:origin='d23820;  //high
            default:origin=0;
        endcase
          dig_pitch=6'd12;
    end
    endcase
end

reg [20:0] counter;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        beep_get<=0;
        counter<=0;
    end
    else if(counter<origin)begin
        counter<=counter+1;
        beep_get<=beep_get;
    end
    else begin
        counter<=0;
        beep_get<=~beep_get;
    end
end

always@(posedge return or negedge rst_n)begin
    if(!rst_n) get_return=1;
    else begin
    if(return) get_return=0;
    else get_return=1;
    end
end

assign beep=beep_get;

endmodule