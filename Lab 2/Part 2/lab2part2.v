/*
Author: Prerak Chaudhari
Student Number: 1005114760

Date: September 26th, 2019
*/

module lab2part2(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	wire s;
	wire [3:0] X;
	wire [3:0] Y;
	wire [3:0] M;
	
	assign s = SW[9];
	assign X = SW[3:0];
	assign Y = SW[7:4];
	mux2to1 u1 (X[0], Y[0], s, M[0]);
	mux2to1 u2 (X[1], Y[1], s, M[1]);
	mux2to1 u3 (X[2], Y[2], s, M[2]);
	mux2to1 u4 (X[3], Y[3], s, M[3]);
	assign LEDR[9] = s;
	assign LEDR[3:0] = M;
endmodule

module mux2to1(x, y, s, m);
	input x;
	input y;
	input s;
	output m;
	
	assign m = (~s & x) | (s & y);
endmodule