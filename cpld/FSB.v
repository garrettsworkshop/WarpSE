module FSB(
	/* MC68HC000 interface */
	input FCLK, input nAS, output reg nDTACK, output reg nVPA,
	/* AS cycle detection */
	output BACT, output reg [3:1] BACTr, output reg WS,
	/* Ready inputs */
	input ROMCS,
	input RAMCS, input RAMReady,
	input IOPWCS, input IOPWReady, input IOReady,
	input QoSReady,
	/* Interrupt acknowledge select */
	input IACS);

	/* AS cycle detection */
	reg ASrf = 0;
	always @(negedge FCLK) begin ASrf <= !nAS; end
	assign BACT = !nAS || ASrf; // BACT - bus active
	always @(posedge FCLK) BACTr[3:1] <= { BACTr[2:1], BACT };
	always @(posedge FCLK) WS <= BACTr[3:1]==3'b111 && BACT;

	/* DTACK/VPA control */
	wire Ready = (QoSReady && RAMCS && RAMReady && !IOPWCS) ||
				 (            RAMCS && RAMReady &&  IOPWCS && IOPWReady) ||
				 (QoSReady && ROMCS) || (IOReady);
	always @(posedge FCLK) nDTACK <= !(Ready && BACT && !IACS);
	always @(posedge FCLK, posedge nAS) begin
		if (nAS) nVPA <= 1;
		else nVPA <= !(Ready && BACT && IACS);
	end
	
endmodule
