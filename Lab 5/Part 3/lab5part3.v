module lab5part3 (SW, KEY, HEX3, HEX2, HEX1, HEX0);
	input [9:0] SW;
	input [3:0] KEY;
	output [6:0] HEX3, HEX2, HEX1, HEX0;
	
	wire [15:0] Q;
	
	tff_sync_reset_enable t1(KEY[0], SW[0], SW[1], Q[0]);
	tff_sync_reset_enable t2 (KEY[0], SW[0], SW[1] & Q[0], Q[1]);
	tff_sync_reset_enable t3 (KEY[0], SW[0], Q[1] & Q[0] & SW[1], Q[2]);
	tff_sync_reset_enable t4 (KEY[0], SW[0], Q[2] & Q[1] & Q[0] & SW[1], Q[3]);
	tff_sync_reset_enable t5 (KEY[0], SW[0], Q[3] & Q[2] & Q[1] & Q[0] & SW[1], Q[4]);
	tff_sync_reset_enable t6 (KEY[0], SW[0], Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & SW[1], Q[5]);
	tff_sync_reset_enable t7 (KEY[0], SW[0], Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & SW[1], Q[6]);
	tff_sync_reset_enable t8 (KEY[0], SW[0], Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & SW[1], Q[7]);
	tff_sync_reset_enable t9 (KEY[0], SW[0], Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & SW[1], Q[8]);
	tff_sync_reset_enable t10 (KEY[0], SW[0], Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & SW[1], Q[9]);
	tff_sync_reset_enable t11 (KEY[0], SW[0], Q[9] & Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & SW[1], Q[10]);
	tff_sync_reset_enable t12 (KEY[0], SW[0], Q[10] & Q[9] & Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & SW[1], Q[11]);
	tff_sync_reset_enable t13 (KEY[0], SW[0], Q[11] & Q[10] & Q[9] & Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & SW[1], Q[12]);
	tff_sync_reset_enable t14 (KEY[0], SW[0], Q[12] & Q[11] & Q[10] & Q[9] & Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & SW[1], Q[13]);
	tff_sync_reset_enable t15 (KEY[0], SW[0], Q[13] & Q[12] & Q[11] & Q[10] & Q[9] & Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & SW[1], Q[14]);
	tff_sync_reset_enable t16 (KEY[0], SW[0], Q[14] & Q[13] & Q[12] & Q[11] & Q[10] & Q[9] & Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & SW[1], Q[15]);
	
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

module tff_sync_reset_enable (clk, reset_n, enable, Q);
	input clk, reset_n, enable;
	output reg Q;
	
	always @ (negedge reset_n, posedge clk) begin
		if (!reset_n)
			Q <= 1'b0;
		else
			Q <= enable ^ Q;
	end
endmodule