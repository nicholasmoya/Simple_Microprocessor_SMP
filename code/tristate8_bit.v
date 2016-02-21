module tristate8_bit(in, enable, out);

	input [7:0] in;
	input enable;
	output reg [7:0] out;
	
	always @(*)
	begin
	out = (enable) ? in : 8'bzzzz_zzzz;
	end

endmodule
