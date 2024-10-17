module SET(
	input CLK,
	input nPOR,
	input BACT,
	input [7:1] A,
	input SetCSWR,
	output reg SetSCCFast,
	output reg SetVIASlow,
	output reg SetIWMSlow,
	output reg SetSndSlow,
	output reg SetClockGate,
	output reg SetSndClockGate,
	output reg SetSlow);
	
	reg SetWRr; always @(posedge CLK) SetWRr <= BACT && SetCSWR;

	always @(posedge CLK) begin
		if (!nPOR) begin
			SetSCCFast <= 1;
			SetVIASlow <= 1;
			SetIWMSlow <= 1;
			SetSndSlow <= 1;
			SetSndClockGate <= 1;
			SetClockGate <= 0;
			SetSlow <= 0;
		end else if (SetWRr) begin
			SetSCCFast <= A[7];
			SetVIASlow  <= A[6];
			SetIWMSlow  <= A[5];
			SetSndSlow  <= A[4];
			SetSndClockGate <= A[3];
			SetClockGate  <= A[2];
			SetSlow <= A[1];
		end
	end

endmodule
