module CS(
	/* MC68HC000 interface */
	input [23:1] A, input CLK, input nRES, input nWE, 
	/* AS cycle detection */
	input BACT,
	/* QoS enable input */
	input QoSEN,
	/* Device select outputs */
	output IOCS, output IORealCS, output IOPWCS,
	output ROMCS, output ROMCS4X,
	output RAMCS, output RAMCS0X,
	output IACKCS, output IACK0CS, output IACK1CS,
	output VIACS, output IWMCS, 
	output SCCCS, output SCSICS, output SndCSWR,
	output SetCSWR);

	/* Overlay control */
	reg Overlay;
	always @(posedge CLK) begin
		if (!BACT && !nRES) Overlay <= 1;
		else if (BACT && ROMCS4X) Overlay <= 0;
	end

	/* I/O select signals */
	assign IACKCS = A[23:20]==4'hF && A[19];
	assign IACK0CS = IACKCS && A[1];
	assign IACK1CS = IACKCS && A[2];
	assign VIACS = A[23:20]==4'hE;
	assign IWMCS = A[23:20]==4'hD;
	assign SCCCS = A[23:20]==4'hB || A[23:20]==4'h9;
	assign SCSICS = A[23:20]==4'h5;

	/* ROM select signals */
	assign ROMCS4X = A[23:20]==4'h4;
	wire ROMCSF0X  = A[23:16]==8'hF0;
	assign ROMCS = Overlay || ROMCS4X || ROMCSF0X;

	/* RAM select signals */
	assign RAMCS0X = A[23:22]==2'b00;
	assign RAMCS = RAMCS0X && !Overlay;
	wire VidRAMCSWR64k = A[23:16]==8'h3F && !nWE; // 3F0000-3FFFFF
	wire VidRAMCSWR = VidRAMCSWR64k; //&& (
		//A[15:12]==4'h2 || // 1792 bytes RAM, 2304 bytes video
		//A[15:12]==4'h3 || // 4096 bytes video
		//A[15:12]==4'h4 || // 4096 bytes video
		//A[15:12]==4'h5 || // 4096 bytes video
		//A[15:12]==4'h6 || // 4096 bytes video
		//A[15:12]==4'h7 || // 3200 bytes video, 896 bytes RAM
		//A[15:12]==4'hA || // 256 bytes RAM, 768 bytes sound, 768 bytes RAM, 2304 bytes video
		//A[15:12]==4'hB || // 4096 bytes video
		//A[15:12]==4'hC || // 4096 bytes video
		//A[15:12]==4'hD || // 4096 bytes video
		//A[15:12]==4'hE || // 4096 bytes video
		//A[15:12]==4'hF); // 3200 bytes video, 128 bytes RAM (system error space), 768 bytes sound
	assign SndCSWR = VidRAMCSWR64k && (
		((A[15:12]==4'hF) && (A[11:8]==4'hD || A[11:8]==4'hE || A[11:8]==4'hF)) ||
		((A[15:12]==4'hA) && (A[11:8]==4'h1 || A[11:8]==4'h2 || A[11:8]==4'h3)));

	assign SetCSWR = A[23:20]==4'hF && A[19:16]==4'h0 && !nWE;

	/* Select signals - IOB domain */
	assign IORealCS =
		(A[23:20]==4'hF && A[19]) || // IACK
		 A[23:20]==4'hE || // VIA
		 A[23:20]==4'hD || // IWM
		 A[23:20]==4'hC || // empty / fast ROM
		 A[23:20]==4'hB || // SCC write
		 A[23:20]==4'hA || // empty
		 A[23:20]==4'h9 || // SCC read/reset
		 A[23:20]==4'h8 || // empty
		 A[23:20]==4'h7 || // empty (expansion RAM on final rev. A except last 64 kB)
		 A[23:20]==4'h6 || // empty (expansion RAM on final rev. A)
		 A[23:20]==4'h5;   // SCSI
	assign IOCS = IORealCS || VidRAMCSWR || QoSEN;
	assign IOPWCS = IACKCS || (VidRAMCSWR64k && !QoSEN); // Posted write to video RAM only when QoS disabled
endmodule
