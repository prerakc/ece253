module lab5part2 (SW, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LEDR, KEY);
	input [9:0] SW;
	input [3:0] KEY;
	output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	output [9:0] LEDR;
		
	wire [7:0] A, B;
	reg [8:0] S;
	
	d_ff_low_async da (SW[7:0], ~KEY[1], KEY[0], A);
	d_ff_low_async db (SW[7:0], KEY[1], KEY[0], B);

	always @ (A, B)
		S = A + B;
		
	assign LEDR[0] = S[8];
	HexDisp h5 (S[7:4], HEX5);
	HexDisp h4 (S[3:0], HEX4);
	HexDisp h3 (A[7:4], HEX3);
	HexDisp h2 (A[3:0], HEX2);
	HexDisp h1 (B[7:4], HEX1);
	HexDisp h0 (B[3:0], HEX0);
endmodule

module d_ff_low_async (D, clk, reset_n, Q);
	input clk, reset_n;	
	input [7:0] D;
	output reg [7:0] Q;
	
	always @ (negedge reset_n, posedge clk) begin
		if (!reset_n)
			Q <= 8'h00;
		else
			Q <= D;
	end
endmodule

module HexDisp(in, out);
	input [3:0] in;
	output reg [6:0] out;
	
	always @ (in) begin
		if (in == 4'h0)
			out = ~(7'h3F);
		else if (in == 4'h1)
			out = ~(7'h06);
		else if (in == 4'h2)
			out = ~(7'h5B);
		else if (in == 4'h3)
			out = ~(7'h4F);
		else if (in == 4'h4)
			out = ~(7'h66);
		else if (in == 4'h5)
			out = ~(7'h6D);
		else if (in == 4'h6)
			out = ~(7'h7D);
		else if (in == 4'h7)
			out = ~(7'h07);
		else if (in == 4'h8)
			out = ~(7'h7F);
		else if (in == 4'h9)
			out = ~(7'h6F);
		else if (in == 4'hA)
			out = ~(7'h77);
		else if (in == 4'hB)
			out = ~(7'h7C);
		else if (in == 4'hC)
			out = ~(7'h39);
		else if (in == 4'hD)
			out = ~(7'h5E);
		else if (in == 4'hE)
			out = ~(7'h79);
		else
			out = ~(7'h71);
	end
endmodule