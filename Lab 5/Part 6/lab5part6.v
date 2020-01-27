module lab5part6 (CLOCK_50, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input CLOCK_50;
	output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	
	wire [25:0] bigcounter;
	wire [3:0] smallcounter;
	
	counter u1 (CLOCK_50, bigcounter, smallcounter);
	
	HexDisp u2 (smallcounter, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
endmodule

module counter (clock, bcounter, scounter);
	input clock;
	output reg [25:0] bcounter;
	output reg [3:0] scounter;
	
	always @ (posedge clock) begin
		bcounter <= bcounter + 1;
			
		if (bcounter == 50000000) begin
			bcounter <= 26'b0;
							
			if (scounter < 5)
				scounter <= scounter + 1;
			else
				scounter <= 4'b0;
		end
	end
endmodule
	
module HexDisp(selector, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input [3:0] selector;
	output reg [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	
	always @ (selector) begin
		if (selector == 4'b0000) begin
			HEX0 = ~(7'h06);
			HEX1 = ~(7'h79);
			HEX2 = ~(7'h5E);
			HEX3 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX5 = 7'b1111111;
		end
		else if (selector == 4'b0001) begin
			HEX0 = 7'b1111111;
			HEX1 = ~(7'h06);
			HEX2 = ~(7'h79);
			HEX3 = ~(7'h5E);
			HEX4 = 7'b1111111;
			HEX5 = 7'b1111111;
		end
		else if (selector == 4'b0010) begin
			HEX0 = 7'b1111111;
			HEX1 = 7'b1111111;
			HEX2 = ~(7'h06);
			HEX3 = ~(7'h79);
			HEX4 = ~(7'h5E);
			HEX5 = 7'b1111111;
		end
		else if (selector == 4'b0011) begin
			HEX0 = 7'b1111111;
			HEX1 = 7'b1111111;
			HEX2 = 7'b1111111;
			HEX3 = ~(7'h06);
			HEX4 = ~(7'h79);
			HEX5 = ~(7'h5E);
		end
		else if (selector == 4'b0100) begin
			HEX0 = ~(7'h5E);
			HEX1 = 7'b1111111;
			HEX2 = 7'b1111111;
			HEX3 = 7'b1111111;
			HEX4 = ~(7'h06);
			HEX5 = ~(7'h79);
		end
		else begin
			HEX0 = ~(7'h79);
			HEX1 = ~(7'h5E);
			HEX2 = 7'b1111111;
			HEX3 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX5 = ~(7'h06);
		end
	end
endmodule