module FSM (w, clock, resetn, z, y);
	input w, clock, resetn;
	output z;
	output [3:0] y;
	
	reg [3:0] Y;
	
	parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100,
	F = 4'b0101, G = 4'b0110, H = 4'b0111, I = 4'b1000;
	
	always @ (w, y) begin
		case (y)
			A: if (w) Y = F;
				else Y = B;
			B: if (w) Y = F;
				else Y = C;
			C: if (w) Y = F;
				else Y = D;
			D: if (w) Y = F;
				else Y = E;
			E: if (w) Y = F;
				else Y = E;
			F: if (w) Y = G;
				else Y = B;
			G: if (w) Y = H;
				else Y = B;
			H: if (w) Y = I;
				else Y = B;
			I: if (w) Y = I;
				else Y = B;
			default: Y = 4'bxxxx;
		endcase
	end
	
	ff_reset0 ff (clock, resetn, y, Y);
	
	assign z = ((y == E) | (y == I));
endmodule