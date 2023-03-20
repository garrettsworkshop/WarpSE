module FSB(
	/* MC68HC000 interface */
	input FCLK, input nAS, output reg nDTACK, output nVPA, output nBERR,
	/* AS cycle detection */
	output BACT, output LBACT,
	/* Ready inputs */
	input Ready0, input Ready1, input Ready2,
	/* BERR input from IOB slave port */
	input IOBS_BERR,
	/* Interrupt acknowledge select */
	input IACS);

	/* AS cycle detection */
	reg ASrf = 0;
	always @(negedge FCLK) begin ASrf <= ~nAS; end
	assign BACT = ~nAS || ASrf; // BACT - bus active

	/* LBACT - "Long BACT" */
	reg [1:0] BACTCnt = 0;
	always @(posedge FCLK) begin
		if (!BACT) begin
			BACTCnt <= 0;
			LBACT <= 0;
		end else begin
			BACTCnt <= BACTCnt+1;
			if (BACTCnt==2'b11 && BACT) LBACT <= 1;
		end
	end
	
	/* Ready generation and bypass */
	reg Ready0r, Ready1r, Ready2r;
	wire Ready = (Ready0 || Ready0r) && 
				 (Ready1 || Ready1r) && 
				 (Ready2 || Ready2r);
	always @(posedge FCLK) begin
		if (~BACT) begin
			Ready0r <= 0;
			Ready1r <= 0;
			Ready2r <= 0;
		end else begin
			if (Ready0) Ready0r <= 1;
			if (Ready1) Ready1r <= 1;
			if (Ready2) Ready2r <= 1;
		end
	end
	
	/* BERR generation */
	assign nBERR = ~(~nAS && IOBS_BERR);

	/* DTACK/VPA control */
	reg VPA;
	assign nVPA = ~(~nAS && VPA);
	always @(posedge FCLK) begin
		if (~BACT) begin
			nDTACK <= 1;
			VPA <= 0;
		end else if (Ready) begin			
			nDTACK <= IACS;
			VPA <= IACS;
		end
	end
	
endmodule
