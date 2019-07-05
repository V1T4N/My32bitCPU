 module RAM(
	input CLK,
	input RST,
	input [5:0] ADDR,
	input [31:0] data_in,
	input WE0,
	output [31:0] ReadData,
	output [9:0]M0
	);

	reg[31:0] m[31:0]; //32word mem
	assign ReadData = m[ADDR];
	
	assign M0 = m[6'b0][9:0];
	
	integer i;
	always @(posedge CLK) begin
		if(WE0) m[ADDR] <= data_in;
		if(RST)begin
			for(i=0;i<32;i=i+1)
				m[i]=0;
		end
	end
	
endmodule
