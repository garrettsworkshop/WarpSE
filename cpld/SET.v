module SET(
	input CLK,
	input nPOR,
	input BACT,
	input [11:1] A,
	input SetCSWR,
	output reg SlowIACK,
	output reg SlowVIA,
	output reg SlowIWM,
	output reg SlowSCC,
	output reg SlowSCSI,
	output reg SlowSnd,
	output reg SlowClockGate,
	output reg [3:0] SlowTimeout);
	
	reg SetWRr; always @(posedge CLK) SetWRr <= BACT && SetCSWR;

	always @(posedge CLK) begin
		if (!nPOR) begin
			SlowTimeout[3:0] <= 4'hF;
			SlowIACK <= 0;
			SlowVIA  <= 1;
			SlowIWM  <= 1;
			SlowSCC  <= 1;
			SlowSCSI <= 1;
			SlowSnd  <= 1;
			SlowClockGate <= 0;
		end else if (SetWRr) begin
			SlowTimeout[3:0] <= A[11:8];
			SlowIACK <= A[7];
			SlowVIA  <= A[6];
			SlowIWM  <= A[5];
			SlowSCC  <= A[4];
			SlowSCSI <= A[3];
			SlowSnd  <= A[2];
			SlowClockGate <= A[1];
		end
	end

endmodule
