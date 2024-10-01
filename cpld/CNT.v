module CNT(
	/* FSB clock and E clock inputs */
	input CLK, input C8M, input E,
	/* Refresh request */
	output reg RefReq, output reg RefUrg,
	/* Reset, button */
	output reg nRESout, input nRESin, input nIPL2, 
	/* Mac PDS bus master control outputs */
	output reg AoutOE, output reg nBR_IOB,
	/* QoS control */
	input BACT,
	input BACTr,
	input IOQoSCS,
	input SndQoSCS,
	input IACKCS,
	output reg IOQoSEN,
	output reg MCKE);
	
	/* E clock synchronization */
	reg [1:0] Er; always @(posedge CLK) Er[1:0] <= { Er[0], E };
	wire EFall = Er[1] && !Er[0];
	
	/* C8M clock synchronization */
	reg [1:0] C8Mr; always @(posedge CLK) C8Mr[1:0] <= { C8Mr[0], C8M };
	wire C8MFall = C8Mr[1] && !C8Mr[0];
	
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
	
	/* During init (IS!=3) long timer counts from 0 to 3072.
	 * 3073 states == 43.151 ms */
	reg [11:0] LTimer;
	wire LTimerTC = LTimer[11:10]==2'b11;
	always @(posedge CLK) begin
		if (EFall && TimerTC) LTimer <= LTimer+1;
	end

	/* QoS select registers */
	reg IOQoSCSr;
	always @(posedge CLK) IOQoSCSr <= (BACT && (IOQoSCS || SndQoSCS || IACKCS)) || !nRESr;
	
	/* I/O QoS timer */
	reg [3:0] IOQS;
	always @(posedge CLK) begin
		if (IOQoSCSr) IOQS <= 4'hF;
		else if (IOQS==0) IOQS <= 0;
		else if (EFall && TimerTC) IOQS <= IOQS-1;
	end

	/* I/O QoS enable */
	always @(posedge CLK) if (!BACT) IOQoSEN <= IOQS!=0;

	/* MC68K clock enable */
	always @(posedge CLK) MCKE <= 1;//BACT || BACTr || !IOQoSEN || C8MFall;
	
	/* */
	reg LookReset;
	always @(posedge CLK) begin
		if (!nRESout) LookReset <= 0;
		else if (EFall) LookReset <= 1;
	end
	
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
				if (LookReset && !nRESr) IS <= 0;
			end
		endcase
	end
endmodule
