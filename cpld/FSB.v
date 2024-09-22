module FSB(
	/* MC68HC000 interface */
	input FCLK, input nAS, output reg nDTACK, output reg nVPA,
	/* AS cycle detection */
	output BACT, output reg BACTr,
	/* Ready inputs */
	input ROMCS,
	input RAMCS, input RAMReady,
	input IOPWCS, input IOPWReady, input IONPReady,
	input QoSEN,
	/* Interrupt acknowledge select */
	input IACS);

	/* AS cycle detection */
	reg ASrf = 0;
	always @(negedge FCLK) begin ASrf <= !nAS; end
	assign BACT = !nAS || ASrf; // BACT - bus active
	always @(posedge FCLK) BACTr <= BACT;

	/* DTACK/VPA control */
	wire Ready = (RAMCS && !QoSEN && RAMReady && !IOPWCS) ||
                 (RAMCS && !QoSEN && RAMReady &&  IOPWCS && IOPWReady) ||
                 (ROMCS && !QoSEN) ||
                 (IONPReady);
	always @(posedge FCLK) nDTACK <= !(Ready && BACT && !IACS);
	always @(posedge FCLK, posedge nAS) begin
		if (nAS) nVPA <= 1;
		else nVPA <= !(Ready && BACT && IACS);
	end
	
endmodule
