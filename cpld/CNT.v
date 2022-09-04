module CNT(
	/* C16M clock */
	input C16M,
	/* FSB clock and bus active signal */
	input FCLK, input BACT,
	/* Refresh request */
	output reg RefReq, output RefUrgent,
	/* BERR and QoS speed limit output */
	output reg BERRTimeout, output reg QoSReady,
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

	/* Sound QoS */
	reg [3:0] SC; // Sound counter
	always @(posedge C16M) begin
		if (PORDone && TimerTC) SC <= SC+1; // SC increment
		if SC[]
	end

	/* IPL2 and /RESET registration */
	reg nIPL2r, nRESr;
	always @(posedge C16M) begin
		nIPL2r <= nIPL2;
		nRESr <= nRES;
	end

	/* Startup sequence control */
	reg PORDone = 0;
	always @(posedge C16M) begin
		if (!PORDone) begin
			if (!nRESr) nRESout <= 1;
			else begin
				nRESout <= 0; // Re-enable reset
				PORDone <= 1; // Mark POR done
				// Decode buttons
				if (nRESr) begin // Reset not pressed: enable WarpSE
					nBR_IOB <= 0; // Request Mac bus
					FastROMEN <= 1; // Fast ROM enabled
				end else if (!nRES && nIPL2r) begin // Reset only: disable card
					nBR_IOB <= 1; // Don't request Mac bus
					FastROMEN <= 0; // Fast ROM enable is don't care
				end else if (!nRES && !nIPL2r) begin // Reset+IPL2: MB ROM
					nBR_IOB <= 0; // Request Mac bus
					FastROMEN <= 1; // Fast ROM disabled so as to use motherboard ROM
				end
			end
		end else if (SC[4]) nRESout <= 1; // Release reset to run
	end

	// Enable both oscillators... only mount one
	assign C20MEN = 1; // SW[0];
	assign C25MEN = 1; //!SW[0];

endmodule
	