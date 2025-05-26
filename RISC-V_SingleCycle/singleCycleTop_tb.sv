`timescale 1ns/100ps

module singleCycleTop_tb();

	reg clk;
	
	singleCycleTop DUT(
		.clk(clk)
	);
	
	always #1 clk = ~clk;
	
	always @(posedge clk) begin
    $display("PC = %h, Instr = %h", DUT.PC, DUT.Instr);
end

	
	initial begin
		clk=0;
		#500;
		$stop;
		$finish;
	end
	
endmodule