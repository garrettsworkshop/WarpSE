`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:24:23 12/07/2021
// Design Name:   FSB
// Module Name:   C:/Users/zanek/Documents/GitHub/Warp-SE/cpld/XC95144XL/test/t_fsb.v
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

module t_fsb;

	// Inputs
	reg FCLK;
	reg nAS;
	reg Ready0;
	reg Ready1;
	reg Ready2;
	reg BERR0;
	reg BERR1;
	reg IACS;

	// Outputs
	wire nDTACK;
	wire nVPA;
	wire nBERR;
	wire BACT;

	// Instantiate the Unit Under Test (UUT)
	FSB uut (
		.FCLK(FCLK), 
		.nAS(nAS), 
		.nDTACK(nDTACK), 
		.nVPA(nVPA), 
		.nBERR(nBERR), 
		.BACT(BACT), 
		.Ready0(Ready0), 
		.Ready1(Ready1), 
		.Ready2(Ready2), 
		.BERR0(BERR0), 
		.BERR1(BERR1), 
		.IACS(IACS)
	);

	initial begin
		// Initial conditions
		nAS = 1;
		FCLK = 0;
		Ready0 = 0;
		Ready1 = 0;
		Ready2 = 0;
		BERR0 = 0;
		BERR1 = 0;
		IACS = 0;
	
		FCLK = 0; #20;
		FCLK = 1; #20;
		FCLK = 0; #20;
		
		
		/* Regular 4-clock access */
		FCLK = 1; #5;
		nAS = 0;
		IACS = 0;
		Ready0 = 1;
		Ready1 = 1;
		Ready2 = 1;
		#15;
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #5;
		nAS = 1;
		#15;
	
		FCLK = 1; #20;
		FCLK = 0; #20;
		
		
		/* Units not immediately ready */
		FCLK = 1; #5;
		nAS = 0;
		IACS = 0;
		Ready0 = 0;
		Ready1 = 0;
		Ready2 = 0;
		#15;
		
		FCLK = 0; #20;
		FCLK = 1; #5;
		Ready0 = 1;
		Ready1 = 0;
		Ready2 = 0;
		#15;
		
		FCLK = 0; #20;
		FCLK = 1; #5;
		Ready0 = 0;
		Ready1 = 1;
		Ready2 = 0;
		#15;
		
		FCLK = 0; #20;
		FCLK = 1; #5;
		Ready0 = 0;
		Ready1 = 0;
		Ready2 = 1;
		#15;
		
		FCLK = 0; #20;
		FCLK = 1; #5;
		Ready0 = 0;
		Ready1 = 0;
		Ready2 = 0;
		#15;
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #5;
		nAS = 1;
		#15;
	
		FCLK = 1; #20;
		FCLK = 0; #20;
		
		/* Access terminated with /VPA */
		FCLK = 1; #5;
		nAS = 0;
		IACS = 1;
		Ready0 = 1;
		Ready1 = 1;
		Ready2 = 1;
		#15;
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		FCLK = 0; #20;
		FCLK = 1; #20;
		FCLK = 0; #20;
		FCLK = 1; #20;
		FCLK = 0; #20;
		FCLK = 1; #20;
		FCLK = 0; #20;
		FCLK = 1; #20;
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #5;
		nAS = 1;
		#15;
	
		FCLK = 1; #20;
		FCLK = 0; #20;
		
	end
      
endmodule

