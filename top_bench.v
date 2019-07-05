 `timescale 1ns/1ps
 module top_bench();
 
 reg clk;
 reg RST;
 
MY32CPU_top t0(.CLK(clk),
					.RST(RST));
		 

initial begin
	clk <= 1'b0;
	RST =1'b0;
	#4 RST = 1'b1;
	#14 RST = 1'b0;
	#140 RST = 1'b1;
	#14 RST = 1'b0;
end

always #5 begin
	clk <= ~clk;
end

endmodule
