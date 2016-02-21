module PC(clock, PCload, INC, in, out);
	
	input clock, INC, PCload;
	input [15:0] in;
	output reg [15:0] out;

	always @(posedge clock)
	begin
		if(INC == 1)
			out = out + 1'b1;
		if(PCload == 1)
			out = in;
	
	end
	
endmodule
