module RAM(
	/* MC68HC000 interface */
	input CLK, input [21:1] A, input nWE,
	input nAS, input nLDS, input nUDS, input nDTACK,
	/* AS cycle detection */
	input BACT, input BACTr,
	/* Select and ready signals */
	input RAMCS, input RAMCS0X, input ROMCS, output reg RAMReady,
	/* Refresh Counter Interface */
	input RefReqIn, input RefUrgIn,
	/* DRAM and NOR flash interface */
	output [11:0] RA, output nRAS, output reg nCAS,
	output nLWE, output nUWE, output reg nOE, output nROMCS, output nROMWE);

	/* BACT and /DTACK registration */
	reg DTACKr; always @(posedge CLK) DTACKr <= !nDTACK;

	/* RAM control state */
	reg [2:0] RS = 0;
	reg RASEN = 0;
	reg RASEL = 0;
	reg RASrr = 0;
	reg RASrf = 0;

	/* Refresh command generation */
	reg RefDone; // Refresh done "remember"
	always @(posedge CLK) begin
		if (!RefReqIn && !RefUrgIn) RefDone <= 0;
		else if (RS[2]) RefDone <= 1;
	end
	wire RefReq = RefReqIn && !RefDone;
	wire RefUrg = RefUrgIn && !RefDone;

	/* RAM control signals */
	assign nRAS = !((!nAS && RAMCS && RASEN) || RASrr || RASrf);
	assign nLWE = !(!nLDS && !nWE && RASEL);
	assign nUWE = !(!nUDS && !nWE && RASEL);

	/* ROM control signals */
	assign nROMCS = !ROMCS;
	assign nROMWE = !(!nAS && !nWE);

	/* Shared ROM and RAM /OE control */
	always @(posedge CLK) nOE <= !(BACT && nWE && !(BACTr && DTACKr));

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
					(RefUrg &&  BACT && !RAMCS0X) ||
					// Urgent refresh if RAM is disabled
					(RefUrg && !RASEN);
	
	always @(posedge CLK) begin
		case (RS[2:0])
			0: begin // Idle/ready
				if (RS0toRef) begin // Refresh RAS I
					RS <= 4;
					RASEL <= 0;
					RASrr <= 1;
					RASEN <= 0;
					RAMReady <= 0;
				end else if (BACT && RAMCS && RASEN) begin // Access RAM
					RS <= 1;
					RASEL <= 1;
					RASrr <= 1;
					RASEN <= 1;
					RAMReady <= 1;
				end else begin // Stay in idle/ready
					RS <= 0;
					RASEL <= 0;
					RASrr <= 0;
					RASEN <= 1;
					RAMReady <= 1;
				end
			end 1: begin // RAM access
				RS <= 2;
				RASEL <= 1;
				RASrr <= 0;
				RASEN <= 0;
				RAMReady <= 1;
			end 2: begin // finish RAM access
				if (DTACKr) RS <= 3; // Cycle ending
				else RS <= 2; // Cycle not ending yet
				RASEL <= 0;
				RASrr <= 0;
				RASEN <= 0;
				RAMReady <= 1;
			end 3: begin  //AS cycle complete
				if (RefUrg)  begin // Refresh RAS
					RS <= 4;
					RASEL <= 0;
					RASrr <= 1;
					RASEN <= 0;
					RAMReady <= 0;
				end else begin // Cycle ended so go abck to idle/ready
					RS <= 0;
					RASEL <= 0;
					RASrr <= 0;
					RASEN <= 1;
					RAMReady <= 1;
				end
			end 4: begin // Refresh RAS II
				RS <= 5;
				RASEL <= 0;
				RASrr <= 1;
				RASEN <= 0;
				RAMReady <= 0;
			end 5: begin // Refresh precharge I
				RS <= 6;
				RASEL <= 0;
				RASrr <= 0;
				RASEN <= 0;
				RAMReady <= 0;
			end 6: begin // Refresh precharge II
				RS <= 7;
				RASEL <= 0;
				RASrr <= 0;
				RASEN <= 0;
				RAMReady <= 0;
			end 7: begin // Reenable RAM and go to idle/ready
				RS <= 0;
				RASEL <= 0;
				RASrr <= 0;
				RASEN <= 1;
				RAMReady <= 1;
			end
		endcase
	end
	always @(negedge CLK) begin
		RASrf <= RS==1;
		case (RS[2:0])
			0: nCAS <= !RS0toRef;
			1: nCAS <= 0;
			2: nCAS <= DTACKr;
			3: nCAS <= !RefUrg;
			4: nCAS <= !RefUrg;
			5: nCAS <= 1;
			6: nCAS <= 1;
			7: nCAS <= 1;
		endcase
	end

endmodule
