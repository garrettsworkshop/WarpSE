`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:38:49 10/23/2021
// Design Name:   FSB
// Module Name:   C:/Users/zanek/Documents/GitHub/SE-030/cpld/XC95144XL/test_fsb.v
// Project Name:  MXSE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FSB
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_fsb;

	// Inputs
	reg FCLK;
	reg nAS;
	reg Ready;
	reg IACS;

	// Outputs
	wire nDTACK;
	wire nVPA;
	wire AINACT;
	wire BACT;
	wire CACT;

	// Instantiate the Unit Under Test (UUT)
	FSB uut (
		.FCLK(FCLK), 
		.nAS(nAS), 
		.nDTACK(nDTACK), 
		.nVPA(nVPA), 
		.AINACT(AINACT), 
		.BACT(BACT), 
		.CACT(CACT), 
		.Ready(Ready), 
		.IACS(IACS)
	);

	initial begin
		FCLK = 0;
		nAS = 1;
		Ready = 1;
		IACS = 0;
		#0;
		
		FCLK = 0; #25;
		FCLK = 1; #5;
		nAS = 1'bX; #20;
		nAS = 0;

		FCLK = 0; #25;
		FCLK = 1; #25;
		
		FCLK = 0; #25;
		FCLK = 1; #25;

		FCLK = 0; #5;
		nAS = 1'bX; #20;
		nAS = 1;
		FCLK = 1; #25;
		
		FCLK = 0; #25;
		FCLK = 1; #5;
		nAS = 1'bX; #20;
		nAS = 0;

		FCLK = 0; #25;
		FCLK = 1; #25;
		
		FCLK = 0; #25;
		FCLK = 1; #25;

		FCLK = 0; #5;
		nAS = 1'bX; #20;
		nAS = 1;
		FCLK = 1; #25;
		
		FCLK = 0; #25;
		FCLK = 1; #5;
		Ready = 0; nAS = 1'bX; #20;
		nAS = 0;

		FCLK = 0; #25;
		FCLK = 1; #25;

		FCLK = 0; #25;
		FCLK = 1; #5;
		Ready = 1; #20;
		
		FCLK = 0; #25;
		FCLK = 1; #25;

		FCLK = 0; #25;
		FCLK = 1; #25;

		FCLK = 0; #5;
		nAS = 1'bX; #20;
		nAS = 1;
		FCLK = 1; #25;

		FCLK = 0; #25;
		FCLK = 1; #25;

		FCLK = 0; #25;
		FCLK = 1; #25;
	
	end
      
endmodule

