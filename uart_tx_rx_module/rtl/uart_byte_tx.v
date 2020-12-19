/***************************************************
*	Module Name		:	uart_byte_tx		   
*	Engineer		   :	朱东来
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 15.0
*	Create Date		:	2020-12-16
*	Revision		   :	v1.0
*	Description		:  uart发送模块设计
**************************************************/
module uart_byte_tx(
	input send_en,
	input [7:0] data_byte,
	input [2:0] baud_set,
	input clk,
	input rst_n,
	output reg rs232_tx,
	output reg tx_done,
	output reg uart_state
);
/********************波特率设置部分******************/
	reg [15:0] bps_DR;//分频计数值
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			bps_DR <= 16'd5207;
		else	begin
			case(baud_set)
				3'd0: bps_DR <= 16'd5207;
				3'd1: bps_DR <= 16'd2603;
				3'd2: bps_DR <= 16'd1301;
				3'd3: bps_DR <= 16'd867;
				3'd4: bps_DR <= 16'd433;
				default: bps_DR <= 16'd5207;
			endcase
		end
	end
	
	reg [15:0] div_cnt;//计数变量
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			div_cnt <= 16'd0;
		else if(uart_state)begin
			if(div_cnt == bps_DR)
				div_cnt <= 16'd0;
			else
				div_cnt <= div_cnt + 1'b1;
		end
		else
			div_cnt <= 16'd0;
	end
	
	reg bps_clk;//波特率时钟
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			bps_clk <= 1'b0;
		else if(div_cnt == bps_DR)
			bps_clk <= 1'b1;
		else
			bps_clk <= 1'b0;
	end
/********************数据发送时序控制******************/
	reg [3:0] bps_cnt;
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			bps_cnt <= 4'd0;
		else if(bps_cnt == 4'd11)
			bps_cnt <= 4'd0;
		else if(bps_clk)
			bps_cnt <= bps_cnt + 1'b1;
		else
			bps_cnt <= bps_cnt;
	end
/********************各标志位时序控制******************/
	always@(posedge clk or negedge rst_n)//tx_done的信号控制
	begin
		if(!rst_n)
			tx_done <= 1'b0;
		else if(bps_cnt == 4'd11)
			tx_done <= 1'b1;
		else
			tx_done <= 1'b0;
	end
	always@(posedge clk or negedge rst_n)//uart_state的信号控制
	begin
		if(!rst_n)
			uart_state <= 1'b0;
		else if(send_en)
			uart_state <= 1'b1;
		else if(bps_cnt == 4'd11)
			uart_state <= 1'b0;
		else
			uart_state <= uart_state;
	end
/*****************寄存器异步输入信号时钟同步******************/
	reg [7:0] r_data_byte;//同步输入的数据
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			r_data_byte <= 8'd0;
		else if(send_en)
			r_data_byte <= data_byte;
		else
			r_data_byte <= r_data_byte;
	end
/************************数据传输控制**********************/
	localparam START_BIT = 1'b0;
	localparam STOP_BIT = 1'b1;
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			rs232_tx <= 1'b1;
		else begin
			case(bps_cnt)
			0:rs232_tx <= 1'b1;
			1:rs232_tx <= START_BIT;
			2:rs232_tx <= r_data_byte[0];
			3:rs232_tx <= r_data_byte[1];
			4:rs232_tx <= r_data_byte[2];
			5:rs232_tx <= r_data_byte[3];
			6:rs232_tx <= r_data_byte[4];
			7:rs232_tx <= r_data_byte[5];
			8:rs232_tx <= r_data_byte[6];
			9:rs232_tx <= r_data_byte[7];
			10:rs232_tx <= STOP_BIT;
			default: rs232_tx <= 1'b1;
			endcase
		end
	end
endmodule