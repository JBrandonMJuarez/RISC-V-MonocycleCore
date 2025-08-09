module MemMono # (
	parameter	DEPTH = 5,
	parameter	WIDTH = 32
) (
		//	Señales generales
		input		rst_ni,
		input		clk_i,
		
		//Puerto de lectura
		input							re_i,
		input			[DEPTH-1:0]	acu_addread_i,
		output 		[WIDTH-1:0]	mem_data_o,
		
		// Puerto de escritura
		input						we_i,
		input		[DEPTH-1:0]	acu_addwrite_i,
		input		[WIDTH-1:0]	mem_data_i

);
	reg	[WIDTH-1:0]	MemMono [0:2**DEPTH-1];
	
	initial
	begin
		$readmemh("ordenaBurbuja.hex",MemMono);
	end
	
	//Puerto de lectura
	assign	mem_data_o	=	MemMono[acu_addread_i];
	
	//Puerto de escrtura
	always @(posedge clk_i)
	begin
		if (we_i)
			MemMono [acu_addwrite_i]= mem_data_i;
	end
	

endmodule
