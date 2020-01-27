module lab4part2 (SW, HEX0, HEX1);
	input [9:0] SW;
	output [6:0] HEX0, HEX1;
	
	wire [3:0] V;
	assign V = SW[3:0];
	
	wire [3:0] S;
	comparator C0 (V, S);
	
	wire [3:0] A;
	circuitA C1 (V, A);
	
	wire [3:0] M;
	fourbit2to1 M0 (V, A, S[0], M);
	
	deciOnHex D0 (M,HEX0);
	deciOnHex D1 (S,HEX1);
endmodule

module deciOnHex(in, out);
	input [3:0] in;
	output [6:0] out;
	
	wire c0,c1,c2,c3;
	
	assign c0=in[0];
	assign c1=in[1];
	assign c2=in[2];
	assign c3=in[3];
	assign out[0] = (~c3&~c2&~c1&c0)|(~c1&~c0&c2)|(c3&c2)|(c1&c3);
	assign out[1] = (~c1&c0&c2)|(c1&~c0&c2)|(c3&c2)|(c1&c3);
	assign out[2] = (c1&~c0&~c2)|(c3&c2)|(c1&c3);
	assign out[3] = (~c1&c0&~c2)|(~c1&~c0&c2)|(c3&c2)|(c1&c3)|(c1&c2&c0);
	assign out[4] = (c1|c0|c2)&(~c1|c0|c3);
	assign out[5] = (~c3&~c2&c0)|(c1&c3)|(~c3&~c2&c1)|(c1&c0)|(c3&c2);
	assign out[6] = (~c3&~c2&~c1)|(c1&c0&c2)|(c3&c2)|(c1&c3);
endmodule

module comparator (V, S);
	input [3:0] V;
	output [3:0] S;
	
	wire r;
	assign r = (V[3] & V[2]) | (V[3] & V[1]);
	
	assign S = {1'b0, 1'b0, 1'b0, r};
endmodule

module circuitA (V, A);
	input [3:0] V;
	output [3:0] A;
	
	assign A[3] = ~V[3];
	assign A[2] = V[3] & V[2] & V[1];
	assign A[1] = V[3] & V[2] & ~V[1];
	assign A[0] = (V[3] & V[2] & V[0]) | (V[3] & V[1] & V[0]);
endmodule

module fourbit2to1 (V, A, S, M);
	input [3:0] V, A;
	input S;
	output [3:0] M;
	
	mux2to1 u1 (V[0], A[0], S, M[0]);
	mux2to1 u2 (V[1], A[1], S, M[1]);
	mux2to1 u3 (V[2], A[2], S, M[2]);
	mux2to1 u4 (V[3], A[3], S, M[3]);
endmodule

module mux2to1(x, y, s, m);
	input x;
	input y;
	input s;
	output m;
	
	assign m = (~s & x) | (s & y);
endmodule