// File này có 2 lỗi sai

module EP0(
	input wire [31:0] 	S_in,
	output wire [31:0] 	D_out
	);
	
	wire [31:0]			ROTRIGHT_2;
	wire [31:0]			ROTRIGHT_13;
	wire [31:0]			ROTRIGHT_22;
	
	assign ROTRIGHT_2	= {S_in[2:0],S_in[31:3]};
	
	assign ROTRIGHT_13	= {S_in[13:0],S_in[31:14]};
	
	assign ROTRIGHT_22	= {S_in[21:0],S_in[31:22]};
 	
	assign D_out = ROTRIGHT_2 ^ ROTRIGHT_13 ^ ROTRIGHT_22; 
	
endmodule
