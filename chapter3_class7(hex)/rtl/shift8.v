module shift8(
	input clk,
	input rst_n,
	input en,
	output [7:0] sel
);
	reg [7:0] sel_r;
	
	initial sel_r = 8'b0000_0001;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			sel_r <= 8'b0000_0001;
		else if(sel_r == 8'b1000_0000)
			sel_r <= 8'b0000_0001;
		else
			sel_r <= sel_r << 1;
	end
	
	assign sel = en ? sel_r : 8'b0000_0000;
endmodule