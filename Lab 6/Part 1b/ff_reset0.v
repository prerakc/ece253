module ff_reset0 (clock, resetn, y, Y);
	input clock, resetn, Y;
	output reg y;
	
	always @ (posedge clock)
		if (!resetn)
			y <= 0;
		else
			y <= Y;
endmodule