`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   07:47:59 12/11/2021
// Design Name:   RAM
// Module Name:   C:/Users/zanek/Documents/GitHub/Warp-SE/cpld/XC95144XL/t_ram.v
// Project Name:  MXSE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RAM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_ram;

	// Inputs
	reg CLK;
	reg [21:1] A;
	reg nWE;
	reg nAS;
	reg nLDS;
	reg nUDS;
	reg BACT;
	reg RAMCS;
	reg ROMCS;
	reg RefReq;
	reg RefUrgent;

	// Outputs
	wire Ready;
	wire RefAck;
	wire [11:0] RA;
	wire nRAS;
	wire nCAS;
	wire nLWE;
	wire nUWE;
	wire nOE;
	wire nROMCS;
	wire nROMWE;

	// Instantiate the Unit Under Test (UUT)
	RAM uut (
		.CLK(CLK), 
		.A(A), 
		.nWE(nWE), 
		.nAS(nAS), 
		.nLDS(nLDS), 
		.nUDS(nUDS), 
		.BACT(BACT), 
		.RAMCS(RAMCS), 
		.ROMCS(ROMCS), 
		.Ready(Ready), 
		.RefReq(RefReq), 
		.RefUrgent(RefUrgent), 
		.RefAck(RefAck), 
		.RA(RA), 
		.nRAS(nRAS), 
		.nCAS(nCAS), 
		.nLWE(nLWE), 
		.nUWE(nUWE), 
		.nOE(nOE), 
		.nROMCS(nROMCS), 
		.nROMWE(nROMWE)
	);
	
	initial begin
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
		CLK = 0; #20; CLK = 1; #20; CLK = 0; #20; CLK = 1; #20;
	end

	initial begin
		nAS = 1;
		nLDS = 1;
		nUDS = 1;
		BACT = 0;
		#30;
		nAS = 0;
		nLDS = 0;
		nUDS = 0;
		BACT = 1;
		#20; #40; #40;
		nAS = 1;
		nLDS = 1;
		nUDS = 1;
		#20;
		BACT = 0;
		#40;
		
		nAS = 0;
		nLDS = 0;
		nUDS = 0;
		BACT = 1;
		#20; #40; #40;
		nAS = 1;
		nLDS = 1;
		nUDS = 1;
		#20;
		BACT = 0;
		#40;
		
		nAS = 0;
		BACT = 1;
		#40;
		nLDS = 0;
		nUDS = 0;
		#20; #40;
		nAS = 1;
		nLDS = 1;
		nUDS = 1;
		#20;
		BACT = 0;
		#40;
		
		nAS = 0;
		nLDS = 0;
		nUDS = 0;
		BACT = 1;
		#20; #40; #40;
		nAS = 1;
		nLDS = 1;
		nUDS = 1;
		#20;
		BACT = 0;
		#40;
		
		nAS = 0;
		BACT = 1;
		#40;
		nLDS = 0;
		nUDS = 0;
		#20; #40;
		nAS = 1;
		nLDS = 1;
		nUDS = 1;
		#20;
		BACT = 0;
		#40;
		
		nAS = 0;
		nLDS = 0;
		nUDS = 0;
		BACT = 1;
		#20; #40; #40;
		nAS = 1;
		nLDS = 1;
		nUDS = 1;
		#20;
		BACT = 0;
		#40;
		
		nAS = 0;
		nLDS = 0;
		nUDS = 0;
		BACT = 1;
		#20; #40; #40;
		nAS = 1;
		nLDS = 1;
		nUDS = 1;
		#20;
		BACT = 0;
		#40;
		
		#160;#160;#160;
		
		nAS = 0;
		nLDS = 0;
		nUDS = 0;
		BACT = 1;
		#20; #40; #40;
		nAS = 1;
		nLDS = 1;
		nUDS = 1;
		#20;
		BACT = 0;
		#40;
	end
	
	initial begin
		RefReq = 0;
		RefUrgent = 0;
		#10;
		#160; #160; #160;
		RefReq = 1;
		#160; #160; #160; #160;
		#120;
		RefReq = 0;
		#200; #120; #120; 
		RefUrgent = 1;
		#120;
		RefUrgent = 0;
		#200;
	end
	
	initial begin
		#10;
		A = 0;
		RAMCS = 0;
		ROMCS = 0;
		nWE = 0;
		#160;
		A = 24'h400000;
		RAMCS = 0;
		ROMCS = 1;
		nWE = 1;
		#160;
		A = 24'h400000>>1;
		RAMCS = 0;
		ROMCS = 1;
		nWE = 0;
		#160;	
		A = 24'h0A5A5A;
		RAMCS = 1;
		ROMCS = 0;
		nWE = 1;
		#160;
		A = 24'h0A5A5A;
		RAMCS = 1;
		ROMCS = 0;
		nWE = 0;
		#160;
		A = 24'h0A5A5A;
		RAMCS = 1;
		ROMCS = 0;
		nWE = 1;
		#160;
		A = 24'h400000;
		RAMCS = 0;
		ROMCS = 1;
		nWE = 1;
		#160;
		
		#160; #160; #160;
		A = 24'h0A5A5A;
		RAMCS = 1;
		ROMCS = 0;
		nWE = 1;
		#160;
	end
      
endmodule

