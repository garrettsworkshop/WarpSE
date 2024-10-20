module CFG(
	input [23:20] A,
	inout GA23,
	inout GA22,
	inout GA21,
	inout GA20,
	output SlowdownIOWriteGate,
	input DBG0_ROMWS,
	input DBG1_RAMWS,
	input DBG4_IOWS,
	output ROMWS,
	output RAMWS,
	output IOWS);
	
	assign GA23 = 1'bZ;
	wire GA23Gate = 
		(A[23:20]==4'h6) ||
		(A[23:20]==4'h7 &&  A[19:16]!=4'hF) ||
		(A[23:20]==4'h5 && !A[19]);
	assign GA22 = ) ? 1'b0 : A[23];
	assign GA21 = 1'bZ;
	assign GA20 = 1'bZ;

	assign SlowdownIOWriteGate = 1;

	assign ROMWS = DBG0_ROMWS;
	assign RAMWS = DBG1_RAMWS;
	assign IOWS = DBG4_IOWS;

endmodule
