module lab6part2 (SW, KEY, LEDR);
	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] LEDR;
	
	wire resetn, w, clock, z;
	wire [3:0] state;
		
	assign resetn = SW[0];
	assign w = SW[1];
	assign clock = KEY[0];
	FSM f (w, clock, resetn, z, state);
	assign LEDR[9] = z;
	assign LEDR [3:0] = state;
	
endmodule