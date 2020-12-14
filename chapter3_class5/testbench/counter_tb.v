`timescale 1ns/1ns
`define clock_period 20
module counter_tb;
	reg clk;
	wire cout;
	wire [19:0] q;
	reg cnt_en, aclr;
	
	counter counter_ins(
		.clock(clk),
		.q(q),
		.cout(cout),
		.cnt_en(cnt_en),
		.aclr(aclr)
	);
	
	initial clk = 1;
	always #(`clock_period/2) clk = ~clk;
	
	initial
	begin
		cnt_en = 1; aclr = 1'b0;
		#1000 aclr = 1'b1; 
		#1 aclr = 1'b0;
		#1000
		$stop;
	end
	
endmodule