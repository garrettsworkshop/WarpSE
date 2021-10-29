module VGA(
	input VCLK,
	input [23:1] A,
	input RnW,
	input [15:0] D,
	input nAS,
	input nLDS,
	input nUDS,
	inout [7:0] RD,
	output reg [14:0] RA,
	output reg nRCS0,
	output reg nRCS1,
	output reg nRWE,
	output reg nROE,
	output reg Video,
	output reg VSync,
	output reg Hsync);

	/* Video RAM select (superset) */
	wire VidRAMWR = ~RnW && A[23:20]==4'h3 && A[19:16]==4'hF;

	/* Horizontal counter */
	reg [9:0] HC;
	always @(posedge VCLK) begin 
		if (HC==671) HC<=0;
		else HC <= HC+1;
	end

	/* Horizontal sync */
	always @(posedge VCLK) begin
		if (HC==0) HSync <= 1; // Visible earea end, back porch start
		else if (HC==079) HSync <= 0; // Back porch end, sync start
		else if (HC==148) HSync <= 1; // Sync end, front porch start
	end

	/* Horizontal active */
	reg HActive = 0;
	always @(posedge VCLK) begin
		if (HC==0) HActive <= 0; // Visible area end, back porch start
		else if (HC==160) HActive <= 1; // Visible area start (FIXME: off by 1?)
	end

	/* Vertical counter */
	reg [9:0] VC;
	always @(posedge VCLK) begin
		if (VC==805) VC <= 0;
		else if (HC==671) VC <= VC+1; // Or HC==0?
	end

	/* Vertical sync */
	always @(posedge VCLK) begin
		if (HC==0) VSync <= 1; // Back porch start
		else if (HC==028) VSync <= 0; // Back porch end, sync start
		else if (HC==034) VSync <= 1; // Sync end, front porch start
		else if (HC==037) VSync <= 1; // Sync end, front porch start
		//else if (HC==38) VSync <= 1; // Visible area start
	end

	/* Vertical active */
	reg VActive = 0;
	always @(posedge VCLK) begin
		if (HC==0) VActive <= 0; // Visible area end, back porch start
		else if (HC==160) VActive <= 1; // Visible area start (FIXME: off by 1?)
	end

	/* AS/select synchronization */
	reg SELr1, SELr2;
	always @(negedge VCLK) begin SELr0 <= ~nAS && VidRAMWR; end
	always @(posedge VCLK) begin SELr1 <= SELr0; end
	always @(posedge VCLK) begin SELr2 <= SELr1; end

	/* Write/AS Request */
	wire ASReqNow = ~SELr2 && SELr1;
	reg ASReqSaved;
	reg ASReqSaved;
	wire ASReq = ASReqNow || ASReqSaved;
	always @(posedge VCLK) begin
		// FIXME: ASReqSaved
		if (HC[2:0]==1 || HC[2:0]==4) ASReqSaved <= 0;
		else if (ASReqNow) ASReqSaved <= 1;
	end

	/* RAM data bus control */
	reg [7:0] RDout;
	reg RDOE;
	assign RD[7:0] = RDOE ? RDout[7:0] : RDOE;
	always @(posedge VCLK) begin
		RDOE <= HC[2:0]==1 || HC[2:0]==2 || HC[2:0]==3 || 
				HC[2:0]==4 || HC[2:0]==5;
	end
	/* Video state machine control */
	always @(posedge VCLK) begin
		case (HC[2:0])
			0: begin
				RA[14:0] <= A[15:1];
				nRCS0 <= 1;
				nRCS1 <= 1;
				nRWE <= 1;
				nROE <= 1;
			end 1: begin
				if (ASReq) begin
					nRCS0 <= ~nLDS;
					nRCS1 <= 1;
				end else begin
					nRCS0 <= 1;
					nRCS1 <= 1;
				end
				RDout[7:0] <= D[7:0];
				nRWE <= 0;
				nROE <= 1;
			end 2: begin
				if (~RCS0) begin
					nRCS0 <= 1;
					nRCS1 <= ~nUDS;
				end else begin
					nRCS0 <= 1;
					nRCS1 <= 1;
				end
				RDout[7:0] <= D[15:8];
				nRWE <= 0;
				nROE <= 1;
			end 3: begin
				if (nRCS1) RA[14:0] <= A[15:1];
				nRCS0 <= 1;
				nRCS1 <= 1;
				nRWE <= 0;
				nROE <= 1;
			end 4: begin
				if (ASReq) begin
					nRCS0 <= ~nLDS;
					nRCS1 <= 1;
				end else begin
					nRCS0 <= 1;
					nRCS1 <= 1;
				end
				RDout[7:0] <= D[7:0];
				nRWE <= 0;
				nROE <= 1;
			end 5: begin
				if (~RCS0) begin
					nRCS0 <= 1;
					nRCS1 <= ~nUDS;
				end else begin
					nRCS0 <= 1;
					nRCS1 <= 1;
				end
				RDout[7:0] <= D[15:8];
				nRWE <= 0;
				nROE <= 1;
			end 6: begin
				nRCS0 <= 1;
				nRCS1 <= 1;
				nRWE <= 1;
				nROE <= 1;
			end 7: begin
				RA[14:0] <= {1'b0, VC[9:1], HC[9:5]}; //FIXME: wrong address
				nRCS0 <= HC[5]; //FIXME: byte ordering
				nRCS1 <= ~HC[5];
				nRWE <= 1;
				nROE <= 0;
			end
		endcase
	end

	/* Video pixel output state machine */
	reg VideoShift[7:1];
	always @(posedge VCLK) begin
		//FIXME: bit ordering and polarity
		if (HActive && VActive) begin
			if (HC[2:0]==0) Video <= RD[0];
			else Video <= VideoShift[1];
		end else Video <= 0;
	end
	always @(posedge VCLK) begin
		//FIXME: bit ordering
		if (HC[2:0]==0) VideoShift[7:1] <= RD[7:1];
		else VideoShift[6:1] <= VideoShift[7:2];
	end

endmodule
