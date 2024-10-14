module SET(
	input CLK,
	input nPOR,
	input BACT,
	input [11:1] A,
	input SetCSWR,
	output SlowIACK,
	output SlowVIA,
	output SlowIWM,
	output SlowSCC,
	output SlowSCSI,
	output SlowSnd,
	output SlowClockGate,
	output [3:0] SlowInterval);
	
	//reg SetWRr; always @(posedge CLK) SetWRr <= BACT && SetCSWR;
	
	
	assign SlowInterval[3:0] = 4'hF;
	assign SlowIACK = 1;
	assign SlowVIA  = 1;
	assign SlowIWM  = 1;
	assign SlowSCC  = 1;
	assign SlowSCSI = 1;
	assign SlowSnd  = 1;
	assign SlowClockGate = 0;

	/*always @(posedge CLK) begin
		if (!nPOR) begin
			SlowInterval[3:0] <= 4'hF;
			SlowIACK <= 1;
			SlowVIA  <= 1;
			SlowIWM  <= 1;
			SlowSCC  <= 1;
			SlowSCSI <= 1;
			SlowSnd  <= 1;
			SlowClockGate <= 0;
		end else if (SetWRr) begin
			SlowInterval[3:0] <= A[11:8];
			SlowIACK <= A[7];
			SlowVIA  <= A[6];
			SlowIWM  <= A[5];
			SlowSCC  <= A[4];
			SlowSCSI <= A[3];
			SlowSnd  <= A[2];
			SlowClockGate <= A[1];
		end
	end*/

endmodule
