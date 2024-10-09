module FSB(
	/* MC68HC000 interface */
	input FCLK, input nAS, output reg nDTACK, output reg nVPA,
	/* AS cycle detection */
	output reg ASrf, output BACT, output reg BACTr,
	/* Ready inputs */
	input ROMCS,
	input RAMCS, input RAMReady,
	input IOPWCS, input IOPWReady, input IONPReady,
	input QoSEN, input SndQoSReady,
	/* Interrupt acknowledge select */
	input IACS);

	/* AS cycle detection */
	always @(negedge FCLK) begin ASrf <= !nAS; end
	assign BACT = !nAS || ASrf; // BACT - bus active
	always @(posedge FCLK) BACTr <= BACT;

	/* DTACK/VPA control */
	wire Ready = (RAMCS && !QoSEN && RAMReady && !IOPWCS) ||
                 (RAMCS && !QoSEN && RAMReady &&  IOPWCS && IOPWReady) ||
                 (ROMCS && !QoSEN) ||
                 (IONPReady && SndQoSReady);
	always @(posedge FCLK, posedge nAS) begin
		if (nAS) nDTACK <= 1;
		else nDTACK <= !(Ready && !IACS);
	end
	always @(posedge FCLK, posedge nAS) begin
		if (nAS) nVPA <= 1;
		else nVPA <= !(Ready && IACS);
	end
	
endmodule
