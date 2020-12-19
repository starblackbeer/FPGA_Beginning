module counter_top(cin, clk, cout, q);
	input cin;
	input clk;
	
	output cout;
	output [7:0] q;
	
	wire cout0;

	counter counter0(
		.cin(cin),
		.clock(clk),
		.cout(cout0),
		.q(q[3:0])
	);

	counter counter1(
		.cin(cout0),
		.clock(clk),
		.cout(cout),
		.q(q[7:4])
	);

endmodule