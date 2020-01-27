module ff_reset1 (clock, resetn, y, Y);
	input clock, resetn, Y;
	output reg y;
	
	always @ (posedge clock)
		if (!resetn)
			y <= 1;
		else
			y <= Y;
endmodule