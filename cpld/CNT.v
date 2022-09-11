module CNT(
	/* C16M clock */
	input C16M,
	/* FSB clock and bus active signal */
	input FCLK, input BACT,
	/* Refresh request */
	output reg RefReq, output RefUrgent,
	/* BERR and QoS speed limit output */
	output reg BERRTimeout, output reg QoSGate,
	/* Reset, switch, button */
	input [3:1] SW, input nRESin, output reg nRESout, input nIPL2, 
	/* Configuration outputs */
	output reg nBR_IOB, output reg FastROMEN, output reg C20MEN, output reg C25MEN);

	/* Timer counts from 0 to 11100000 (224) -- 225 states == 14.36 uS */
	reg [7:0] Timer = 0;
	wire TimerTC = Timer[7:5]==3'b111;
	always @(posedge C16M) Timer <= TimerTC ? 0 : Timer+1;

	/* Refresh timer outputs
	 *        ___             _______________________________________
	 * RefReq    |___________|                                       |_________
	 *        ___^ Timer==0  ^ Timer==17                _____________^ Timer==0
	 * RefUrg    |_____________________________________|             |_________
	 *           ^ Timer==0                            ^ Timer==128  ^ Timer==0
	 */
	assign RefUrgent = Timer[7];
	always @(posedge C16M) begin
		if (Timer[4]) RefREQ <= 1;
		else if (TimerTC) RefREQ <= 0;
	end

	/* NBACT - "Narrow BACT" in FCLK clock domain */
	reg [1:0] BACTCnt = 0;
	reg NBACT;
	always @(posedge FCLK) begin
		if (!BACT) begin
			BACTCnt <= 0;
			NBACT <= 0;
		end else begin
			BACTCnt <= BACTCnt+1;
			if (BACTCnt==2'b11 && BACT) NBACT <= 1;
		end
	end

	/* NBACTr - NBACT synchronized to C16M clock domain */
	reg NBACTr;
	always @(posedge C16M) NBACTr <= NBACT;

	/* BERR generation in C16M clock domain */
	reg BERRArm = 0;
	reg BERRTimeout = 0;
	always @(posedge C16M) begin
		if (NBACTr && TimerTC) begin
			if (BERRArm) BERRTimeout <= 1;
		end else if (!NBACTr) begin
			BERRArm <= 0;
			BERRTimeout <= 0;
		end
	end

	/* Sound QoS counter */
	reg [15:0] SC; // Sound counter
	always @(posedge C16M) begin
		if (TimerTC) SC <= SC+1; // SC increment
	end

	/* IPL2 registration */
	reg nIPL2r;
	always @(posedge C16M) nIPL2r <= nIPL2;

	/* Startup sequence control */
	reg PORS = 0;
	always @(posedge C16M) begin
		case (PORS[1:0])
			0: begin
				nRESout <= !nRESr;
				if (nRESr) PORS <= 1;
			end 1: begin
				nRESout <= 0;
				if (TimerTC && nIPL2r) PORS <= 2;
			end 2: begin
				nRESout <= 0;
				if (TimerTC && SC[15:0]==16'hFFFF) PORS <= 3;
			end 3: begin
				nRESout <= 1;
			end
		endcase
	end

	/* Accelerator enable/disable control */
	always @(posedge CLK) begin
		if (PORS==0) begin
			if (nRESr) nBR_IOB <= nIPL2r;
			else nBR_IOB <= 1;
		end
	end

	// Enable both oscillators... only mount one
	assign C20MEN = 1;
	assign C25MEN = 1;

endmodule
	