`timescale 1ns/1ns
`define clock_period 20

module counter_tb2;
	reg clk;
	reg cin;
	
	wire [7:0]out;
	reg cnt_en,sclr;
	
	counter counter0(
		.cin(cin),
		.clock(clk),
		.cnt_en(cnt_en),
		.q(out),
		.sclr(sclr)
	);
	
	initial clk = 0;
	always #(`clock_period/2) clk = ~clk;
	
	initial
	begin
		cnt_en = 1; cin = 0;
		#(`clock_period/2) cin = 1;
		#(`clock_period/2) cin = 0;
		#(`clock_period/2) cin = 1;
		#(`clock_period/2) cin = 0;
		#(`clock_period/2) cin = 1;
		#(`clock_period/2) cin = 0;
		#(`clock_period/2) cin = 1;
		#(`clock_period/2) cin = 0;
		#(`clock_period/2) cin = 1;
		#(`clock_period/2) cin = 0;
		#(`clock_period/2) cin = 1;
		#(`clock_period*5)
		$stop;
	end
	
	initial
	begin
		sclr = 0;
		#(`clock_period*2 + 5) sclr = 1;
		#(`clock_period-5) sclr = 0;
	end
endmodule