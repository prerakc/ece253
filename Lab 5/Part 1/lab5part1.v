module lab5part1 (SW, Qa, Qb, Qc);
	input [9:0] SW;
	output Qa, Qb, Qc;
	
	wire D = SW[1];
	wire clk = SW[0];
		
	D_latch u0 (D, clk, Qa);
	D_FF_posedge u1 (D, clk, Qb);
	D_FF_negedge u2 (D, clk, Qc);
endmodule

module D_latch (D, clk, Q);
	input D, clk;
	output reg Q;
	
	always @ (D, clk)
		if (clk == 1)
			Q = D;
endmodule

module D_FF_posedge (D, clk, Q);
	input D, clk;
	output reg Q;
	
	always @ (posedge clk)
		Q <= D;
endmodule

module D_FF_negedge (D, clk, Q);
	input D, clk;
	output reg Q;
	
	always @ (negedge clk)
		Q <= D;
endmodule