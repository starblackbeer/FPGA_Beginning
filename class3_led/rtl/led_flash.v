module led_flash(
//端口列表
	clk_50, 
	reset,
	led
);
//端口定义
	input clk_50;
	input reset;
	output reg[3:0] led;
	
	reg [24:0] cnt;
	
	parameter CNT_MAX = 25'd24_999_999;
	
	initial
	begin
		cnt <= 25'd0;
		led <= 4'b1110;
	end
	
	always@(posedge clk_50 or negedge reset)
	begin
		if(!reset) cnt <= 25'd0;
		else if(cnt == CNT_MAX) cnt <= 25'd0;
		else cnt <= cnt + 1'b1;
	end
	
	always@(posedge clk_50 or negedge reset)
	begin
		if(!reset)
		begin
			led <= 4'b1110;
		end
		else if(cnt == CNT_MAX)
		begin
//			case (led)
//			4'b0111: led <= 4'b1110;
//			4'b1110: led <= 4'b1101;
//			4'b1101: led <= 4'b1011;
//			4'b1011: led <= 4'b0111;
//			endcase
			led <= {led[2:0], led[3]};
		end
		else
			led <= led;
	end

endmodule