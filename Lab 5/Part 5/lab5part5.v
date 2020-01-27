module lab5part5 (CLOCK_50, HEX0);
	input CLOCK_50;
	output [6:0] HEX0;
	
	wire [25:0] bigcounter;
	wire [3:0] smallcounter;
	
	counter u1 (CLOCK_50, bigcounter, smallcounter);
	
	HexDisp u2 (smallcounter, HEX0);
endmodule

module counter (clock, bcounter, scounter);
	input clock;
	output reg [25:0] bcounter;
	output reg [3:0] scounter;
	
	always @ (posedge clock) begin
		bcounter <= bcounter + 1;
			
		if (bcounter == 50000000) begin
			bcounter <= 26'b0;
							
			if (scounter < 9)
				scounter <= scounter + 1;
			else
				scounter <= 4'b0;
		end
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