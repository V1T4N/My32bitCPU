 module PC(
	input CLK,
	input RST,
	output[31:0] INST, //instruction code
	input BranchTrue,
	input [31:0] SrcB
);

	wire [31:0] data_in = 32'b0; //initialize
	wire [31:0] data_out;
	wire [4:0] addr;
	wire write = 1'b0; //dont use now
	
	assign INST = data_out; //output instruction code
	
	
	COUNTER5b COUNTER(.CLK(CLK),
							.RST(RST),
							.addr(addr),
							.BranchTrue(BranchTrue),
							.SrcB(SrcB)
							);
	
	CPU_REG PMEM(.addr(addr),.data_in(data_in),.data_out(data_out),.CLK(CLK),.write(write));
	
	
	
endmodule





module CPU_REG(
		input [4:0] addr,//registar address
		input [31:0] data_in,
		output[31:0] data_out,
		
		input CLK,
		input write);
		
		reg[31:0] PROGRAM[31:0]; //32bit * 32 ROM
		
		initial $readmemb("C:/intelFPGA_lite/My_CPU/PROGRAM.bin", PROGRAM);
		
		assign data_out = PROGRAM[addr]; //output instruction
		
		always @(posedge CLK) if(write) PROGRAM[addr] <= data_in; //write instruction
		
endmodule

module COUNTER5b(
	input CLK,
	input RST,
	output [4:0] addr,
	input BranchTrue,
	input [31:0] SrcB
);

	reg[4:0] count;
	
	
	always @(posedge CLK) begin
		if(RST == 1 ) begin
			count <= 5'b0;
		end
		else if(BranchTrue == 1) begin
			count <= count + SrcB[4:0];
		end
		else begin
			count <= count + 5'b1;
		end
	
	end
	assign addr = count;
	
endmodule

	