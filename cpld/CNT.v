module CNT(
	/* FSB clock and E clock inputs */
	input CLK, input E,
	/* Refresh request */
	output reg RefReq, output reg RefUrg,
	/* Reset, button */
	output reg nRESout, input nRESin, input nIPL2, 
	/* Mac PDS bus master control outputs */
	output reg AoutOE, output reg nBR_IOB,
	/* QoS control */
	input BACT,
	input QoSCS,
	output reg QoSEN);
	
	/* E clock synchronization */
	reg [1:0] Er; always @(posedge CLK) Er[1:0] <= { Er[0], E };
	wire EFall = Er[1] && !Er[0];
	
	/* NMI and reset synchronization */
	reg nIPL2r; always @(posedge CLK) nIPL2r <= nIPL2;
	reg nRESr; always @(posedge CLK) nRESr <= nRESin;
	
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
			RefUrg <= Timer==8 || Timer==9;
			RefReq <= Timer!=10;
			TimerTC <= Timer==9;
		end
	end
	
	/* During init (IS!=3) long timer counts from 0 to 4095.
	 * 4096 states == 57.516 ms */
	reg [11:0] LTimer;
	reg LTimerTC;
	always @(posedge CLK) begin
		if (EFall && TimerTC) begin
			LTimer <= LTimer+1;
			LTimerTC <= LTimer[11:0]==12'hFFE;
		end
	end

	/* QoS select latch */
	reg QoSCSr;
	always @(posedge CLK) if (BACT) QoSCSr <= QoSCS;
	
	/* QoS timer
	 * In the absence of a QoS trigger, QS==0.
	 * When Qos triggered, QS is set to 1 and counts 1, 2, 3, 0.
	 * While QS!=0, QoS is enabled.
	 * QoS enable period is 28.124 us - 42.240 us */
	reg [1:0] QS;
	always @(posedge CLK) begin
		if (!nRESr || QoSCSr) QS[1:0] <= 1;
		else if (QS==0) QS[1:0] <= 0;
		else if (EFall && TimerTC) QS[1:0] <= QS+1;
	end

	/* QoS enable control */
	always @(posedge CLK) if (!BACT) QoSEN <= QoSCSr || QS!=0;

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
