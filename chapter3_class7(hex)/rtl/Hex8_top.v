module Hex8_top(
	input clk,
	input rst_n,
	input en,
	input [31:0] disp_data,
	output [6:0]seg,
	output [7:0]sel
);
	wire clk_1k;
	wire [3:0] data_tmp;
	//分频模块
	divder divder_0(
		.clk(clk),
		.rst_n(rst_n),
		.clk_1k(clk_1k)
	);
	//移位寄存器
	shift8 shift8_0(
		.clk(clk_1k),
		.rst_n(rst_n),
		.en(en),
		.sel(sel)
	);
	//扫描，获得每位数码管显示的数字
	mux8 mux8_0(
		.data(disp_data),
		.sel(sel),
		.data_tmp(data_tmp)
	);
	//得到数码管的显示阵列
	lut lut_0(
		.data_tmp(data_tmp),
		.seg(seg)
	);
endmodule