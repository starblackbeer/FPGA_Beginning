`timescale 1ns/1ns
module key_filter(clk, rst_n, key_in, key_flag, key_state);
	input clk, rst_n, key_in;
	output key_flag, key_state;
	
	wire key, cout;
	wire neg, pos;
	wire [19:0] q;
	reg key_flag, key_state;
	reg cnt_en, aclr;
	reg [3:0] state;
	
	localparam
		IDLE = 4'b0001,	//闲置状态
		FILTER0 = 4'b0010,//按下判断状态
		DOWN = 4'b0100,	//按下状态
		FILTER1 = 4'b1000;//弹起判断状态
	
	initial
	begin
		key_state <= 1'b1;//按键按下和弹起的状态指示
		key_flag <= 1'b0;//按键状态变化指示
		state <= IDLE;//状态机状态变量
		cnt_en <= 1'b0;//计数器计数使能信号
		aclr <= 1'b0;//异步清零信号
	end
	
	sync_trigger sync_ins(//用于将按键的输入和时钟信号同步，输出为key，此处使用了两个D触发器
		.clk(clk),
		.rst_n(rst_n),
		.key_in(key_in),
		.key_out(key)
	);
	
	edge_tell edge_ins(//判断按键的上升沿和下降沿，具体实现见edge_tell.v文件，也是使用了两个D触发器
		.clk(clk),
		.rst_n(rst_n),
		.data(key),
		.neg(neg),
		.pos(pos)
	);
	
	counter counter0(	//使用IP核中自带的lpm_counter模块
		.clock(clk),
		.cout(cout),
		.q(q),
		.cnt_en(cnt_en),
		.aclr(aclr)
	);

	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
		begin
			key_state <= 1'b1;
			key_flag <= 1'b0;
			state <= IDLE;	
			cnt_en <= 1'b0;
		end
		else
		begin
			case (state)
			IDLE://闲置状态时主要判断是否有按下操作，有则进入下一状态，同时使能计数器，否则保持原状态
				begin
					key_flag <= 1'b0;
					if(neg)
					begin
						state <= FILTER0;
						cnt_en <= 1'b1;
					end
					else
						state <= IDLE;
				end
			FILTER0://按下判断状态，如果出现弹起操作，则清零并关闭计数器，返回上一状态，若计数器计数完毕，则进入下一状态，否则一直等待	
			begin
				if(cout)
				begin
					cnt_en <= 1'b0;
					state <= DOWN;
					key_state <= 1'b0;
					key_flag <= 1'b1;
				end
				else if(pos)
				begin
					cnt_en <= 1'b0;
					state <= IDLE;
					aclr <= 1'b1;
					#5 aclr <= 1'b0;
				end
				else
					state <= FILTER0;
			end
			DOWN://按下状态，如果出现弹起操作，使能计数器并进入下一状态，否则保持原状态
				begin
					key_flag <= 1'b0;
					if(pos)
					begin
						state <= FILTER1;
						cnt_en <= 1;
					end
					else
						state <= DOWN;
				end
			FILTER1://弹起判断状态，如果出现按下操作，则清零计数器并关闭计数器，返回原状态，若计数器计数已完成则进入IDLE状态，否则等待
				begin
					if(cout)
					begin
						cnt_en <= 1'b0;
						state <= IDLE;
						key_state <= 1'b1;
						key_flag <= 1'b1;
					end
					else if(neg)
					begin
						cnt_en <= 1'b0;
						state <= DOWN;
						aclr <= 1'b1;
						#5 aclr <= 1'b0;
					end
					else
						state <= FILTER1;
				end
			endcase
		end
	end

endmodule