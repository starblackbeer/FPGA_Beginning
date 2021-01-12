module rom_top(
	input clk,
	input rst_n,
	output [7:0]q
);
	reg [7:0] addr; 
	
	rom rom(
		.address(addr),
		.clock(clk),
		.q(q)
	);
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			addr <= 8'd0;
		else
			addr <= addr + 1'b1;
	end
	
endmodule