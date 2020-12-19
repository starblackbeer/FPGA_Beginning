`timescale 1ns/1ns
`define clock_period 20
module BCD_counter_tb;
	reg clk, cin, rst_n;
	wire cout;
	wire [3:0] q;
	
	BCD_counter BCD_counter_ins(
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
		repeat(30)begin
			cin = 1'b1;
			#`clock_period;
			cin = 1'b0;
			#(`clock_period*5);
		end
		#(`clock_period*20);
		$stop;
	end
endmodule