module singleCycleTop (
	input clk
);

	reg [31:0] PC = 0;
	wire [31:0] ImmExt;
	wire [31:0] PCSrc;
	wire [31:0]	PCTarget = PC + ImmExt; 
	wire [31:0]	PCPlus4 = PC + 'd4;
	wire [31:0]	Instr;
	wire [31:0] PCNext = PCPlus4;//PCSrc? PCTarget:PCPlus4;
	wire [31:0] result, SrcA, RD2;
	wire RegWrite;
	wire ALUSrc;
	wire [31:0] SrcB = ALUSrc? ImmExt:RD2;
	wire [1:0] ImmSrc;
	wire [2:0] ALUControl;
	wire [31:0] ALUResult;
	wire Zero;
	wire ResultSrc, MemWrite;
	wire [31:0] ReadData;
	
	always @(posedge clk)
	begin
		PC <= PCNext;
	end
	
	instruction_memory IM(
		.clk(clk),
		.A(PC),
		.RD(Instr)
	);
	
	control_unit CU(
		.clk(clk),
		.funct7_5(Instr[30]),
		.Zero(Zero),
		.op(Instr[6:0]),
		.funct3(Instr[14:12]),
		.PCSrc(PCSrc),
		.MemWrite(MemWrite),
		.ALUSrc(ALUSrc),
		.RegWrite(RegWrite),
		.ALUControl(ALUControl),
		.ResultSrc(ResultSrc),
		.ImmSrc(ImmSrc)
	);
	
	extend EXT(
		.extend_in(Instr[31:7]),
		.immSrc(ImmSrc),
		.immExt(ImmExt)
	);
	
	register_file RF(
		.clk(clk),
		.WE3(RegWrite),
		.A1(Instr[19:15]),
		.A2(Instr[24:20]),
		.A3(Instr[11:7]),
		.WD3(result),
		.RD1(SrcA),
		.RD2(RD2)
	);
	
	ALU ALUM(
		.srcA(SrcA),
		.srcB(SrcB),
		.alu_control(ALUControl),
		.alu_result(ALUResult),
		.zero(Zero)
	);
	
	data_memory DM (
		.clk(clk),
		.WE(MemWrite),
		.A(ALUResult),
		.WD(RD2),
		.RD(ReadData)
	);
	assign result = ResultSrc? ReadData:ALUResult;

endmodule