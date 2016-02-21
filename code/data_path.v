module data_path(clock, we, MEMbus, BUSmem, ARload, ARinc, 
						PCload, PCinc, PCbus, DRload, DRHbus, DRLbus, TRload,
						TRbus, IRload, Rload, Rbus, ALUS, ACload, ACbus, 
						Zload, PCout, ACoutput, Rout, IRout, z);

	input clock, we, MEMbus, BUSmem, ARload, ARinc;
	input PCload, PCinc, PCbus, DRload, DRHbus, DRLbus, TRload;
	input TRbus, IRload, Rload, Rbus, ACload, ACbus, Zload;
	input [6:0] ALUS;
	
	output [15:0] IRout;
	output [15:0] PCout;
	output [7:0] ACoutput;
	output [7:0] Rout;
	output z;
	
	wire [15:0] BUS;
	wire [15:0] ARout_MEMin;
	wire [15:0] PCout_TSin;
	wire [7:0] DRout;
	wire [7:0] TRout_TSin;
	wire [7:0] Rout_TSin;
	wire [7:0] ACout;
	wire [7:0] ALUout;
	wire ZeroFlag;	// zero flag (if AC = 0, Z = 1, else, Z = 0)
	
	assign PCout = PCout_TSin;	// observe contents of PC register
	assign ACoutput = ACout;	// observe contents of AC register
	assign Rout = Rout_TSin;	// observe contents of R register
	
	reg16_bit AR(clock, ARload, ARinc, BUS, ARout_MEMin);
	// reg16_bit(clock, load,   INC,   in,  out);
	
	memory SRAM(clock, ARout_MEMin, BUS[7:0], MEMbus, BUSmem,  we);
	//   memory(clock, address,     data,     MEMbus, BUSmem,  we);
	
	reg16_bit PC(clock, PCload, PCinc, BUS, PCout_TSin);
	//        PC(clock, load,   INC,   in,  out);
	
	tristate16_bit PCTS(PCout_TSin, PCbus, BUS);
	//   tristate16_bit(in,         enable, out);
	
	reg8_bit DR(clock, DRload, BUS[7:0], DRout);
	// reg8_bit(clock, load,   in,       out);
	
	tristate8_bit DRH(DRout, DRHbus, BUS[15:8]);
	//  tristate8_bit(in,    enable, out);
	
	tristate8_bit DRL(DRout, DRLbus, BUS[7:0]);
	//  tristate8_bit(in,    enable, out);
	
	reg8_bit TR(clock, TRload, DRout, TRout_TSin);
	// reg8_bit(clock, load,   in,    out);
	
	tristate8_bit TRTS(TRout_TSin, TRbus, BUS[7:0]);
	//   tristate8_bit(in,         enable, out);
	
	IR reg8_bit(clock, IRload, DRout, IRout);
	//       IR(clock, load,   in,    out);
	
	reg8_bit R(clock, Rload, BUS[7:0], Rout_TSin);
	//reg8_bit(clock, load,  in,       out);
	
	tristate8_bit RTS(Rout_TSin, Rbus,   BUS[7:0]);
	//  tristate8_bit(in,        enable, out);
	
	reg8_bit AC(clock, ACload, ALUout, ACout);
	// reg8_bit(clock, load,   in,     out);
	
	ALU ALU8_bit(ACout, BUS[7:0], ALUS, ALUout);
	//       ALU(AC,    BUS,      ALUS, out);
	
	tristate8_bit ACTS(ACout, ACbus, BUS[7:0]);
	//   tristate8_bit(in,    enable, out)
	
	z_latch zl(clock, ZeroFlag, Zload, z);
	// z_latch(clock, in,   load,  out);
	
   assign ZeroFlag = ~(ALUout[7] | ALUout[6] | ALUout[5] | ALUout[4] | ALUout[3] |ALUout[2] | ALUout[1] | ALUout[0]);

endmodule
