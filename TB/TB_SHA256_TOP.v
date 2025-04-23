`timescale 1ns/1ps

module TB_SHA256_TOP;

  reg CLK, RST, start_in;
  reg [31:0] message [0:15];
  reg [31:0] state [0:7];

  wire [31:0] state0_out, state1_out, state2_out, state3_out;
  wire [31:0] state4_out, state5_out, state6_out, state7_out;
  wire valid_out;

  // Instantiate DUT
  SHA256_TOP uut (
    .CLK(CLK),
    .RST(RST),
    .start_in(start_in),
    .message0_in(message[0]), .message1_in(message[1]),
    .message2_in(message[2]), .message3_in(message[3]),
    .message4_in(message[4]), .message5_in(message[5]),
    .message6_in(message[6]), .message7_in(message[7]),
    .message8_in(message[8]), .message9_in(message[9]),
    .message10_in(message[10]), .message11_in(message[11]),
    .message12_in(message[12]), .message13_in(message[13]),
    .message14_in(message[14]), .message15_in(message[15]),
    .state0_in(state[0]), .state1_in(state[1]),
    .state2_in(state[2]), .state3_in(state[3]),
    .state4_in(state[4]), .state5_in(state[5]),
    .state6_in(state[6]), .state7_in(state[7]),
    .state0_out(state0_out), .state1_out(state1_out),
    .state2_out(state2_out), .state3_out(state3_out),
    .state4_out(state4_out), .state5_out(state5_out),
    .state6_out(state6_out), .state7_out(state7_out),
    .valid_out(valid_out)
  );

  // Clock generator
  always #5 CLK = ~CLK;

  initial begin
    $display("Start SHA256_TOP Simulation");

    // Initial reset
    CLK = 0; RST = 0; start_in = 0;
    #20 RST = 1;

    // Message input: "abc" + SHA-256 padding
    message[0]  = 32'h61626380; // "abc" + 0x80
    message[1]  = 32'h00000000;
    message[2]  = 32'h00000000;
    message[3]  = 32'h00000000;
    message[4]  = 32'h00000000;
    message[5]  = 32'h00000000;
    message[6]  = 32'h00000000;
    message[7]  = 32'h00000000;
    message[8]  = 32'h00000000;
    message[9]  = 32'h00000000;
    message[10] = 32'h00000000;
    message[11] = 32'h00000000;
    message[12] = 32'h00000000;
    message[13] = 32'h00000000;
    message[14] = 32'h00000000;
    message[15] = 32'h00000018; // 24-bit = 3 bytes

    // Initial SHA-256 state values (H0-H7)
    state[0] = 32'h6a09e667;
    state[1] = 32'hbb67ae85;
    state[2] = 32'h3c6ef372;
    state[3] = 32'ha54ff53a;
    state[4] = 32'h510e527f;
    state[5] = 32'h9b05688c;
    state[6] = 32'h1f83d9ab;
    state[7] = 32'h5be0cd19;

    // Start hashing
    #10 start_in = 1;
    #10 start_in = 0;
	
	#1000;
	// Message input: "abc" + SHA-256 padding
    message[0]  = 32'h61626380; // "abc" + 0x80
    message[1]  = 32'h00000000;
    message[2]  = 32'h00000000;
    message[3]  = 32'h00000000;
    message[4]  = 32'h00000000;
    message[5]  = 32'h00000000;
    message[6]  = 32'h00000000;
    message[7]  = 32'h00000000;
    message[8]  = 32'h00000000;
    message[9]  = 32'h00000000;
    message[10] = 32'h00000000;
    message[11] = 32'h00000000;
    message[12] = 32'h00000000;
    message[13] = 32'h00000000;
    message[14] = 32'h00000000;
    message[15] = 32'h00000018; // 24-bit = 3 bytes

    // Initial SHA-256 state values (H0-H7)
    state[0] = 32'h6a09e667;
    state[1] = 32'hbb67ae85;
    state[2] = 32'h3c6ef372;
    state[3] = 32'ha54ff53a;
    state[4] = 32'h510e527f;
    state[5] = 32'h9b05688c;
    state[6] = 32'h1f83d9ab;
    state[7] = 32'h5be0cd19;

    // Start hashing
    #10 start_in = 1;
    #10 start_in = 0;
    // Wait for hash to complete (adjust time depending on your design latency)
    wait (valid_out == 1);

    // Display final hash output
    $display("Hash Output:");
    $display("%08x %08x %08x %08x", state0_out, state1_out, state2_out, state3_out);
    $display("%08x %08x %08x %08x", state4_out, state5_out, state6_out, state7_out);

    $finish;
  end

endmodule
