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
	
	assign GA23 = 1'bZ;
	wire GA22Gate = 
		(A[23:20]==4'h6) ||
		(A[23:20]==4'h7 &&  A[19:16]!=4'hF) ||
		(A[23:20]==4'h5 && !A[19]);
	assign GA22 = GA22Gate ? 1'b0 : A[23];
	assign GA21 = 1'bZ;
	assign GA20 = 1'bZ;

	assign SlowdownIOWriteGate = 1;

	output RA11_BA19 = BA[19];
	output RA10 = RowA10;
	assign nBG_BA18 = BA[18];

	assign ROMWS = DBG0_ROMWS;
	assign RAMWS = DBG1_RAMWS;
	assign IOWS = DBG4_IOWS;

endmodule
