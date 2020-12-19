 module uart_tx_top(
	input clk,
	input rst_n,
	input key_in0,
	output rs232_tx,
	output led
);
	wire key_flag, key_state;
	wire send_en;
	wire [7:0] data_byte;
	wire led1;
	
	assign led = ~led1;
	
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
		.baud_set(3'd0),
		.rs232_tx(rs232_tx),
		.tx_done(),
		.uart_state(led1)
	);
	
	uart_data u0(
		.source(data_byte),
		.probe()
	);
	
endmodule