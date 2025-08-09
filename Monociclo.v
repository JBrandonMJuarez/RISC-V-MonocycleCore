module Monociclo (
		input					clk_i,
		input					rst_ni,
		output	[31:0]	dataSrc_rd_o

);
	
	wire [31:0] pc_instaddr_o;
	wire [31:0]	pc_nextAddr_o;
	wire [31:0] mem_inst_o;
	wire [31:0]	data_rrd1_o;
	wire [31:0]	data_rrd2_o;
	wire [31:0] imm_data_o;
	wire [31:0] data_rrd2_mux_o;
	wire [31:0]	dataALU_rd_o;
	wire [31:0]	dataMem_rd_o;
	
	wire [31:0]	dataSrc_rd_w;
	
	wire			zero_w;
	
	wire [6:0]	inst_opcode_w;
	wire			ALU_Scr_o;
	wire			MemToReg_o;
	wire			RegWrite_o;
	wire			MemRead_o;
	wire			MemWrite_o;
	wire			Branch_o;
	wire			ALUOp1_o;
	wire			ALUOp0_o;
	
	//Instanciar PC

	PC_cal PC_U0 (
		.clk_i				(clk_i),
		.rst_ni				(rst_ni),
		.pc_nextaddr_i		(pc_nextAddr_o),
		.pc_instaddr_o		(pc_instaddr_o)
	
	);
	
	
	wire	branch_w;
	
	assign	branch_w = Branch_o & zero_w;
	
	//Instanciar Mux de direccion
	Multiplexor2a1	PCAddr_U8(
		.a_i				(pc_instaddr_o+32'h4),
		.b_i				(pc_instaddr_o+(imm_data_o<<1)),
		.sel_i			(branch_w),
		.result_o		(pc_nextAddr_o)
	
	);
	
	
	// Instanciar MemInst
	MemMono	MemInst_U1 (
		.rst_ni				(rst_ni),
		.clk_i				(clk_i),
		.re_i					(1'b1),
		.acu_addread_i		(pc_instaddr_o[6:2]),
		.mem_data_o			(mem_inst_o),
		.we_i					(1'h0),
		.acu_addwrite_i	(32'h0),
		.mem_data_i			(32'h0)
	);
	
	//Instanciar RegisterFile
	RegisterFile	RegFile_U2(
		.clk_i				(clk_i),
		.rr_re_i				(1'b1),
		.rr_rs1_i			(mem_inst_o[19:15]),
		.rr_rs2_i			(mem_inst_o[24:20]),
		.rr_datars1_o		(data_rrd1_o),
		.rr_datars2_o		(data_rrd2_o),
		.rr_we_i				(RegWrite_o),
		.rr_rd_i				(mem_inst_o[11:7]),
		.rr_datard_i		(dataSrc_rd_w)
	
	);
	
	//Instanciar ImmGen
	ImmGen 	ImmGen_U3(
		.inst_data_i		(mem_inst_o),
		.imm_data_o			(imm_data_o)
	
	);
	
	//Instanciar Mux RegFile-ALU
	Multiplexor2a1	RegALU_U4(
		.a_i				(data_rrd2_o),
		.b_i				(imm_data_o),
		.sel_i			(ALU_Scr_o),
		.result_o		(data_rrd2_mux_o)
	
	);
	
	
	//Instanciar ALU
	ALUInt 	ALUInt_U5(
		.rs1_i							(data_rrd1_o),
		.rs2_i							(data_rrd2_mux_o),
		.OP_type_i						({ALUOp1_o,ALUOp0_o}),
		.funct7_bit6_i					(mem_inst_o[30]),
		.funct3							(mem_inst_o[14:12]),
		.zero_o							(zero_w),
		.rd_out							(dataALU_rd_o)
		
	);
	
	//Instanciar MemData
	MemMono	MemData_U6 (
		.rst_ni					(rst_ni),
		.clk_i					(clk_i),
		
		.re_i						(MemRead_o),
		.acu_addread_i			(dataALU_rd_o[6:2]),
		.mem_data_o				(dataMem_rd_o),
		
		.we_i						(MemWrite_o),
		.acu_addwrite_i		(dataALU_rd_o[6:2]),
		.mem_data_i				(data_rrd2_o)
	);
	
	//Instanciar Mux DataSrc
	Multiplexor2a1	DataSrc_U7(
		.a_i				(dataALU_rd_o),
		.b_i				(dataMem_rd_o),
		.sel_i			(MemToReg_o),
		.result_o		(dataSrc_rd_w)
	
	);
	
	
	assign	inst_opcode_w = mem_inst_o [6:0];
	
	Control	Control_Unit_U9 (
		.inst_opcode_i		(inst_opcode_w),
		.ALU_Scr_o			(ALU_Scr_o),
		.MemToReg_o			(MemToReg_o),
		.RegWrite_o			(RegWrite_o),
		.MemRead_o			(MemRead_o),
		.MemWrite_o			(MemWrite_o),
		.Branch_o			(Branch_o),
		.ALUOp1_o			(ALUOp1_o),
		.ALUOp0_o			(ALUOp0_o)
	);
	
	assign	dataSrc_rd_o = dataSrc_rd_w;
	
endmodule


module Monociclo_tb ();
		reg					clk_i;
		reg					rst_ni;
		wire	[31:0]	dataRd_source_o;
		
		Monociclo 	Mono_U0 (
			.rst_ni				(rst_ni),
			.clk_i				(clk_i),
			.dataSrc_rd_o		(dataRd_source_o)
		
		);
		
		initial
		begin
			clk_i	= 1'b1;
			rst_ni = 1'b0;
			
		end
		
		// Generar señal de reloj
		
		always
		begin
		#50
			clk_i = ~clk_i;
		end
		
		//Señales generales
		always
		begin
		#100
			rst_ni = 1'b1;
		end
		



endmodule
