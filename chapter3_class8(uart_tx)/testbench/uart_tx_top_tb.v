`timescale 1ns / 1ns
`define clock_period 20
module uart_tx_top_tb;
	reg clk, rst_n, key_in0;
	wire rs232_tx, led;

	uart_tx_top u0(
		.clk(clk),
		.rst_n(rst_n),
		.key_in0(key_in0),
		.rs232_tx(rs232_tx),
		.led(led)
	);
	
	initial clk = 0;
	always#(`clock_period/2) clk <= ~clk;

	initial
	begin
		rst_n <= 1'b0;
		key_in0 <= 1'b1;
		#5000 rst_n <= 1'b1;
		#5000 key_in0 <= 1'b0;
		#2_000_000 key_in0 <= 1'b1;
		#2_000_000 $stop;
	end
endmodule