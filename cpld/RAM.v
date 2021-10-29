module RAM(
	/* MC68HC000 interface */
	input CLK, input [21:1] A, input nWE, input nAS, input nLDS, input nUDS,
	/* AS cycle detection */
	input BACT, 
	/* Select and ready signals */
	input RAMCS, input ROMCS, output Ready,
	/* Refresh Counter Interface */
	input RefReq, input RefUrgent, output RefAck,
	/* DRAM and NOR flash interface */
	output [11:0] RA, output nRAS, output reg nCAS,
	output nLWE, output nUWE, output nOE, output nROMCS, output nROMWE);
	
	/* RAM control state */
	reg [2:0] RS = 0;
	reg Once = 0;
	reg RAMReady = 0;
	reg RASEL = 0; // RASEL controls /CAS signal
	
	/* Refresh state */
	reg RAMDIS1 = 0;
	reg RAMDIS2 = 0;
	wire RAMDIS = RAMDIS1 || RAMDIS2;
	wire RAMEN = ~RAMDIS;
	reg RefRAS = 0;

	assign nROMCS = ~ROMCS;
	assign nRAS =   ~((~nAS && RAMCS && RAMEN && ~RefRAS /* does this add loading to these P-terms? */) || RefRAS);
	assign nOE =    ~(~nAS &&  nWE);
	assign nLWE =   ~(~nAS && ~nWE && ~nLDS && RAMEN);
	assign nUWE =   ~(~nAS && ~nWE && ~nUDS && RAMEN);
	assign nROMWE = ~(~nAS && ~nWE);

	assign RA[11] = A[19];
	assign RA[10] = A[21];
	assign RA[9:0] = RASEL ? {A[20], A[09:01]} : {A[19], A[18:10]};

	always @(posedge CLK) begin
		if (~BACT) Once <= 0;
		else if (RS==0 && BACT && RAMCS) Once <= 1;
	end
	always @(posedge CLK) begin
		if (~BACT) RAMDIS2 <= 0;
		else if ((RS==0 && BACT && RefUrgent && Once && RAMCS) || 
		         (RS==7 && BACT && RefUrgent && Once)) RAMDIS2 <= 1;
	end
	reg BACTr;
	always @(posedge CLK) begin BACTr <= BACT; end
	always @(posedge CLK) begin
		if (RS==0) begin
			if (( BACT && RefReq && ~RAMCS && ~BACTr) || // Non-urgent refresh can start during first clock of non-RAM cycle
				 (~BACT && RefUrgent) || // Urgent refresh can start during bus idle
				 ( BACT && RefUrgent && ~RAMCS)) begin // Urgent refresh can start during non-ram cycle
				RS <= 2;
				RAMReady <= 0;
				RASEL <= 1;
				RAMDIS1 <= 1;
			end else if (BACT &&  RAMCS && ~Once) begin
				// RAM access cycle has priority over urgent refresh if RAM access already begun
				RS <= 5;
				RAMReady <= 0;
				RASEL <= 1;
				RAMDIS1 <= 0;
			end else if (BACT &&  RAMCS && RefUrgent) begin
				// Urgent refresh can start during prolonged RAM access cycle
				// But we must insert one extra precharge state first.
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
			RS <= 2;
			RAMReady <= 0;
			RASEL <= 1;
			RAMDIS1 <= 1;
			RefRAS <= 0;
		end else if (RS==2) begin
			RS <= 3;
			RAMReady <= 0;
			RASEL <= 1;
			RAMDIS1 <= 1;
			RefRAS <= 1;
		end else if (RS==3) begin
			RS <= 4;
			RAMReady <= 0;
			RASEL <= 0;
			RAMDIS1 <= 1;
			RefRAS <= 1;
		end else if (RS==4) begin
			RS <= 7;
			RAMReady <= 0;
			RASEL <= 0;
			RAMDIS1 <= 1;
			RefRAS <= 0;
		end else if (RS==5) begin
			RS <= 6;
			RAMReady <= 0;
			RASEL <= 1;
			RAMDIS1 <= 0;
			RefRAS <= 0;
		end else if (RS==6) begin
			RS <= 7;
			RAMReady <= 0;
			RASEL <= 0;
			RAMDIS1 <= 0;
			RefRAS <= 0;
		end else if (RS==7) begin
			if (~BACT && RefUrgent) begin
				RS <= 2;
				RAMReady <= 0;
				RAMDIS1 <= 1;
				RASEL <= 1;
			end else if (BACT && RefUrgent) begin
				RS <= 1;
				RAMReady <= 0;
				RASEL <= 0;
				RAMDIS1 <= 1;
			end else begin
				RS <= 0;
				RAMReady <= 1;
				RASEL <= 0;
				RAMDIS1 <= 0;
			end
			RefRAS <= 0;
		end
	end
	always @(negedge CLK) begin nCAS <= ~RASEL; end

	assign RefAck = RefRAS;

	assign Ready = ~RAMCS || RAMReady;

endmodule
