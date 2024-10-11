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
	output RnW_IOB,
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
	
	/* Power-on reset */
	wire nPOR;

	/* AS cycle detection */
	wire ASrf, BACT, BACTr;

	/* Refresh request/ack signals */
	wire RefReq, RefUrg;
	
	/* FSB chip select signals */
	wire IOCS, IORealCS, IOPWCS;
	wire ROMCS, ROMCS4X;
	wire RAMCS, RAMCS0X;
	wire QoSEN;
	wire IACKCS, VIACS, IWMCS, SCCCS, SCSICS, SndCSWR;
	wire SetCSWR;
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
		.ROMCS(ROMCS),
		.ROMCS4X(ROMCS4X),
		.RAMCS(RAMCS),
		.RAMCS0X(RAMCS0X),
		/* Motherboard I/O device select outputs  */
		.IACKCS(IACKCS),
		.VIACS(VIACS),
		.IWMCS(IWMCS),
		.SCCCS(SCCCS),
		.SCSICS(SCSICS),
		.SndCSWR(SndCSWR),
		/* Settings register select output */
		.SetCSWR(SetCSWR));

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
	wire IOREQ, IORW;
	wire IOL0, IOU0;
	wire ALE0S, ALE0M, ALE1;
	assign nADoutLE0 = ~(ALE0S || ALE0M);
	assign nADoutLE1 = ~ALE1;
	wire IOACT, IODONE;
	IOBS iobs(
		/* MC68HC000 interface */
		.CLK(FCLK),
		.nWE(nWE_FSB),
		.nAS(nAS_FSB),
		.nLDS(nLDS_FSB),
		.nUDS(nUDS_FSB),
		/* AS cycle detection */
		.BACT(BACT), .BACTr(BACTr),
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
		.IOREQ(IOREQ),
		.IORW(IORW),
		.IOACT(IOACT),
		.IODONEin(IODONE),
		.nBERR_IOB(!nBERR_IOB),
		/* FIFO primary level control */
		.ALE0(ALE0S),
		.IOL0(IOL0),
		.IOU0(IOU0),
		/* FIFO secondary level control */
		.ALE1(ALE1));

	wire AoutOE;
	assign nAoutOE = !AoutOE;
	wire nAS_IOBout, RnW_IOBout, nLDS_IOBout, nUDS_IOBout, nVMA_IOBout;
	assign nAS_IOB = AoutOE ? nAS_IOBout : 1'bZ;
	assign RnW_IOB = AoutOE ? RnW_IOBout : 1'bZ;
	assign nLDS_IOB = AoutOE ? nLDS_IOBout : 1'bZ;
	assign nUDS_IOB = AoutOE ? nUDS_IOBout : 1'bZ;
	assign nVMA_IOB = AoutOE ? nVMA_IOBout : 1'bZ;
	IOBM iobm(
		/* PDS interface */
		.C16M(C16M),
		.C8M(C8M),
		.E(E),
		.nAS(nAS_IOBout),
		.RnW(RnW_IOBout),
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
		.IOREQ(IOREQ),
		.IORW(IORW),
		.IOLDS(IOL0),
		.IOUDS(IOU0),
		.IOACT(IOACT),
		.IODONE(IODONE));

	wire SlowIACK, SlowVIA, SlowIWM, SlowSCC, SlowSCSI, SlowSnd, SlowClockGate;
	wire [3:0] SlowTimeout;
	SET set(
		.CLK(FCLK),
		.nPOR(nPOR),
		.BACT(BACT), 
		.A(A_FSB[11:1]), 
		.SetCSWR(SetCSWR),
		.SlowIACK(SlowIACK),
		.SlowVIA(SlowVIA),
		.SlowIWM(SlowIWM),
		.SlowSCC(SlowSCC),
		.SlowSCSI(SlowSCSI),
		.SlowSnd(SlowSnd),
		.SlowClockGate(SlowClockGate),
		.SlowTimeout(SlowTimeout));

	wire nBR_IOBout;
	assign nBR_IOB = nBR_IOBout ? 1'bZ : 1'b0;
	CNT cnt(
		/* FSB clock, 7.8336 MHz clock, and E clock inputs */
		.CLK(FCLK),
		.C8M(C8M),
		.E(E),
		/* Power-on reset */
		.nPOR(nPOR),
		/* Refresh request */
		.RefReq(RefReq),
		.RefUrg(RefUrg),
		/* Reset, button */
		.nRESout(nRESout),
		.nRESin(nRESin),
		.nIPL2(nIPL2),
		/* Mac PDS bus master control outputs */
		.AoutOE(AoutOE),
		.nBR_IOB(nBR_IOBout),
		/* QoS select inputs */
		.nAS(nAS_FSB),
		.ASrf(ASrf),
		.BACT(BACT),
		.IACKCS(IACKCS),
		.VIACS(VIACS),
		.IWMCS(IWMCS),
		.SCCCS(SCCCS),
		.SCSICS(SCSICS),
		.SndCSWR(SndCSWR),
		/* QoS settings inputs */
		.SlowIACK(SlowIACK),
		.SlowVIA(SlowVIA),
		.SlowIWM(SlowIWM),
		.SlowSCC(SlowSCC),
		.SlowSCSI(SlowSCSI),
		.SlowSnd(SlowSnd),
		.SlowClockGate(SlowClockGate),
		.SlowTimeout(SlowTimeout),
		/* QoS outputs */
		.QoSEN(QoSEN),
		.MCKE(MCKE));
	
	FSB fsb(
		/* MC68HC000 interface */
		.FCLK(FCLK),
		.nAS(nAS_FSB),
		.nDTACK(nDTACK_FSB),
		.nVPA(nVPA_FSB),
		/* FSB cycle detection */
		.ASrf(ASrf),
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
		/* Interrupt acknowledge select */
		.IACKCS(IACKCS));


endmodule
