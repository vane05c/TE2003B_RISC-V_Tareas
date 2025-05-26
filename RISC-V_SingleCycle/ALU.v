module ALU ( //32, gen25
	input [31:0] srcA, srcB,
	input [2:0] alu_control,
	
	output reg [31:0] alu_result,
	output reg zero
);

	always @(*)
		begin
		case (alu_control)
			3'b000: alu_result = srcA + srcB;
			
			3'b001: alu_result = srcA - srcB;
			
			3'b101:
				begin
				if (srcA < srcB)
					alu_result = srcA;
				else
					alu_result = 0;//alu_result;
				end
				
			3'b011: alu_result = srcA | srcB;
			
			3'b010: alu_result = srcA & srcB;
			
			3'b110: alu_result = srcA * srcB;
			
			default: alu_result = 0;//alu_result;
			
		endcase
		
		if (alu_result==0)
			zero=1;
		else
			zero=0;
		end

endmodule