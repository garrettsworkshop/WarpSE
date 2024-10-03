module WarpSE(
	input [23:1] A_FSB,
	output [23:22] GA,
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
	output nROMOE,
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
	output MCKE,
	input [5:0] DBG);

	/* MC68k clock enable */
	assign MCKE = 1;

	/* GA gated (translated) address output */
	assign GA[23:22] = A_FSB[23:22];
	/*assign GA[23:22] = (
		// $800000-$8FFFFF to $000000-$0FFFFF (1 MB)
		(A_FSB[23:20]==4'h8) ||
		// $700000-$7EFFFF to $300000-$3EFFFF (960 kB)
		(A_FSB[23:20]==4'h7 && A_FSB[19:16]!=4'hF) ||
		// $600000-$6FFFFF to $200000-$2FFFFF (1 MB)
		(A_FSB[23:20]==4'h6)) ? 2'b00 : A_FSB[23:22];*/

	/* Reset input and open-drain output */
	wire nRESin = nRES;
	wire nRESout;
	assign nRES = !nRESout ? 1'b0 : 1'bZ;

	/* AS cycle detection */
	wire BACT;
	wire BACTr;

	/* Refresh request/ack signals */
	wire RefReq, RefUrg;
	
	/* FSB chip select signals */
	wire IOCS, IORealCS, IOPWCS, IACS;
	wire ROMCS, ROMCS4X;
	wire RAMCS, RAMCS0X;
	wire QoSCS, SndQoSCS, QoSEN;
	CS cs(
		/* MC68HC000 interface */
		.A(A_FSB[23:08]),
		.CLK(FCLK),
		.nRES(nRESin),
		.nWE(nWE_FSB),
		/* /AS cycle detection */
		.BACT(BACT),
		/* QoS enable input */
		.QoSEN(QoSEN),
		/* Device select outputs */
		.IOCS(IOCS),
		.IORealCS(IORealCS),
		.IOPWCS(IOPWCS),
		.IACS(IACS),
		.ROMCS(ROMCS),
		.ROMCS4X(ROMCS4X),
		.RAMCS(RAMCS),
		.RAMCS0X(RAMCS0X),
		.QoSCS(QoSCS),
		.SndQoSCS(SndQoSCS));

	wire RAMReady;
	RAM ram(
		/* MC68HC000 interface */
		.CLK(FCLK),
		.A(A_FSB[21:1]),
		.nWE(nWE_FSB),
		.nAS(nAS_FSB),
		.nLDS(nLDS_FSB),
		.nUDS(nUDS_FSB),
		.nDTACK(nDTACK_FSB),
		/* AS cycle detection inputs */
		.BACT(BACT),
		.BACTr(BACTr),
		/* RAM and ROM select inputs */
		.RAMCS(RAMCS),
		.RAMCS0X(RAMCS0X),
		.ROMCS(ROMCS),
		.ROMCS4X(ROMCS4X),
		/* RAM ready output */
		.RAMReady(RAMReady),
		/* Refresh Counter Interface */
		.RefReqIn(RefReq),
		.RefUrgIn(RefUrg), 
		/* DRAM and NOR flash interface */
		.RA(RA[11:0]),
		.nRAS(nRAS),
		.nCAS(nCAS),
		.nLWE(nRAMLWE),
		.nUWE(nRAMUWE),
		.nOE(nOE),
		.nROMOE(nROMOE),
		.nROMWE(nROMWE));

	wire IONPReady, IOPWReady;
	wire IORDREQ, IOWRREQ;
	wire IOL0, IOU0;
	wire ALE0S, ALE0M, ALE1;
	assign nADoutLE0 = ~(ALE0S || ALE0M);
	assign nADoutLE1 = ~ALE1;
	wire IOACT, IODONE, IOBERR;
	IOBS iobs(
		/* MC68HC000 interface */
		.CLK(FCLK),
		.nWE(nWE_FSB),
		.nAS(nAS_FSB),
		.nLDS(nLDS_FSB),
		.nUDS(nUDS_FSB),
		/* AS cycle detection */
		.BACT(BACT),
		/* Select signals */
		.IOCS(IOCS),
		.IORealCS(IORealCS),
		.IOPWCS(IOPWCS),
		/* FSB cycle termination outputs */
		.IONPReady(IONPReady),
		.IOPWReady(IOPWReady),
		.nBERR_FSB(nBERR_FSB),
		/* Read data OE control */
		.nDinOE(nDinOE),
		/* IOB Master Controller Interface */
		.IORDREQ(IORDREQ),
		.IOWRREQ(IOWRREQ),
		.IOACT(IOACT),
		.IODONEin(IODONE),
		.IOBERR(IOBERR),
		/* FIFO primary level control */
		.ALE0(ALE0S),
		.IOL0(IOL0),
		.IOU0(IOU0),
		/* FIFO secondary level control */
		.ALE1(ALE1));

	wire AoutOE;
	assign nAoutOE = !AoutOE;
	wire nAS_IOBout, nLDS_IOBout, nUDS_IOBout, nVMA_IOBout;
	assign nAS_IOB = AoutOE ? nAS_IOBout : 1'bZ;
	assign nLDS_IOB = AoutOE ? nLDS_IOBout : 1'bZ;
	assign nUDS_IOB = AoutOE ? nUDS_IOBout : 1'bZ;
	assign nVMA_IOB = AoutOE ? nVMA_IOBout : 1'bZ;
	IOBM iobm(
		/* PDS interface */
		.C16M(C16M),
		.C8M(C8M),
		.E(E),
		.nASout(nAS_IOBout),
		.nLDS(nLDS_IOBout),
		.nUDS(nUDS_IOBout),
		.nVMA(nVMA_IOBout),
		.nDTACK(nDTACK_IOB),
		.nVPA(nVPA_IOB),
		.nBERR(nBERR_IOB),
		.nRES(nRESin),
		/* PDS address and data latch control */
		.AoutOE(AoutOE),
		.nDoutOE(nDoutOE),
		.ALE0(ALE0M),
		.nDinLE(nDinLE),
		/* IO bus slave port interface */
		.IORDREQ(IORDREQ),
		.IOWRREQ(IOWRREQ),
		.IOLDS(IOL0),
		.IOUDS(IOU0),
		.IOACT(IOACT),
		.IODONE(IODONE),
		.IOBERR(IOBERR));

	wire SndQoSReady;
	CNT cnt(
		/* FSB clock, 7.8336 MHz clock, and E clock inputs */
		.CLK(FCLK),
		.C8M(C8M),
		.E(E),
		/* Refresh request */
		.RefReq(RefReq),
		.RefUrg(RefUrg),
		/* Reset, button */
		.nRESout(nRESout),
		.nRESin(nRESin),
		.nIPL2(nIPL2),
		/* Mac PDS bus master control outputs */
		.AoutOE(AoutOE),
		.nBR_IOB(nBR_IOB),
		/* QoS select inputs */
		.BACT(BACT),
		.QoSCS(QoSCS),
		.SndQoSCS(SndQoSCS),
		/* QoS outputs */
		.QoSEN(QoSEN),
		.SndQoSReady(SndQoSReady));
	
	FSB fsb(
		/* MC68HC000 interface */
		.FCLK(FCLK),
		.nAS(nAS_FSB),
		.nDTACK(nDTACK_FSB),
		.nVPA(nVPA_FSB),
		/* FSB cycle detection */
		.BACT(BACT),
		.BACTr(BACTr),
		/* Ready inputs */
		.ROMCS(ROMCS4X),
		.RAMCS(RAMCS0X),
		.RAMReady(RAMReady),
		.IOPWCS(IOPWCS),
		.IOPWReady(IOPWReady),
		.IONPReady(IONPReady),
		.QoSEN(QoSEN),
		.SndQoSReady(SndQoSReady),
		/* Interrupt acknowledge select */
		.IACS(IACS));


endmodule
