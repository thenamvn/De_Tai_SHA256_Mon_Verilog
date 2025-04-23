`timescale 1ns / 1ps

module TB_Message_Expansion;

    reg         CLK;
    reg         RST;
    reg         start_in;
    reg [31:0]  message0_in;
    reg [31:0]  message1_in;
    reg [31:0]  message2_in;
    reg [31:0]  message3_in;
    reg [31:0]  message4_in;
    reg [31:0]  message5_in;
    reg [31:0]  message6_in;
    reg [31:0]  message7_in;
    reg [31:0]  message8_in;
    reg [31:0]  message9_in;
    reg [31:0]  message10_in;
    reg [31:0]  message11_in;
    reg [31:0]  message12_in;
    reg [31:0]  message13_in;
    reg [31:0]  message14_in;
    reg [31:0]  message15_in;

    wire [31:0] message_out;
    wire [6:0]  round_out;
    wire [1:0]  state_out;

    // Instantiate the DUT
    Message_Expansion dut (
        .CLK(CLK),
        .RST(RST),
        .start_in(start_in),
        .message0_in(message0_in),
        .message1_in(message1_in),
        .message2_in(message2_in),
        .message3_in(message3_in),
        .message4_in(message4_in),
        .message5_in(message5_in),
        .message6_in(message6_in),
        .message7_in(message7_in),
        .message8_in(message8_in),
        .message9_in(message9_in),
        .message10_in(message10_in),
        .message11_in(message11_in),
        .message12_in(message12_in),
        .message13_in(message13_in),
        .message14_in(message14_in),
        .message15_in(message15_in),
        .message_out(message_out),
        .round_out(round_out),
        .state_out(state_out)
    );

    // Clock generator
    always #5 CLK = ~CLK;

    initial begin
        // Initialize
        CLK = 0;
        RST = 0;
        start_in = 0;
		message0_in  = 32'h61626380;
        message1_in  = 32'h00000000;
        message2_in  = 32'h00000000;
        message3_in  = 32'h00000000;
        message4_in  = 32'h00000000;
        message5_in  = 32'h00000000;
        message6_in  = 32'h00000000;
        message7_in  = 32'h00000000;
        message8_in  = 32'h00000000;
        message9_in  = 32'h00000000;
        message10_in = 32'h00000000;
        message11_in = 32'h00000000;
        message12_in = 32'h00000000;
        message13_in = 32'h00000000;
        message14_in = 32'h00000000;
        message15_in = 32'h00000018; // length in bits (3 bytes * 8)

        #10 RST = 1;
        #10 start_in = 1;
        #10 start_in = 0;
		
		#600;
		
        $finish;
    end

endmodule
