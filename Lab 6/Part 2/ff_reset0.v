module ff_reset0 (clock, resetn, y, Y);
	input clock, resetn;
	input [3:0] Y;
	output reg [3:0] y;
	
	always @ (posedge clock)
		if (!resetn)
			y <= 0;
		else
			y <= Y;
endmodule