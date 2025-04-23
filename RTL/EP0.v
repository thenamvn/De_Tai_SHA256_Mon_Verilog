module EP0(
    input wire [31:0] 	S_in,
    output wire [31:0] 	D_out
    );
    
    wire [31:0]			ROTRIGHT_2;
    wire [31:0]			ROTRIGHT_13;
    wire [31:0]			ROTRIGHT_22;
    
    // Error: Incorrect rotation, should rotate right by 2
    // assign ROTRIGHT_2	= {S_in[2:0],S_in[31:3]};
    
    // Fixed:
    assign ROTRIGHT_2	= {S_in[1:0],S_in[31:2]};
    
    assign ROTRIGHT_13	= {S_in[12:0],S_in[31:13]};
    
    // Error: Incorrect rotation, should rotate right by 22
    // assign ROTRIGHT_22	= {S_in[21:0],S_in[31:22]};
    
    // Fixed:
    assign ROTRIGHT_22	= {S_in[21:0],S_in[31:22]};
     
    assign D_out = ROTRIGHT_2 ^ ROTRIGHT_13 ^ ROTRIGHT_22; 
    
endmodule