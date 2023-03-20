module CNT(
	/* C8M clock input */
	input C8M,
	/* FSB clock and bus active signal */
	input FCLK, input LBACT,
	/* Refresh request */
	output reg RefReq, output RefUrgent,
	/* BERR output */
	output reg BERRTimeout,
	/* Reset, switch, button */
	input [3:1] SW, input nRESin, output reg nRESout, input nIPL2, 
	/* Mac PDS bus master control outputs */
	output reg AoutOE, output nAoutOE, output nBR_IOB, 
	/* Configuration outputs */
	output reg WarpEnable, output reg FastROMEN, output C20MEN, output C25MEN);

	/* Timer counts from 0 to 1100000 (96) -- 97 states == 12.382 us */
	reg [6:0] Timer = 0;
	wire TimerTC = Timer[6:5]==2'b11;
	always @(posedge C8M) Timer <= TimerTC ? 0 : Timer+1;

	/* Refresh timer sequence
	 * | Timer | RefReq | RefUrgent |
	 * |----------------------------|
	 * |   0   |   0    |     0     |
	 * |   1   |   0    |     0     |
	 * |   2   |   0    |     0     |
	 * |   3   |   0    |     0     |
	 * |   4   |   0    |     0     |
	 * |   5   |   0    |     0     |
	 * |   6   |   0    |     0     |
	 * |   7   |   0    |     0     |
	 * |   8   |   0    |     0     |
	 * |   9   |   1    |     0     |
	 * |  10   |   1    |     0     |
	 * |  11   |   1    |     0     |
	 * |  ...  |   1    |     0     |
	 * |  62   |   1    |     0     |
	 * |  63   |   1    |     0     |
	 * |  64   |   1    |     1     |
	 * |  65   |   1    |     1     |
	 * |  66   |   1    |     1     |
	 * |  ...  |   1    |     1     |
	 * |  93   |   1    |     1     |
	 * |  94   |   1    |     1     |
	 * |  95   |   1    |     1     |
	 * |  96   |   1    |     1     |
	 * back to timer==0
	 */
	assign RefUrgent = Timer[6];
	always @(posedge C8M) begin
		if (Timer[3]) RefReq <= 1;
		else if (TimerTC) RefReq <= 0;
	end

	/* LBACTr - LBACT synchronized to C16M clock domain */
	reg LBACTr;
	always @(posedge C8M) LBACTr <= LBACT;

	/* BERR generation in C8M clock domain */
	reg BERRArm = 0;
	always @(posedge C8M) begin
		if (LBACTr && TimerTC) begin
			BERRArm <= 1;
			if (BERRArm) BERRTimeout <= 1;
		end else if (!LBACTr) begin
			BERRArm <= 0;
			BERRTimeout <= 0;
		end
	end

	/* Long timer counts from 0 to 16384 -- 16385 states == 202.888 ms */
	reg [14:0] LTimer; // Long timer
	wire LTimerTC = LTimer[14];
	always @(posedge C8M) begin
		if (LTimerTC) LTimer <= 0;
		else LTimer <= LTimer+1;
	end
	
	/* IPL2 synchronizer */
	reg IPL2r;
	always @(posedge C8M) IPL2r <= !nIPL2;
	
	/* Startup sequence control */
	reg [1:0] PORS = 0;
	reg Disable = 0;
	reg BR_IOB = 0; assign nBR_IOB = !BR_IOB;
	assign nAoutOE = !AoutOE;
	always @(posedge C8M) begin
		case (PORS)
			0: begin
				AoutOE <= 0; // Tristate PDS address and control
				nRESout <= 0; // Hold reset low
				Disable <= 0;
				if (LTimerTC) PORS <= 1;
			end 1: begin
				AoutOE <= 0; // Tristate PDS address and control
				nRESout <= 0; // Hold reset low
				Disable <= Disable | IPL2r;
				if (!IPL2r && LTimerTC) begin
					BR_IOB <= !Disable;
					PORS <= 2;
				end
			end 2: begin
				AoutOE <= 0; // Tristate PDS address and control
				nRESout <= 0; // Hold reset low
				if (LTimerTC) PORS <= 3;
			end 3: begin
				AoutOE <= BR_IOB;
				// Wait until LTimerTC to release reset
				if (LTimerTC) nRESout <= 1;
				else nRESout = 0;
				PORS <= 3;
			end
		endcase
	end

	// Enable both oscillators... only mount one
	assign C20MEN = 1;
	assign C25MEN = 1;
	// Enable fast ROM
	assign FastROMEN = 1;

endmodule
