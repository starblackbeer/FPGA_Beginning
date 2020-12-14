module BCD_counter_top(clk, cin, rst_n, cout, q);
	input clk, cin, rst_n;
	output cout;
	output [11:0] q;
	
	wire cout0, cout1;
	/***在仿真波形中BCD的二进制为1001_1001_1001，转换为10进制或16进制≠999***/
	BCD_counter BCD_counter0(
		.clk(clk),
		.cin(cin),
		.rst_n(rst_n),
		.cout(cout0),
		.q(q[3:0])
	);
	
	BCD_counter BCD_counter1(
		.clk(clk),
		.cin(cout0),
		.rst_n(rst_n),
		.cout(cout1),
		.q(q[7:4])
	);
	
	BCD_counter BCD_counter2(
		.clk(clk),
		.cin(cout1),
		.rst_n(rst_n),
		.cout(cout),
		.q(q[11:8])
	);
	
	
endmodule