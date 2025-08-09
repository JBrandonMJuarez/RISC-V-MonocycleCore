module ImmGen (
	input				[31:0]	inst_data_i,
	output	reg	[31:0]	imm_data_o
);

	parameter	SE20 = 20;
	parameter	SE19 = 19;
	parameter	SE12 = 12;

	wire	[6:0]	opcode_inst_in;
	
	assign opcode_inst_in = inst_data_i[6:0];

	always @(*)
	begin
		case(opcode_inst_in)
		
			7'b0000011 :	// I (lw)
				imm_data_o = {{SE20{inst_data_i[31]}},inst_data_i[31:20]} ;
				
			7'b0010011 :	// I (ADDI,ANDI, etc.)
				imm_data_o = {{SE20{inst_data_i[31]}},inst_data_i[31:20]} ;
				
			7'b0010111 :	// U (auipc)
				imm_data_o = {inst_data_i[31:12],12'b0} ;
				
			7'b0100011 :	// S (sw)
				imm_data_o = {{SE20{inst_data_i[31]}},inst_data_i[31:25],inst_data_i[11:7]} ;
				
			7'b0110111 :	// U (lui)
				imm_data_o = {inst_data_i[31:12],12'b0} ;
			
			7'b1100111 :	// I (jalr)
				imm_data_o = {{SE20{inst_data_i[31]}},inst_data_i[31:20]} ;
			
			7'b1100011 :	// B (beq, bne, etc)
				imm_data_o = {{SE20{inst_data_i[31]}},inst_data_i[31],inst_data_i[7],inst_data_i[30:25],inst_data_i[11:8]};
			
			7'b1101111 :	// J (jal)
				imm_data_o = {{SE12{inst_data_i[31]}},inst_data_i[31],inst_data_i[19:12],inst_data_i[20],inst_data_i[30:21] };
			
			default:
				imm_data_o = 32'h0 ;
			
		endcase
	
	end


endmodule
