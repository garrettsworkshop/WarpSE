module RAM(
	/* Fast clock and 25 MHz substate */
	input CLK, input [1:0] SS,
	/* MC68HC000 interface */
	input [21:1] A, input nWE, input nAS, input nLDS, input nUDS,
	input BACT,
	/* Select and ready signals */
	input RAMCS, input ROMCS,
	/* SDRAM interface */
	output reg CKE, output reg nCS,
	output reg nRAS, output reg nCAS, output reg nRWE,
	output reg [1:0] BA, output reg [11:0] RA,
	output reg DQMH, output reg DQML);

	/* RAM control state */
	reg [1:0] RS = 0;
	reg Once1 = 0;
	reg Once3 = 0;
	always @(posedge CLK) begin
		if (SS[1:0]==2'h3) case (RS[1:0])
			2'h0: RS <= 2'h1;
			2'h1: RS <= ~nAS ? (Once3 ? 2'h3 : 2'h2) : 2'h1;
			2'h2: RS <= 2'h3;
			2'h3: RS <= 2'h0;
		endcase
	end
	always @(posedge CLK) begin
		if (SS[1:0]==2'h1 && RS[1:0]==2'h1 && ~nAS && RAMCS) Once1 <= 1;
		else if (SS[1:0]==2'h3) begin
			if (nAS) begin
				Once1 <= 0;
				Once3 <= 0;
			end else Once3 <= Once1;
		end
	end

	/* RAM control and address */
	always @(posedge CLK) begin
		case (RS[1:0])
			2'h0: begin
				// NOP CKD
				CKE <= 1'b0;
				nCS <= 1'b1;
				nRAS <= 1'b1;
				nCAS <= 1'b1;
				nRWE <= 1'b1;
				DQML <= 1'b1;
				DQMH <= 1'b1;
			end 2'h1: begin
				case (SS[1:0])
					2'h0: begin
						if (RAMCS || ROMCS) begin
							// NOP CKE
							CKE <= 1'b1;
							nCS <= 1'b1;
							nRAS <= 1'b1;
							nCAS <= 1'b1;
							nRWE <= 1'b1;
							DQML <= 1'b1;
							DQMH <= 1'b1;
						end else begin
							// NOP CKD
							CKE <= 1'b0;
							nCS <= 1'b1;
							nRAS <= 1'b1;
							nCAS <= 1'b1;
							nRWE <= 1'b1;
							DQML <= 1'b1;
							DQMH <= 1'b1;
						end
						RA[11:0] <= A[21:10];
					end 2'h1: begin
						if (~nAS && ~Once3 && (RAMCS || ROMCS)) begin
							// ACT CKD
							CKE <= 1'b0;
							nCS <= 1'b0;
							nRAS <= 1'b0;
							nCAS <= 1'b1;
							nRWE <= 1'b1;
							DQML <= 1'b1;
							DQMH <= 1'b1;
						end else begin
							// NOP CKD
							CKE <= 1'b0;
							nCS <= 1'b1;
							nRAS <= 1'b1;
							nCAS <= 1'b1;
							nRWE <= 1'b1;
							DQML <= 1'b1;
							DQMH <= 1'b1;
						end
						RA[11:0] <= A[21:10];
					end 2'h2: begin
						if (~nAS && ~Once3 && nWE && (RAMCS || ROMCS)) begin
							// NOP CKE
							CKE <= 1'b1;
							nCS <= 1'b1;
							nRAS <= 1'b1;
							nCAS <= 1'b1;
							nRWE <= 1'b1;
							DQML <= 1'b1;
							DQMH <= 1'b1;
						end else begin
							// NOP CKD
							CKE <= 1'b0;
							nCS <= 1'b1;
							nRAS <= 1'b1;
							nCAS <= 1'b1;
							nRWE <= 1'b1;
							DQML <= 1'b1;
							DQMH <= 1'b1;
						end
						RA[10] <= 1'b1; // auto-precharge
						RA[9] <= A[9]; // don't care
						RA[8:0] <= A[9:1];
					end 2'h3: begin
						if (~nAS && ~Once3 && nWE && (RAMCS || ROMCS)) begin
							// RD CKE
							CKE <= 1'b1;
							nCS <= 1'b0;
							nRAS <= 1'b1;
							nCAS <= 1'b0;
							nRWE <= 1'b1;
							DQML <= 1'b1;
							DQMH <= 1'b1;
						end else begin
							// NOP CKD
							CKE <= 1'b0;
							nCS <= 1'b1;
							nRAS <= 1'b1;
							nCAS <= 1'b1;
							nRWE <= 1'b1;
							DQML <= 1'b1;
							DQMH <= 1'b1;
						end
						RA[10] <= 1'b1; // auto-precharge
						RA[9] <= A[19]; // don't care
						RA[8:0] <= A[9:1];
					end
				endcase
				BA[1] <= 1'b0;
				BA[0] <= RAMCS;
			end 2'h2: begin
				case (SS[1:0])
					2'h0: begin
						if (~nWE && RAMCS) begin
							// NOP CKE
							CKE <= 1'b1;
							nCS <= 1'b1;
							nRAS <= 1'b1;
							nCAS <= 1'b1;
							nRWE <= 1'b1;
							DQML <= 1'b1;
							DQMH <= 1'b1;
						end else begin
							// NOP CKD
							CKE <= 1'b0;
							nCS <= 1'b1;
							nRAS <= 1'b1;
							nCAS <= 1'b1;
							nRWE <= 1'b1;
							DQML <= 1'b1;
							DQMH <= 1'b1;
						end
					end 2'h1: begin
						if (~nWE && RAMCS) begin
							// WR CKE
							CKE <= 1'b1;
							nCS <= 1'b0;
							nRAS <= 1'b1;
							nCAS <= 1'b0;
							nRWE <= 1'b0;
							DQML <= nLDS;
							DQMH <= nUDS;
						end else begin
							// NOP CKD
							CKE <= 1'b0;
							nCS <= 1'b1;
							nRAS <= 1'b1;
							nCAS <= 1'b1;
							nRWE <= 1'b1;
							DQML <= 1'b1;
							DQMH <= 1'b1;
						end
					end 2'h2: begin
						// NOP CKE
						CKE <= 1'b1;
						nCS <= 1'b1;
						nRAS <= 1'b1;
						nCAS <= 1'b1;
						nRWE <= 1'b1;
						DQML <= 1'b1;
						DQMH <= 1'b1;
					end 2'h3: begin
						// PC CKD
						CKE <= 1'b0;
						nCS <= 1'b0;
						nRAS <= 1'b0;
						nCAS <= 1'b1;
						nRWE <= 1'b0;
						DQML <= 1'b1;
						DQMH <= 1'b1;
					end
				endcase
				// BA[1:0] doesn't change
				RA[10] <= 1'b1; // auto-precharge / "all"
				RA[9] <= A[19]; // don't care
				RA[8:0] <= A[9:1];
			end 2'h3: begin
				case (SS[1:0])
					2'h0: begin
						// NOP CKE
						CKE <= 1'b1;
						nCS <= 1'b1;
						nRAS <= 1'b1;
						nCAS <= 1'b1;
						nRWE <= 1'b1;
						DQML <= 1'b1;
						DQMH <= 1'b1;
					end 2'h1: begin
						// AREF
						CKE <= 1'b1;
						nCS <= 1'b0;
						nRAS <= 1'b0;
						nCAS <= 1'b0;
						nRWE <= 1'b1;
						DQML <= 1'b1;
						DQMH <= 1'b1;
					end 2'h2: begin
						// NOP CKD
						CKE <= 1'b0;
						nCS <= 1'b1;
						nRAS <= 1'b1;
						nCAS <= 1'b1;
						nRWE <= 1'b1;
						DQML <= 1'b1;
						DQMH <= 1'b1;
					end 2'h3: begin
						// NOP CKD
						CKE <= 1'b0;
						nCS <= 1'b1;
						nRAS <= 1'b1;
						nCAS <= 1'b1;
						nRWE <= 1'b1;
						DQML <= 1'b1;
						DQMH <= 1'b1;
					end
				endcase
			end
		endcase
	end

endmodule
