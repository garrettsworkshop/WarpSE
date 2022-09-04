module RAM(
	/* MC68HC000 interface */
	input CLK, input [21:1] A, input nWE, input nAS, input nLDS, input nUDS,
	/* AS cycle detection */
	input BACT, 
	/* Select and ready signals */
	input RAMCS, input ROMCS, output Ready,
	/* Refresh Counter Interface */
	input RefReqIn, input RefUrgentIn,
	/* DRAM and NOR flash interface */
	output [11:0] RA, output nRAS, output reg nCAS,
	output nLWE, output nUWE, output nOE, output nROMCS, output nROMWE);
	
	/* RAM control state */
	reg [2:0] RS = 0;
	reg RAMEN = 0;
	reg RAMReady = 0;
	reg RASEL = 0; // RASEL controls /CAS signal

	/* Refresh request synchronization */
	reg RefReqR; // Refresh synchronization
	always @(posedge CLK) RefReqR <= RefReqIn;
	reg RefReq, RefUrgent; // Refresh commands
	reg RefDone; // Refresh done "remember"
	always @(posedge CLK) begin
		RefReq <= RefReqR && !RefDone;
		RefUrgent <= RefReqR && RefUrgentIn && !RefDone;
		if (!RefReqR) RefDone <= 0;
		else if (RS==2 || RS==3) RefDone <= 1; // RS2 || RS3 to save 1 input
	end

	/* RAM enable
	 */

	/* Refresh init conditions */
	wire RAMRefFromRS0Next = RS==0 && (
		// Non-urgent refresh can start during first clock of non-RAM cycle
		( BACT && ~BACTr && ~RAMCS && RefReq) ||
		// Urgent refresh can start during bus idle
		(~BACT && RefUrgent) ||
		// Urgent refresh can start during non-ram cycle
		( BACT && ~RAMCS && RefUrgent));
	wire RAMRefFromRS0Pre = RS==0 &&
		// Urgent refresh can start during long RAM cycle after RAM access done.
		BACT &&  RAMCS && !RAMEN && RefUrgent;
	wire RAMRefFromRS0 = RAMRefFromRS0Next || RAMRefFromRS0Pre;
	// Urgent refresh cannot start when BACT and RAMCS and RAMEN,
	// since /RAS has already been asserted. For this we wait for RS7.
	wire RAMRefFromRS7 = RS==7 && RefUrgent;

	/* RAM access start condition */
	wire RAMStart = RS==0 && BACT && RAMCS && RAMEN;

	/* RAM enable (/AS -> /RAS) */
	always @(posedge CLK) begin
		if (RS==0) begin
			if (RAMRefFromRS0) RAMEN <= 0;
			else if (!BACT) RAMEN <= 1;
		end else if (RS==7) begin
			if (RAMRefFromRS7) RAMEN <= 0;
			else if (BACT) RAMEN <= 0;
			else if (!BACT) RAMEN <= 1;
		end
	end
	
	/* Refresh state */
	reg RefRAS = 0;

	assign nROMCS = ~ROMCS;
	assign nRAS =   ~((~nAS && RAMCS && RAMEN) || RefRAS);
	assign nOE =    ~(~nAS &&  nWE);
	assign nLWE =   ~(~nAS && ~nWE && ~nLDS && RAMEN);
	assign nUWE =   ~(~nAS && ~nWE && ~nUDS && RAMEN);
	assign nROMWE = ~(~nAS && ~nWE);

	/* RAM address mux (and ROM address on RA8) */
	assign RA[11] = A[19];
	assign RA[10] = A[21];
	assign RA[09] = RASEL ? A[20] : A[19];
	assign RA[08] = (RASEL && RAMCS) ? A[09] : A[18];
	assign RA[07] = RASEL ? A[08] : A[17];
	assign RA[06] = RASEL ? A[07] : A[16];
	assign RA[05] = RASEL ? A[06] : A[15];
	assign RA[04] = RASEL ? A[05] : A[14];
	assign RA[03] = RASEL ? A[04] : A[13];
	assign RA[02] = RASEL ? A[03] : A[12];
	assign RA[01] = RASEL ? A[02] : A[11];
	assign RA[00] = RASEL ? A[01] : A[10];

	 // Save BACT from last clock
	reg BACTr;
	always @(posedge CLK) BACTr <= BACT;
	always @(posedge CLK) begin
		if (RS==0) begin
			// In RS0, RAM is idle and ready for new command.
			if (RefFromRS0Next) begin
				RS <= 2;
				RAMReady <= 0;
				RASEL <= 1;
				RAMDIS1 <= 1;
			end else if (RefFromRS0Pre) begin
				// Urgent ref can start during long RAM cycle after access.
				// Must insert one extra precharge state first by going to RS1.
				RS <= 1;
				RAMReady <= 0;
				RASEL <= 0;
				RAMDIS1 <= 1;
			end else if (BACT &&  RAMCS && RAMEN) begin
				// RAM access cycle has priority over urgent refresh if RAM access already begun
				RS <= 5;
				RAMReady <= 0;
				RASEL <= 1;
				RAMDIS1 <= 0;
			end else if (RAMRefFromRS0Pre) begin
				RS <= 1;
				RAMReady <= 0;
				RASEL <= 0;
				RAMDIS1 <= 1;
			end else begin
				// No RAM access/refresh requests pending
				RS <= 0;
				RAMReady <= 1;
				RASEL <= 0;
				RAMDIS1 <= 0;
			end
			RefRAS <= 0;
		end else if (RS==1) begin
			// RS1 implements extra precharge time before refresh.
			RS <= 2;
			RAMReady <= 0;
			RASEL <= 1;
			RAMDIS1 <= 1;
			RefRAS <= 0;
		end else if (RS==2) begin
			// Refresh RAS pulse asserted ater RS2.
			RS <= 3;
			RAMReady <= 0;
			RASEL <= 1;
			RAMDIS1 <= 1;
			RefRAS <= 1;
		end else if (RS==3) begin
			// RS3 implements requisite RAS pulse width.
			RS <= 4;
			RAMReady <= 0;
			RASEL <= 0;
			RAMDIS1 <= 1;
			RefRAS <= 1;
		end else if (RS==4) begin
			// RS4 implements precharge after RAM refresh.
			RS <= 7;
			RAMReady <= 0;
			RASEL <= 0;
			RAMDIS1 <= 1;
			RefRAS <= 0;
		end else if (RS==5) begin
			// RS5 is first state of R/W operation
			RS <= 6;
			RAMReady <= 0;
			RASEL <= 1;
			RAMDIS1 <= 0;
			RefRAS <= 0;
		end else if (RS==6) begin
			// RS6 is second state of R/W operation
			RS <= 7;
			RAMReady <= 0;
			RASEL <= 0;
			RAMDIS1 <= 0;
			RefRAS <= 0;
		end else if (RS==7) begin
			// RS7 is final state of R/W or refresh operation.
			if (~BACT && RefUrgent) begin
				 // If /AS cycle terminated and urgent refresh request,
				 // we know /RAS has been in precharge so we can go to RS2.
				RS <= 2;
				RAMReady <= 0;
				RAMDIS1 <= 1;
				RASEL <= 1;
			end else if (BACT && RefUrgent) begin
				 // But if /AS cycle hasn't terminated and we need to refresh,
				 // we need to go to RS1 to add additional precharge time.
				RS <= 1;
				RAMReady <= 0;
				RASEL <= 0;
				RAMDIS1 <= 1;
			end else begin
				// Otherwise if no urgent refresh request, go to RS0.
				RS <= 0;
				RAMReady <= 1;
				RASEL <= 0;
				RAMDIS1 <= 0;
			end
			RefRAS <= 0;
		end
	end
	always @(negedge CLK) begin nCAS <= ~RASEL; end

	assign Ready = ~RAMCS || RAMReady;

endmodule
