module main_decoder( //408
	input 				clk,

	input [6:0] 		op,

	output reg			branch,
							//jump,
							mem_write,
							alu_src,
							reg_write,
						
	output reg [1:0]	result_src,
							imm_src,
							alu_op
);

	always @(*)//posedge clk)
	begin
		case(op)
			3:
			begin
				reg_write = 1;
				imm_src = 2'b00;
				alu_src = 1;
				mem_write = 0;
				result_src = 2'b01;
				branch = 0;
				alu_op = 2'b00;
				//jump = 0;
			end
			
			35:
			begin
				reg_write = 0;
				imm_src = 2'b01;
				alu_src = 1;
				mem_write = 1;
				result_src = 2'bxx;
				branch = 0;
				alu_op = 2'b00;
				//jump = 0;
			end
			
			51:
			begin
				reg_write = 1;
				imm_src = 2'bxx;
				alu_src = 0;
				mem_write = 0;
				result_src = 2'b00;
				branch = 0;
				alu_op = 2'b10;
				//jump = 0;
			end
			
			99:
			begin
				reg_write = 0;
				imm_src = 2'b10;
				alu_src = 0;
				mem_write = 0;
				result_src = 2'bxx;
				branch = 1;
				alu_op = 2'b01;
				//jump = 0;
			end
			
			111:
			begin
				reg_write = 1;
				imm_src = 2'b11;
				alu_src = 1'bx;
				mem_write = 0;
				result_src = 2'b10;
				branch = 0;
				alu_op = 2'bxx;
				//jump = 1;
			end
			
			default:
			begin
				reg_write = 0;
				imm_src = 2'b00;
				alu_src = 0;
				mem_write = 0;
				result_src = 2'b00;
				branch = 0;
				alu_op = 2'b00;
				//jump = 0;
			end
		
		endcase
		
	end

endmodule 