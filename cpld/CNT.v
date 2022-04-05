module CNT(
	/* FSB clock and AS detection */
	input FCLK, input CACT,
	/* Timeout signals */
	output reg TimeoutA, output reg TimeoutB);
	
	/* Refresh counter */
	reg [7:0] RefCnt = 0;
	always @(posedge FCLK) begin
		RefCnt <= RefCnt+1;
	end

	/* Timeout signals */
	reg TimeoutBPre;
	always @(posedge FCLK) begin
		if (~CACT) begin
			TimeoutA <= 0;
			TimeoutBPre <= 0;
			TimeoutB <= 0;
		end else begin
			if (RefCnt[6:0]==0) TimeoutA <= 1;
			if (RefCnt==0) TimeoutBPre <= 1;
			if (RefCnt==0 && TimeoutBPre) TimeoutB <= 1;
		end
	end

endmodule
