module reg8_bit(clock, load, in, out);

	input clock, load;
	input [7:0] in;
	output reg [7:0] out;
	
	always @(posedge clock)
	begin
		if (load == 1'b1)
			out <= in;
	end
		
endmodule
