module FSB(
	/* MC68HC000 interface */
	input FCLK, input nAS, output reg nDTACK, output reg nVPA,
	/* MC68HC000 clock enable */
	input MCKEi, output reg MCKE,
	/* AS cycle detection */
	output BACT, output reg BACTr,
	/* Ready inputs */
	input ROMCS,
	input RAMCS, input RAMReady,
	input IOPWCS, input IOPWReady, input IONPReady,
	input IOQoSEN, input SndQoSReady,
	/* Interrupt acknowledge select */
	input IACS);

	/* MC68k clock enable */
	always @(negedge FCLK) MCKE <= MCKEi;

	/* AS cycle detection */
	reg ASrf = 0;
	always @(negedge FCLK) begin ASrf <= !nAS; end
	assign BACTu = !nAS || ASrf;
	assign BACT = BACTu && MCKE;
	always @(posedge FCLK) BACTr <= BACT;

	/* DTACK/VPA control */
	wire Ready = (RAMCS && !IOQoSEN && RAMReady && !IOPWCS) ||
                 (RAMCS && !IOQoSEN && RAMReady &&  IOPWCS && IOPWReady) ||
                 (ROMCS && !IOQoSEN) ||
                 (IONPReady && SndQoSReady);
	always @(posedge FCLK) nDTACK <= !(Ready && BACT && !IACS);
	always @(posedge FCLK, posedge nAS) begin
		if (nAS) nVPA <= 1;
		else nVPA <= !(Ready && BACT && IACS);
	end
	
endmodule
