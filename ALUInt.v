module ALUInt (
		input					[31:0]	rs1_i,
		input					[31:0]	rs2_i,
		input					[1:0]		OP_type_i,
		input								funct7_bit6_i,
		input					[2:0]		funct3,
		output							cout_o,
		output		reg				zero_o,
		output		reg	[31:0]	rd_out

);
	wire [31:0] res_addsub_w;
	wire [3:0]	operacion_w;
	reg			cin_op_w;
	
	assign operacion_w = {funct7_bit6_i,funct3};

	always @(*)
	begin
		zero_o = 1'b0;
		case	(OP_type_i)
			2'b00 :
			begin
				cin_op_w = funct7_bit6_i;
				case (operacion_w)
					4'b0000:				//Suma
								rd_out = res_addsub_w;
					4'b1000:				//Resta
								rd_out = res_addsub_w;
					4'b0010: begin			//SLT
								if (rs1_i < rs2_i) begin
									rd_out[0]= 1'b1 ;
								end else begin
									rd_out[0]= 1'b0 ;
								end
								rd_out[31:1] = 31'b0;
							end
					4'b0011: begin		//SLTU
								if (rs1_i<rs2_i) begin
								rd_out[0]=1'b1;
								end
								else begin
									rd_out[0]=1'b0;
								end
									rd_out[31:1] = 31'b0;
							end
					4'b0100:				//XOR
						rd_out=rs1_i ^ rs2_i;
					4'b0110:				//OR
						rd_out=rs1_i | rs2_i;
					4'b0111:				//AND
						rd_out=rs1_i & rs2_i;
				
				default:
						rd_out =32'b0;
		
				endcase
			end
			
			2'b01 :		//I type
			begin
				cin_op_w = 1'b0;
				case (operacion_w)
					4'b_000:				//Suma I
					begin
								rd_out = res_addsub_w;
								
					end
					4'b0001:				//slli
								rd_out = rs1_i << rs2_i;
					4'b_010: begin			//SLTI
								if (rs1_i < rs2_i) begin
									rd_out[0]= 1'b1 ;
								end else begin
									rd_out[0]= 1'b0 ;
								end
								rd_out[31:1] = 31'b0;
							end
					4'b_011: begin		//SLTIU
								if (rs1_i<rs2_i) begin
								rd_out[0]=1'b1;
								end
								else begin
									rd_out[0]=1'b0;
								end
									rd_out[31:1] = 31'b0;
							end
					4'b_100:				//XORI
						rd_out=rs1_i ^ rs2_i;
					4'b0101:				//srli
						rd_out = rs1_i >> rs2_i;
					4'b_110:				//ORI
						rd_out=rs1_i | rs2_i;
					4'b_111:				//ANDI
						rd_out=rs1_i & rs2_i;
						
				default:
						rd_out =32'b0;
		
				endcase
			end
			
			2'b10 :
			begin
				cin_op_w = 1'b1;
				case(operacion_w)
					4'b0000 :  //beq
					begin
						//cin_op_w = 1'b1;
						rd_out = res_addsub_w;
						if ( rd_out == 32'b0) begin
							zero_o = 1'b1;
						end else begin
							zero_o = 1'b0;
							
						end
					end
					
					4'b0001 :  //bne
					begin
						//cin_op_w = 1'b1;
						rd_out = res_addsub_w;
						if ( rd_out != 0) begin
							zero_o = 1'b1;
						end else begin
							zero_o = 1'b0;
							
						end
					end
					
					4'b1000 :  //beq
					begin
						//cin_op_w = 1'b1;
						rd_out = res_addsub_w;
						if ( rd_out == 32'b0) begin
							zero_o = 1'b1;
						end else begin
							zero_o = 1'b0;
							
						end
					end
					
					4'b1001 :  //bne
					begin
						//cin_op_w = 1'b1;
						rd_out = res_addsub_w;
						if ( rd_out != 0) begin
							zero_o = 1'b1;
						end else begin
							zero_o = 1'b0;
							
						end
					end
					
					//4'b_101 :
					
					//4'b_110 :
					
					//4'b_111 :
					
					default :
						rd_out =32'b0;
				
				endcase
			
			end
			
			2'b11 :
			begin
				cin_op_w = 1'b0;
				case (operacion_w)
					4'b0010 :	// LW
						rd_out = res_addsub_w;
					4'b1010 :	// LW
						rd_out = res_addsub_w;
					default :
						rd_out =32'b0;
				
				endcase
				
			end
			
			default:
				rd_out =32'b0;

		endcase	
	end

SumadorRestador AddSub_U0(
		.fun7_bit6_i		(cin_op_w),	//Bit 6 Function 7
		.a_i					(rs1_i),
		.b_i					(rs2_i),
		.suma_o				(res_addsub_w),
		.cout_o				(cout_o)

);

endmodule
