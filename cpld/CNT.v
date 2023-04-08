module CNT(
	/* FSB clock and E clock inputs */
	input CLK, input E,
	/* Refresh request */
	output reg RefReq, output reg RefUrg,
	/* Reset, button */
	output reg nRESout, input nIPL2, 
	/* Mac PDS bus master control outputs */
	output reg AoutOE, output reg nBR_IOB,
	/* Sound QoS */
	input BACT, input SndRAMCSWR, output QoSReady);
	
	/* E clock synchronization */
	reg [1:0] Er;
	wire EFall = Er[1] && !Er[0];
	always @(posedge CLK) Er[1:0] <= { Er[0], E };
	
	/* NMI button synchronization */
	reg nIPL2r; always @(posedge CLK) nIPL2r <= nIPL2;

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
	 * | 9  1001 |   1    |     0     |
	 * | 10 1010 |   1    |     1     |
	 * back to timer==0
	 */
	reg [3:0] Timer = 0;
	wire TimerTC = RefUrg;
	always @(posedge CLK) begin
		if (EFall) begin
			if (TimerTC) Timer <= 0;
			else Timer <= Timer+1;
			RefUrg <= Timer==9;
			RefReq <= !(Timer==10);
		end
	end
	
	/* During init (IS!=3) long timer counts from 0 to 8191.
	 * 8192 states == 115.033 ms 
	 * During operation (IS==3) long timer counts from 0 to 1023
	 * starting at first sound RAM access.
	 * 8192 states == 14.379 ms */
	reg [12:0] LTimer;
	reg LTimerTC;
	always @(posedge CLK) begin
		if (EFall && TimerTC) begin
			if (IS==3) begin
				LTimer[12:10] <= 3'b000;
				if (LTimer==0 && BACT && VidRAMCSWR) LTimer <= 1;
				else if (LTimer==0) LTimer <= 0;
				else LTimer[9:0] <= LTimer+1;
			end else LTimer <= LTimer+1;
			LTimerTC <= LTimer[12:0]==13'h1FFE;
		end
	end

	/* Sound QoS */
	reg [3:0] WS = 0;
	always @(posedge CLK) begin
		if (BACT) begin
			if (QoSReady) QoSReady <= 1;
			else if (WS==12) QoSReady <= 1;
			WS <= WS+1;
		end else begin
			if (LTimer!=0) QoSReady <= 0;
			else QoSReady <= 1;
			WS <= 0;
		end
	end

	/* Startup sequence control */
	reg [1:0] IS = 0;
	wire ISTC = EFall && TimerTC && LTimerTC;
	always @(posedge CLK) begin
		case (IS[1:0])
			2'h0: begin
				AoutOE <= 0; // Tristate PDS address and control
				nRESout <= 0; // Hold reset low
				nBR_IOB <= 0; // Default to request bus
				if (ISTC) IS <= 1;
			end 2'h1: begin
				AoutOE <= 0;
				nRESout <= 0;
				nBR_IOB <= !(!nBR_IOB && nIPL2r); // Disable bus request if NMI pressed
				if (ISTC && nIPL2r) IS <= 2;
			end 2'h2: begin
				AoutOE <= !nBR_IOB;
				nRESout <= 0;
				if (ISTC) IS <= 3;
			end 2'h3: begin
				nRESout <= 1; // Release reset
				IS <= 3;
			end
		endcase
	end

endmodule
