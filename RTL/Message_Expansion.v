//File này có 2 lỗi

module Message_Expansion(
	input wire 		 		CLK,
	input wire 		 		RST,
	input wire				start_in,
	input wire	[31:0]		message0_in,
	input wire	[31:0]		message1_in,
	input wire	[31:0]		message2_in,
	input wire	[31:0]		message3_in,
	input wire	[31:0]		message4_in,
	input wire	[31:0]		message5_in,
	input wire	[31:0]		message6_in,
	input wire	[31:0]		message7_in,
	input wire	[31:0]		message8_in,
	input wire	[31:0]		message9_in,
	input wire	[31:0]		message10_in,
	input wire	[31:0]		message11_in,
	input wire	[31:0]		message12_in,
	input wire	[31:0]		message13_in,
	input wire	[31:0]		message14_in,
	input wire	[31:0]		message15_in,
	output wire [31:0] 		message_out,
	output wire [6:0] 		round_out,
	output wire [1:0] 		FSM_state_out
	);
	
	//State Declarations
	parameter IDLE 			= 0;
	parameter ROUND0to15	= 1;
	parameter ROUND16to63	= 2;	
	parameter ROUND64   	= 3;
	
	///// Tín hiệu wire
	wire [31:0] 	SIG0_w;
	wire [31:0] 	SIG1_w;
	wire [31:0] 	m9_w;
	wire [31:0] 	m0_w;	
	wire [31:0] 	m16_w;

	///// Tín hiệu reg
	reg [1:0] 		state_r;
	reg [1:0] 		next_state_r;
	reg [6:0] 		round_r;
	
	reg	[31:0]		message0_r;
	reg	[31:0]		message1_r;
	reg	[31:0]		message2_r;
	reg	[31:0]		message3_r;
	reg	[31:0]		message4_r;
	reg	[31:0]		message5_r;
	reg	[31:0]		message6_r;
	reg	[31:0]		message7_r;
	reg	[31:0]		message8_r;
	reg	[31:0]		message9_r;
	reg	[31:0]		message10_r;
	reg	[31:0]		message11_r;
	reg	[31:0]		message12_r;
	reg	[31:0]		message13_r;
	reg	[31:0]		message14_r;
	reg	[31:0]		message15_r;
	
	///// Mạch tổ hợp
	assign message_out = 	(round_r == 0) ?   message0_r:
							(round_r == 1) ?   message1_r: 
							(round_r == 2) ?   message2_r:
							(round_r == 3) ?   message3_r:
							(round_r == 4) ?   message4_r:
							(round_r == 5) ?   message5_r:
							(round_r == 6) ?   message6_r:
							(round_r == 7) ?   message7_r:
							(round_r == 8) ?   message8_r:
							(round_r == 9) ?   message9_r:
							(round_r == 10) ?   message10_r:
							(round_r == 11) ?   message11_r:
							(round_r == 12) ?   message12_r:
							(round_r == 13) ?   message13_r:
							(round_r == 14) ?   message14_r:
							(round_r == 15) ?   message15_r: m16_w; 
	assign FSM_state_out	= state_r;
	assign round_out		= round_r;
	
	SIG1 sig1(
		.S_in(message14_r),
		.D_out(SIG1_w)
	);

	SIG0 sig0(
		.S_in(message1_r),
		.D_out(SIG0_w)
	);
	
	assign m0_w			= message0_r;
	assign m9_w			= message9_r;
	
	assign m16_w 		= SIG1_w + m9_w + SIG0_w + m0_w;
	
	///// Mạch tuần tự
	
	always @(posedge CLK or negedge RST) begin
		if (RST == 0) begin
			message0_r	 <= 0;
			message1_r	 <= 0;
			message2_r	 <= 0;
			message3_r	 <= 0;
			message4_r	 <= 0;
			message5_r	 <= 0;
			message6_r	 <= 0;
			message7_r	 <= 0;
			message8_r	 <= 0;
			message9_r	 <= 0;
			message10_r	 <= 0;
			message11_r	 <= 0;
			message12_r	 <= 0;
			message13_r	 <= 0;
			message14_r	 <= 0;
			message15_r	 <= 0;
		end
		else begin
			if(state_r == IDLE) begin
				if(start_in) begin
					message0_r	 <= message0_in;
					message1_r	 <= message1_in;
					message2_r	 <= message2_in;
					message3_r	 <= message3_in;
					message4_r	 <= message4_in;
					message5_r	 <= message5_in;
					message6_r	 <= message6_in;
					message7_r	 <= message7_in;
					message8_r	 <= message8_in;
					message9_r	 <= message9_in;
					message10_r	 <= message10_in;
					message11_r	 <= message11_in;
					message12_r	 <= message12_in;
					message13_r	 <= message13_in;
					message14_r	 <= message14_in;
					message15_r	 <= message15_in;				
				end
				else begin
					message0_r	 <= 0;
					message1_r	 <= 0;
					message2_r	 <= 0;
					message3_r	 <= 0;
					message4_r	 <= 0;
					message5_r	 <= 0;
					message6_r	 <= 0;
					message7_r	 <= 0;
					message8_r	 <= 0;
					message9_r	 <= 0;
					message10_r	 <= 0;
					message11_r	 <= 0;
					message12_r	 <= 0;
					message13_r	 <= 0;
					message14_r	 <= 0;
					message15_r	 <= 0;	
				end
			end
			else if(state_r == ROUND0to15) begin
				message0_r	 <= message0_r;
				message1_r	 <= message1_r;
				message2_r	 <= message2_r;
				message3_r	 <= message3_r;
				message4_r	 <= message4_r;
				message5_r	 <= message5_r;
				message6_r	 <= message6_r;
				message7_r	 <= message7_r;
				message8_r	 <= message8_r;
				message9_r	 <= message9_r;
				message10_r	 <= message10_r;
				message11_r	 <= message11_r;
				message12_r	 <= message12_r;
				message13_r	 <= message13_r;
				message14_r	 <= message14_r;
				message15_r	 <= message15_r;
			end
			else if(state_r == ROUND16to63) begin
				message0_r	 <= message1_r;
				message1_r	 <= message2_r;
				message2_r	 <= message3_r;
				message3_r	 <= message4_r;
				message4_r	 <= message5_r;
				message5_r	 <= message6_r;
				message6_r	 <= message7_r;
				message7_r	 <= message8_r;
				message8_r	 <= message9_r;
				message9_r	 <= message10_r;
				message10_r	 <= message11_r;
				message11_r	 <= message12_r;
				message12_r	 <= message13_r;
				message13_r	 <= message14_r;
				message14_r	 <= message15_r;
				message15_r	 <= m16_w;
			end
			else begin
				message0_r	 <= 0;
				message1_r	 <= 0;
				message2_r	 <= 0;
				message3_r	 <= 0;
				message4_r	 <= 0;
				message5_r	 <= 0;
				message6_r	 <= 0;
				message7_r	 <= 0;
				message8_r	 <= 0;
				message9_r	 <= 0;
				message10_r	 <= 0;
				message11_r	 <= 0;
				message12_r	 <= 0;
				message13_r	 <= 0;
				message14_r	 <= 0;
				message15_r	 <= 0;
			end
		end
	end

	always @(posedge CLK or negedge RST) begin
		if (RST == 0) begin
			round_r <= 0;
		end
		else begin
		if(state_r != IDLE)
			round_r <= round_r + 1;
		else
			round_r <= 0;
	  end
	end		  
	
	///// Máy trạng thái FSM
	
	//Combinational Next State Logic
	always @(state_r or start_in or round_r)
	  case (state_r)
		IDLE:
		  if (start_in)
			next_state_r = ROUND0to15;
		  else
			next_state_r = IDLE;
		ROUND0to15:
		  if (round_r == 15)
			next_state_r = ROUND16to63;
		  else
			next_state_r = ROUND0to15;
		ROUND16to63:
		  if (round_r == 62)  
			next_state_r = ROUND64;
		  else
			next_state_r = ROUND16to63;
		ROUND64:
	   	  if (round_r == 63)  
			next_state_r = IDLE;
		  else
			next_state_r = ROUND64;
		endcase
	
	always @(posedge CLK)
		  if (RST == 0)
			state_r <= IDLE;
		  else
			state_r <= next_state_r;

endmodule