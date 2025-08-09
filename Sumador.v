



//Sumador completo 32 bits
module Sumador(
      input     [31:0]a_i,
		input     [31:0]b_i,
		input          c_i,
		output    [31:0]s_o,
		output         c_o
);

      wire           carry_w;
		
		Sumador16bits Sumador16_0(
		   .a_i      (a_i[15:0]),
			.b_i      (b_i[15:0]),
			.c_i      (c_i),
			.s_o      (s_o[15:0]),
			.c_o      (carry_w)
		);
		
		Sumador16bits Sumador16_1(
		   .a_i      (a_i[31:16]),
			.b_i      (b_i[31:16]),
			.c_i      (carry_w),
			.s_o      (s_o[31:16]),
			.c_o      (c_o)
		);
		
endmodule

// Sumadores 1, 4, 16 bits

// Sumador 1 bit: descripción funcional
module Sumador1Bit ( // Declaración de entradas y salidas
		input		a_i,
		input		b_i,
		input		c_i,
		output	s_o,
		output	c_o
);

	assign    s_o = a_i ^ b_i ^ c_i;								// Asignación de funciones
	assign    c_o = (a_i & b_i) | ((a_i | b_i) & c_i); 
	
endmodule

// Sumador 4 bits: Asignación de modulos

module Sumador4bits (
		input		[3:0] a_i,
		input		[3:0] b_i,
		input		c_i,
		output	[3:0] s_o,
		output	c_o

);
	wire [2:0] carry_w;		// Declaración de conexión interna
	
		Sumador1Bit Sumador_0(
		   .a_i		(a_i[0]),
			.b_i		(b_i[0]),
			.c_i		(c_i),
			.s_o		(s_o[0]),
			.c_o		(carry_w[0])
		);
		
		Sumador1Bit Sumador_1(
		   .a_i		(a_i[1]),
			.b_i		(b_i[1]),
			.c_i		(carry_w[0]),
			.s_o		(s_o[1]),
			.c_o		(carry_w[1])
		);
		
		Sumador1Bit Sumador_2(
		   .a_i		(a_i[2]),
			.b_i		(b_i[2]),
			.c_i		(carry_w[1]),
			.s_o		(s_o[2]),
			.c_o		(carry_w[2])
		);
		
		Sumador1Bit Sumador_3(
		   .a_i		(a_i[3]),
			.b_i		(b_i[3]),
			.c_i		(carry_w[2]),
			.s_o		(s_o[3]),
			.c_o		(c_o)
		);


endmodule

// Sumador de 16 bits
module Sumador16bits(
      input     [15:0]a_i,
		input     [15:0]b_i,
		input          c_i,
		output    [15:0]s_o,
		output         c_o
);

      wire      [2:0]carry_w;
		
		Sumador4bits Sumador4_0(
		   .a_i      (a_i[3:0]),
			.b_i      (b_i[3:0]),
			.c_i      (c_i),
			.s_o      (s_o[3:0]),
			.c_o      (carry_w[0])
		);
		
		Sumador4bits Sumador4_1(
		   .a_i      (a_i[7:4]),
			.b_i      (b_i[7:4]),
			.c_i      (carry_w[0]),
			.s_o      (s_o[7:4]),
			.c_o      (carry_w[1])
		);
		
		Sumador4bits Sumador4_2(
		   .a_i      (a_i[11:8]),
			.b_i      (b_i[11:8]),
			.c_i      (carry_w[1]),
			.s_o      (s_o[11:8]),
			.c_o      (carry_w[2])
		);
		
		Sumador4bits Sumador4_3(
		   .a_i      (a_i[15:12]),
			.b_i      (b_i[15:12]),
			.c_i      (carry_w[2]),
			.s_o      (s_o[15:12]),
			.c_o      (c_o)
		);

endmodule
