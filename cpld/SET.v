module SET(
	input CLK,
	input nPOR,
	input BACT,
	input A1,
	input SetCSWR,
	output reg SetSndSlow);
	
	always @(posedge CLK) begin
		if (!nPOR) SetSndSlow <= 1;
		else if (BACT && SetCSWR) SetSndSlow <= A1;
	end

endmodule
