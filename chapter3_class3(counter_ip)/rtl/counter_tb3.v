`timescale 1ns/1ns
`define clock_period 20

module counter_tb3;
	reg cin;
	reg clk;
	
	wire [7:0]q;
	wire cout;
	
	counter_top counter_top_ins(
		.cin(cin),
		.clk(clk),
		.cout(cout),
		.q(q)
	);
	
	initial clk = 1;
	always #(`clock_period/2) clk = ~clk;
	
	initial
	begin
		repeat(300) begin
			cin = 1'b0;
			#(`clock_period*5) cin = 1'b1;
			#(`clock_period) cin = 1'b0;
		end
		#(`clock_period*200);
		$stop;
	end
	
endmodule