module uart_rx_top(
	input clk,
	input rst_n,
	input rs232_rx
);
	wire [7:0]data_byte;
	reg [7:0]data_byte_r;
	wire rx_done;
	
	uart_byte_rx u_rx0(
		.rs232_rx(rs232_rx),
		.baud_set(3'd0),
		.clk(clk),
		.rst_n(rst_n),
		.data_byte(data_byte),
		.rx_done(rx_done)
	);
	
	uart_data u0(
		.probe(data_byte_r)
	);
	
	uart_byte_tx u_tx0();
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			data_byte_r <= 8'd0;
		else if(rx_done)
			data_byte_r <= data_byte;
		else
			data_byte_r <= data_byte_r;
	end
endmodule