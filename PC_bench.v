`timescale 1ns/1ps
 module PC_bench();
 
 reg clk;
 reg RST;
 wire[31:0] INST;
 
 PC t0(.CLK(clk),
		 .RST(RST),
		 .INST(INST));
		 

initial begin
	clk <= 1'b0;
	RST =1'b0;
	#4 RST = 1'b1;
	#2 RST = 1'b0;
end

always #5 begin
	clk <= ~clk;
end

endmodule
