module extend (
	input [31:0] extend_in,
	input [1:0] immSrc,
	
	output reg [31:0] immExt
);

	reg [11:0] aux_extend;
	
	//
	reg [19:0] aux_extend20;
	//

	always @(*)
		begin
		case (immSrc)
			0: aux_extend = extend_in[31:20];
			
			1: aux_extend = {extend_in[31:25],extend_in[11:7]};
			
			2: aux_extend = {extend_in[31],extend_in[7],extend_in[30:25],extend_in[11:8]};
			
	//estos son mas bits que 12 (20)		3: aux_extend = {extend_in[31],extend_in[19:12],extend_in[20],extend_in[30:21]};
	
			//
			3: aux_extend20 = {extend_in[31],extend_in[19:12],extend_in[20],extend_in[30:21]};
			//
			
		endcase
		
		if (immSrc==3)
			immExt = {{12{aux_extend20[19]}},aux_extend20};
		else
			immExt = {{20{aux_extend[11]}},aux_extend};
		
		end

endmodule