module get_notes_spec(
    input clk,
    input rst_n,
    input [4:0] j,
    output beep
);

wire n;
reg [20:0] origin;
reg beep_get;

assign n=1;

always @(*)begin

if(!rst_n)begin
	origin=0;
end

else
	begin
    case(j)
    'd1:origin='d95565;  //low
    'd2:origin='d85120;
    'd3:origin='d75849;
    'd4:origin='d71591;
    'd5:origin='d63775;
    'd6:origin='d56817;
    'd7:origin='d50617;
    'd8:origin='d47773;  //middle
    'd9:origin='d42567;
    'd10:origin='d37918;
    'd11:origin='d35790;
    'd12:origin='d31887;
    'd13:origin='d28408;
    'd14:origin='d25308;
    'd15:origin='d23820;  //high
    'd16:origin='d21281;
    'd17:origin='d18960;
    'd18:origin='d17896;
    'd19:origin='d15943;
    'd20:origin='d14204;
    'd21:origin='d12654;  //higher
    'd22:origin='d11949;
    'd23:origin='d10633;
    'd24:origin='d9483;
    'd25:origin='d8947;
    'd26:origin='d7971;
    'd27:origin='d7101;
    'd28:origin='d6324;
    default:origin='d0;
    endcase     
	end

end

reg [20:0] counter;

always @(posedge clk) begin
    if(counter<origin)begin
        counter<=counter+1;
        beep_get<=beep_get;
    end
    else begin
        counter<=0;
        beep_get<=~beep_get;
    end
end

assign beep=beep_get;

endmodule