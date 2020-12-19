`timescale 1ns / 1ns
`define clock_period 20
module key_led_tb;
	reg clk, rst_n, key_in0, key_in1;
	wire [3:0] led;
	
	key_led_top key_led_top0(
		.clk(clk),
		.rst_n(rst_n),
		.key_in0(key_in0),
		.key_in1(key_in1),
		.led(led)
	);
	
	initial clk = 0;
	always#(`clock_period/2) clk = ~clk;
	
	initial
	begin
		rst_n = 1'b0; key_in0 = 1'b1; key_in1 = 1'b1;
		#5000 rst_n = 1'b1;
		#5000 key_in0 = 1'b0;
		#5000 key_in0 = 1'b1;
		#5000 key_in0 = 1'b0;
		#5000 key_in0 = 1'b1;
		#5000 key_in0 = 1'b0;
		#5000 key_in0 = 1'b1;
		#5000 key_in1 = 1'b0;
		#5000 key_in1 = 1'b1;
		#5000 key_in1 = 1'b0;
		#5000 key_in1 = 1'b1;
		#5000 key_in1 = 1'b0;
		#5000 $stop;
	end

endmodule