/*
Author: Prerak Chaudhari
Student Number: 1005114760

Date: September 26th, 2019
*/

module lab2part3(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	wire [1:0] s;
	wire [1:0] U;
	wire [1:0] V;
	wire [1:0] W;
	wire [1:0] M;
	
	assign s = SW[9:8];
	assign U = SW[5:4];
	assign V = SW[3:2];
	assign W = SW[1:0];
	mux3to1 u1 (U[0], V[0], W[0], s, M[0]);
	mux3to1 u2 (U[1], V[1], W[1], s, M[1]);

	assign LEDR[1:0] = M;
endmodule

module mux3to1(u, v, w, s, m);
	input u;
	input v;
	input w;
	input [1:0] s;
	output m;
	
	wire c;
	
	mux2to1 u1 (u, v, s[0], c);
	mux2to1 u2 (c, w, s[1], m);
endmodule

module mux2to1(x, y, s, m);
	input x;
	input y;
	input s;
	output m;
	
	assign m = (~s & x) | (s & y);
endmodule