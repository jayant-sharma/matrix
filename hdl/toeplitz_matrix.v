`timescale 1ns / 1ps

module matrix #(
	parameter ROW 	= 5,
	parameter COL 	= 4,
	parameter WIDTH	= 16

)(
	input clk,
	input valid,
	input [WIDTH-1:0] data
);

reg [WIDTH-1:0] mat [0:ROW-1] [0:COL-1];
reg [7:0] r,c;

initial begin
	c <= 0;
	r <= 0;
end

always@(posedge clk) begin
	if(valid) begin
		mat[r][c] <= data;
		c <= c+1;
		if(c==COL-1) begin	
			c <= 0;
			r <= r+1;
		end
	end
	else begin
		r <= 0;
		c <= 0;
	end	
end

endmodule 
