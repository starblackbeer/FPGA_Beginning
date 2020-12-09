`timescale 1ns/1ns
`define clock_period 20
module beep_test_tb();
	reg clk;
	reg rst;
	reg [31:0]cnt_default;
	reg mode;
	reg ena;
	
	wire [31:0]cnt_now;
	wire flag;
	
	beep_test beep_test_ins(
		.clk(clk),
		.rst(rst),
		.cnt_default(cnt_default),
		.mode(mode),
		.ena(ena),
		.cnt_now(cnt_now),
		.flag(flag)
	);
	initial clk <= 0;
	always #(`clock_period/2) clk <= ~clk;
	initial
	begin
		rst <= 1'b0;
		ena <= 1'b1;
		cnt_default <= 1'b0;
		mode <= 1'b0;
		/*循环定时模式，循环周期为1000*20 = 20000ns*,一共计时10个周期*/
		#(`clock_period*5) cnt_default <= 32'd1000;
		#(`clock_period*5) mode <= 1'b1; ena = 1'b0; rst <= 1'b1;
		#(`clock_period*10000) rst <= 1'b0; ena <= 1'b1;
		/*单次定时模式，循环周期为500*20 = 10000ns*,一共计时1个周期,时长4个周期*/
		#(`clock_period * 5) cnt_default <= 32'd500;
		#(`clock_period*5) mode <= 1'b0; ena <= 1'b0; rst <= 1'b1;
		#(`clock_period * 2000) $stop;
	end
endmodule
