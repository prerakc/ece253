module lab6part3 (SW, KEY, LEDR, CLOCK_50);
 	input [2:0] SW; // for letter selection 
 	input [1:0] KEY; // start & asynchronous reset
 	input CLOCK_50; // 50MHz clock 
 	output reg [0:0] LEDR; // morse code output

	// letter representation on switches
	parameter Js = 3'b000;
	parameter Ks = 3'b001;
	parameter Ls = 3'b010;
	parameter Ms = 3'b011;
	parameter Ns = 3'b100;
	parameter Os = 3'b101;
	parameter Ps = 3'b110;
	parameter Qs = 3'b111;

	// letter representation per 0.5 seconds
	parameter Jc = 13'b1011101110111;
	parameter Kc = 9'b111010111;
	parameter Lc = 9'b101110101;
	parameter Mc = 7'b1110111;
	parameter Nc = 5'b11101;
	parameter Oc = 11'b11101110111;
	parameter Pc = 11'b10111011101;
	parameter Qc = 13'b1110111010111;

	reg [12:0] code;
	reg [3:0] length;
	reg [12:0] Q;
	reg Qout;

	reg [25:0] timer;

	always @ (negedge KEY[0], negedge KEY[1], posedge CLOCK_50) begin
		// if reset was pressed
		if (!KEY[0]) begin
			code <= 0;
			Q <= code;
		end
		
		// select letter
		else if (!KEY[1]) begin
			case (SW[2:0])
				Js: begin
					code <= Jc;
					length <= 13;
				end
				Ks: begin
					code <= {Kc, 1'b0, 1'b0, 1'b0, 1'b0};
					length <= 9;
				end
				Ls: begin
					code <= {Lc, 1'b0, 1'b0, 1'b0, 1'b0};
					length <= 9;
				end
				Ms: begin
					code <= {Mc, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
					length <= 7;
				end
				Ns: begin
					code <= {Nc, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
					length <= 5;
				end
				Os: begin
					code <= {Oc, 1'b0, 1'b0};
					length <= 11;
				end
				Ps: begin
					code <= {Pc, 1'b0, 1'b0};
					length <= 11;
				end
				Qs: begin
					code <= Qc;
					length <= 13;
				end
			endcase
			
			Q <= code;
		end
		
		else begin
			timer <= timer + 1;

			if (timer == 25000000) begin
				timer <= 0;

				Qout <= Q[12];
				Q[1] <= Q[0];
				Q[2] <= Q[1];
				Q[3] <= Q[2];
				Q[4] <= Q[3];
				Q[5] <= Q[4];
				Q[6] <= Q[5];
				Q[7] <= Q[6];
				Q[8] <= Q[7];
				Q[9] <= Q[8];
				Q[10] <= Q[9];
				Q[11] <= Q[10];
				Q[12] <= Q[11];
				Q[13-length] <= Qout;
			end
		end
	
	LEDR = Qout;
	end
endmodule