module lab4part2 (digits, HEX1, HEX0);
	input [4:0] digits;
	output [6:0] HEX1, HEX0;
	
	wire cout;
	wire [3:0] V, S;
	
	assign cout = digits[4];
	assign V = digits[3:0];
	
	comparator C0 (V, S);
		
	wire [3:0] A;
	circuitA CA (V, A);
	
	wire [3:0] M0;
	fourbit2to1 F0 (V, A, S[0], M0);

	wire [3:0] B;
	circuitB CB (M0, B);
	
	wire [3:0] M1;
	fourbit2to1 F1 (M0, B, cout, M1);
	
	deciOnHex D1 ({1'b0, 1'b0, 1'b0, (S[0] | cout)},HEX1);	
	deciOnHex D0 (M1,HEX0);
endmodule

module circuitB (M, B);
	input [3:0] M;
	output [3:0] B;
	
	assign B[3] = M[1];
	assign B[2] = ~M[1];
	assign B[1] = ~M[1];
	assign B[0] = M[0];
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