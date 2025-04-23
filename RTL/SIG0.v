module SIG0(
	input wire [31:0] 	S_in,
	output wire [31:0] 	D_out
	);
	
	wire [31:0]			ROTRIGHT_7;
	wire [31:0]			ROTRIGHT_18;
	wire [31:0]			SHIFT_3;
	
	assign ROTRIGHT_7	= {S_in[6:0],S_in[31:7]};
	
	assign ROTRIGHT_18	= {S_in[17:0],S_in[31:18]};
	
	assign SHIFT_3		= {3'b000,S_in[31:3]};
 	
	assign D_out = ROTRIGHT_7 ^ ROTRIGHT_18 ^ SHIFT_3; 
	
endmodule
