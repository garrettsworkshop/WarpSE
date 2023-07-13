module CNT(
	/* FSB clock, C8M clock, E clock inputs */
	input CLK, input C8M, input E,
	/* Refresh request */
	output RefClk,
	/* Reset, button */
	output reg nRESout, input nIPL2, 
	/* Mac PDS bus master control outputs */
	output reg AoutOE, output reg nBR_IOB,
	/* Sound QoS */
	input BACT, input WS, input SndRAMCSWR, output reg QoSReady);
	
	/* E clock synchronization */
	reg [1:0] Er; always @(posedge CLK) Er[1:0] <= { Er[0], E };
	wire EFall = Er[1] && !Er[0];

	/* C8M clock synchronization */
	reg [1:0] C8Mr; always @(posedge CLK) C8Mr[1:0] <= { C8Mr[0], C8M };
	wire C8MFall = C8Mr[1] && !C8Mr[0];

	/* NMI button synchronization */
	reg nIPL2r; always @(posedge CLK) nIPL2r <= nIPL2;
	
	/* Startup sequence state */
	reg [1:0] IS = 0;

	/* Timer counts from 0 to 1010 (10) -- 11 states == 14.042 us
    *	Refresh timer sequence
	 * |  Timer  | RefReq |   RefUrg  |
	 * |---------|--------|-----------|
	 * | 0  0000 |   0    |     0     |
	 * | 1  0001 |   1    |     0     |
	 * | 2  0010 |   1    |     0     |
	 * | 3  0011 |   1    |     0     |
	 * | 4  0100 |   1    |     0     |
	 * | 5  0101 |   1    |     0     |
	 * | 6  0110 |   1    |     0     |
	 * | 7  0111 |   1    |     0     |
	 * | 8  1000 |   1    |     0     |
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
			TimerTC <= Timer==9;
		end
	end
	assign RefClk = Timer[3];

	/* Long timer counts from 0 to 4095.
	 * 4096 states == 57.516 ms */
	reg [11:0] LTimer;
	reg LTimerTC;
	/* Sound QoS trigger
	 * Sound timer counts from 1 to 3
	 * starting at first sound RAM access.
	 * Period is 28.124 us - 42.240 us */
	reg [1:0] STimer;
	reg SndSlowEN;
	always @(posedge CLK) begin
		if (BACT && SndRAMCSWR) begin
			STimer <= 1;
			SndSlowEN <= 1;
		end else if (STimer==0) begin
			STimer <= 0;
			SndSlowEN <= 0;
		end else if (EFall && TimerTC) begin
			LTimer <= LTimer+1;
			SndSlowEN <= STimer!=3;
		end
		LTimerTC <= LTimer[11:0]==12'hFFE;
	end

	/* Sound QoS */
	reg [6:0] Credits;
	always @(posedge CLK) begin
		if (!SndSlowEN) Credits <= 8;
		else if (!C8MFall && !WS) Credits <= Credits+1;
		else if ( C8MFall && !WS) Credits <= Credits;
		else if (!C8MFall &&  WS) Credits <= Credits;
		else if ( C8MFall &&  WS) Credits <= Credits-1;
	end
	always @(posedge CLK) if (!BACT || !QoSReady) QoSReady <= Credits[6:3]==0;

	/* Startup sequence state control */
	wire ISTC = EFall && TimerTC && LTimerTC;
	always @(posedge CLK) begin
		case (IS[1:0])
			0: begin
				AoutOE <= 0; // Tristate PDS address and control
				nRESout <= 0; // Hold reset low
				nBR_IOB <= 0; // Default to request bus
				if (ISTC) IS <= 1;
			end 1: begin
				AoutOE <= 0;
				nRESout <= 0;
				nBR_IOB <= !(!nBR_IOB && nIPL2r); // Disable bus request if NMI pressed
				if (ISTC && nIPL2r) IS <= 2;
			end 2: begin
				AoutOE <= !nBR_IOB;
				nRESout <= 0;
				if (ISTC) IS <= 3;
			end 3: begin
				nRESout <= 1; // Release reset
				IS <= 3;
			end
		endcase
	end
endmodule
