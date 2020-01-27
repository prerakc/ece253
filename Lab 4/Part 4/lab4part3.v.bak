module lab4part3 (SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	wire [3:0] a,b,s;
	assign a = SW[7:4];
	assign b = SW[3:0];
	
	wire cin;
	assign cin = SW[8];
	
	wire cout;
	
	wire c1,c2,c3;
	
	FA U0 (a[0], b[0], cin, s[0], c1);
	FA U1 (a[1], b[1], c1, s[1], c2);
	FA U2 (a[2], b[2], c2, s[2], c3);
	FA U3 (a[3], b[3], c3, s[3], cout);
	
	assign LEDR[4:0] = {cout, s};
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