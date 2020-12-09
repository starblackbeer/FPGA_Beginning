module beep_top(
	clk,
	rst,
	ena,
	beep
);
	input clk, rst, ena;
	output beep;
	wire [31:0] cnt_now;
	beep_test beep_test0(
		.clk(clk),
		.rst(rst),
		.cnt_default(32'd49999),
		.mode(1'b1),
		.ena(ena),
		.cnt_now(cnt_now),
		.flag()
	);
	assign beep = (cnt_now >= 25000)? 1'b1 : 1'b0;
	
endmodule