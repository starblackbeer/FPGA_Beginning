 module uart_tx_top(
	input clk,
	input rst_n,
	input key_in0,
	input [3:0] baud_set,
	input [7:0] data_byte,
	output rs232_tx,
	output tx_done
);
	wire key_flag, key_state;
	wire send_en;
	
	key_filter key_filter(
		.clk(clk),
		.rst_n(rst_n),
		.key_in(key_in0),
		.key_flag(key_flag),
		.key_state(key_state)
	);
	
	assign send_en = key_flag & !key_state;
	
	uart_byte_tx uart_byte_0(
		.clk(clk),
		.rst_n(rst_n),
		.send_en(send_en),
		.data_byte(data_byte),
		.baud_set(baud_set),
		.rs232_tx(rs232_tx),
		.tx_done(tx_done),
		.uart_state()
	);
	
	
endmodule