module lab4part5 (SW, HEX5, HEX4,HEX1, HEX0);
	input [9:0] SW;
	output [6:0] HEX5, HEX4, HEX1, HEX0;
	
	wire [3:0] A, B;
	wire cin;

	assign A = SW[7:4];
	assign B = SW[3:0];
	assign cin = SW[8];	
	
	reg [4:0] f;
	reg [3:0] s, c;
	
	always @ (A, B, cin) begin
		f = A + B + cin;
		if (f > 5'b01001) begin
			s = f - 5'b01010;
			c = 4'b0001;
		end
		else begin
			s = f;
			c = 4'b0000;
		end
	end
	
	deciOnHex DA (A, HEX5);
	deciOnHex DB (B, HEX4);
	deciOnHex DC (c, HEX1); 
	deciOnHex DS (s, HEX0);
endmodule