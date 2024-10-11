module CNT(
	/* FSB clock and E clock inputs */
	input CLK, input C8M, input E,
	/* Power-on reset */
	output reg nPOR,
	/* Refresh request */
	output reg RefReq, output reg RefUrg,
	/* Reset, button */
	output reg nRESout, input nRESin, input nIPL2, 
	/* Mac PDS bus master control outputs */
	output reg AoutOE, output reg nBR_IOB,
	/* QoS select inputs */
	input nAS,
	input ASrf,
	input BACT,
	input IACKCS,
	input VIACS,
	input IWMCS,
	input SCCCS,
	input SCSICS,
	input SndCSWR,
	/* QoS settings inputs */
	input SlowIACK,
	input SlowVIA,
	input SlowIWM,
	input SlowSCC,
	input SlowSCSI,
	input SlowSnd,
	input SlowClockGate,
	input [3:0] SlowTimeout,
	/* QoS outputs */
	output reg QoSEN,
	output reg MCKE);
	
	/* E clock synchronization */
	reg [1:0] Er; always @(posedge CLK) Er[1:0] <= { Er[0], E };
	wire EFall = Er[1] && !Er[0];
	
	/* C8M clock synchronization */
	reg [3:0] C8Mr; always @(posedge CLK) C8Mr[3:0] <= { C8Mr[2:0], C8M };
	wire C8MFall =  C8Mr[1] && !C8Mr[0]; // C8M falling edge detect
	
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
	wire TimerTC = Timer==10;
	reg TimerTick;
	always @(posedge CLK) begin
		if (EFall) begin
			if (TimerTC) Timer <= 0;
			else Timer <= Timer+1;
			RefReq <= Timer!=10;
			RefUrg <= Timer==8 || Timer==9;
		end
	end
	always @(posedge CLK) TimerTick <= EFall && TimerTC;

	/* QoS select latches */
	reg QoSCSr;
	always @(posedge CLK) begin
		QoSCSr <= !nRESin ||
			(!nAS && SlowIACK  && IACKCS) ||
			(!nAS && SlowVIA   && VIACS) ||
			(!nAS && SlowIWM   && IWMCS) ||
			(!nAS && SlowSCC   && SCCCS) ||
			(!nAS && SlowSCSI  && SCSICS) ||
			(!nAS && SlowSnd   && SndCSWR);
	end

	/* QoS timer
	 * In the absence of a QoS trigger, QS==0.
	 * When Qos triggered, QS is set to 1 and counts 1, 2, 3, 0.
	 * While QS!=0, QoS is enabled.
	 * QoS enable period is 196.588 us - 210.630 us */
	reg [3:0] QS;
	always @(posedge CLK) begin
		if (QoSCSr) QS <= 15;
		else if (QS==0) QS <= 0;
		else if (TimerTick) QS <= QS-1;
	end

	/* QoS enable control */
	always @(posedge CLK) if (!BACT) QoSEN <= QS!=0 || SlowTimeout==0;
	
	/* MC68k clock gating during QoS */
	always @(negedge CLK, negedge nAS) begin
		if (!nAS) MCKE <= 1;
		else MCKE <= ASrf || !QoSEN || C8MFall || !SlowClockGate;
	end
	
	/* Long timer counts from 0 to 4095.
	 * 4096 states == 57.516 ms */
	reg [11:0] LTimer;
	wire LTimerTC = LTimer[11:0]==12'hFFF;
	reg LTimerTick;
	always @(posedge CLK) if (TimerTick) LTimer <= LTimer+1;
	always @(posedge CLK) LTimerTick <= TimerTick && LTimerTC;

	/* C8M duty cycle check and power-on reset */
	always @(posedge CLK) begin
		if (C8Mr[3:0]==4'b0000 || C8Mr[3:0]==4'b1111) nPOR <= 0;
		else if (C8Mr[1:0]==2'b01) nPOR <= 1;
	end

	/* Startup sequence state control */
	reg [1:0] IS = 0;
	always @(posedge CLK) begin
		if (!nPOR) IS <= 0;
		else case (IS[1:0])
			0: if (LTimerTick) IS <= 1;
			1: if (LTimerTick) IS <= 2;
			2: if (LTimerTick && nIPL2) IS[0] <= 1;
			3: IS <= 3;
		endcase
	end

	/* Startup sequence */
	always @(posedge CLK) begin
		case (IS[1:0])
			0, 1: begin
				AoutOE <= 0; // Tristate PDS address and control
				nRESout <= 0; // Hold reset low
				nBR_IOB <= 0; // Default to request bus
			end 2: begin
				AoutOE <= 0;
				nRESout <= 0;
				if (!nIPL2) nBR_IOB <= 1; // Disable bus request if NMI pressed
			end 3: begin
				AoutOE <= !nBR_IOB;
				if (LTimerTick) nRESout <= 1; // Release reset after a while
			end
		endcase
	end

endmodule
