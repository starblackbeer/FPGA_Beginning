module edge_tell(clk, rst_n, data, neg, pos);
	input  clk, rst_n, data;
	output neg, pos;
	
	reg a, b;
	//此模块主要借助两个D触发器在级联时，能够记录当前时钟的信号和上一时钟的信号，在借助门电路进行逻辑判断
	assign neg = (~a & b);
	assign pos = (a & ~b);
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
		begin
			a <= 1'b0;
			b <= 1'b0;
		end
		else
		begin
			a <= data;
			b <= a;
		end
	end
endmodule