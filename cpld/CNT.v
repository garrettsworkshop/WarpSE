module CNT(
	/* FSB clock and E clock inputs */
	input CLK, input E,
	/* Refresh request */
	output reg RefReq, output RefUrg,
	/* Reset, button */
	output reg nRESout, input nIPL2, 
	/* Mac PDS bus master control outputs */
	output reg AoutOE, output reg nBR_IOB);
	
	/* E clock synchronization */
	reg [1:0] Er;
	wire EFall = Er[1] && !Er[0];
	always @(posedge CLK) Er[1:0] <= { Er[0], E };

	/* Timer counts from 0 to 1010 (10) -- 11 states == 14.042 us
    *	Refresh timer sequence
	 * |  Timer  | RefReq | RefUrg |
	 * |------------------------------|
	 * | 0  0000 |   0    |     0     |
	 * | 1  0001 |   0    |     0     |
	 * | 2  0010 |   1    |     0     |
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
	always @(posedge CLK) begin
		if (EFall) begin
			if (TimerTC) Timer <= 0;
			else Timer <= Timer+1;
			RefReq <= !(Timer==4'h0 || Timer==4'h1);
			TimerTC <= Timer[3:0]==4'h9;
		end
	end
	assign RefUrg = Timer[3];
	
	/* Long timer counts from 0 to 8191 -- 8192 states == 115.033 ms */
	reg [12:0] LTimer;
	reg LTimerTC;
	always @(posedge CLK) begin
		if (EFall && TimerTC) begin
			LTimer <= LTimer+1;
			LTimerTC <= LTimer[12:0]==13'h1FFE;
		end
	end
	
	reg nIPL2r; always @(posedge CLK) nIPL2r <= nIPL2;
	
	/* Startup sequence control */
	reg [1:0] INITS = 0;
	wire INITSTC = EFall && TimerTC && LTimerTC;
	always @(posedge CLK) begin
		case (INITS[1:0])
			2'h0: begin
				AoutOE <= 0; // Tristate PDS address and control
				nRESout <= 0; // Hold reset low
				nBR_IOB <= 0; // Default to request bus
				if (INITSTC) INITS <= 1;
			end 2'h1: begin
				AoutOE <= 0;
				nRESout <= 0;
				nBR_IOB <= !(!nBR_IOB && nIPL2r); // Disable bus request if NMI pressed
				if (INITSTC && nIPL2r) INITS <= 2;
			end 2'h2: begin
				AoutOE <= !nBR_IOB;
				nRESout <= 0;
				if (INITSTC) INITS <= 3;
			end 2'h3: begin
				nRESout <= 1; // Release reset
				INITS <= 3;
			end
		endcase
	end

endmodule
