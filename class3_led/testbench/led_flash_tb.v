`timescale 1ns/1ns
`define clock_period 20
module led_flash_tb;

	reg clk, rst;
	wire [3:0]led;

	led_flash #(.CNT_MAX(2499)) led_flash_ins(clk, rst, led);

	initial clk = 1;
	always #(`clock_period/2) clk <= !clk;
	
	initial 
	begin
		rst = 0;
		#(`clock_period*2) rst = 1;
		#(`clock_period*25000 + 1); 
		$stop;
	end
	
endmodule