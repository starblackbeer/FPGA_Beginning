`timescale 1ns/1ns
`define clock_period 20
module BCD_counter_tb2;
	reg clk, cin, rst_n;
	wire cout;
	wire [11:0] q;
	
	BCD_counter_top BCD_counter_top_ins(
		.clk(clk),
		.cin(cin),
		.rst_n(rst_n),
		.cout(cout),
		.q(q)
	);
	initial clk <= 1'b1;
	always#(`clock_period/2) clk = ~clk;
	
	initial 
	begin
		rst_n = 1'b0;
		cin = 1'b0;
		#(`clock_period*200)
		rst_n = 1'b1;
		#(`clock_period*20)
		repeat(1000)begin
			cin = 1'b1;
			#`clock_period;
			cin = 1'b0;
			#(`clock_period*5);
		end
		#(`clock_period*20);
		$stop;
	end
endmodule