module IR(clock, IRload, in, out);
	
	input clock;
	input IRload;
	input [7:0] in;
	output [15:0] out; 
	reg [7:0] code;

	always @(posedge clock)
	begin
		if(IRload == 1)
			code = in;
	end
	
	decoder dc(code,out[15],out[14],out[13],out[12],out[11],out[10],out[9],out[8],out[7],out[6],out[5],out[4],out[3],out[2],out[1],out[0]);
	//decoder (IR,	 NOP,    LDAC,   STAC,   MVAC,   MOVR,   JUMP,   JMPZ,  JPNZ,  ADD,   SUB,   INAC,  CLAC,  AND,   OR,    XOR,   NOT);

endmodule

