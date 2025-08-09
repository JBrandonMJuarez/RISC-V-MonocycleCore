module Multiplexor (
		input		[3:0] d0_i,
		input		[3:0] d1_i,
		input		[3:0] d2_i,
		input		[3:0] d3_i,
		input		[1:0] s_i,
		output	[3:0] y_o

);

	wire [3:0] low;
	wire [3:0] high;
	
	
	//	Instancia relacional
	Multiplexor2a1 MuxLow (
		.a_i			(d0_i),
		.b_i			(d1_i),
		.sel_i		(s_i[0]),
		.result_o	(low)
	
	);
	
	
	//	Instancia relacional
	Multiplexor2a1  MuxHigh (
		.a_i			(d2_i),
		.b_i			(d3_i),
		.sel_i		(s_i[0]),
		.result_o	(high)
	
	);
	
	Multiplexor2a1  MuxFinal (
		.a_i			(low),
		.b_i			(high),
		.sel_i		(s_i[1]),
		.result_o	(y_o)
	
	);
	
	
	
	
	// Instancia posicional
	//Multiplexor2a1 : MuxHigh (
	//	d0_i[],
	//	d1_i[],
	//	s_i[]
	//	high
	
	//);
	
	
endmodule
