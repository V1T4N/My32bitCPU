 module ALU(
	input [1:0] ALUOp,
	input [31:0] SrcA,
	input [31:0] SrcB,	
	output [31:0] ALUout,
	output flag
 );
 
   reg [32:0] tout;
	
	always @(*)begin //alu exe
		case(ALUOp)
			2'b00: tout = SrcA + SrcB;
			2'b01: tout = SrcA - SrcB;
			2'b10: tout = SrcA & SrcB;
			2'b11: tout = SrcA | SrcB;
		endcase
	end
	
	
    assign flag = tout[32]; //Overflow Flag
    assign ALUout = tout[31:0];  
	
endmodule
