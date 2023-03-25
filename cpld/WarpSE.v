module WarpSE(
	input [23:1] A_FSB,
	input nAS_FSB,
	input nLDS_FSB,
	input nUDS_FSB,
	input nWE_FSB,
	output nDTACK_FSB,
	output nVPA_FSB,
	output nBERR_FSB,
	input FCLK,
	input C16M,
	input C8M,
	input E,
	input nDTACK_IOB,
	input nVPA_IOB,
	output nVMA_IOB,
	output nAS_IOB,
	output nUDS_IOB,
	output nLDS_IOB,
	output nBR_IOB,
	input nBG_IOB,
	input nBERR_IOB,
	inout nRES,
	input nIPL2,
	output nROMCS,
	output nRAMLWE,
	output nRAMUWE,
	output nROMWE,
	output nRAS,
	output nCAS,
	output [11:0] RA,
	output nOE,
	output nADoutLE0,
	output nADoutLE1,
	output nAoutOE,
	output nDoutOE,
	output nDinOE,
	output nDinLE,
	input [3:1] SW,
	output C20MEN,
	output C25MEN);	

	/* Reset input and open-drain output */
	wire nRESin = nRES;
	wire nRESout;
	assign nRES = !nRESout ? 1'b0 : 1'bZ;

	/* E clock registration */
	reg Er; always @(negedge C8M) begin Er <= E; end

	/* AS cycle detection */
	wire BACT;

	/* Refresh request/ack signals */
	wire RefReq, RefUrgent;

	/* Fast ROM enable setting */
	wire FastROMEN;
	
	/* FSB chip select signals */
	wire IOCS, SCSICS, IOPWCS, IACS, ROMCS, RAMCS, SndRAMCSWR;
	CS cs(
		/* Setting input */
		FastROMEN,
		/* MC68HC000 interface */
		A_FSB[23:08], FCLK, nRESin, nWE_FSB,
		/*  AS cycle detection */
		BACT,
		/* Device select outputs */
		IOCS, SCSICS, IOPWCS, IACS, ROMCS, RAMCS, SndRAMCSWR);

	wire RAM_Ready;
	RAM ram(
		/* MC68HC000 interface */
		FCLK, A_FSB[21:1], nWE_FSB, nAS_FSB, nLDS_FSB, nUDS_FSB,
		/*  AS cycle detection */
		BACT,
		/* Select and ready signals */
		RAMCS, ROMCS, RAM_Ready,
		/* Refresh Counter Interface */
		RefReq, RefUrgent,
		/* DRAM and NOR flash interface */
		RA[11:0], nRAS, nCAS,
		nRAMLWE, nRAMUWE, nOE, nROMCS, nROMWE);

	wire IOBS_Ready;
	wire IOREQ, IOACT, IOBERR;
	wire ALE0S, ALE0M, ALE1;
	assign nADoutLE0 = ~(ALE0S || ALE0M);
	assign nADoutLE1 = ~ALE1;
	wire IORW0, IOL0, IOU0;
	IOBS iobs(
		/* MC68HC000 interface */
		FCLK, nWE_FSB, nAS_FSB, nLDS_FSB, nUDS_FSB,
		/* AS cycle detection, FSB BERR */
		BACT,
		/* Select and ready signals */
		IOCS, IOPWCS, IOBS_Ready, nBERR_FSB,
		/* Read data OE control */
		nDinOE,
		/* IOB Master Controller Interface */
		IOREQ, IOACT, IOBERR,
		/* FIFO primary level control */
		ALE0S, IORW0, IOL0, IOU0,
		/* FIFO secondary level control */
		ALE1);
	
	wire AoutOE;
	assign nAoutOE = !AoutOE;
	wire nAS_IOBout, nLDS_IOBout, nUDS_IOBout, nVMA_IOBout;
	assign nAS_IOB = AoutOE ? nAS_IOBout : 1'bZ;
	assign nLDS_IOB = AoutOE ? nLDS_IOBout : 1'bZ;
	assign nUDS_IOB = AoutOE ? nUDS_IOBout : 1'bZ;
	assign nVMA_IOB = AoutOE ? nVMA_IOBout : 1'bZ;
	IOBM iobm(
		/* PDS interface */
		C16M, C8M, E, Er,
		nAS_IOBout, nLDS_IOBout, nUDS_IOBout, nVMA_IOBout,
		nDTACK_IOB, nVPA_IOB, nBERR_IOB, nRESin,
		/* PDS address and data latch control */
		AoutOE, nDoutOE, ALE0M, nDinLE,
		/* IO bus slave port interface */
		IOACT, IOBERR,
		IOREQ, IOL0, IOU0, IORW0);

	CNT cnt(
		/* C8M and E clocks */
		C8M, E, Er,
		/* Refresh request */
		RefReq, RefUrgent,
		/* Reset, switch, button */
		SW[3:1], nRESout, nIPL2, 
		/* Mac PDS bus master control outputs */
		AoutOE, nBR_IOB, 
		/* Configuration outputs */
		FastROMEN, C20MEN, C25MEN);
	
	FSB fsb(
		/* MC68HC000 interface */
		FCLK, nAS_FSB, nDTACK_FSB, nVPA_FSB,
		/* FSB cycle detection */
		BACT,
		/* Ready inputs */
		RAM_Ready, IOBS_Ready, 1,
		/* Interrupt acknowledge select */
		IACS);

endmodule
