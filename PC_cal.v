module PC_cal (
		input						clk_i,
		input						rst_ni,
		input			 [31:0]	pc_nextaddr_i,
		output	reg [31:0]	pc_instaddr_o
);

	always @(negedge rst_ni, posedge clk_i)
	begin
			if (!rst_ni)
				pc_instaddr_o=32'b0;
			else
				pc_instaddr_o= pc_nextaddr_i;
			
	end

endmodule
