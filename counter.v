module counter(clock, start, reset, out);

	input clock;
	input start;
	input reset;
	output reg [2:0] out;

	always @(posedge clock)
	begin
		if(reset == 0 & start == 1)
			out <= out + 1'b1;
		else
			out <= 0;
	end

endmodule
