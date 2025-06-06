module control_unit (
	input clk, funct7_5, Zero,
	input [6:0] op,
	input [2:0] funct3,
	
	output PCSrc, MemWrite, ALUSrc, RegWrite, //Jump,
	output [2:0] ALUControl,
	output [1:0] ResultSrc, ImmSrc
);

	wire Branch;
	wire [1:0] ALUOp;
	
	main_decoder MD ( 
		.clk(clk),
		.op(op),
		.branch(Branch),
		//.jump(Jump),
		.mem_write(MemWrite),
		.alu_src(ALUSrc),
		.reg_write(RegWrite),
		.result_src(ResultSrc),
		.imm_src(ImmSrc),
		.alu_op(ALUOp)
	);
	
	alu_decoder AD (
		.clk(clk),
		.op_5(op[5]),
		.funct7_5(funct7_5),
		.funct3(funct3),
		.alu_op(ALUOp),
		.alu_control(ALUControl)
	);
	
	assign PCSrc = Branch & Zero ;//| Jump;

endmodule