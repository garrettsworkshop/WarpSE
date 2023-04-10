module RAM(
	/* MC68HC000 interface */
	input CLK, input [21:1] A, input nWE, input nAS, input nLDS, input nUDS,
	/* AS cycle detection */
	input BACT, 
	/* Select and ready signals */
	input RAMCS, input RAMCS0X, input ROMCS, output reg RAMReady,
	/* Refresh Counter Interface */
	input RefReqIn, input RefUrgIn,
	/* DRAM and NOR flash interface */
	output [11:0] RA, output nRAS, output reg nCAS,
	output nLWE, output nUWE, output nOE, output nROMCS, output nROMWE);
	
	/* BACT saved from last cycle */
	reg BACTr; always @(posedge CLK) BACTr <= BACT;
	
	/* RAM control state */
	reg [2:0] RS = 0;
	reg Once = 0;
	reg RAMEN = 0;
	reg RASEL = 0;
	reg CAS = 0;
	reg RASrr = 0;
	reg RASrf = 0;

	/* Refresh command generation */
	reg RefDone; // Refresh done "remember"
	always @(posedge CLK) begin
		if (!RefReqIn && !RefUrgIn) RefDone <= 0;
		else if (RS==4 || RS==5) RefDone <= 1;
	end
	wire RefReq = RefReqIn && !RefDone;
	wire RefUrg = RefUrgIn && !RefDone;

	/* RAM control signals */
	assign nRAS =   !((!nAS && RAMCS && RAMEN) || RASrr || RASrf);
	assign nOE =    !((!nAS &&  nWE)); // Shared with ROM
	assign nLWE =   !((!nAS && !nWE && !nLDS && RAMEN));
	assign nUWE =   !((!nAS && !nWE && !nUDS && RAMEN));

	/* ROM control signals */
	assign nROMCS = !ROMCS;
	assign nROMWE = !((!nAS && !nWE));

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

	wire RefFromRS0 = ((RefReq &&  BACT && !BACTr && !RAMCS0X) ||
					   (RefUrg && !BACT) ||
					   (RefUrg &&  BACT && !RAMCS0X) ||
					   (RefUrg &&  BACT && !RAMEN && !nWE));
	wire RefFromRS2 = RefUrg;
	wire RAMStart = BACT && RAMCS && RAMEN;
	always @(posedge CLK) begin
		case (RS[2:0])
			0: begin
				if (RAMStart) begin
					RS <= 1;
					RASEL <= 1;
					CAS <= 1;
					RASrr <= 1;
				end else if (RefFromRS0) begin
					RS <= 3;
					RASEL <= 0;
					CAS <= 1;
					RASrr <= 0;
				end else begin
					RS <= 0;
					RASEL <= 0;
					CAS <= 0;
					RASrr <= 0;
				end
			end 1: begin
				RS <= 2;
				RASEL <= 1;
				CAS <= 1;
				RASrr <= 0;
			end 2: begin
				if (RefFromRS2) begin
					RS <= 3;
					RASEL <= 0;
					CAS <= 1;
					RASrr <= 0;
				end else begin
					RS <= 7;
					RASEL <= 0;
					CAS <= 0;
					RASrr <= 0;
				end
			end 3: begin
				RS <= 4;
				RASEL <= 0;
				CAS <= 1;
				RASrr <= 1;
			end 4: begin
				RS <= 5;
				RASEL <= 0;
				CAS <= 0;
				RASrr <= 1;
			end 5: begin
				RS <= 6;
				RASEL <= 0;
				CAS <= 0;
				RASrr <= 0;
			end 6: begin
				RS <= 7;
				RASEL <= 0;
				CAS <= 0;
				RASrr <= 0;
			end 7: begin
				RS <= 0;
				RASEL <= 0;
				CAS <= 0;
				RASrr <= 0;
			end
		endcase
	end
	always @(negedge CLK) RASrf <= RS==1;
	always @(negedge CLK) nCAS <= !CAS;

	/* RAM state control */
	always @(posedge CLK) begin
		if (RS==0 && RefFromRS0) RAMEN <= 0;
		else if (RS==1) RAMEN <= 0;
		else if (!BACT && RS==7) RAMEN <= 1;
		else if (!BACT && RS==0) RAMEN <= 1;
		else if (!Once && RS==7) RAMEN <= 1;
		else if (!Once && RS==0) RAMEN <= 1; // not needed?
	end
	always @(posedge CLK) begin
		if (!BACT) Once <= 0;
		else if (RS==0 && RAMStart) Once <= 1;
	end

	/* RAM ready signal */
	always @(posedge CLK) begin
		RAMReady <= (BACT && RAMReady) || (RS==7) || (RS==0 && !RefFromRS0);
	end	

endmodule
