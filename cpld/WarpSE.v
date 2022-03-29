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
	input nRES,
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
	input [2:0] SW,
	output CLK20EN,
	output CLK25EN);

	/* DIP switches */
	assign CLK20EN =  SW[0];
	assign CLK25EN = !SW[0];
	wire MotherboardROMEN = !SW[1];

	/* AS cycle detection */
	wire BACT;

	/* Refresh request/ack signals */
	wire RefReq, RefUrgent, RefAck;
	
	wire IOCS, SCSICS, IOPWCS, IACS, ROMCS, RAMCS, SndRAMCSWR;
	CS cs(
		/* Setting input */
		MotherboardROMEN,
		/* MC68HC000 interface */
		A_FSB[23:08], CLK_FSB, nRES, nWE_FSB,
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
		RefReq, RefUrgent, RefAck,
		/* DRAM and NOR flash interface */
		RA[11:0], nRAS, nCAS,
		nRAMLWE, nRAMUWE, nOE, nROMCS, nROMWE);

	wire Ready_IOBS, BERR_IOBS;
	wire Park, IOREQ, IOACT, IOBERR;
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
		nBR_IOB, nAS_IOBout, nLDS_IOBout, nUDS_IOBout, nVMA_IOBout,
		nAS_IOB, nBG_IOB, nDTACK_IOB, nVPA_IOB, nBERR_IOB, nRES,
		/* PDS address and data latch control */
		nAoutOE, nDoutOE, ALE0M, nDinLE,
		/* IO bus slave port interface */
		IOACT, IOBERR,
		Park, IOREQ, IOL0, IOU0, IORW0);

	wire TimeoutA, TimeoutB;
	CNT cnt(
		/* FSB clock and AS detection */
		CLK_FSB, BACT,
		/* Refresh request */
		RefReq, RefUrgent, RefAck,
		/* Timeout signals */
		TimeoutA, TimeoutB);

	/* Accelerator Disable Control */
	reg RESr0 = 0;
	reg RESr1 = 0;
	reg RESr2 = 0;
	reg IPL2r0 = 0;
	reg IPL2r1 = 0;
	reg RESDone = 0;
	reg Disable = 0;
	assign Park = ~Disable;
	always @(posedge CLK_FSB) begin
		RESr0  <= ~nRES;  RESr1  <= RESr0;  RESr2  <= RESr1;
		IPL2r0 <= ~nIPL2; IPL2r1 <= IPL2r0;
		if ( RESr0 &&  RESr1 && RESr2 && ~RESDone && IPL2r0 && IPL2r1) Disable <= 1;
		if (~RESr0 && ~RESr1 && RESr2) RESDone <= 1;
	end
	
	FSB fsb(
		/* MC68HC000 interface */
		CLK_FSB, nAS_FSB, nDTACK_FSB, nVPA_FSB, nBERR_FSB,
		/* AS cycle detection */
		BACT,
		/* Ready and IA inputs */
		Ready_RAM, Ready_IOBS, ~(SndRAMCSWR && ~TimeoutA), Disable,
		/* BERR inputs */
		(~SCSICS && TimeoutB), BERR_IOBS,
		/* Interrupt acknowledge select */
		IACS);

endmodule
