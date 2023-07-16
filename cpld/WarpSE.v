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
	input C20MEN,
	output C25MEN);

	/* FSB clock oscillator enable */
	assign C25MEN = 1;

	/* Reset input and open-drain output */
	wire nRESin = nRES;
	wire nRESout;
	assign nRES = !nRESout ? 1'b0 : 1'bZ;

	/* AS cycle detection */
	wire BACT;
	wire [3:1] BACTr;
	wire WS;

	/* Refresh request clock */
	wire RefClk;
	
	/* FSB chip select signals */
	wire Overlay;
	wire IOCS, IOPWCS, IACS;
	wire ROMCS, ROMCS4X, SndROMCS;
	wire RAMCS, RAMCS0X, SndRAMCSWR;
	CS cs(
		/* MC68HC000 interface */
		A_FSB[23:08], FCLK, nRESin, nWE_FSB,
		/* /AS cycle detection */
		BACT,
		/* Overlay */
		Overlay,
		/* Device select outputs */
		IOCS, IOPWCS, IACS,
		ROMCS, ROMCS4X,
		RAMCS, RAMCS0X, SndRAMCSWR);

	wire RAMReady;
	RAM ram(
		/* MC68HC000 interface */
		FCLK, A_FSB[21:1], nWE_FSB,
		nAS_FSB, nLDS_FSB, nUDS_FSB, nDTACK_FSB,
		/* AS cycle detection */
		BACT, BACTr,
		/* Select and ready signals */
		RAMCS, RAMCS0X, ROMCS, RAMReady,
		/* Refresh Counter Interface */
		RefClk, 
		/* DRAM and NOR flash interface */
		RA[11:0], nRAS, nCAS,
		nRAMLWE, nRAMUWE, nOE, nROMCS, nROMWE);

	wire IOReady, IOPWReady;
	wire IORDREQ, IOWRREQ;
	wire IOL0, IOU0;
	wire ALE0S, ALE0M, ALE1;
	assign nADoutLE0 = ~(ALE0S || ALE0M);
	assign nADoutLE1 = ~ALE1;
	wire IOACT, IODONE, IOBERR;
	IOBS iobs(
		/* MC68HC000 interface */
		FCLK, nWE_FSB, nAS_FSB, nLDS_FSB, nUDS_FSB,
		/* AS cycle detection */
		BACT,
		/* Select signals */
		IOCS, IOPWCS, Overlay,
		/* FSB cycle termination outputs */
		IOReady, IOPWReady, nBERR_FSB,
		/* Read data OE control */
		nDinOE,
		/* IOB Master Controller Interface */
		IORDREQ, IOWRREQ,
		IOACT, IODONE, IOBERR,
		/* FIFO primary level control */
		ALE0S, IOL0, IOU0,
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
		C16M, C8M, E,
		nAS_IOBout, nLDS_IOBout, nUDS_IOBout, nVMA_IOBout,
		nDTACK_IOB, nVPA_IOB, nBERR_IOB, nRESin,
		/* PDS address and data latch control */
		AoutOE, nDoutOE, ALE0M, nDinLE,
		/* IO bus slave port interface */
		IORDREQ, IOWRREQ, IOL0, IOU0,
		IOACT, IODONE, IOBERR);

	wire QoSReady;
	CNT cnt(
		/* FSB clock, C8M clock, E clock inputs */
		FCLK, C8M, E,
		/* Refresh request */
		RefClk,
		/* Reset, button */
		nRESout, nIPL2, 
		/* Mac PDS bus master control outputs */
		AoutOE, nBR_IOB,
		/* Sound QoS */
		BACT, WS, SndRAMCSWR, QoSReady);
	
	FSB fsb(
		/* MC68HC000 interface */
		FCLK, nAS_FSB, nDTACK_FSB, nVPA_FSB,
		/* FSB cycle detection */
		BACT, BACTr, WS,
		/* Ready inputs */
		ROMCS4X,
		RAMCS0X, RAMReady,
		IOPWCS, IOPWReady, IOReady,
		QoSReady,
		/* Interrupt acknowledge select */
		IACS);

endmodule
