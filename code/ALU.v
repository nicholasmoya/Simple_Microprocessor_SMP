module ALU(ac, bus, select, out);

	input [7:0] ac;
	input [7:0] bus;
	input [6:0] select;
	output reg [7:0] out; 

	always @(*)
	begin
		if (select[6] == 0)
			begin
				case(select[3:0])
					4'b0000: out = 8'b0000_0000;
					4'b0100: out = bus;
					4'b0101: out = ac + bus;
					4'b1001: out = ac + 1'b1;
					4'b1011: out = ac + ~bus + 1'b1;
					default: out = 8'b0000_0000;
				endcase
			end
			
		if (select[6] == 1)
			begin
				case(select[5:4])
					2'b00: out = ac & bus;
					2'b01: out = ac ^ bus;
					2'b10: out = ac | bus;
					2'b11: out = ~ac;
					default: out = 8'b0000_0000;
				endcase
			end
	end
	
endmodule
