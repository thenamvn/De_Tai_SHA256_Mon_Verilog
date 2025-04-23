module CH(
    input wire [31:0] 	S0_in,
    input wire [31:0] 	S1_in,
    input wire [31:0] 	S2_in,
    output wire [31:0] 	D_out
    );
     	
    // Error: Missing negation of S0_in in second term
    // assign D_out = ((S0_in) & (S1_in)) ^ ((S0_in) & (S2_in)); 
    
    // Fixed:
    assign D_out = ((S0_in) & (S1_in)) ^ ((~S0_in) & (S2_in)); 
    
endmodule