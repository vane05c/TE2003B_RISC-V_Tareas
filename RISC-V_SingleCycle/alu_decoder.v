module alu_decoder ( //408
	input 		clk,
	
	input			op_5, funct7_5,
	input [2:0]	funct3,
	
	input [1:0]	alu_op,
	
	output reg [2:0] alu_control

);

always @(*)//posedge clk)
begin
	case(alu_op)
		0:
		begin
			alu_control = 3'b000;
		end
		1:
		begin
			alu_control = 3'b001;
		end
		2:
		begin
			case(funct3)
				0:
				begin
					if (funct3 == 3'b000) begin
						if (funct7_5)
							alu_control = 3'b001;
						else
						  alu_control = 3'b000;
					
					end

					/*if({op_5,funct7_5} == 2'b11)
						alu_control = 3'b000;
					else
						alu_control = 3'b001;*/
				end	
				2:
					alu_control = 3'b101;
				6:
					alu_control = 3'b011;
				7:
					alu_control = 3'b010;
				default:
					alu_control = 3'b000;
			endcase
		end
		
		default:
					alu_control = 3'b000;

	endcase
end


endmodule