module lab4part4 (SW, HEX0, HEX1, HEX4, HEX5, LEDR);
	input [9:0] SW;
	output [6:0] HEX0, HEX1, HEX4, HEX5;
	output [9:0] LEDR;
	
	wire [3:0] X, Y, S;
	assign X = SW[7:4];
	assign Y = SW[3:0];
	
	wire cin, cout;
	assign cin = SW[8];
	
	wire [4:0] sum;
	wire err_led;
	
	lab4part3 BCD (X, Y, S, cin, cout);
	
	assign sum = {cout, S};
		
	lab4part2 DIS (sum, HEX1, HEX0);
	
	deciOnHex DX (X,HEX5);
	deciOnHex DY (Y,HEX4);
	
	checkerror err (X, Y, err_led);
	
	assign LEDR[4:0] = sum;
	assign LEDR[9] = err_led;
endmodule

module checkerror (x, y, led);
	input [3:0] x, y;
	output led;
	
	wire [3:0] xr, yr;
	
	comparator CX (x, xr);
	comparator CY (y, yr);
	assign led = xr[0] | yr[0];
endmodule