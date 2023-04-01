module IOBS(
	/* MC68HC000 interface */
	input CLK, input nWE, input nAS, input nLDS, input nUDS,
	/* AS cycle detection */
	input BACT,
	/* Select signals */
	input IOCS, input IOPWCS, input ROMCS,
	/* FSB cycle termination outputs */
	output IOBS_Ready, output nBERR_FSB,
	/* Read data OE control */
	output nDinOE,
	/* IOB Master Controller Interface */
	output reg IOREQ, input IOACT, input nIOBERR, input nIODTACK,
	/* FIFO primary level control */
	output reg ALE0, output reg IORW0, output reg IOL0, output reg IOU0,
	/* FIFO secondary level control */
	output reg ALE1);
	
	/* IOACT input synchronization */
	reg IOACTr = 0; always @(posedge CLK) begin IOACTr <= IOACT; end
	
	/* /IODTACK input synchronization */
	reg IODTACKr = 0; always @(posedge CLK) begin IODTACKr <= !nIODTACK; end

	/* Read data OE control */
	assign nDinOE = !(!nAS && IOCS && nWE && !ROMCS);
	
	/* I/O transfer state
	 * TS0 - I/O bridge idle:
	 *       asserts IOREQ
	 *       transitions to TS3 when BACT && IOCS && !ALE1 && !Sent
	 * TS3 - starting I/O transfer:
	         latches LDS and UDS from FSB or FIFO secondary level
			 transitions immediately to TS2
	 * TS2 - waiting for IOBM to begin:
		     transitions to TS1 when IOACT true
	 * TS1 - waiting for IOBM to finish:
	 *       transitions to TS1 when IOACT false */
	reg [1:0] TS = 0;
	reg Sent = 0;

	/* FIFO second level control */
	reg Load1;
	reg Clear1;
	reg IORW1;
	reg IOL1;
	reg IOU1;
	always @(posedge CLK) begin
		// If write currently posting (TS!=0),
		// I/O selected, and FIFO secondary level empty
		if (TS!=0 && BACT && IOCS && !ALE1 && !Sent && IOPWCS) begin
			// Latch R/W now but latch address and LDS/UDS next cycle
			IORW1 <= nWE;
			Load1 <= 1;
		end else Load1 <= 0;
	end
	always @(posedge CLK) begin
		// Make address latch transparent in cycle after TS3
		// (i.e. first TS2 cycle that's not part of current write)
		if (TS==3) Clear1 <= 1;
		else Clear1 <= 0;
	end
	always @(posedge CLK) begin
		if (Load1) begin
			// Latch address, LDS, UDS when Load1 true
			ALE1 <= 1;
			IOL1 <= ~nLDS;
			IOU1 <= ~nUDS;
		end else if (Clear1) ALE1 <= 0;
	end
	
	/* FIFO Primary Level Control */
	always @(posedge CLK) begin
		if (TS==0) begin
			if (ALE1) begin // If FIFO secondary level occupied
				// Request transfer from IOBM and latch R/W from FIFO
				TS <= 3;
				IOREQ <= 1;
				IORW0 <= IORW1;
			end else if (BACT && IOCS && !ALE1 && !Sent) begin // If I/O selected and FIFO empty
				// Request transfer from IOBM and latch R/W from FSB
				TS <= 3;
				IOREQ <= 1;
				IORW0 <= nWE;
			end else begin // Otherwise stay in idle
				TS <= 0;
				IOREQ <= 0;
			end
			ALE0 <= 0;
		end else if (TS==3) begin
			// Always go to TS2. Keep IOREQ active
			TS <= 2;
			IOREQ <= 1;
			// Latch address (and data)
			ALE0 <= 1;
			// Latch data strobes from FIFO or FSB as appropriate
			if (ALE1) begin
				IOL0 <= IOL1;
				IOU0 <= IOU1;
			end else begin
				IOL0 <= ~nLDS;
				IOU0 <= ~nUDS;
			end
		end else if (TS==2) begin
			// Wait for IOACT then withdraw IOREQ and enter TS1
			if (IOACTr) begin
				TS <= 1;
				IOREQ <= 0;
			end else begin
				TS <= 2;
				IOREQ <= 1;
			end
			ALE0 <= 1;
		end else if (TS==1) begin
			// Wait for IOACT low (transfer over) before going back to idle
			if (~IOACTr) TS <= 0;
			else TS <= 1;
			IOREQ <= 0;
			// Address latch released since it's controlled by IOBM now
			ALE0 <= 0;
		end
	end

	/* Sent, ready, BERR control */
	reg DTACKEN = 0;
	always @(posedge CLK) begin
		if (~BACT) Sent <= 0;
		else if (BACT && IOCS && !ALE1 && !Sent && (TS==0 || IOPWCS)) Sent <= 1;
	end
	always @(posedge CLK) begin
		if (~BACT) DTACKEN <= 0;
		else if (IOCS && !IOPWCS && !ALE1 && Sent && IOACTr) DTACKEN <= 1;
	end
	assign IOBS_Ready = !IOCS || (IOPWCS && !ALE1) || (DTACKEN && (!IOACT || IODTACKr));
	assign nBERR_FSB = !(DTACKEN && !nIOBERR);
endmodule
