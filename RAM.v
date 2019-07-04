 module RAM(
	input CLK,
	input [5:0] ADDR,
	input [31:0] data_in,
	input WE0,
	output [31:0] ReadData
	);

	reg[31:0] m[31:0]; //32word mem
	assign ReadData = m[ADDR];
	
	always @(posedge CLK) if(WE0) m[ADDR] <= data_in;
	
endmodule
