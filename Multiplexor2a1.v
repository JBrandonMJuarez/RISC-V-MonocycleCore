module Multiplexor2a1 (
		input		[31:0]	a_i,
		input		[31:0]	b_i,
		input					sel_i,
		output	[31:0]	result_o

);

	assign result_o= (sel_i) ? b_i:a_i;
	
endmodule 