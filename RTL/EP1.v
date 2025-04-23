module EP1(
    input wire [31:0] 	S_in,
    output wire [31:0] 	D_out
    );
    
    wire [31:0]			ROTRIGHT_6;
    wire [31:0]			ROTRIGHT_11;
    wire [31:0]			ROTRIGHT_25;
    
    // Error: Wrong rotation - indices reversed
    // assign ROTRIGHT_6	= {S_in[31:6],S_in[5:0]};
    
    // Fixed:
    assign ROTRIGHT_6	= {S_in[5:0],S_in[31:6]};
    
    assign ROTRIGHT_11	= {S_in[10:0],S_in[31:11]};
    
    // Error: Wrong rotation - indices reversed
    // assign ROTRIGHT_25	= {S_in[31:25],S_in[24:0]};
    
    // Fixed:
    assign ROTRIGHT_25	= {S_in[24:0],S_in[31:25]};
     
    assign D_out = ROTRIGHT_6 ^ ROTRIGHT_11 ^ ROTRIGHT_25; 
    
endmodule