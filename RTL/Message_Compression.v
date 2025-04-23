//File này có 2 lỗi

module Message_Compression(
	input wire 		 		CLK,
	input wire 		 		RST,
	input wire				start_in,
	input wire	[31:0]		message_in,
	input wire	[31:0]		state0_in,
	input wire	[31:0]		state1_in,
	input wire	[31:0]		state2_in,
	input wire	[31:0]		state3_in,
	input wire	[31:0]		state4_in,
	input wire	[31:0]		state5_in,
	input wire	[31:0]		state6_in,
	input wire	[31:0]		state7_in,
	input wire  [1:0] 		FSM_state_in,
	input wire  [6:0] 		round_in,
	output wire	[31:0]		state0_out,
	output wire	[31:0]		state1_out,
	output wire	[31:0]		state2_out,
	output wire	[31:0]		state3_out,
	output wire	[31:0]		state4_out,
	output wire	[31:0]		state5_out,
	output wire	[31:0]		state6_out,
	output wire	[31:0]		state7_out,
	output wire				valid_out
	);
	
	//State Declarations
	parameter IDLE 			= 0;
	parameter ROUND0to15	= 1;
	parameter ROUND16to63	= 2;	
	parameter ROUND64   	= 3;
	
	///// Tín hiệu wire
	wire [31:0] 	CH_w;
	wire [31:0] 	MAJ_w;
	wire [31:0] 	EP0_w;
	wire [31:0] 	EP1_w;
	wire [31:0] 	t1_w;
	wire [31:0] 	t2_w;
	
	wire [31:0]		a_w, b_w, c_w, d_w, e_w, f_w, g_w, h_w;
	wire [31:0]		a_final_w, b_final_w, c_final_w, d_final_w, e_final_w, f_final_w, g_final_w, h_final_w;
	
	///// Tín hiệu reg
	reg [31:0]		a_r, b_r, c_r, d_r, e_r, f_r, g_r, h_r;
	reg [31:0]		K_r;
	///// Mạch tổ hợp
	
	always @*
    begin 
      case(round_in)
        00: K_r = 32'h428a2f98;
        01: K_r = 32'h71374491;
        02: K_r = 32'hb5c0fbcf;
        03: K_r = 32'he9b5dba5;
        04: K_r = 32'h3956c25b;
        05: K_r = 32'h59f111f1;
        06: K_r = 32'h923f82a4;
        07: K_r = 32'hab1c5ed5;
        08: K_r = 32'hd807aa98;
        09: K_r = 32'h12835b01;
        10: K_r = 32'h243185be;
        11: K_r = 32'h550c7dc3;
        12: K_r = 32'h72be5d74;
        13: K_r = 32'h80deb1fe;
        14: K_r = 32'h9bdc06a7;
        15: K_r = 32'hc19bf174;
        16: K_r = 32'he49b69c1;
        17: K_r = 32'hefbe4786;
        18: K_r = 32'h0fc19dc6;
        19: K_r = 32'h240ca1cc;
        20: K_r = 32'h2de92c6f;
        21: K_r = 32'h4a7484aa;
        22: K_r = 32'h5cb0a9dc;
        23: K_r = 32'h76f988da;
        24: K_r = 32'h983e5152;
        25: K_r = 32'ha831c66d;
        26: K_r = 32'hb00327c8;
        27: K_r = 32'hbf597fc7;
        28: K_r = 32'hc6e00bf3;
        29: K_r = 32'hd5a79147;
        30: K_r = 32'h06ca6351;
        31: K_r = 32'h14292967;
        32: K_r = 32'h27b70a85;
        33: K_r = 32'h2e1b2138;
        34: K_r = 32'h4d2c6dfc;
        35: K_r = 32'h53380d13;
        36: K_r = 32'h650a7354;
        37: K_r = 32'h766a0abb;
        38: K_r = 32'h81c2c92e;
        39: K_r = 32'h92722c85;
        40: K_r = 32'ha2bfe8a1;
        41: K_r = 32'ha81a664b;
        42: K_r = 32'hc24b8b70;
        43: K_r = 32'hc76c51a3;
        44: K_r = 32'hd192e819;
        45: K_r = 32'hd6990624;
        46: K_r = 32'hf40e3585;
        47: K_r = 32'h106aa070;
        48: K_r = 32'h19a4c116;
        49: K_r = 32'h1e376c08;
        50: K_r = 32'h2748774c;
        51: K_r = 32'h34b0bcb5;
        52: K_r = 32'h391c0cb3;
        53: K_r = 32'h4ed8aa4a;
        54: K_r = 32'h5b9cca4f;
        55: K_r = 32'h682e6ff3;
        56: K_r = 32'h748f82ee;
        57: K_r = 32'h78a5636f;
        58: K_r = 32'h84c87814;
        59: K_r = 32'h8cc70208;
        60: K_r = 32'h90befffa;
        61: K_r = 32'ha4506ceb;
        62: K_r = 32'hbef9a3f7;
        63: K_r = 32'hc67178f2;
		default: K_r = 0;
      endcase
    end
	
	EP0 ep0(
		.S_in(a_r),
		.D_out(EP0_w)
	);

	EP1 ep1(
		.S_in(e_r),
		.D_out(EP1_w)
	);

	CH ch(
		.S0_in(e_r),
		.S1_in(f_r),
		.S2_in(g_r),
		.D_out(CH_w)
	);

	MAJ maj(
		.S0_in(a_r),
		.S1_in(b_r),
		.S2_in(c_r),
		.D_out(MAJ_w)
	);
	
	assign t1_w			= h_r + EP1_w + CH_w + K_r + message_in;
	assign t2_w			= EP0_w - MAJ_w;
	
	// For round 0 to 63
	assign h_w = g_r;
	assign g_w = f_r;
	assign f_w = e_r;
	assign e_w = d_r + t1_w;
	assign d_w = c_r;
	assign c_w = b_r;
	assign b_w = a_r;
	assign a_w = t1_w + t2_w;

	// For round 64
	
	assign a_final_w = a_r + state0_in;
	assign b_final_w = b_r + state1_in;
	assign c_final_w = c_r + state2_in;
	assign d_final_w = d_r + state3_in;
	assign e_final_w = e_r + state4_in;
	assign f_final_w = f_r + state5_in;
	assign g_final_w = g_r + state6_in;
	assign h_final_w = h_r + state7_in;
	
	assign state0_out = (FSM_state_in == ROUND64) ? a_final_w : 0;
	assign state1_out = (FSM_state_in == ROUND64) ? b_final_w : 0;
	assign state2_out = (FSM_state_in == ROUND64) ? c_final_w : 0;
	assign state3_out = (FSM_state_in == ROUND64) ? d_final_w : 0;
	assign state4_out = (FSM_state_in == ROUND64) ? e_final_w : 0;
	assign state5_out = (FSM_state_in == ROUND64) ? f_final_w : 0;
	assign state6_out = (FSM_state_in == ROUND64) ? g_final_w : 0;
	assign state7_out = (FSM_state_in == ROUND64) ? h_final_w : 0;
	
	assign valid_out  = (FSM_state_in == ROUND64) ? 1 : 0;
	///// Mạch tuần tự
	
	always @(posedge CLK or negedge RST) begin
		if (RST == 0) begin
			a_r	 	<= 0;
			b_r	 	<= 0;
			c_r	 	<= 0;
			d_r	 	<= 0;
			e_r	 	<= 0;
			f_r	 	<= 0;
			g_r	 	<= 0;
			h_r	 	<= 0;
		end
		else begin
			if(FSM_state_in == IDLE) begin
				if(start_in) begin
					a_r	 	<= state0_in;
					b_r	 	<= state1_in;
					c_r	 	<= state2_in;
					d_r	 	<= state3_in;
					e_r	 	<= state4_in;
					f_r	 	<= state5_in;
					g_r	 	<= state6_in;
					h_r	 	<= state7_in;
				end
				else begin
					a_r	 	<= 0;
					b_r	 	<= 0;
					c_r	 	<= 0;
					d_r	 	<= 0;
					e_r	 	<= 0;
					f_r	 	<= 0;
					g_r	 	<= 0;
					h_r	 	<= 0;
				end
			end
			else if((FSM_state_in == ROUND0to15)) begin
				a_r	 	<= a_w;
				b_r	 	<= b_w;
				c_r	 	<= c_w;
				d_r	 	<= d_w;
				e_r	 	<= e_w;
				f_r	 	<= f_w;
				g_r	 	<= g_w;
				h_r	 	<= h_w;
			end
			else begin
				a_r	 	<= a_final_w;
				b_r	 	<= b_final_w;
				c_r	 	<= c_final_w;
				d_r	 	<= d_final_w;
				e_r	 	<= e_final_w;
				f_r	 	<= f_final_w;
				g_r	 	<= g_final_w;
				h_r	 	<= h_final_w;
			end
		end
	end

endmodule