module lab6part1b (SW, KEY, LEDR);
	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] LEDR;
	
	wire resetn, w, clock, z;
	wire [8:0] state;
		
	assign resetn = SW[0];
	assign w = SW[1];
	assign clock = KEY[0];
	FSM f (w, clock, resetn, z, state);
	assign LEDR[9] = z;
	assign LEDR [8:0] = state;
	
endmodule