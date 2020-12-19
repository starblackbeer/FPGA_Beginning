module divder(
	input clk,
	input rst_n,
	output reg clk_1k
);
	reg [15:0] cnt;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			cnt <= 15'b0;
		else if(cnt == 15'd24_999)
			cnt <= 15'b0;
		else
			cnt <= cnt + 1'b1;
	end
	always@(posedge clk or negedge rst_n)
		if(!rst_n)
			clk_1k <= 1'b0;
		else if(cnt == 15'd24_999)
			clk_1k <= ~clk_1k;
		else
			clk_1k <= clk_1k;
endmodule