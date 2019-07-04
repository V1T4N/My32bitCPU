 module REGISTER(
	input CLK,
	input [4:0] REGNUM0,REGNUM1,REGNUM2, //register number 0,1: read, 2: write
	input [31:0] data_in,
	input WE0, //write enable
	output [31:0] DOUT0,DOUT1
	);
	
	reg[31:0] r[15:0]; //15word register
	
	assign DOUT0 = (REGNUM0==0) ? 0 : r[REGNUM0];
	assign DOUT1 = (REGNUM1==0) ? 0 : r[REGNUM1];
	
	always @(posedge CLK) if(WE0) r[REGNUM2] <= data_in;
	

endmodule
	