module IOBM(
	/* PDS interface */
	input C16M, input C8M, input E,
	output reg nASout, output reg nLDS, output reg nUDS, output reg nVMA,
	input nDTACK, input nVPA, input nBERR, input nRES,
	/* PDS address and data latch control */
	input AoutOE, output nDoutOE, output reg ALE0, output reg nDinLE,
	/* IO bus slave port interface */
	input IORDREQ, input IOWRREQ, input IOLDS, input IOUDS,
	output reg IOACT, output reg IODONE, output reg IOBERR);

	/* C8M clock registration */
	reg C8Mr; always @(posedge C16M) C8Mr <= C8M;

	/* I/O request input synchronization */
	reg IORDREQr; always @(posedge C16M) IORDREQr <= IORDREQ;
	reg IOWRREQr; always @(posedge C16M) IOWRREQr <= IOWRREQ;
	wire IOREQr = IORDREQr || IOWRREQr;
	
	/* DTACK and BERR synchronization */
	always @(negedge C8M, posedge nASout) begin
		if (nASout) begin
			IODONE <= 0;
			IOBERR <= 0;
		end else begin
			IODONE <= (!nDTACK || ETACK || !nRES);
			IOBERR <= !nIOBERR;
		end
	end

	/* VPA and RESET synchronization */
	reg RESr; always @(posedge C16M) RESr <= !nRES;
	reg VPAr; always @(posedge C16M) VPAr <= !nVPA;
	
	/* E clock synchronization */
	reg Er;  always @(negedge C8M)  begin Er <= E; end
	reg Er2; always @(posedge C16M) begin Er2 <= Er; end
	
	/* E clock state */
	reg [4:0] ES;
	always @(posedge C16M) begin
		if (Er2 && ~Er) ES <= 1;
		else if (ES==0 || ES==19) ES <= 0;
		else ES <= ES+1;
	end

	/* ETACK and VMA generation */
	reg ETACK = 0;
	always @(posedge C16M) begin ETACK <= ES==16 && ~nVMA; end
	always @(posedge C16M) begin
		if (ES==7 && IOACT && VPAr) nVMA <= 0;
		else if (ES==0) nVMA <= 1;
	end

	/* I/O bus state */
	reg [2:0] IOS = 0;
	reg IOS0;
	always @(posedge C16M) begin
		if (IOS==0) begin
			if (IOREQr && !C8Mr && AoutOE) begin // "IOS1"
				IOS <= 2;
				IOS0 <= 0;
			end else begin // "regular" IOS0
				IOS <= 0;
				IOS0 <= 1;
			end
			IOACT <= IOREQr && AoutOE;
			ALE0 <= IOREQr && AoutOE;
		end else if (IOS==2) begin
			IOS <= 3;
			IOS0 <= 0;
			IOACT <= 1;
			ALE0 <= 1;
		end else if (IOS==3) begin
			IOS <= 4;
			IOS0 <= 0;
			IOACT <= 1;
			ALE0 <= 1;
		end else if (IOS==4) begin
			IOS <= 5;
			IOS0 <= 0;
			IOACT <= 1;
			ALE0 <= 1;
		end else if (IOS==5) begin
			if (!C8Mr && (IODONE || IOBERR)) begin
				IOS <= 6;
				IOACT <= 0;
			end else begin
				IOS <= 5;
				IOACT <= 1;
			end
			IOS0 <= 0;
			ALE0 <= 1;
		end else if (IOS==6) begin
			IOS <= 7;
			IOS0 <= 0;
			IOACT <= 0;
			ALE0 <= 0;
		end else if (IOS==7) begin
			IOS <= 0;
			IOS0 <= 1;
			IOACT <= 0;
			ALE0 <= 0;
		end
	end

	/* PDS address and data latch control */
	always @(negedge C16M) begin nDinLE = IOS==4 || IOS==5; end
	reg DoutOE = 0;
	always @(posedge C16M) begin
		DoutOE <= (IOS==0 && IOWRREQr && !C8Mr) ||
				  (DoutOE && (IOS==2 || IOS==3 || IOS==4 || IOS==5));
	end
	assign nDoutOE = !(AoutOE && (DoutOE || (IOS==0 && !IOREQr)));

	/* AS, DS control */
	always @(negedge C16M) begin
		nASout <= ~((IOS==0 && IOREQr && !C8Mr) || IOS==2 || IOS==3 || IOS==4 || IOS==5);
		nLDS <= ~(IOLDS && ((IOS==0 && IORDREQr && !C8Mr) || (IOS==2 && IORDREQr) || IOS==3 || IOS==4 || IOS==5));
		nUDS <= ~(IOUDS && ((IOS==0 && IORDREQr && !C8Mr) || (IOS==2 && IORDREQr) || IOS==3 || IOS==4 || IOS==5));
	end

endmodule
