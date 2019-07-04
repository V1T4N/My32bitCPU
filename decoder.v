 module DECODER(
	input [31:0] INST,
	output [4:0] rs,
	output [4:0] rt,
	output [4:0] rd,
	output [1:0] ALUOp,
	output InstType,
	output RegWrite,
	output MemWrite,
	output MemRegWriteSelect
 );
 
	
	wire [31:0] opcode;
	wire [5:0]  funct;
 
 
	assign opcode = INST[31:26];
	assign rs = INST[25:21];
	assign funct = INST[5:0];
	assign rt = INST[20:16];
	assign rd = INST[15:11];
	
	
	reg [1:0]ALUOp_temp;
	assign ALUOp = ALUOp_temp;
	
	reg InstType_temp;
	assign InstType = InstType_temp;
	
	reg RegWrite_temp;
	assign RegWrite = RegWrite_temp;
	
	reg MemWrite_temp;
	assign MemWrite = MemWrite_temp;
	
	reg MemRegWriteSelect_temp;
	assign MemRegWriteSelect = MemRegWriteSelect_temp;
	
	always @(*)begin
		if(opcode == 6'b0)begin //R-type instruction
			
			InstType_temp = 0;
			
			case(funct)
				6'b100000 : begin ALUOp_temp = 2'b00;//ADD
									RegWrite_temp = 1;
									MemWrite_temp = 0;
									MemRegWriteSelect_temp = 0;
								end
								
				6'b101011 : begin ALUOp_temp = 2'b01;//SUB
									RegWrite_temp = 1;
									MemWrite_temp = 0;
									MemRegWriteSelect_temp = 0;
								end
								
				6'b100100 : begin ALUOp_temp = 2'b01;//AND
									RegWrite_temp = 1;
									MemWrite_temp = 0;
									MemRegWriteSelect_temp = 0;
								end
								
				6'b100101 : begin ALUOp_temp = 2'b11;//OR
									RegWrite_temp = 1;
									MemWrite_temp = 0;
									MemRegWriteSelect_temp = 0;
								end
								
				default   : begin ALUOp_temp = 2'b00;//ADD
									RegWrite_temp = 1;
									MemWrite_temp = 0;
									MemRegWriteSelect_temp = 0;
							   end
			endcase
			
		end
		
		else begin //I-type instruction
			InstType_temp = 1;
			
			case(opcode)
				6'b001000 : begin ALUOp_temp = 2'b00;//ADDI
									RegWrite_temp = 1;
									MemWrite_temp = 0;
									MemRegWriteSelect_temp = 0;
								end
								
				6'b101011 : begin ALUOp_temp = 2'b00;//SW Store Word
									RegWrite_temp = 0;
									MemWrite_temp = 1;
									MemRegWriteSelect_temp = 0;
								end
								
				6'b100011 : begin ALUOp_temp = 2'b00;//LW Load Word
									RegWrite_temp = 1;
									MemWrite_temp = 0;
									MemRegWriteSelect_temp = 1;
								end
								
				default :   begin ALUOp_temp = 2'b00;//ADD
									RegWrite_temp = 1;
									MemWrite_temp = 0;
									MemRegWriteSelect_temp = 0;
								end
			endcase
		end
	end
	
 
	
 
 
 endmodule
 
 
 
 
 
 
 
 
 
 
 
 
 
 /*
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
		SrcA = RD0; //always RD0
		
		if(INST[31:26]==0)begin //if R-type inst
			rt = INST[20:16];
			rd = INST[15:11];
			des = rd; //written register(destination)
			
			ALUSrc = 0;
			SrcB = RD1; //normal
		end
		else begin //if I-type inst
			rt = INST[20:16];//same
			des=rt;//written register(destination)
			
			ALUSrc = 1;
			SrcB = INST[5:0];//immediate value
		end
	end
/*
endmodule
	
	
	/*	DECODER DEC(.INST(INST),
					.SrcA(SrcA),
					.SrcB(SrcB),
					.opcode(opcode),
					.rs(rs),
					.rt(rt),
					.des(des),
					.funct(funct)
					.ALUSrc(ALUSrc));
	*/