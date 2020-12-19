/***************************************************
*	Module Name		:	uart_tx_rx		   
*	Engineer		   :	朱东来
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 15.0
*	Create Date		:	2020-12-19
*	Revision		   :	v1.0
*	Description		:  uart发送接收顶层模块
**************************************************/
module uart_tx_rx_top(
	input clk,//时钟信号
	input rst_n,//复位信号
	input [2:0]baud_set,//波特率选择,0:9600 1:19200 2:38400 3:57600 4:115200，默认9600
	input send_en,//发送使能，使能保持一个时钟周期即有效
	input [7:0]data_byte_tx,//需要发送的字节
	input rs232_rx,//接收到的1bit信息，分配到板子上的uart_rx
	output rs232_tx,//发送的1bit信息分配到板子上的uart_tx
	output [7:0]data_byte_rx,//接收到的字节
	output rx_done,//接受成功标志位
	output tx_done//发送成功标志位
);	
	reg [7:0]data_byte_rx_r;
//	wire [7:0]data_byte_tx;
	
	uart_byte_rx uart_rx(
		.clk(clk),
		.rst_n(rst_n),
		.baud_set(baud_set),
//		.baud_set(3'd0),
		.data_byte(data_byte_rx),
		.rs232_rx(rs232_rx),
		.rx_done(rx_done)
	);
	uart_byte_tx uart_byte_0(
		.clk(clk),
		.rst_n(rst_n),
		.send_en(send_en),
		.data_byte(data_byte_tx),
		.baud_set(baud_set),
//		.baud_set(3'd0),
		.rs232_tx(rs232_tx),
		.tx_done(tx_done),
	);
//	uart_tx_top uart_tx_top(
//		.clk(clk),
//		.rst_n(rst_n),
//		.baud_set(baud_set),
//		.baud_set(3'd0),
//		.key_in0(send_en),
//		.data_byte(data_byte_tx),
//		.rs232_tx(rs232_tx),
//		.tx_done(tx_done)
//	);
	
//	always@(posedge clk or negedge rst_n)
//	begin
//		if(!rst_n)
//			data_byte_rx_r <= 8'd0;
//		else if(rx_done)
//			data_byte_rx_r <= data_byte_rx;
//		else
//			data_byte_rx_r <= data_byte_rx;
//	end
	
//	ISSP ISSP(
//		.probe(data_byte_rx_r),
//		.source(data_byte_tx)
//	);
endmodule