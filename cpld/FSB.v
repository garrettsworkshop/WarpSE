module FSB(
	/* MC68HC000 interface */
	input FCLK, input nAS, output reg nDTACK, output reg nVPA,
	/* AS cycle detection */
	output BACT,
	/* Ready inputs */
	input ROMCS,
	input RAMCS, input RAMReady,
	input IOPWCS, input IOPWReady, input IONPReady,
	input QoSCS, input QoSReady,
	/* Interrupt acknowledge select */
	input IACS);

	/* AS cycle detection */
	reg ASrf = 0;
	always @(negedge FCLK) begin ASrf <= !nAS; end
	assign BACT = !nAS || ASrf; // BACT - bus active


	/* DTACK/VPA control */
	wire Ready = /*(RAMCS && RAMReady && !IOPWCS) ||*/
				 (/*RAMCS && RAMReady &&*/ IOPWCS && IOPWReady /*&& !QoSCS*/) ||
				 /*(RAMCS && RAMReady &&  IOPWCS && IOPWReady &&  QoSCS && QoSReady)*/ ||
				 (ROMCS) || (IONPReady);
	always @(posedge FCLK) nDTACK <= !(Ready && BACT && !IACS);
	always @(posedge FCLK, posedge nAS) begin
		if (nAS) nVPA <= 1;
		else nVPA <= !(Ready && BACT && IACS);
	end
	
endmodule
