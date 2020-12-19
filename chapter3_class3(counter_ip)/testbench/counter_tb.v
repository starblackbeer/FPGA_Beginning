`timescale 1ns/1ns
`define clock_period 20

module counter_tb;
	reg cin;
	reg clk;
	
	wire [3:0]out;
	wire cout;
	
	counter counter0(
		.cin(cin),
		.clock(clk),
		.cout(cout),
		.q(out)
	);
	
	initial clk = 1;
	always #(`clock_period/2) clk = ~clk;
	
	initial
	begin
		#5 ;
		repeat(20) begin
			cin = 1'b0;
			#(`clock_period/2) cin = 1'b1;
			#(`clock_period/2) cin = 1'b0;
		end
		#(`clock_period*200);
		$stop;
	end
	
endmodule