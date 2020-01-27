module lab4part3 (a, b, s, cin, cout);
	input [3:0] a, b;
	input cin;
	output [3:0] s;
	output cout;
	
	wire c1,c2,c3;
	
	FA U0 (a[0], b[0], cin, s[0], c1);
	FA U1 (a[1], b[1], c1, s[1], c2);
	FA U2 (a[2], b[2], c2, s[2], c3);
	FA U3 (a[3], b[3], c3, s[3], cout);
endmodule

module FA (a, b, cin, s, cout);
	input a;
	input b;
	input cin;
	output s;
	output cout;
	
	assign s = a ^ b ^ cin;
	assign cout = (a & b) | (cin & a) | (cin & b);
endmodule