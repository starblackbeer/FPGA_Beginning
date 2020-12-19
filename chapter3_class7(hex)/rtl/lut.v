module lut(
	input [3:0] data_tmp,
	output reg [6:0] seg
);
	always@(*)
	begin
		case(data_tmp)
			4'h0: seg = 7'b100_0000;
			4'h1: seg = 7'b111_1001;
			4'h2: seg = 7'b010_0100;
			4'h3: seg = 7'b011_0000;
			4'h4: seg = 7'b001_1001;
			4'h5: seg = 7'b001_0010;
			4'h6: seg = 7'b000_0010;
			4'h7: seg = 7'b111_1000;
			4'h8: seg = 7'b000_0000;
			4'h9: seg = 7'b001_0000;
			4'ha: seg = 7'b000_1000;
			4'hb: seg = 7'b000_0011;
			4'hc: seg = 7'b100_0110;
			4'hd: seg = 7'b010_0001;
			4'he: seg = 7'b000_0110;
			4'hf: seg = 7'b000_1110;
		endcase
	end

endmodule