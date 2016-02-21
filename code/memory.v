module memory(clock, address, data, MEMbus, BUSmem, we);

	input [15:0] address;
	input clock;
	input we; //write enable
	input MEMbus;
	input BUSmem;

	inout [7:0] data;	// inout between memory and BUS
	reg [7:0] data_out;
	(*ram_init_file="mem.mif"*)	// initilization file
	reg [7:0] mem [65536:0];	// 64k

	assign data = (MEMbus && !we) ? data_out: 8'bzzzz_zzzz ;

	always @(posedge clock)
	begin
		if(we && BUSmem)
			mem[address] = data; //writing
	end

	always @(MEMbus)
	begin
		if(!we)
			data_out = mem[address]; //reading
	end

endmodule
