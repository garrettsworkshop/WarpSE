`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   04:40:18 10/23/2021
// Design Name:   RAM
// Module Name:   C:/Users/zanek/Documents/GitHub/SE-030/cpld/XC95144XL/test.v
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

module test;

	// Inputs
	reg CLK;
	reg [21:1] A;
	reg nWE;
	reg nAS;
	reg nLDS;
	reg nUDS;
	reg CACT;
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
		.CACT(CACT), 
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
		CLK = 0;
		RAMCS = 0;	ROMCS = 0; CACT = 0;
		RefReq = 0;	RefUrgent = 0;
		nAS = 1;	nLDS = 1;	nUDS = 1;	nWE = 1;
		A = 0;
		#100;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; 
		A = 8195; #5; ROMCS = 1;
		CLK = 1; #5; #5; #5; #5;
		nAS = 0; nLDS = 0; nUDS = 0; nWE = 1; #5; CACT = 1;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; RefUrgent = 1; #5; #5; #5; #5;
		
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; RefUrgent = 0; #5; #5; #5; #5;
		
		CLK = 0; #5; CACT = 0; #5; #5; #5;
		nAS = 1; nLDS = 1; nUDS = 1; nWE = 1; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5;  A = 0; #5; ROMCS = 0;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	
		CLK = 0; #5; #5; #5; #5; #5;
		CLK = 1; #5; #5; #5; #5; #5;
	end
      
endmodule

