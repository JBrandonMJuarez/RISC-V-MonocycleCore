module RegisterFile (
		//Puertos de lectura
		input			clk_i,
		input			rr_re_i,
		input			[4:0] rr_rs1_i,
		input			[4:0] rr_rs2_i,
		output 		[31:0]rr_datars1_o,
		output 		[31:0]rr_datars2_o,
		//Puerto de escritura
		input		rr_we_i,
		input		[4:0] rr_rd_i,
		input		[31:0] rr_datard_i
);

	reg	[0:31]	RegisterFile [31:0];
	
	initial
	begin
		RegisterFile[0] = 32'b0;
		RegisterFile[1] = 32'b0;
		RegisterFile[2] = 32'b0;
		RegisterFile[3] = 32'b0;
		RegisterFile[4] = 32'b0;
		RegisterFile[5] = 32'b0;
		RegisterFile[6] = 32'b0;
		RegisterFile[7] = 32'b0;
		RegisterFile[8] = 32'b0;
		RegisterFile[9] = 32'b0;
		RegisterFile[10] = 32'b0;
		RegisterFile[11] = 32'b0;
		RegisterFile[12] = 32'b0;
		RegisterFile[13] = 32'b0;
		RegisterFile[14] = 32'b0;
		RegisterFile[15] = 32'b0;
		RegisterFile[16] = 32'b0;
		RegisterFile[17] = 32'b0;
		RegisterFile[18] = 32'b0;
		RegisterFile[19] = 32'b0;
		RegisterFile[20] = 32'b0;
		RegisterFile[21] = 32'b0;
		RegisterFile[22] = 32'b0;
		RegisterFile[23] = 32'b0;
		RegisterFile[24] = 32'b0;
		RegisterFile[25] = 32'b0;
		RegisterFile[26] = 32'b0;
		RegisterFile[27] = 32'b0;
		RegisterFile[28] = 32'b0;
		RegisterFile[29] = 32'b0;
		RegisterFile[30] = 32'b0;
		RegisterFile[31] = 32'b0;
	end
	
	
	//Proceso de escritura
	always @(posedge clk_i)
	begin
		if(rr_we_i)
			RegisterFile[rr_rd_i] <= rr_datard_i;
	end
	
	//Proceso de lectura
	assign rr_datars1_o = RegisterFile[rr_rs1_i];
	assign rr_datars2_o = RegisterFile[rr_rs2_i];
	

endmodule