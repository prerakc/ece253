module FSM (w, clock, resetn, z, y);
	input w, clock, resetn;
	output z;
	output [8:0] y;
	
	reg [8:0] Y;
	
	always @ (w, y) begin
		Y[0] = 1;
		Y[1] = (!w & ~y[0]) | (!w & y[5]) | (!w & y[6]) | (!w & y[7]) | (!w & y[8]);
		Y[2] = (!w & y[1]);
		Y[3] = (!w & y[2]);
		Y[4] = (!w & y[3]) | (!w & y[4]);
		Y[5] = (w & ~y[0]) | (w & y[1]) | (w & y[2]) | (w & y[3]) | (w & y[4]);
		Y[6] = (w & y[5]);
		Y[7] = (w & y[6]);
		Y[8] = (w & y[7]) | (w & y[8]);
	end

	ff_reset0 y0 (clock, resetn, y[0], Y[0]);
	ff_reset0 y1 (clock, resetn, y[1], Y[1]);
	ff_reset0 y2 (clock, resetn, y[2], Y[2]);
	ff_reset0 y3 (clock, resetn, y[3], Y[3]);
	ff_reset0 y4 (clock, resetn, y[4], Y[4]);
	ff_reset0 y5 (clock, resetn, y[5], Y[5]);
	ff_reset0 y6 (clock, resetn, y[6], Y[6]);
	ff_reset0 y7 (clock, resetn, y[7], Y[7]);
	ff_reset0 y8 (clock, resetn, y[8], Y[8]);
	
	assign z = ((y == 9'b000010001) | (y == 9'b100000001));
endmodule