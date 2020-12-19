module Hex_top(
	input clk,
	input rst_n,
	input en,
	output DS,
	output SH_CP,
	output ST_CP
);
	wire [31:0] disp_data;
	wire [7:0] sel;
	wire [6:0] seg;
	
	hex_data hex_data0(
		.probe(),
		.source(disp_data)
	);
	
	Hex8_top Hex8_top0(
		.clk(clk),
		.rst_n(rst_n),
		.en(1'b1),
		.disp_data(disp_data),
		.sel(sel),
		.seg(seg)
	);
	
	HC595_Driver HC595_Driver0(
		.Clk(clk),
		.Rst_n(rst_n),
		.Data({1'b1,seg,sel}),
		.S_EN(1'b1),
		.SH_CP(SH_CP),
		.ST_CP(ST_CP),
		.DS(DS)
	);
endmodule