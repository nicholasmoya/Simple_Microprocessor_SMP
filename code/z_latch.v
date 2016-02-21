module z_latch(clock, in, load, out);

	input clock;
	input in;
	input load;
	output reg out;

	always @(posedge clock)
	begin
		if(load == 1)
			out <= in;
	end

endmodule
