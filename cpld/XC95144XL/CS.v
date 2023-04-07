module CS(
	/* MC68HC000 interface */
	input [23:08] A, input CLK, input nRES, input nWE, 
	/* AS cycle detection */
	input BACT,
	/* Device select outputs */
	output IOCS, output IOPWCS, output IACS,
	output ROMCS, output ROMCS4X,
	output RAMCS, output RAMCS0X, output SndRAMCSWR);

	/* Overlay control */
	reg nOverlay = 0; wire Overlay = !nOverlay;
	reg ODCSr;
	always @(posedge CLK) begin
		ODCSr <= ROMCS4X && BACT;
		if (!BACT) begin
			if (!nRES) nOverlay <= 0;
			else if (ODCSr) nOverlay <= 1;
		end
	end

	/* ROM select signals */
	assign ROMCS4X = A[23:20]==4'h4;
	assign ROMCS = ((A[23:20]==4'h0) && Overlay) || ROMCS4X;

	/* RAM select signals */
	assign RAMCS0X = A[23:22]==2'b00;
	assign RAMCS = RAMCS0X && !Overlay;
	wire VidRAMCSWR64k = RAMCS && !nWE && (A[23:20]==4'h3) && (A[19:16]==4'hF); // 3F0000-3FFFFF
	wire VidRAMCSWR = VidRAMCSWR64k && (
		(A[15:12]==4'h2) || // 1792 bytes RAM, 2304 bytes video
		(A[15:12]==4'h3) || // 4096 bytes video
		(A[15:12]==4'h4) || // 4096 bytes video
		(A[15:12]==4'h5) || // 4096 bytes video
		(A[15:12]==4'h6) || // 4096 bytes video
		(A[15:12]==4'h7) || // 3200 bytes video, 896 bytes RAM,
		(A[15:12]==4'hA) || // 256 bytes RAM, 768 bytes sound, 768 bytes RAM, 2304 bytes video
		(A[15:12]==4'hB) || // 4096 bytes video
		(A[15:12]==4'hC) || // 4096 bytes video
		(A[15:12]==4'hD) || // 4096 bytes video
		(A[15:12]==4'hE) || // 4096 bytes video
		(A[15:12]==4'hF)); // 3200 bytes video, 128 bytes RAM (system error space), 768 bytes sound

	/* Select signals - IOB domain */
	assign IACS =  (A[23:20]==4'hF) && (A[19:18]==2'b11); // IACK
	assign IOCS =  (A[23:20]==4'hF) || // IACK
				   (A[23:20]==4'hE) || // VIA
				   (A[23:20]==4'hD) || // IWM
				   (A[23:20]==4'hC) || // empty / fast ROM
				   (A[23:20]==4'hB) || // SCC write
				   (A[23:20]==4'hA) || // empty
				   (A[23:20]==4'h9) || // SCC read/reset
				   (A[23:20]==4'h8) || // empty
				   (A[23:20]==4'h7) || // empty
				   (A[23:20]==4'h6) || // empty
				   (A[23:20]==4'h5) || // SCSI
				  ((A[23:20]==4'h4) && Overlay) ||
				    VidRAMCSWR; // ROM once
	assign IOPWCS = VidRAMCSWR;
endmodule
