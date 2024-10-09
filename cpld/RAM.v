module RAM(
	/* MC68HC000 interface */
	input CLK, input [21:1] A, input nWE,
	input nAS, input nLDS, input nUDS, input nDTACK,
	/* AS cycle detection */
	input BACT, input BACTr,
	/* Select and ready signals */
	input RAMCS, input RAMCS0X, input ROMCS, input ROMCS4X,
	/* RAM ready output */
	output RAMReady,
	/* Refresh Counter Interface */
	input RefReqIn, input RefUrgIn,
	/* DRAM interface */
	output [11:0] RA, output nRAS, output reg nCAS,
	output nLWE, output nUWE, output reg nOE,
	/* NOR flash interface */
	output nROMOE, output nROMWE);

	/* RAM control state */
	reg [2:0] RS;
	reg RASEN;
	reg RASEL;
	reg RASrf;
	reg RefCAS;
	reg CASEndEN;

	/* Refresh command generation */
	reg RefDone; // Refresh done "remember"
	always @(posedge CLK) begin
		if (!RefReqIn) RefDone <= 0;
		else if (RS[2]) RefDone <= 1;
	end
	wire RefReq = RefReqIn && !RefDone;
	wire RefUrg = RefUrgIn && !RefDone;
	
	/* RAM ready control */
	reg RAMReadyReg;
	assign RAMReady = RAMReadyReg;//!RS[2];

	/* RAM /RAS control */
	assign nRAS = !((!nAS && RAMCS && RASEN) || RASrf);
	
	/* RAM /WE control */
	assign nLWE = !(!nLDS && RASEL && !nWE);
	assign nUWE = !(!nUDS && RASEL && !nWE);
	
	/* RAM /OE control */
	always @(posedge CLK, posedge nAS) begin
		if (nAS) nOE <= 1;
		else nOE <= !(RAMCS && nWE);
	end

	/* ROM /OE and /WE control */
	assign nROMOE = !(!nAS && ROMCS   &&  nWE);
	assign nROMWE = !(!nAS && ROMCS4X && !nWE);

	/* RAM address mux (and ROM address on RA8) */
	// RA11 doesn't do anything so both should be identical.
	assign RA[11] = !RASEL ? A[19] : A[20]; // ROM address 19
	assign RA[03] = !RASEL ? A[19] : A[20];
	// RA10 has only row so different rows but same column.
	assign RA[10] = !RASEL ? A[17] : A[07];
	assign RA[02] = !RASEL ? A[16] : A[07];
	// Remainder of RA bus is unpaired
	assign RA[09] = !RASEL ? A[15] : A[08];
	assign RA[08] = !RASEL ? A[18] : A[21]; // ROM address 18
	assign RA[07] = !RASEL ? A[14] : A[06];
	assign RA[06] = !RASEL ? A[13] : A[05];
	assign RA[05] = !RASEL ? A[12] : A[04];
	assign RA[04] = !RASEL ? A[11] : A[03];
	assign RA[01] = !RASEL ? A[10] : A[02];
	assign RA[00] = !RASEL ? A[09] : A[01];

	wire RS0toRef = // Refresh during first clock of non-RAM access
					(RefReq &&  BACT && !BACTr && !RAMCS0X) ||
					// Urgent refresh while bus inactive
					(RefUrg && !BACT) ||
					// Urgent refresh during non-RAM access
					(RefUrg &&  BACT && !RAMCS0X);
	wire RS0toRAM = BACT && RAMCS && RASEN;
	
	always @(posedge CLK) begin
		case (RS[2:0])
			0: begin // Idle/ready
				if (RS0toRAM) RS <= 1; // Access RAM
				else if (RS0toRef) RS <= 4; // To refresh
				else RS <= 0; // Stay in idle/ready
				RASEL <= BACT && RAMCS;
				RefCAS <= RS0toRef;
				RASEN <= !RS0toRef;
				RAMReadyReg <= !RS0toRef;
			end 1: begin // RAM access
				if (!nDTACK || !BACT) RS <= 2; // Cycle ending
				else RS <= 1; // Cycle not ending yet
				RASEL <= 1;
				RefCAS <= 0;
				RASEN <= nDTACK;
				RAMReadyReg <= 1;
			end 2: begin // finish RAM access
				RS <= 3;
				RASEL <= 0;
				RefCAS <= 0;
				RASEN <= 0;
				RAMReadyReg <= 1;
			end 3: begin  //AS cycle complete
				if (RefUrg)  begin // Refresh RAS
					RS <= 4;
					RefCAS <= 1;
					RASEN <= 0;
					RAMReadyReg <= 0;
				end else begin // Cycle ended so go back to idle/ready
					RS <= 0;
					RefCAS <= 0;
					RASEN <= 1;
					RAMReadyReg <= 1;
				end
				RASEL <= 0;
			end 4: begin // Refresh RAS I
				RS <= 5;
				RASEL <= 0;
				RefCAS <= 0;
				RASEN <= 0;
				RAMReadyReg <= 0;
			end 5: begin // Refresh RAS II
				RS <= 6;
				RASEL <= 0;
				RefCAS <= 0;
				RASEN <= 0;
				RAMReadyReg <= 0;
			end 6: begin // Refresh precharge I
				RS <= 7;
				RASEL <= 0;
				RefCAS <= 0;
				RASEN <= 0;
				RAMReadyReg <= 0;
			end 7: begin // Reenable RAM and go to idle/ready
				RS <= 0;
				RASEL <= 0;
				RefCAS <= 0;
				RASEN <= 1;
				RAMReadyReg <= 1;
			end
		endcase
	end

	always @(negedge CLK) begin
		case (RS[2:0])
			0: begin
				RASrf <= 0;
				CASEndEN <= 0;
			end 1: begin
				RASrf <= 1;
				CASEndEN <= 1;
			end 2: begin
				RASrf <= 0;
				CASEndEN <= 1;
			end 3: begin
				RASrf <= 0;
				CASEndEN <= 0;
			end 4: begin
				RASrf <= 1;
				CASEndEN <= 0;
			end 5: begin
				RASrf <= 1;
				CASEndEN <= 0;
			end 6: begin
				RASrf <= 0;
				CASEndEN <= 0;
			end 7: begin
				RASrf <= 0;
				CASEndEN <= 0;
			end
		endcase
	end

	wire CASEnd = CASEndEN && nAS;
	always @(negedge CLK, posedge RefCAS, posedge CASEnd) begin
		if (RefCAS) nCAS <= 0;
		else if (CASEnd) nCAS <= 1;
		else case (RS[2:0])
			0: nCAS <= 1;
			1: nCAS <= 0;
			2: nCAS <= 0;
			3: nCAS <= 1;
			4: nCAS <= 0;
			5: nCAS <= 1;
			6: nCAS <= 1;
			7: nCAS <= 1;
		endcase
	end

endmodule
