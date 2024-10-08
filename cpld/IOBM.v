module IOBM(
	/* PDS interface */
	input C16M, input C8M, input E,
	output reg nAS, output reg RnW, output reg nLDS, output reg nUDS, output reg nVMA,
	input nDTACK, input nVPA, input nBERR, input nRES,
	/* PDS address and data latch control */
	input AoutOE, output nDoutOE, output reg ALE0, output reg nDinLE,
	/* IO bus slave port interface */
	input IOREQ, input IORW, input IOLDS, input IOUDS,
	output reg IOACT, output IODONE);

	/* C8M clock registration */
	reg C8Mr; always @(posedge C16M) C8Mr <= C8M;

	/* I/O request input synchronization */
	reg IOREQr; always @(posedge C16M) IOREQr <= IOREQ;

	/* VPA synchronization */
	reg VPAr; always @(negedge C8M) VPAr <= !nVPA;
	
	/* E clock synchronization */
	reg Er; always @(negedge C8M) begin Er <= E; end
	
	/* E clock state */
	reg [3:0] ES;
	always @(negedge C8M) begin
		if (!E && Er) ES <= 1;
		else if (ES==0 || ES==9) ES <= 0;
		else ES <= ES+1;
	end

	/* ETACK and VMA generation */
	wire ETACK = (ES==8) && !nVMA;
	always @(negedge C8M) begin
		if ((ES==3) && IOACT && VPAr) nVMA <= 0;
		else if (ES==0) nVMA <= 1;
	end
	
	/* I/O bus state */
	reg [2:0] IOS = 0;
	reg IOS0;
	
	/* IODONE DTACK/"ETACK"/BERR/reset synchronization */
	reg IODONEr;
	always @(posedge C16M) begin
		if ((IOS==3 || IOS==5) && !C8Mr) begin
			IODONEr <= !nDTACK || ETACK || !nBERR || !nRES;
		end else if (IOS==0) IODONEr <= 0;
	end

	/* IODONE output */
	assign IODONE = IODONEr;

	/* I/O bus control */
	always @(posedge C16M) case (IOS[2:0])
		3'h0: begin
			if (IOREQr && !C8Mr && AoutOE) begin // "IOS1"
				IOS <= 2;
				IOS0 <= 0;
			end else begin // "regular" IOS0
				IOS <= 0;
				IOS0 <= 1;
			end
			IOACT <= IOREQr;
			ALE0 <= IOREQr;
		end 3'h2: begin
			IOS <= 3;
			IOS0 <= 0;
			IOACT <= 1;
			ALE0 <= 1;
		end 3'h3: begin
			IOS <= 4;
			IOS0 <= 0;
			IOACT <= 1;
			ALE0 <= 1;
		end 3'h4: begin
			IOS <= 5;
			IOS0 <= 0;
			IOACT <= 1;
			ALE0 <= 1;
		end 3'h5: begin
			if (!C8Mr && IODONEr) begin
				IOS <= 6;
				IOACT <= 0;
			end else begin
				IOS <= 5;
				IOACT <= 1;
			end
			IOS0 <= 0;
			ALE0 <= 1;
		end 3'h6: begin
			IOS <= 7;
			IOS0 <= 0;
			IOACT <= 0;
			ALE0 <= 0;
		end 3'h7: begin
			IOS <= 0;
			IOS0 <= 1;
			IOACT <= 0;
			ALE0 <= 0;
		end
	endcase

	/* PDS address and data latch control */
	always @(negedge C16M) begin nDinLE = IOS==4 || IOS==5; end
	reg DoutOE = 0;
	always @(posedge C16M) begin
		DoutOE <= ((IOS==0 && IOREQr && !IORW && !C8Mr) ||
				   (DoutOE && (IOS==2 || IOS==3 || IOS==4 || IOS==5)));
	end
	//assign nDoutOE = !(AoutOE && (DoutOE || (IOS0 && !IOREQr)));
	assign nDoutOE = !(AoutOE && DoutOE);

	/* AS, DS, RW control */
	always @(negedge C16M) begin
		nAS <= !(
			(IOS==0 && IOREQr && !C8Mr) || 
			(IOS==2) || 
			(IOS==3) || 
			(IOS==4) || 
			(IOS==5));
		RnW <= !(
			(IOS==0 && IOREQr && !IORW && !C8Mr) || 
			(!RnW && IOS==2) || 
			(!RnW && IOS==3) || 
			(!RnW && IOS==4) || 
			(!RnW && IOS==5) || 
			(!RnW && IOS==6));
		nLDS <= !(
			(IOS==0 && IOREQr && IORW && IOLDS && !C8Mr) ||
			(IOS==2 && IOLDS) ||
			(IOS==3 && IOLDS) ||
			(IOS==4 && IOLDS) ||
			(IOS==5 && IOLDS));
		nUDS <= !(
			(IOS==0 && IOREQr && IORW && IOUDS && !C8Mr) ||
			(IOS==2 && IOUDS) ||
			(IOS==3 && IOUDS) ||
			(IOS==4 && IOUDS) ||
			(IOS==5 && IOUDS));
	end

endmodule
