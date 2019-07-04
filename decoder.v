 module DECODER(
	input [31:0] INST,
	output [31:0] SrcA,SrcB,
	output [5:0] opcode,
	output [4:0] rs,
	output [4:0] rt,
	output [4:0] des,
	output [5:0] funct
 );
 
    assign opcode = INST[31:26];
	 assign rs = INST[25:21];
	 assign funct = INST[5:0];
	
	 reg [4:0] rt;
	 reg [4:0] rd;
	 reg [4:0] des;
	 reg ALUSrc;
	
	 wire [31:0] out;
	 wire flag;
	
	 always @(*)begin
		 SrcA = ina;
		
		 if(INST[31:26]==0)begin //if math inst
			 rt = INST[20:16];
			 rd = INST[15:11];
			 des = rd; //written register(destination)
			 ALUSrc = 0;
			 SrcB = inb;
		 end
		 else begin //if immediate inst
			 rt = INST[20:16];//same
			 des=rt;//written register(destination)
			 ALUSrc = 1;
			 SrcB = INST[5:0];
		 end
	 end
	
endmodule
