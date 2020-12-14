	module led_ctrl(
	input clk,
	input rst_n,
	input key_flag0,
	input key_state0,
	input key_flag1,
	input key_state1,
	output [3:0]led
);
	reg [3:0]led_r;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			led_r <= 4'b0000;
		else if(key_flag0 && !key_state0)
			led_r <= led_r + 1'b1;
		else if(key_flag1 && !key_state1)
			led_r <= led_r - 1'b1;
		else led_r <= led_r;
	end

	assign led = ~led_r;
endmodule