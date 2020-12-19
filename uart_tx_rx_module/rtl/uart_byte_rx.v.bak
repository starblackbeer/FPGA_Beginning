/***************************************************
*	Module Name		:	uart_byte_tx		   
*	Engineer		   :	朱东来
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2020-12-18
*	Revision		   :	v1.0
*	Description		:  串口发送模块设计
**************************************************/
module uart_byte_rx(
	input rs232_rx,
	input [2:0]baud_set,
	input clk,
	input rst_n,
	output reg [7:0]data_byte,
	output reg rx_done
);
reg [3:0] START_BIT;
reg [3:0] STOP_BIT;
reg uart_state;
/******************输入信号同步*********************/
	reg s0_rs232_rx, s1_rs232_rx;//同步寄存器
	reg tmp0_rs232_rx, tmp1_rs232_rx;//数据寄存器
	wire neg;//下降沿判断标志位
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)	begin
			s0_rs232_rx <= 1'b0;
			s1_rs232_rx <= 1'b0;
		end
		else begin
			s0_rs232_rx <= rs232_rx;
			s1_rs232_rx <= s0_rs232_rx;
		end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)	begin
			tmp0_rs232_rx <= 1'b0;
			tmp0_rs232_rx <= 1'b0;
		end
		else begin
			tmp0_rs232_rx <= s1_rs232_rx;
			tmp1_rs232_rx <= tmp0_rs232_rx;
		end
	end
	
	assign neg = !tmp0_rs232_rx & tmp1_rs232_rx;
/*****************采样时钟生成模块*******************/
	reg [15:0] bps_DR;
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			bps_DR <= 16'd324;
		else	begin
			case (baud_set)
				0:bps_DR <= 16'd324;
				1:bps_DR <= 16'd162;
				2:bps_DR <= 16'd80;
				3:bps_DR <= 16'd53;
				4:bps_DR <= 16'd26;
				default:bps_DR <= 16'd324;
			endcase
		end
	end
	
	reg [15:0] div_cnt;
	reg bps_clk;
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			div_cnt <= 1'b0;
		else if(uart_state)
			if(div_cnt == bps_DR)
				div_cnt <= 16'd0;
			else
				div_cnt <= div_cnt + 1'b1;
		else
			div_cnt <= 16'd0;	
	end
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			bps_clk <= 1'b0;
		else if(div_cnt == bps_DR)
			bps_clk <= 1'b1;
		else
			bps_clk <= 1'b0;
	end
/*****************采样时钟生成模块*******************/
	reg [7:0]bps_cnt;
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			bps_cnt <= 8'd0;
		else if(bps_cnt == 8'd159 || (bps_cnt == 8'd12 && (START_BIT > 2)))
			bps_cnt <= 8'd0;
		else if(bps_clk)
			bps_cnt <= bps_cnt + 1'b1;
		else
			bps_cnt <= bps_cnt;
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			rx_done <= 1'b0;
		else if(bps_cnt == 8'd159)
			rx_done <= 1'b1;
		else
			rx_done <= 1'b0;
	end
/*******************数据接收模块*********************/
	reg  [2:0] r_data_byte[7:0];
	always@(posedge clk or negedge rst_n)
	if(!rst_n)begin
		START_BIT = 3'd0;
		r_data_byte[0] <= 3'd0;
		r_data_byte[1] <= 3'd0;
		r_data_byte[2] <= 3'd0;
		r_data_byte[3] <= 3'd0;
		r_data_byte[4] <= 3'd0;
		r_data_byte[5] <= 3'd0;
		r_data_byte[6] <= 3'd0;
		r_data_byte[7] <= 3'd0;
		STOP_BIT = 3'd0;
	end
	else if(bps_clk)begin
		case(bps_cnt)
			0:begin
					START_BIT = 3'd0;
					r_data_byte[0] <= 3'd0;
					r_data_byte[1] <= 3'd0;
					r_data_byte[2] <= 3'd0;
					r_data_byte[3] <= 3'd0;
					r_data_byte[4] <= 3'd0;
					r_data_byte[5] <= 3'd0;
					r_data_byte[6] <= 3'd0;
					r_data_byte[7] <= 3'd0;
					STOP_BIT = 3'd0;			
				end
			6,7,8,9,10,11:START_BIT <= START_BIT + s1_rs232_rx;
			22,23,24,25,26,27:r_data_byte[0] <= r_data_byte[0] + s1_rs232_rx;
			38,39,40,41,42,43:r_data_byte[1] <= r_data_byte[1] + s1_rs232_rx;
			54,55,56,57,58,59:r_data_byte[2] <= r_data_byte[2] + s1_rs232_rx;
			70,71,72,73,74,75:r_data_byte[3] <= r_data_byte[3] + s1_rs232_rx;
			86,87,88,89,90,91:r_data_byte[4] <= r_data_byte[4] + s1_rs232_rx;
			102,103,104,105,106,107:r_data_byte[5] <= r_data_byte[5] + s1_rs232_rx;
			118,119,120,121,122,123:r_data_byte[6] <= r_data_byte[6] + s1_rs232_rx;
			134,135,136,137,138,139:r_data_byte[7] <= r_data_byte[7] + s1_rs232_rx;
			150,151,152,153,154,155:STOP_BIT <= STOP_BIT + s1_rs232_rx;
			default:
				begin
					START_BIT = START_BIT;
					r_data_byte[0] <= r_data_byte[0];
					r_data_byte[1] <= r_data_byte[1];
					r_data_byte[2] <= r_data_byte[2];
					r_data_byte[3] <= r_data_byte[3];
					r_data_byte[4] <= r_data_byte[4];
					r_data_byte[5] <= r_data_byte[5];
					r_data_byte[6] <= r_data_byte[6];
					r_data_byte[7] <= r_data_byte[7];
					STOP_BIT = STOP_BIT;						
				end
		endcase
	end
/********************数据输出****************************/
	always@(posedge clk or negedge rst_n)
	if(!rst_n)
		data_byte <= 8'd0;
	else if(bps_cnt == 8'd159)begin
		data_byte[0] <= r_data_byte[0][2];
		data_byte[1] <= r_data_byte[1][2];
		data_byte[2] <= r_data_byte[2][2];
		data_byte[3] <= r_data_byte[3][2];
		data_byte[4] <= r_data_byte[4][2];
		data_byte[5] <= r_data_byte[5][2];
		data_byte[6] <= r_data_byte[6][2];
		data_byte[7] <= r_data_byte[7][2];
	end	
/***********************传输标志位*************************/
	always@(posedge clk or negedge rst_n)
	if(!rst_n)
		uart_state <= 1'b0;
	else if(neg)
		uart_state <= 1'b1;
	else if(rx_done || (bps_cnt == 8'd12 && (START_BIT > 2)))
		uart_state <= 1'b0;
	else
		uart_state <= uart_state;		
endmodule