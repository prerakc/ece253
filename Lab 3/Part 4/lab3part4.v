/*
Author: Prerak Chaudhari
Student Number: 1005114760

Date: September 26th, 2019
*/

module lab3part4(SW, HEX0);
	input [9:0] SW;
	output [6:0] HEX0;
	
	wire [1:0] c;
	
	assign c = SW[1:0];
	
	assign HEX0[0] = c[1] & c[0];
	assign HEX0[1] = c[0];
	assign HEX0[2] = c[1] ~^ c[0];
	assign HEX0[3] = c[1] & c[0];
	assign HEX0[4] = c[1] | c[0];
	assign HEX0[5] = c[1] | ~c[0];
	assign HEX0[6] = c[1] & c[0];
endmodule