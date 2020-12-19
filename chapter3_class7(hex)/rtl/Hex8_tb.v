`timescale 1ns / 1ns
`define clock_period 20
module Hex8_tb;
	reg clk, rst_n, en;
	reg [31:0] disp_data;
	wire [6:0]seg;
	wire [7:0]sel;
	Hex8_top Hex8_top_1(
		.clk(clk),
		.rst_n(rst_n),
		.en(en),
		.disp_data(disp_data),
		.seg(seg),
		.sel(sel)
	);
	initial clk = 0; 
	always #(`clock_period/2) clk = ~clk;
	
	initial
	begin
		rst_n = 1'b0;
		en = 1'b1;
		disp_data = 32'h1234_5678;
		#(`clock_period*20)
		rst_n = 1'b1;
		#(`clock_period*20);
		disp_data = 32'h8765_4321;
		#20_000_000;
		disp_data = 32'h89ab_cdef;
		#20_000_000;
		$stop;
	end
	
endmodule