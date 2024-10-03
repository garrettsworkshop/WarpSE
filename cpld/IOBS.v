module IOBS(
	/* MC68HC000 interface */
	input CLK, input nWE, input nAS, input nLDS, input nUDS,
	/* AS cycle detection */
	input BACT, input BACTr,
	/* Select signals */
	input IOCS, input IORealCS, input IOPWCS,
	/* FSB cycle termination outputs */
	output reg IONPReady, output IOPWReady, output reg nBERR_FSB,
	/* Read data OE control */
	output nDinOE,
	/* IOB master controller interface */
	output reg IORDREQ, output reg IOWRREQ,
	input IOACT, input IODONEin, input IOBERR,
	/* FIFO primary level control */
	output reg ALE0, output reg IOL0, output reg IOU0,
	/* FIFO secondary level control */
	output reg ALE1);
	
	/* IOACT input synchronization */
	reg IOACTr = 0; always @(posedge CLK) IOACTr <= IOACT;

	/* IODTACK input synchronization */
	reg IODONEr; always @(posedge CLK) IODONEr <= IODONEin;
	wire IODONE = IODONEr;

	/* Read data OE control */
	assign nDinOE = !(!nAS && BACTr && IORealCS && nWE);
	
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

	/* FIFO secondary level control */
	reg Load1; reg Clear1;
	reg IORW1; reg IOL1; reg IOU1;
	always @(posedge CLK) begin // ALE and R/W load control
		// If write currently posting (TS!=0),
		// I/O selected, and FIFO secondary level empty
		if (BACT && IOPWCS && !ALE1 && !Sent && TS!=0) begin
			// Latch R/W now but latch address and LDS/UDS next cycle
			IORW1 <= nWE;
			Load1 <= 1;
		end else Load1 <= 0;
	end
	always @(posedge CLK) begin // ALE clear control
		// Make address latch transparent in cycle after TS3
		// (i.e. first TS2 cycle that's not part of current write)
		if (TS==3) Clear1 <= 1;
		else Clear1 <= 0;
	end
	always @(posedge CLK) begin // LDS, UDS, ALE control
		if (Load1) begin // Latch address, LDS, UDS when Load1 true
			ALE1 <= 1;
			IOL1 <= !nLDS;
			IOU1 <= !nUDS;
		end else if (Clear1) ALE1 <= 0;
	end
	
	/* FIFO primary level control */
	always @(posedge CLK) begin
		if (TS==0) begin
			if (ALE1) begin // If FIFO secondary level occupied
				// Request transfer from IOBM and latch R/W from FIFO
				TS <= 3;
				IORDREQ <= IORW1;
				IOWRREQ <= !IORW1;
				IOL0 <= IOL1;
				IOU0 <= IOU1;
			end else if (BACT && IOCS && !ALE1 && !Sent) begin // FSB request
				// Request transfer from IOBM and latch R/W from FSB
				TS <= 3;
				IORDREQ <= nWE;
				IOWRREQ <= !nWE;
				IOL0 <= !nLDS;
				IOU0 <= !nUDS;
			end else begin // Otherwise stay in idle
				TS <= 0;
				IORDREQ <= 0;
				IOWRREQ <= 0;
			end
			ALE0 <= 0;
		end else if (TS==3) begin
			TS <= 2; // Always go to TS2. Keep IORDREQ/IOWRREQ active
			ALE0 <= 1; // Latch address (and data)
			// Latch data strobes from FIFO or FSB as appropriate
			if (ALE1) begin
				IOL0 <= IOL1;
				IOU0 <= IOU1;
			end else begin
				IOL0 <= !nLDS;
				IOU0 <= !nUDS;
			end
		end else if (TS==2) begin
			// Wait for IOACT then withdraw IOREQ and enter TS1
			if (IOACTr) begin
				TS <= 1;
				IORDREQ <= 0;
				IOWRREQ <= 0;
			end else TS <= 2;
			ALE0 <= 1; // Keep address latched
		end else if (TS==1) begin
			// Wait for IOACT low (transfer over) before going back to idle
			if (!IOACTr) TS <= 0;
			else TS <= 1;
			IORDREQ <= 0;
			IOWRREQ <= 0;
			ALE0 <= 0; // Release addr latch since it's controlled by IOBM now
		end
	end

	/* Sent control */
	always @(posedge CLK) begin
		if (!BACT) Sent <= 0;
		else if (BACT && IOCS && !ALE1 && (IOPWCS || TS==0)) Sent <= 1;
	end

	/* Nonposted and posted ready */
	assign IOPWReady = !ALE1 || Sent; // Posted write reaedy
	always @(posedge CLK) begin // Nonposted read/write ready
		if (!BACT) IONPReady <= 0;
		else if (Sent && !IOPWCS && IODONE) IONPReady <= 1;
	end

	/* BERR control */
	always @(posedge CLK) begin
		if (!BACT) nBERR_FSB <= 1;
		else if (Sent && IOBERR) nBERR_FSB <= 0;
	end
endmodule
