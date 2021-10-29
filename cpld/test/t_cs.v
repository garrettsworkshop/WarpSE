`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   07:17:58 10/23/2021
// Design Name:   CS
// Module Name:   C:/Users/zanek/Documents/GitHub/SE-030/cpld/test/t_cs.v
// Project Name:  MXSE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CS
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_cs;

	// Inputs
	reg [23:8] A;
	reg CLK;
	reg nRES;
	reg nWE;
	reg CACT;

	// Outputs
	wire IOCS;
	wire IACS;
	wire ROMCS;
	wire RAMCS;
	wire SndRAMCSWR;

	// Instantiate the Unit Under Test (UUT)
	CS uut (
		.A(A), 
		.CLK(CLK), 
		.nRES(nRES), 
		.nWE(nWE), 
		.CACT(CACT), 
		.IOCS(IOCS), 
		.IACS(IACS), 
		.ROMCS(ROMCS), 
		.RAMCS(RAMCS), 
		.SndRAMCSWR(SndRAMCSWR)
	);

	initial begin
		A = 0;
		CLK = 0;
		nRES = 0;
		nWE = 0;
		CACT = 0;
		#0;
		
		CLK = 0; #25;
		CLK = 1; #5;
		nRES = 1; #20;
		
		CLK = 0; #25;
		CLK = 1; #25;
		
		A = 16'h0000; #50;
		A = 16'h5000; #50;
		A = 16'h6000; #50;
		A = 16'h7F00; #50;
		A = 16'h7FA1; #50;
		A = 16'h7FA2; #50;
		A = 16'h4000; #50;
		
		CLK = 0; #25;
		CLK = 1; #5;
		CACT = 1; #20;
		
		CLK = 0; #25;
		CLK = 1; #5;
		CACT = 0; #20;
		
		CLK = 0; #25;
		CLK = 1; #25;
		
		A = 16'h0000; #50;
		A = 16'h5000; #50;
		A = 16'h6000; #50;
		A = 16'h0000; #50;
		A = 16'h3FA1; #50;
		A = 16'h3FA2; #50;
		A = 16'h4000; #50;
		
	end
      
endmodule

