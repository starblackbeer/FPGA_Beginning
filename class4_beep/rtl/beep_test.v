/*功能介绍：

	该定时器的定时时间参数可以通过该模块的一个端口输入，通过调节端口上输入数据的值，就能修改其定时时间。
设置一个计数模式控制信号，当该信号为1时，设置为循环定时模式，当该信号为0时，设置为单次定时模式。
设置一个计数启动信号，在循环定时模式下，该信号为高电平使能计时，为低电平则停止计时。在单次计数模式下，
该信号的一个单基准时钟周期的脉冲使能一次定时。输出计数器实时计数值，该值将用于产生特定占空比的方波。
*/
module beep_test(
	clk,
	rst,
	
	cnt_default,
	mode,
	ena,
	
	cnt_now,
	flag
);
//变量声明必须在变量使用的行号前
	input clk, rst, mode, ena;
	input [31:0]cnt_default;
	output [31:0]cnt_now;
	output flag;
	
	reg [31:0]cnt;
	reg oneshot;
	
	assign cnt_now = cnt;
	assign flag = (cnt_now >= cnt_default);
//always@()必须对敏感变量进行判断
	always@(posedge clk or negedge rst)
	begin
		if(!rst) cnt <= 0;
		else if(mode)
		begin
			if(!ena && cnt < cnt_default)
				cnt <= cnt + 1'b1;
			else
				cnt <= 1'b0;
		end
		else if(!mode)
		begin
			if(oneshot)
				cnt <= cnt + 1'b1;
			else 
				cnt <= 1'b0;
		end
	end
	
	initial oneshot <= 1'b0;
	
	always@(posedge clk or negedge rst)
	begin
		if(!rst) oneshot <= 1'b1;
		else if(!mode)
		begin
			if(flag) oneshot <= 1'b0;
			else if(ena) oneshot <= 1'b0;
		end
	end
	
endmodule