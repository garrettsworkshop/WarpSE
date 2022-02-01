`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   05:57:17 12/11/2021
// Design Name:   IOBM
// Module Name:   C:/Users/zanek/Documents/GitHub/Warp-SE/cpld/XC95144XL/test/t_iobm.v
// Project Name:  MXSE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: IOBM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_iobm;

	// Inputs
	reg C16M;
	reg C8M;
	reg E;
	reg nDTACK;
	reg nVPA;
	reg nBERR;
	reg nRES;
	reg IOREQ;
	reg IOLDS;
	reg IOUDS;
	reg IOWE;

	// Outputs
	wire nAS;
	wire nLDS;
	wire nUDS;
	wire nVMA;
	wire nAoutOE;
	wire nDoutOE;
	wire ALE0;
	wire nDinLE;
	wire IOACT;
	wire IOBERR;

	// Instantiate the Unit Under Test (UUT)
	IOBM uut (
		.C16M(C16M), 
		.C8M(C8M), 
		.E(E), 
		.nAS(nAS), 
		.nLDS(nLDS), 
		.nUDS(nUDS), 
		.nVMA(nVMA), 
		.nDTACK(nDTACK), 
		.nVPA(nVPA), 
		.nBERR(nBERR), 
		.nRES(nRES), 
		.nAoutOE(nAoutOE), 
		.nDoutOE(nDoutOE), 
		.ALE0(ALE0), 
		.nDinLE(nDinLE), 
		.IOACT(IOACT), 
		.IOBERR(IOBERR), 
		.IOREQ(IOREQ), 
		.IOLDS(IOLDS), 
		.IOUDS(IOUDS), 
		.IOWE(IOWE)
	);

	initial begin
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
		C16M = 0; #30; C16M = 1; #30;	C16M = 0; #30; C16M = 1; #30;
	end

	initial begin
		C8M = 0; #50; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
		C8M = 0; #60; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
		C8M = 0; #60; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
		C8M = 0; #60; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
		C8M = 0; #60; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
		C8M = 0; #60; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
		C8M = 0; #60; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
		C8M = 0; #60; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
		C8M = 0; #60; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
		C8M = 0; #60; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
		C8M = 0; #60; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
		C8M = 0; #60; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
		C8M = 0; #60; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
		C8M = 0; #60; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
		C8M = 0; #60; C8M = 1; #60; C8M = 0; #60; C8M = 1; #60;
	end

	initial begin
		E = 0; #130; E = 1; #480; E = 0; #720; E = 1; #480;
		E = 0; #720; E = 1; #480; E = 0; #720; E = 1; #480;
		E = 0; #720; E = 1; #480; E = 0; #720; E = 1; #480;
		E = 0; #720; E = 1; #480; E = 0; #720; E = 1; #480;
	end

	initial begin
		nRES = 1;
		nBERR = 1;
		nDTACK = 1;
		nVPA = 1;
		
		#320;
		nDTACK = 0;
		#300;
		nDTACK = 1;
		
		#180;
		nDTACK = 0;
		#300;
		nDTACK = 1;
		
		#180;
		nBERR = 0;
		#300;
		nBERR = 1;
		
		#180;
		nVPA = 0;
		#1200;
		nBERR = 1;
		
		#220;
		nRES = 0;
		#300;
		nRES = 1;
	end

	initial begin
		IOREQ = 0;
		IOLDS = 0;
		IOUDS = 0;
		IOWE = 0;
		#195;
		
		IOREQ = 1;
		IOWE = 0;
		#40;
		IOLDS = 1;
		IOUDS = 1;
		#200;
		IOREQ = 0;	
		#240;
		
		IOREQ = 1;
		IOWE = 1;
		#40;
		IOLDS = 1;
		IOUDS = 1;
		#200;
		IOREQ = 0;	
		#240;
		
		IOREQ = 1;
		IOWE = 0;
		#40;
		IOLDS = 1;
		IOUDS = 1;
		#200;
		IOREQ = 0;	
		#240;
		
		IOREQ = 1;
		IOWE = 0;
		#40;
		IOLDS = 1;
		IOUDS = 1;
		#200;
		IOREQ = 0;	
		#240;
		
		
		IOREQ = 1;
		IOWE = 0;
		#40;
		IOLDS = 1;
		IOUDS = 1;
		#1300;
		IOREQ = 0;	
		#240;
	end
      
endmodule

