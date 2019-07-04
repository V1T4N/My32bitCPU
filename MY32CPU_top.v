//https://www.mtl.t.u-tokyo.ac.jp/~jikken/cpu/wiki/ISA%20%E3%81%AE%E4%BB%95%E6%A7%98/
module MY32CPU_top(
	input CLK,
	input RST

);

	reg write = 1; //now,writeonly cmd exist
   wire [31:0] RD0, RD1, ALUA, ALUB;
	reg [31:0] SrcA,SrcB;

	wire [31:0] INST;//decoder
	
	wire [5:0] opcode;
	wire [4:0] rs;
	wire [5:0] funct;
	
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
		
		if(INST[31:26]==0)begin //if math inst
			rt = INST[20:16];
			rd = INST[15:11];
			des = rd; //written register(destination)
			
			ALUSrc = 0;
			SrcB = RD1; //normal
		end
		else begin //if immediate inst
			rt = INST[20:16];//same
			des=rt;//written register(destination)
			
			ALUSrc = 1;
			SrcB = INST[5:0];//immediate value
		end
	end
	
	REGISTER REG(.REGNUM0(rs),
					 .REGNUM1(rt),
					 .REGNUM2(des),
					 .data_in(out),
					 .DOUT0(RD0), //ina:value of register rs
					 .DOUT1(RD1), //inb:value of register rt
					 .CLK(CLK),
					 .WE0(write));
	
	PC PC(.CLK(CLK),
		.RST(RST),
		.INST(INST));
		
	ALU ALU(.opcode(opcode),
			  .SrcA(SrcA),
			  .SrcB(SrcB),
			  .ALUSrc(ALUSrc),
			  .funct(funct),
			  .out(out),
			  .ALUA(ALUA),
			  .ALUB(ALUB),
			  .flag(flag));

	
	
	
endmodule
