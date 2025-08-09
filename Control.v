module	Control(
	input		[6:0]	inst_opcode_i,
	output	reg	ALU_Scr_o,
	output	reg	MemToReg_o,
	output	reg	RegWrite_o,
	output	reg	MemRead_o,
	output	reg	MemWrite_o,
	output	reg	Branch_o,
	output	reg	ALUOp1_o,
	output	reg	ALUOp0_o
);

	always @(*)
	begin
		case	(inst_opcode_i)
		
			7'b0110011 :	// R
			begin
				ALU_Scr_o =	1'b0;
				MemToReg_o = 1'b0;
				RegWrite_o = 1'b1;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				Branch_o = 1'b0;
				ALUOp1_o = 1'b0;
				ALUOp0_o = 1'b0;
			end
			
			7'b0000011 :	// ld
			begin
				ALU_Scr_o =	1'b1;
				MemToReg_o = 1'b1;
				RegWrite_o = 1'b1;
				MemRead_o = 1'b1;
				MemWrite_o = 1'b0;
				Branch_o = 1'b0;
				ALUOp1_o = 1'b1;
				ALUOp0_o = 1'b1;
			end
			
			7'b0100011 :	// sd
			begin
				ALU_Scr_o =	1'b1;
				MemToReg_o = 1'b0;
				RegWrite_o = 1'b0;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b1;
				Branch_o = 1'b0;
				ALUOp1_o = 1'b1;
				ALUOp0_o = 1'b1;
			end
			
			7'b1100011 :	// B type
			begin
				ALU_Scr_o =	1'b0;
				MemToReg_o = 1'b0;
				RegWrite_o = 1'b0;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				Branch_o = 1'b1;
				ALUOp1_o = 1'b1;
				ALUOp0_o = 1'b0;
			end
			
			7'b0010011  :	// I (ALU)
			begin
				ALU_Scr_o =	1'b1;
				MemToReg_o = 1'b0;
				RegWrite_o = 1'b1;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				Branch_o = 1'b0;
				ALUOp1_o = 1'b0;
				ALUOp0_o = 1'b1;
			end
			
//			7'1101111  :	// J (jal)
//			begin
//				ALU_Scr_o =	1'b1;
//				MemToReg_o = 1'b0;
//				RegWrite_o = 1'b1;
//				MemRead_o = 1'b0;
//				MemWrite_o = 1'b0;
//				Branch_o = 1'b0;
//				ALUOp1_o = 1'b0;
//				ALUOp0_o = 1'b0;
//			end
			
			default:
			begin
				ALU_Scr_o =	1'b0;
				MemToReg_o = 1'b0;
				RegWrite_o = 1'b0;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				Branch_o = 1'b0;
				ALUOp1_o = 1'b0;
				ALUOp0_o = 1'b0;
			end
		
		endcase
	end

endmodule
