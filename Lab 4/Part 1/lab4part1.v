module lab4part1(SW, HEX0, HEX1);
	input[7:0]SW;
	output[6:0]HEX0,HEX1;
	
	deciOnHex U1(SW[3:0],HEX0);
	deciOnHex U2(SW[7:4],HEX1);
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