module SIG1(
	input wire [31:0] 	S_in,
	output wire [31:0] 	D_out
	);
	
	wire [31:0]			ROTRIGHT_17;
	wire [31:0]			ROTRIGHT_19;
	wire [31:0]			SHIFT_10;
	
	assign ROTRIGHT_17	= {S_in[16:0],S_in[31:17]};
	assign ROTRIGHT_19	= {S_in[18:0],S_in[31:19]};
	assign SHIFT_10		= {10'b0000000000,S_in[31:10]};
	
	assign D_out = ROTRIGHT_17 ^ ROTRIGHT_19 ^ SHIFT_10; 
	
endmodule
