module tristate16_bit(in, enable, out);

	input [15:0] in;
	input enable;
	output reg [15:0] out;
	
	always @(*)
	begin
	out = (enable) ? in : 16'bzzzz_zzzz_zzzz_zzzz;
	end

endmodule
