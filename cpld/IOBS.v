module IOBS(
	/* MC68HC000 interface */
	input CLK, input nWE, input nAS, input nLDS, input nUDS,
	/* AS cycle detection */
	input BACT,
	/* Select and ready signals */
	input IOCS, input IOPWCS, output Ready, output reg BERR,
	/* Read data OE control */
	output nDinOE,
	/* IOB Master Controller Interface */
	output reg IOREQ, input IOACT, input IOBERR,
	/* FIFO primary level control */
	output reg ALE0, output reg IORW0, output reg IOL0, output reg IOU0,
	/* FIFO secondary level control */
	output reg ALE1);
	
	/* IOACT input synchronization */
	reg IOACTr = 0;
	always @(posedge CLK) begin IOACTr <= IOACT; end

	/* Read data OE control */
	assign nDinOE = ~nAS && IOCS && nWE;
	
	/* Posted read/write state */
	reg [1:0] PS = 0;
	reg Once = 0;

	/* FIFO second level control */
	reg Load1;
	reg IORW1;
	reg IOL1;
	reg IOU1;
	always @(posedge CLK) begin
		if (PS!=0 && BACT && IOCS && ~Once && ~ALE1) begin
			ALE1 <= 1;
			IORW1 <= nWE;
			Load1 <= 1;
		end else begin
			if (PS==3) ALE1 <= 0;
			Load1 <= 0;
		end
	end
	always @(posedge CLK) begin
		if (Load1) begin
			IOL1 <= ~nLDS;
			IOU1 <= ~nUDS;
		end
	end
	
	/* FIFO Primary Level Control */
	always @(posedge CLK) begin
		if (PS==0) begin
			if (ALE1) begin
				PS <= 3;
				IOREQ <= 1;
				IORW0 <= IORW1;
			end else if (BACT && IOCS && ~Once) begin
				PS <= 3;
				IOREQ <= 1;
				IORW0 <= nWE;
			end else begin
				PS <= 0;
				IOREQ <= 0;
			end
			ALE0 <= 0;
		end else if (PS==3) begin
			PS <= 2;
			IOREQ <= 1;
			ALE0 <= 1;
			if (ALE1) begin
				IOL0 <= IOL1;
				IOU0 <= IOU1;
			end else begin
				IOL0 <= ~nLDS;
				IOU0 <= ~nUDS;
			end
		end else if (PS==2) begin
			if (IOACTr) begin
				PS <= 1;
				IOREQ <= 0;
			end else begin
				PS <= 2;
				IOREQ <= 1;
			end
			ALE0 <= 0;
		end else if (PS==1) begin
			if (~IOACTr) PS <= 0;
			else PS <= 2;
			IOREQ <= 0;
			ALE0 <= 0;
		end
	end

	/* Once, ready, BERR control */
	reg IOReady;
	wire IOPWReady = ~ALE1;
	always @(posedge CLK) begin
		if (~BACT) Once <= 0;
		else if (IOCS && (PS==0 || (IOPWCS && IOPWReady))) Once <= 1;
	end
	always @(posedge CLK) begin
		if (~BACT) begin
			IOReady <= 0;
			BERR <= 0;
		end else if (Once && (PS==0 || PS==1) && ~IOACTr && IOPWReady) begin
			IOReady <= ~IOBERR;
			BERR <= IOBERR;
		end
	end
	assign Ready = ~IOCS || IOReady || (IOPWCS && IOPWReady);

endmodule
