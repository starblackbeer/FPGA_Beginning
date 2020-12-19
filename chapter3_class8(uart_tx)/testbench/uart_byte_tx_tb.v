`timescale 1ns / 1ns
`define clock_period 20
module uart_byte_tx_tb;
	reg send_en, clk, rst_n;
	reg [2:0] baud_set;
	reg [7:0] data_byte;
	
	wire uart_state, tx_done, rs232_tx;
	uart_byte_tx uart_0
	(
		.send_en(send_en),
		.data_byte(data_byte),
		.baud_set(baud_set),
		.clk(clk),
		.rst_n(rst_n),
		.rs232_tx(rs232_tx),
		.tx_done(tx_done),
		.uart_state(uart_state)
	);

	initial clk <= 0;
	always#(`clock_period/2) clk <= ~clk;
	
	initial
	begin

		rst_n <= 0;
		baud_set <= 3'd0;
		send_en <= 1'b0;
		data_byte <= 8'd24;
		#5000;
		rst_n <= 1'b1;
		send_en <= 1'b1;
		#(`clock_period) send_en <= 1'b0;
		
		wait(tx_done) #100000;
		data_byte <= 8'b0101_0101;
		send_en <= 1'b1;
		#(`clock_period) 
		send_en <= 1'b0;
		wait(tx_done) #5000 $stop;
	end
	
endmodule