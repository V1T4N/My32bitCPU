 module ALU(
	input [5:0] opcode,
	input [31:0] SrcA,
	input [31:0] SrcB,
	input ALUSrc, //use immediate value mux
	input [5:0] funct,	
	output [31:0] out,ALUA,ALUB,
	output flag
 );
 
   reg [32:0] tout;
    
   assign ALUA = SrcA;
   assign ALUB = SrcB;

	
	always @(*)begin //alu exe
		if(opcode ==6'd0)begin //if opcode is math instruction
			case(funct)
				6'd0:    tout = ALUA + ALUB;//add
				6'd2:    tout = ALUA - ALUB;//sub
				6'd10:   tout = ALUA ^ ALUB; //xor
				default: tout = ALUA + ALUB;
			endcase
		end
		
		else begin //if opcode is immediate instruction
			case(opcode)
				6'd1:tout = ALUA + ALUB; //addi
				6'd4:tout = ALUA ^ ALUB; //xori
				default:tout = ALUA + ALUB;
			endcase
		end
	end
	
	
    assign flag = tout[32]; //Overflow Flag
    assign out = tout[31:0];  
	
endmodule
