//https://www.mtl.t.u-tokyo.ac.jp/~jikken/cpu/wiki/ISA%20%E3%81%AE%E4%BB%95%E6%A7%98/
module MY32CPU_top(
	//output [9:0] LEDR,
	input CLK,
	//input [1:0]KEY,
	input RST

);
	wire[9:0]LEDR;

	/*wire cLK;
	assign cLK = KEY[0];
	
	wire rST;
	assign rST = KEY[1];
	*/
	wire [31:0] INST;
	wire [4:0] rs;
	wire [4:0] rt;
	wire [4:0] rd;
	
	reg [4:0] A0; //Register Input
	reg [4:0] A1;
	reg [4:0] A2;
	
	wire InstType;
	
	wire [1:0] ALUOp;
	wire signed [31:0] ALUout;
	wire [31:0] SrcA; //ALU input
	reg [31:0] SrcB;
	
	
	wire[31:0] RD0; //Register output
	wire[31:0] RD1;
	
	wire WriteEnable;
	wire MemWriteEnable;
	wire[31:0] ReadData;
	
	assign SrcA = RD0;
	
	wire MemRegWriteSelect; //write register from ALU or Memory
	reg [31:0]REG_DIN;
	
	wire BranchEnable;
	reg BranchTrue;
	
	always @(*)begin
		A0 = rs;
		if(InstType == 0)begin//R-type ALU INPUT SELECTOR
			A1 <= rt;
			A2 <= rd;
			SrcB <= RD1;
		end
		else begin //I-type
			A1 <= rt;
			A2 <= rt;
			SrcB <= INST[5:0]; //immediate value;
		end
		
		if(MemRegWriteSelect == 0)begin
			REG_DIN <= ALUout;
		end
		else begin
			REG_DIN <= ReadData;
		end
	
		if(BranchEnable)begin //Branch BGTZ only
			if(SrcA >0)begin
				BranchTrue <= 1;
			end
			else begin
				BranchTrue <= 0;
			end
		end
		else begin
			BranchTrue <= 0;
		end
		
	end
	
	

	DECODER DEC(.INST(INST),
					.rs(rs),
					.rt(rt),
					.rd(rd),
					.ALUOp(ALUOp),
					.InstType(InstType),
					.RegWrite(WriteEnable),
					.MemWrite(MemWriteEnable),
					.MemRegWriteSelect(MemRegWriteSelect),
					.BranchEnable(BranchEnable)
					);
	
	REGISTER REG(.REGNUM0(A0),
					 .REGNUM1(A1),
					 .REGNUM2(A2),
					 .data_in(REG_DIN),
					 .DOUT0(RD0), //ina:value of register rs
					 .DOUT1(RD1), //inb:value of register rt
					 .CLK(~CLK),
					 .RST(RST),
					 .WE0(WriteEnable)
					 );
	
	
	PC PC(.CLK(CLK), ////////
			.RST(RST),
			.INST(INST),
			.BranchTrue(BranchTrue),
			.SrcB(SrcB)
			);
		
	ALU ALU(.ALUOp(ALUOp),
			  .SrcA(SrcA),
			  .SrcB(SrcB),
			  .ALUout(ALUout),
			  .flag(flag));
			  
	RAM RAM(.CLK(~CLK),
			  .RST(RST),
			  .ADDR(ALUout[5:0]),
			  .data_in(RD1),
			  .WE0(MemWriteEnable),
			  .ReadData(ReadData),
			  .M0(LEDR)
			  );

	
	
	
endmodule
