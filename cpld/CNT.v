module CNT(
	/* C8M clock input */
	input C8M, input E, input Er,
	/* Refresh request */
	output reg RefReq, output RefUrgent,
	/* Reset, switch, button */
	input [3:1] SW, output reg nRESout, input nIPL2, 
	/* Mac PDS bus master control outputs */
	output reg AoutOE, output reg nBR_IOB, 
	/* Configuration outputs */
	output C20MEN, output C25MEN, output FastROMEN);

	/* Timer counts from 0 to 1010 (10) -- 11 states == 14.042 us
    *	Refresh timer sequence
	 * |  Timer  | RefReq | RefUrgent |
	 * |------------------------------|
	 * | 0  0000 |   0    |     0     |
	 * | 1  0001 |   0    |     0     |
	 * | 2  0010 |   0    |     0     |
	 * | 3  0011 |   1    |     0     |
	 * | 4  0100 |   1    |     0     |
	 * | 5  0101 |   1    |     0     |
	 * | 6  0110 |   1    |     0     |
	 * | 7  0111 |   1    |     0     |
	 * | 8  1000 |   1    |     1     |
	 * | 9  1001 |   1    |     1     |
	 * | 10 1010 |   1    |     1     |
	 * back to timer==0
	 */
	reg [3:0] Timer = 0;
	reg TimerTC;
	assign RefUrgent = Timer[3];
	always @(negedge C8M) begin
		if (Er && !E) begin
			TimerTC <= Timer[3:0]==4'h8;
			if (TimerTC) Timer <= 0;
			else Timer <= Timer+1;
			RefReq <=	 Timer[3:0]==4'h2 || 
						 Timer[3:0]==4'h3 || Timer[3:0]==4'h4 || Timer[3:0]==4'h5 ||
						 Timer[3:0]==4'h6 || Timer[3:0]==4'h7 || Timer[3:0]==4'h8;
		end
	end
	
	/* Long timer counts from 0 to 8192 -- 8193 states == 115.046 ms */
	reg [13:0] LTimer;
	wire LTimerTC = LTimer[13];
	always @(negedge C8M) begin
		if (Er && !E) && TimerTC begin
			if (LTimerTC) LTimer <= 0;
			else LTimer <= LTimer+1;
		end
	end
	
	/* Startup sequence control */
	reg [1:0] INITS = 0;
	assign nAoutOE = !AoutOE;
	always @(negedge C8M) begin
		case (INITS)
			0: begin
				AoutOE <= 0; // Tristate PDS address and control
				nRESout <= 0; // Hold reset low
				nBR_IOB <= 0; // Default to request bus
				if (LTimerTC) INITS <= 1;
				else INITS <= 0;
			end 1: begin
				AoutOE <= 0; // Tristate PDS address and control
				nRESout <= 0; // Hold reset low
				nBR_IOB <= nBR_IOB | !nIPL2; // Disable bus request if NMI pressed
				if (LTimerTC && !IPL2r) INITS <= 2;
			end 2: begin
				AoutOE <= 0; // Tristate PDS address and control
				nRESout <= 0; // Hold reset low
				if (LTimerTC) INITS <= 3;
			end 3: begin
				AoutOE <= !nBR_IOB; // Get on PDS bus if bus was requested
				nRESout <= 1; // Release reset
				INITS <= 3;
			end
		endcase
	end

	// Enable both oscillators... only mount one
	assign C20MEN = 1;
	assign C25MEN = 1;
	// Enable fast ROM
	assign FastROMEN = 1;

endmodule
