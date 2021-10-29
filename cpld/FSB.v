module FSB(
	/* MC68HC000 interface */
	input FCLK, input nAS, output reg nDTACK, output nVPA, output nBERR,
	/* AS cycle detection */
	output BACT,
	/* Ready inputs */
	input Ready0, input Ready1, input Ready2,
	/* BERR inputs */
	input BERR0, input BERR1,
	/* Interrupt acknowledge select */
	input IACS);

	/* AS cycle detection */
	reg ASrf = 0;
	always @(negedge FCLK) begin ASrf <= ~nAS; end
	assign BACT = ~nAS || ASrf;
	
	/* Ready and BERR "remember" */
	reg Ready0r, Ready1r, Ready2r;
	reg BERR0r, BERR1r;
	wire Ready = (Ready0 || Ready0r) && 
					 (Ready1 || Ready1r) && 
					 (Ready2 || Ready2r);
	wire BERR = (BERR0 || BERR0r || BERR1 || BERR1r);
	assign nBERR = ~(~nAS && BERR);
	always @(posedge FCLK) begin
		if (~BACT) begin
			Ready0r <= 0;
			Ready1r <= 0;
			Ready2r <= 0;
			BERR0r <= 0;
			BERR1r <= 0;
		end else begin
			if (Ready0) Ready0r <= 1;
			if (Ready1) Ready1r <= 1;
			if (Ready2) Ready2r <= 1;
			if (BERR0) BERR0r <= 1;
			if (BERR1) BERR1r <= 1;
		end
	end

	/* DTACK/VPA control */
	reg VPA;
	assign nVPA = ~(~nAS && VPA);
	always @(posedge FCLK) begin
		if (~BACT) begin
			nDTACK <= 1;
			VPA <= 0;
		end else if (Ready && ~BERR) begin			
			nDTACK <= IACS;
			VPA <= IACS;
		end
	end
	
endmodule
