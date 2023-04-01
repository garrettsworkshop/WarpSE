module IOBM(
	/* PDS interface */
	input C16M, input C8M, input E,
	output reg nASout, output reg nLDS, output reg nUDS, output reg nVMA,
	input nDTACK, input nVPA, input nBERR, input nRES,
	/* PDS address and data latch control */
	input AoutOE, output nDoutOE, output reg ALE0, output reg nDinLE,
	/* IO bus slave port interface */
	output reg IOACT,
	input IOREQ, input IOLDS, input IOUDS, input IOWE);

	/* I/O bus slave port input synchronization */
	reg IOREQr = 0;
	always @(negedge C16M) begin IOREQr <= IOREQ; end
	
	/* DTACK, BERR, RESET synchronization */
	reg DTACKrf, BERRrf, RESrf;
	always @(negedge C8M) begin
		DTACKrf <= !nDTACK;
		BERRrf <= !nBERR;
		RESrf <= !nRES;
	end
	
	/* VPA synchronization */
	reg VPAr;
	always @(negedge C16M) VPAr <= !nVPA;
	
	/* E clock synchronization */
	reg Er; always @(negedge C8M) begin Er <= E; end
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
	always @(posedge C16M) begin
		if (IOS==0) begin
			if (~C8M && IOREQr && AoutOE) IOS <= 1;
			else IOS <= 0;
			IOACT <= IOREQr;
			ALE0 <= IOREQr;
		end else if (IOS==1) begin
			IOS <= 2;
			IOACT <= 1;
			ALE0 <= 1;
		end else if (IOS==2) begin
			IOS <= 3;
			IOACT <= 1;
			ALE0 <= 1;
		end else if (IOS==3) begin
			IOS <= 4;
			IOACT <= 1;
			ALE0 <= 1;
		end else if (IOS==4) begin
			IOS <= 5;
			ALE0 <= 1;
			if (DTACKrf) IOACT <= 0;
			else IOACT <= 1;
		end else if (IOS==5) begin
			if (C8M && (DTACKrf || ETACK || BERRrf || RESrf)) begin
				IOS <= 6;
				IOACT <= 0;
			end else begin
				IOS <= 5;
				IOACT <= 1;
			end
			ALE0 <= 1;
		end else if (IOS==6) begin
			IOS <= 7;
			IOACT <= 0;
			ALE0 <= 0;
		end else if (IOS==7) begin
			IOS <= 0;
			IOACT <= 0;
			ALE0 <= 0;
		end
	end

	/* PDS address and data latch control */
	always @(negedge C16M) begin nDinLE = IOS==4 || IOS==5; end
	reg DoutOE = 0; assign nDoutOE = !(AoutOE && DoutOE);
	always @(posedge C16M) begin
		DoutOE <= ( IOWE   && (IOS==1 || IOS==2 || IOS==3 ||  IOS==4 || IOS==5 || IOS==6)) ||
					 (!IOREQr && IOS==0 && AoutOE);
	end

	/* AS, DS control */
	always @(negedge C16M) begin
		nASout <= ~(IOS==1 || IOS==2 || IOS==3 || IOS==4 || IOS==5);
		nLDS <= ~(IOLDS && (((IOS==1 || IOS==2) && ~IOWE) || IOS==3 || IOS==4 || IOS==5));
		nUDS <= ~(IOUDS && (((IOS==1 || IOS==2) && ~IOWE) || IOS==3 || IOS==4 || IOS==5));
	end

endmodule
