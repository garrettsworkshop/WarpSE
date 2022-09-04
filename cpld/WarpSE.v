module WarpSE(
	input [23:1] A_FSB,
	input nAS_FSB,
	input nLDS_FSB,
	input nUDS_FSB,
	input nWE_FSB,
	output nDTACK_FSB,
	output nVPA_FSB,
	output nBERR_FSB,
	input CLK_FSB,
	input CLK2X_IOB,
	input CLK_IOB,
	input E_IOB,
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

	/* AS cycle detection */
	wire BACT;

	/* Refresh request/ack signals */
	wire RefReq, RefUrgent;

	/* Fast ROM enable setting */
	wire FastROMEN;
	
	wire IOCS, SCSICS, IOPWCS, IACS, ROMCS, RAMCS, SndRAMCSWR;
	CS cs(
		/* Setting input */
		FastROMEN,
		/* MC68HC000 interface */
		A_FSB[23:08], CLK_FSB, nRESin, nWE_FSB,
		/*  AS cycle detection */
		BACT,
		/* Device select outputs */
		IOCS, SCSICS, IOPWCS, IACS, ROMCS, RAMCS, SndRAMCSWR);

	wire Ready_RAM;
	RAM ram(
		/* MC68HC000 interface */
		CLK_FSB, A_FSB[21:1], nWE_FSB, nAS_FSB, nLDS_FSB, nUDS_FSB,
		/*  AS cycle detection */
		BACT,
		/* Select and ready signals */
		RAMCS, ROMCS, Ready_RAM,
		/* Refresh Counter Interface */
		RefReq, RefUrgent,
		/* DRAM and NOR flash interface */
		RA[11:0], nRAS, nCAS,
		nRAMLWE, nRAMUWE, nOE, nROMCS, nROMWE);

	wire Ready_IOBS, BERR_IOBS;
	wire IOREQ, IOACT, IOBERR;
	wire ALE0S, ALE0M, ALE1;
	assign nADoutLE0 = ~(ALE0S || ALE0M);
	assign nADoutLE1 = ~ALE1;
	wire IORW0, IOL0, IOU0;
	IOBS iobs(
		/* MC68HC000 interface */
		CLK_FSB, nWE_FSB, nAS_FSB, nLDS_FSB, nUDS_FSB,
		/* AS cycle detection, FSB BERR */
		BACT,
		/* Select and ready signals */
		IOCS, IOPWCS, Ready_IOBS, BERR_IOBS,
		/* Read data OE control */
		nDinOE,
		/* IOB Master Controller Interface */
		IOREQ, IOACT, IOBERR,
		/* FIFO primary level control */
		ALE0S, IORW0, IOL0, IOU0,
		/* FIFO secondary level control */
		ALE1);
	
	wire nAS_IOBout, nLDS_IOBout, nUDS_IOBout, nVMA_IOBout;
	assign nAS_IOB = nAoutOE ? 1'bZ : nAS_IOBout;
	assign nLDS_IOB = nAoutOE ? 1'bZ : nLDS_IOBout;
	assign nUDS_IOB = nAoutOE ? 1'bZ : nUDS_IOBout;
	assign nVMA_IOB = nAoutOE ? 1'bZ : nVMA_IOBout;
	IOBM iobm(
		/* PDS interface */
		CLK2X_IOB, CLK_IOB, E_IOB,
		nAS_IOBout, nLDS_IOBout, nUDS_IOBout, nVMA_IOBout,
		nAS_IOB, nBG_IOB, nDTACK_IOB, nVPA_IOB, nBERR_IOB, nRESin,
		/* PDS address and data latch control */
		nAoutOE, nDoutOE, ALE0M, nDinLE,
		/* IO bus slave port interface */
		IOACT, IOBERR,
		IOREQ, IOL0, IOU0, IORW0);

	wire BERRTimeout, QoSReady;
	CNT cnt(
		/* C16M  clock */
		C16M,
		/* FSB clock and bus active signal */
		FCLK, BACT,
		/* Refresh request */
		RefReq, RefUrgent,
		/* BERR and QoS speed limit output */
		BERRTimeout, QoSReady,
		/* Reset, switch, button */
		SW[3:1], nRESin, nRESout, nIPL2, 
		/* Configuration outputs */
		nBR_IOB, FastROMEN, C20MEN, C25MEN);
	
	FSB fsb(
		/* MC68HC000 interface */
		CLK_FSB, nAS_FSB, nDTACK_FSB, nVPA_FSB, nBERR_FSB,
		/* AS cycle detection */
		BACT,
		/* Ready and IA inputs */
		Ready_RAM, Ready_IOBS, (!SndRAMCSWR || QoSReady),
		/* BERR inputs */
		(~IOCS && BERRTimeout), BERR_IOBS,
		/* Interrupt acknowledge select */
		IACS);

endmodule
