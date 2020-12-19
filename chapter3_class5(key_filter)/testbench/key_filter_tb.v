`timescale 1ns/1ns
`define clock_period 20

module key_filter_tb;
	reg clk, rst_n, key_in;
	wire key_flag, key_state;

	key_filter key_filter_ins(
		.clk(clk),
		.rst_n(rst_n),
		.key_in(key_in),
		.key_flag(key_flag),
		.key_state(key_state)
	);
	
	initial clk = 1'b1;
	always #(`clock_period/2) clk = ~clk;
	
	initial
	begin
		rst_n = 1'b0; key_in = 1'b1;
		#1000 rst_n = 1'b1;
		/**反复横跳**/
		#1000 key_in = 1'b0;
		#1000 key_in = 1'b1;
		#1000 key_in = 1'b0;
		#1000 key_in = 1'b1;
		#1000 key_in = 1'b0;
		/**按下**/
		#205_000 key_in = 1'b1;
		#1000 key_in = 1'b0;
		#1000 key_in = 1'b1;
		#1000 key_in = 1'b0;
		#1000 key_in = 1'b1;
		#195_000 key_in = 1'b0;
		#1000 key_in = 1'b1;
		/**弹起**/
		#205_000 key_in = 1'b1;
		#1000 $stop;
	end
endmodule