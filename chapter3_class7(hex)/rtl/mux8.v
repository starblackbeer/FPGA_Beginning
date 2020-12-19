module mux8(
	input [31:0] data,
	input [7:0] sel,
	output reg [3:0] data_tmp
);
	always@(*)
	begin
		case(sel)
			8'b0000_0001:data_tmp = data[3:0];
			8'b0000_0010:data_tmp = data[7:4];
			8'b0000_0100:data_tmp = data[11:8];
			8'b0000_1000:data_tmp = data[15:12];
			8'b0001_0000:data_tmp = data[19:16];
			8'b0010_0000:data_tmp = data[23:20];
			8'b0100_0000:data_tmp = data[27:24];
			8'b1000_0000:data_tmp = data[31:28];
			default: data_tmp = 4'b0000;
		endcase
	end
endmodule