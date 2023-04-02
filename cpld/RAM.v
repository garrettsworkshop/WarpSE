module RAM(
	/* MC68HC000 interface */
	input CLK, input [21:1] A, input nWE, input nAS, input nLDS, input nUDS,
	/* AS cycle detection */
	input BACT, 
	/* Select and ready signals */
	input RAMCS, input ROMCS, output RAM_Ready,
	/* Refresh Counter Interface */
	input RefReqIn, input RefUrgIn,
	/* DRAM and NOR flash interface */
	output [11:0] RA, output nRAS, output reg nCAS,
	output nLWE, output nUWE, output nOE, output nROMCS, output nROMWE);
	
	// Save BACT from last clock
	reg BACTr; always @(posedge CLK) BACTr <= BACT;
	
	/* RAM control state */
	reg [2:0] RS = 0;
	reg RAMEN = 0;
	reg RAMReady = 0;
	reg RASEL = 0; // RASEL controls /CAS signal

	/* Refresh request synchronization */
	reg RefReqSync; always @(posedge CLK) RefReqSync <= RefReqIn;
	reg RegUrgSync; always @(posedge CLK) RegUrgSync <= RefUrgIn;
	
	/* Refresh command generation */
	reg RefReq, RefUrg; // Refresh commands
	reg RefDone; // Refresh done "remember"
	always @(posedge CLK) begin
		RefReq <= RefReqSync && !RefDone;
		RefUrg <= RegUrgSync && !RefDone;
		if (!RefReqSync) RefDone <= 0;
		else if (RS==2 || RS==3) RefDone <= 1; // RS2 || RS3 to save 1 input
	end

	/* Refresh init conditions */
	wire RefFromRS0Next = RS==0 && (
		// Non-urgent refresh can start during first clock of non-RAM cycle
		( BACT && ~BACTr && ~RAMCS && RefReq) ||
		// Urgent refresh can start during bus idle
		(~BACT && RefUrg) ||
		// Urgent refresh can start during non-ram cycle
		( BACT && ~RAMCS && RefUrg));
	wire RefFromRS0Pre = RS==0 &&
		// Urgent refresh can start during long RAM cycle after RAM access done.
		BACT &&  RAMCS && !RAMEN && RefUrg;
	wire RefFromRS0 = RefFromRS0Next || RefFromRS0Pre;
	// Urgent refresh cannot start when BACT and RAMCS and RAMEN,
	// since /RAS has already been asserted. For this we wait for RS7.
	wire RefFromRS7 = RS==7 && RefUrg;

	/* RAM enable (/AS -> /RAS) */
	always @(posedge CLK) begin
		if (RS==0) begin
			if (RefFromRS0) RAMEN <= 0;
			else if (!BACT) RAMEN <= 1;
		end else if (RS==7) begin
			if (RefFromRS7) RAMEN <= 0;
			else RAMEN <= 1;
		end
	end
	
	/* Refresh state */
	reg RefRAS = 0;

	assign nROMCS = !ROMCS;
	assign nRAS =   !((~nAS && RAMCS && RAMEN) || RefRAS);
	assign nOE =    !(~nAS &&  nWE);
	assign nLWE =   !(~nAS && ~nWE && ~nLDS && RAMEN);
	assign nUWE =   !(~nAS && ~nWE && ~nUDS && RAMEN);
	assign nROMWE = !(~nAS && ~nWE);

	/* RAM address mux (and ROM address on RA8) */
	assign RA[11] = ROMCS ? A[19] : !RASEL ? A[21] : A[20];
	assign RA[03] = 				!RASEL ? A[21] : A[20];

	assign RA[10] = 				!RASEL ? A[19] : A[17];
	assign RA[02] = 				!RASEL ? A[18] : A[17];
	
	assign RA[09] = 				!RASEL ? A[16] : A[08];
	assign RA[08] = ROMCS ? A[18] : !RASEL ? A[15] : A[07];
	assign RA[07] = 				!RASEL ? A[14] : A[06];
	assign RA[06] = 				!RASEL ? A[13] : A[05];
	assign RA[05] = 				!RASEL ? A[12] : A[04];
	assign RA[04] = 				!RASEL ? A[11] : A[03];
	assign RA[01] = 				!RASEL ? A[10] : A[02];
	assign RA[00] = 				!RASEL ? A[09] : A[01];

	always @(posedge CLK) begin
		if (RS==0) begin
			// In RS0, RAM is idle and ready for new command.
			if (RefFromRS0Next) begin
				RS <= 2;
				RAMReady <= 0;
				RASEL <= 1;
			end else if (RefFromRS0Pre) begin
				// Urgent ref can start during long RAM cycle after access.
				// Must insert one extra precharge state first by going to RS1.
				RS <= 1;
				RAMReady <= 0;
				RASEL <= 0;
			end else if (BACT &&  RAMCS && RAMEN) begin
				// RAM access cycle has priority over urgent refresh if RAM access already begun
				RS <= 5;
				RAMReady <= 0;
				RASEL <= 1;
			end else if (RefFromRS0Pre) begin
				RS <= 1;
				RAMReady <= 0;
				RASEL <= 0;
			end else begin
				// No RAM access/refresh requests pending
				RS <= 0;
				RAMReady <= 1;
				RASEL <= 0;
			end
			RefRAS <= 0;
		end else if (RS==1) begin
			// RS1 implements extra precharge time before refresh.
			RS <= 2;
			RAMReady <= 0;
			RASEL <= 1;
			RefRAS <= 0;
		end else if (RS==2) begin
			// Refresh RAS pulse asserted ater RS2.
			RS <= 3;
			RAMReady <= 0;
			RASEL <= 1;
			RefRAS <= 1;
		end else if (RS==3) begin
			// RS3 implements requisite RAS pulse width.
			RS <= 4;
			RAMReady <= 0;
			RASEL <= 0;
			RefRAS <= 1;
		end else if (RS==4) begin
			// RS4 implements precharge after RAM refresh.
			RS <= 7;
			RAMReady <= 0;
			RASEL <= 0;
			RefRAS <= 0;
		end else if (RS==5) begin
			// RS5 is first state of R/W operation
			RS <= 6;
			RAMReady <= 0;
			RASEL <= 1;
			RefRAS <= 0;
		end else if (RS==6) begin
			// RS6 is second state of R/W operation
			RS <= 7;
			RAMReady <= 0;
			RASEL <= 0;
			RefRAS <= 0;
		end else if (RS==7) begin
			// RS7 is final state of R/W or refresh operation.
			if (~BACT && RefUrg) begin
				 // If /AS cycle terminated and urgent refresh request,
				 // we know /RAS has been in precharge so we can go to RS2.
				RS <= 2;
				RAMReady <= 0;
				RASEL <= 1;
			end else if (BACT && RefUrg) begin
				 // But if /AS cycle hasn't terminated and we need to refresh,
				 // we need to go to RS1 to add additional precharge time.
				RS <= 1;
				RAMReady <= 0;
				RASEL <= 0;
			end else begin
				// Otherwise if no urgent refresh request, go to RS0.
				RS <= 0;
				RAMReady <= 1;
				RASEL <= 0;
			end
			RefRAS <= 0;
		end
	end
	always @(negedge CLK) begin nCAS <= ~RASEL; end

	assign RAM_Ready = ~RAMCS || RAMReady;

endmodule
