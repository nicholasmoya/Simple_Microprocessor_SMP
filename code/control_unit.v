module control_unit(clock, start, instruction, z, we, MEMbus, BUSmem,
							ARload, ARinc, PCload, PCinc, PCbus, DRload, 
							DRHbus, DRLbus, TRload, TRbus, IRload, Rload, 
							Rbus, ACload, ACbus, ALUS, Zload, output_counter,
							reset);
	
	input clock;
	input start;
	input z;
	input [15:0] instruction;

	output reg we, MEMbus, BUSmem, ARload, ARinc, PCload, PCinc, PCbus;
	output reg DRload, DRHbus, DRLbus, TRload, TRbus, IRload, Rload;
	output reg Rbus, ACload, ACbus, Zload;
	output reg [6:0] ALUS;
	output [2:0] output_counter;
	output reset;
	
	wire [7:0] T;
	wire [2:0] counter_out;

	counter   c(clock, start, reset, counter_out);
	// counter (clock, start, reset, out);
	
	decoder_time   d(counter_out, T);
	// decoder_time (in,          out);

	assign output_counter = counter_out; // observe counter clock
	assign reset = instruction[14]&T[7]|instruction[10]&T[5]|T[3]&(instruction[11]|instruction[12])|instruction[13]&T[7]|(~z)&instruction[9]&T[4]|instruction[9]&z&T[5]|instruction[8]&z&T[4]|instruction[8]&(~z)&T[5]|instruction[15]&T[3]|T[3]&(instruction[7]|instruction[6]|instruction[5]|instruction[4]|instruction[3]|instruction[2]|instruction[1]|instruction[0]);

	always @(*)
	begin
		we <= T[7]&instruction[13];
		MEMbus <= T[1]|instruction[14]&(T[3]|T[4]|T[6])|instruction[10]&(T[3]|T[4])|instruction[8]&(T[3]|T[4])&(~z)|instruction[13]&(T[3]|T[4])|instruction[9]&(T[3]|T[4])&z;
		BUSmem <= T[7]&instruction[13];
		ARload <= T[0]|T[2]|instruction[14]&T[5]|instruction[13]&T[5];
		ARinc  <= T[3]&(instruction[14]|instruction[10]|instruction[13])|instruction[9]&T[3]&z|instruction[8]&T[3]&(~z);
		PCload <= instruction[10]&T[5]|instruction[9]&T[5]&z|(~z)&instruction[8]&T[5];
		PCinc  <= T[1] | instruction[14]&(T[3]|T[4])|instruction[13]&(T[3]|T[4])|instruction[9]&(~z)&(T[3]|T[4])|instruction[8]&z&(T[3]|T[4]);
		PCbus  <= T[0]|T[2];
		DRload <= T[1]|instruction[14]&(T[3]|T[4]|T[6])|instruction[10]&(T[3]|T[4])|instruction[13]&(T[3]|T[4]|T[6])|z&instruction[9]&(T[3]|T[4])|instruction[8]&(T[3]|T[4])&(~z);
		DRHbus <= T[5]&(instruction[14]|instruction[10]|instruction[13])|instruction[9]&T[5]&z|instruction[8]&(~z)&T[5];
		DRLbus <= instruction[14]&T[7]|instruction[13]&T[7];
		TRload <= T[4]&(instruction[14]|instruction[10]|instruction[13])|instruction[9]&z&T[4]|instruction[8]&(~z)&T[4];
		TRbus  <= T[5]&(instruction[14]|instruction[10]|instruction[13])|instruction[9]&T[5]&z|instruction[8]&(~z)&T[5];
		IRload <= T[2];
		Rload  <= instruction[12]&T[3];
		Rbus   <= T[3]&(instruction[11]|instruction[7]|instruction[6]|instruction[3]|instruction[2]|instruction[1]);
		ACload <= instruction[14]&T[7]|T[3]&(instruction[11]|instruction[7]|instruction[6]|instruction[5]|instruction[4]|instruction[3]|instruction[2]|instruction[1]|instruction[0]);
		ACbus  <= instruction[12]&T[3]|instruction[13]&T[6];
		ALUS[6]<= T[3]&(instruction[3]|instruction[2]|instruction[1]|instruction[0]);
		ALUS[5]<= T[3]&(instruction[2]|instruction[0]);
		ALUS[4]<= T[3]&(instruction[1]|instruction[0]);
		ALUS[3]<= T[3]&(instruction[6]|instruction[5]);
		ALUS[2]<= T[3]&instruction[7]|T[7]&instruction[14]|T[3]&instruction[11];
		ALUS[1]<= T[3]&instruction[6];
		ALUS[0]<= T[3]&(instruction[7]|instruction[6]|instruction[5]);
		Zload  <= T[3]&(instruction[0]|instruction[1]|instruction[2]|instruction[3]|instruction[4]|instruction[5]|instruction[6]|instruction[7]);
	end

endmodule
		
		
		
		
		
		