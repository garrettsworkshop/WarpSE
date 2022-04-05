module CLK(
	input CLK, output reg [2:0] SS,
	output reg MCLK, output RCLK);

	always @(posedge CLK) begin
		SS[1:0] <= SS[1:0]+1;
	end

	always @(posedge CLK) begin
		MCLK <= SS[1:0]==2'b01 || SS[1:0]==2'b10;
	end

endmodule
