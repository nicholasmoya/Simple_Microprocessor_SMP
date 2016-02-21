module SMP(clock, start, reset, output_counter, PCout, ACout, Rout, IRout);

	input clock;
	input start;
	output reset;
	output [2:0] output_counter;	// display current counter
	output [15:0] PCout;	// output contents in PC register
	output [15:0] IRout; // output contents in IR register
	output [7:0] ACout;	// output contents in AC register
	output [7:0] Rout;	// output contents in R register

	wire we, MEMbus, BUSmem, ARload, ARinc, PCload, PCinc, PCbus;
	wire DRload, DRHbus, DRLbus, TRload, TRbus, IRload, Rload, Rbus;
	wire ACload, ACbus, Zload, z;
	wire [6:0] ALUS;

	control_unit cu(clock, start, IRout, z, we, MEMbus, BUSmem, ARload,
							ARinc, PCload, PCinc, PCbus, DRload, DRHbus, 
							DRLbus, TRload, TRbus, IRload, Rload, Rbus, 
							ACload, ACbus, ALUS, Zload, output_counter,
							reset);
	
	data_path dp(clock, we, MEMbus, BUSmem, ARload, ARinc, PCload,
						PCinc, PCbus, DRload, DRHbus, DRLbus, TRload, TRbus,
						IRload, Rload, Rbus, ALUS, ACload, ACbus, Zload,
						PCout, ACout, Rout, IRout, z);
	
endmodule
