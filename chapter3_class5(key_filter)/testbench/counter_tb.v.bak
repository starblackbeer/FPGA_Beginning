`timescale 1ns/1ns
`define clock_period 20
module edge_tell_tb;
	reg clk, rst_n, q;
	wire neg, pos;
	
	edge_tell edge_ins(
		.clk(clk),
		.rst_n(rst_n),
		.data(q),
		.neg(neg),
		.pos(pos)
	);
	
	initial clk = 1;
	always #(`clock_period/2) clk = ~clk;
	
	initial
	begin
		q = 1'b0;
		repeat(20)
		begin
			#100 q = 1'b1;
			#500 q =	1'b0;
		end
		#1000
		$stop;
	end
	
endmodule