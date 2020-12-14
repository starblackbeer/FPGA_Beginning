module BCD_counter(clk, rst_n, cin, cout, q);
	input clk, rst_n, cin;
	output cout;
	output [3:0]q;
	
	reg [3:0]cnt;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(rst_n == 0)
			cnt <= 4'd0;
		else if(cin == 1'b1)begin
			if(cnt == 4'd9)
				cnt <= 4'd0;
			else
				cnt <= cnt + 1'b1;
		end
	end
/*此处如果将cout进位信号作为reg类型会导致计数器级联时，下一级的进位信号产生延迟，因此设置为wire类型，满足条件立即生效
	always@(posedge clk or negedge rst_n)
	begin
		if(rst_n == 0)
			cout <= 1'b0;
		else if(cnt == 4'd9 && cin == 1'b1)
			cout <= 1'b1;
		else
			cout <= 1'b0;
	end
*/	
	assign cout = (cnt == 4'd9 && cin == 1 && rst_n);
	assign q = cnt;
	
endmodule