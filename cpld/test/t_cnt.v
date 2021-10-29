`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   07:44:31 10/23/2021
// Design Name:   CNT
// Module Name:   C:/Users/zanek/Documents/GitHub/SE-030/cpld/test/t_cnt.v
// Project Name:  MXSE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CNT
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_cnt;

	// Inputs
	reg FCLK;
	reg CACT;
	reg RefAck;

	// Outputs
	wire RefReq;
	wire RefUrgent;
	wire TimeoutA;
	wire TimeoutB;

	// Instantiate the Unit Under Test (UUT)
	CNT uut (
		.FCLK(FCLK), 
		.CACT(CACT), 
		.RefReq(RefReq), 
		.RefUrgent(RefUrgent), 
		.RefAck(RefAck), 
		.TimeoutA(TimeoutA), 
		.TimeoutB(TimeoutB)
	);

	initial begin
		FCLK = 0;
		CACT = 0;
		RefAck = 0;
		
		FCLK = 0; #20;
		FCLK = 1; #20; CACT = 1;
		
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
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #20;
		FCLK = 1; #20; CACT = 0;
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #20;
		FCLK = 1; #20; CACT = 1;
		
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
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #20;
		FCLK = 1; #20; RefAck = 1;
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #20;
		FCLK = 1; #20; RefAck = 0;
		
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
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #20;
		FCLK = 1; #20; RefAck = 1;
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #20;
		FCLK = 1; #20; RefAck = 0;
		
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
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
		FCLK = 0; #20;
		FCLK = 1; #20;
		
	end
      
endmodule

