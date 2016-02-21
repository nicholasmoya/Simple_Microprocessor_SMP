module reg16_bit(clock, load, INC, in, out);

	input clock, load, INC;
	input [15:0] in;
	output reg [15:0] out;
	
	always @(posedge clock)
	begin
		if (load == 1'b1)
			out = in;
		if (INC == 1'b1)
			out = out + 1'b1;
	end
		
endmodule

