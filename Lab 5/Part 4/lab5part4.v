module lab5part4 (SW, KEY, HEX3, HEX2, HEX1, HEX0);
	input [9:0] SW;
	input [6:0] KEY;
	output [6:0] HEX3, HEX2, HEX1, HEX0;
	
	wire reset_n;
	assign reset_n = SW[0];
	wire enable;
	assign enable = SW[1];
	wire clk;
	assign clk = KEY[0];
	
	reg [15:0] Q = 16'b0;
	
	always @ (negedge reset_n, posedge clk) begin
		if (!reset_n)
			Q <= 1'b0;
		else if (enable)
			Q <= Q + 1;
	end

	HexDisp h3 (Q[3:0],HEX0);
	HexDisp h2 (Q[7:4],HEX1);
	HexDisp h1 (Q[11:8],HEX2);
	HexDisp h0 (Q[15:12],HEX3);
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