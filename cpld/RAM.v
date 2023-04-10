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
	
	/* RAM control state */
	reg [3:0] RS = 0;
	reg RASEN = 0;
	reg RASEL = 0;
	reg CAS = 0;
	reg RASrr = 0;
	reg RASrf = 0;

	/* Refresh command generation */
	reg RefDone; // Refresh done "remember"
	always @(posedge CLK) begin
		if (!RefReqIn && !RefUrgIn) RefDone <= 0;
		else if (RS[3]) RefDone <= 1;
	end
	wire RefReq = RefReqIn && !RefDone;
	wire RefUrg = RefUrgIn && !RefDone;

	/* RAM control signals */
	assign nRAS =   !((!nAS && RAMCS && RASEN) || RASrr || RASrf);
	assign nOE =    !(!nAS &&  nWE); // Shared with ROM
	assign nLWE =   !(!nLDS && !nWE && RASEL);
	assign nUWE =   !(!nUDS && !nWE && RASEL);

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
	
	reg BACTr; always @(posedge CLK) BACTr <= BACT;
	
	always @(posedge CLK) begin
		case (RS[3:0])
			0: begin
				if (( BACT && !BACTr && !RAMCS0X && RefReq) ||
					 (!BACT && RefUrg) ||
					 ( BACT && RefUrg && !RAMCS0X) ||
					 (!RASEN)) begin
					RS <= 8;
					RASEL <= 0;
					CAS <= 1;
					RASrr <= 0;
					RASEN <= 0;
					RAMReady <= 0;
				end else if (BACT && RAMCS && RASEN) begin
					RS <= 1;
					RASEL <= 1;
					CAS <= 1;
					RASrr <= 1;
					RASEN <= 1;
					RAMReady <= 1;
				end else begin
					RS <= 0;
					RASEL <= 0;
					CAS <= 0;
					RASrr <= 0;
					RASEN <= 1;
					RAMReady <= 1;
				end
			end 1: begin
				RS <= 2;
				RASEL <= 1;
				CAS <= 1;
				RASrr <= 0;
				RASEN <= 0;
				RAMReady <= 1;
			end 2: begin
				RS <= 3;
				RASEL <= 0;
				CAS <= 0;
				RASrr <= 0;
				RASEN <= 0;
				RAMReady <= 1;
			end 3: begin
				if (BACT) begin
					RS <= 3;
					RASEL <= 0;
					CAS <= 0;
					RASrr <= 0;
					RASEN <= 0;
					RAMReady <= 1;
				end else if (RefUrg) begin
					RS <= 8;
					RASEL <= 0;
					CAS <= 1;
					RASrr <= 0;
					RASEN <= 0;
					RAMReady <= 0;
				end else begin
					RS <= 0;
					RASEL <= 0;
					CAS <= 0;
					RASrr <= 0;
					RASEN <= 1;
					RAMReady <= 1;
				end
			end 8: begin
				RS <= 9;
				RASEL <= 0;
				CAS <= 1;
				RASrr <= 1;
				RASEN <= 0;
				RAMReady <= 0;
			end 9: begin
				RS <= 10;
				RASEL <= 0;
				CAS <= 0;
				RASrr <= 1;
				RASEN <= 0;
				RAMReady <= 0;
			end 10: begin
				RS <= 11;
				RASEL <= 0;
				CAS <= 0;
				RASrr <= 0;
				RASEN <= 0;
				RAMReady <= 0;
			end 11: begin
				RS <= 15;
				RASEL <= 0;
				CAS <= 0;
				RASrr <= 0;
				RASEN <= 0;
				RAMReady <= 0;
			end 15: begin
				RS <= 0;
				RASEL <= 0;
				CAS <= 0;
				RASrr <= 0;
				RASEN <= 1;
				RAMReady <= 1;
			end default: begin
				RS <= 0;
				RASEL <= 0;
				CAS <= 0;
				RASrr <= 0;
				RASEN <= 1;
				RAMReady <= 1;
			end
		endcase
	end
	always @(negedge CLK) RASrf <= RS==1;
	always @(negedge CLK) nCAS <= !CAS;

endmodule
