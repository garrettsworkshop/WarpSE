module IOBM(
	/* PDS interface */
	input C16M, input C8M, input E,
	output reg nAS, output reg nLDS, output reg nUDS, output reg nVMA,
	input nDTACK, input nVPA, input nBERR, input nRES,
	/* PDS address and data latch control */
	output nAoutOE, output reg nDoutOE, output reg ALE0, output reg nDinLE,
	/* IO bus slave port interface */
	output reg IOACT, output reg IOBERR, input IOREQ, input IOLDS, input IOUDS, input IOWE);

	/* I/O bus slave port input synchronization */
	reg IOREQr = 0;
	always @(negedge C16M) begin IOREQr <= IOREQ; end
	
	/* DTACK, BERR, RESET synchronization */
	reg DTACKrr, DTACKrf, VPArr, VPArf, BERRrr, BERRrf, RESrr, RESrf;
	always @(posedge C16M) begin
		DTACKrr <= ~nDTACK;
		VPArr <= ~nVPA;
		BERRrr <= ~nBERR;
		RESrr <= ~nRES;
	end
	always @(negedge C16M) begin
		DTACKrf <= ~nDTACK;
		VPArf <= ~nVPA;
		BERRrf <= ~nBERR;
		RESrf <= ~nRES;
	end
	wire DTACK = DTACKrr && DTACKrf;
	wire BERR = BERRrr && BERRrf;
	wire VPA = VPArr && VPArf;
	wire RES = RESrr && RESrf;

	/* E clock state */
	reg [4:0] ES;
	reg Er;
	reg Er2;
	always @(negedge C8M) begin Er <= E; end
	always @(posedge C16M) begin Er2 <= Er; end
	always @(posedge C16M) begin
		if (Er2 && ~Er) ES <= 1;
		else if (ES==0 || ES==19) ES <= 0;
		else ES <= ES+1;
	end

	/* ETACK and VMA generation */
	reg ETACK = 0;
	always @(posedge C16M) begin ETACK <= ES==16 && ~nVMA; end
	always @(posedge C16M) begin
		if (ES==7 && IOACT && VPA) nVMA <= 0;
		else if (ES==0) nVMA <= 1;
	end

	/* I/O bus state */
	reg [2:0] IOS = 0;
	always @(posedge C16M) begin
		if (IOS==0) begin
			if (IOREQr) begin
				if (~C8M) begin
					IOS <= 1;
				end else begin
					IOS <= 0;
				end
				IOACT <= 1;
				ALE0 <= 1;
			end else begin
				IOS <= 0;
				IOACT <= 0;
				ALE0 <= 0;
			end
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
			IOACT <= 1;
			ALE0 <= 1;
		end else if (IOS==5) begin
			if (C8M && (DTACK || ETACK || BERR || RES)) begin
				IOS <= 6;
				IOACT <= 0;
				IOBERR <= ~nBERR;
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
	assign nAoutOE = 0;
	always @(negedge C16M) begin nDinLE <= IOS==4 || IOS==5; end
	always @(posedge C16M) begin
		nDoutOE <= ~(IOWE && (IOS==1 || IOS==2 || IOS==3 || 
							  IOS==4 || IOS==5 || IOS==6));
	end

	/* AS, DS control */
	always @(negedge C16M) begin
		nAS <= ~(IOS==1 || IOS==2 || IOS==3 || IOS==4 || IOS==5);
		nLDS <= ~(IOLDS && (((IOS==1 || IOS==2) && ~IOWE) || IOS==3 || IOS==4 || IOS==5));
		nUDS <= ~(IOUDS && (((IOS==1 || IOS==2) && ~IOWE) || IOS==3 || IOS==4 || IOS==5));
	end

endmodule
