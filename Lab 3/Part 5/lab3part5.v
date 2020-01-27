module lab3part5 (SW, LEDR, HEX0, HEX1, HEX2);
	input [9:0] SW; // slide switches
	output [9:0] LEDR; // red lights
	output [6:0] HEX0, HEX1, HEX2; // 7-seg display
	
	wire [1:0] M0;
	wire [1:0] M1;
	wire [1:0] M2;
	
	mux_2bit_3to1 U0 (SW[9:8], SW[1:0], SW[5:4], SW[3:2], M0);
	char_7seg H0 (M0, HEX0);
	
	mux_2bit_3to1 U1 (SW[9:8], SW[3:2], SW[1:0], SW[5:4], M1);
	char_7seg H1 (M1, HEX1);
	
	mux_2bit_3to1 U2 (SW[9:8], SW[5:4], SW[3:2], SW[1:0], M2);
	char_7seg H2 (M2, HEX2);

	assign LEDR = SW;
	
endmodule

// implements a 7-segment decoder for 2, 5, 3 and ‘blank’
module char_7seg (C, Display);
	input [1:0] C; // input code
	output [6:0] Display; // output 7-seg code
	
	assign Display[0] = C[1] & C[0];
	assign Display[1] = C[0];
	assign Display[2] = C[1] ~^ C[0];
	assign Display[3] = C[1] & C[0];
	assign Display[4] = C[1] | C[0];
	assign Display[5] = C[1] | ~C[0];
	assign Display[6] = C[1] & C[0];
endmodule

// implements a 2-bit wide 3-to-1 multiplexer
module mux_2bit_3to1(S, U, V, W, M);	
	input [1:0] S, U, V, W;
	output [1:0] M;
	
	mux3to1 u1 (U[0], V[0], W[0], S, M[0]);
	mux3to1 u2 (U[1], V[1], W[1], S, M[1]);
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