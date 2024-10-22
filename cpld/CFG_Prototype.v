module CFG(
	input [23:20] A,
	inout GA23,
	inout GA22,
	inout GA21,
	inout GA20,
	output SlowdownIOWriteGate,
	input [11:10] RA,
	input [19:18] BA,
	input RowA10,
	output RA11_BA19,
	output RA10,
	inout nBG_BA18,
	input DBG0_ROMWS,
	input DBG1_RAMWS,
	input DBG4_IOWS,
	output ROMWS,
	output RAMWS,
	output IOWS);
	
	assign GA23 = A_FSB[23];
	assign GA22 = A_FSB[22];
	assign GA21 = 1'bZ;
	assign GA20 = 1'bZ;





	assign SlowdownIOWriteGate = 0;

	output RA11_BA19 = RA[11];
	output RA10 = RA[10];
	assign nBG_BA18 = 1'bZ;

	assign ROMWS = 0;
	assign RAMWS = 0;
	assign IOWS = 0;

endmodule
