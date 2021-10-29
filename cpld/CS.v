module CS(
	/* MC68HC000 interface */
	input [23:08] A, input CLK, input nRES, input nWE, 
	/* AS cycle detection */
	input BACT,
	/* Device select outputs */
	output IOCS, output SCSICS, output IOPWCS, output IACS, output ROMCS, output RAMCS, output SndRAMCSWR);

	/* Overlay control */
	reg nOverlay0 = 0;
	reg nOverlay1 = 0;
	wire Overlay = ~nOverlay1;
	wire ODCS = A[23:20]==4'h4; // Disable overlay
	always @(posedge CLK, negedge nRES) begin
		if (~nRES) nOverlay0 <= 0;
		else if (BACT && ODCS) nOverlay0 <= 1;
	end
	always @(posedge CLK) begin
		if (~BACT) nOverlay1 <= nOverlay0;
	end

	/* Select signals - FSB domain */
	wire RAMCS_OverlayOff = A[23:22]==2'b00;
	wire RAMCS_OverlayOn  = A[23:21]==3'b011;
	assign RAMCS = (RAMCS_OverlayOff && ~Overlay) || // 000000-3FFFFF when overlay disabled
	               (RAMCS_OverlayOn  &&  Overlay);   // 600000-7FFFFF when overlay enabled
	wire VidRAMCSWR64k = RAMCS && A[21:20]==2'h3 && A[19:16]==4'hF && ~nWE; // 3F0000-3FFFFF / 7F0000-7FFFFF
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
	assign SndRAMCSWR = VidRAMCSWR64k && (
		(A[15:12]==4'hF && (A[11:8]==4'hD || A[11:8]==4'hE || A[11:8]==4'hF)) ||
		(A[15:12]==4'hA && (A[11:8]==4'h1 || A[11:8]==4'h2 || A[11:8]==4'h3)));

	assign ROMCS = A[23:20]==4'h4 || (A[23:20]==4'h0 && Overlay);

	/* Select signals - IOB domain */
	assign IACS = A[23:08]==16'hFFFF; // IACK
	assign IOCS = A[23:20]==4'h5 || // SCSI
	              A[23:20]==4'h8 || // empty
	              A[23:20]==4'h9 || // SCC read/reset
	              A[23:20]==4'hA || // empty
	              A[23:20]==4'hB || // SCC write
	              A[23:20]==4'hC || // empty
	              A[23:20]==4'hD || // IWM
	              A[23:20]==4'hE || // VIA
	              A[23:20]==4'hF || // IACK
	              VidRAMCSWR;
	assign SCSICS = A[23:20]==4'h5; // SCSI
	assign IOPWCS = RAMCS_OverlayOff && ~nWE;

endmodule
