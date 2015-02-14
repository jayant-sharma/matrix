`timescale 1ns / 1ps

module toeplitz_mat #(
	parameter ROW 		= 4,
	parameter COL 		= 4,
	parameter WIDTH		= 16,
	parameter ADDR		= 8

)(
	input 				clk,
	input 				start,
	input		[WIDTH-1:0] 	data,
	output reg	[ADDR-1:0] 	addr,
	output reg			rd
);

reg [WIDTH-1:0] mat [0:ROW-1] [0:COL-1];
reg [7:0] r,c;
reg state;

parameter 
	IDLE  = 1'b0,
	STORE = 1'b1;
	
initial begin
	c <= 0;
	r <= 0;
	rd <= 1'b0;
	addr <= 0;
	state <= IDLE;
end

always@(posedge clk) begin
	case(state)
		IDLE: begin
			r <= 0;
			c <= 0;
			rd <= 1'b0;
			addr <= 0;
			if(start) begin
				rd <= 1'b1;
				addr <= 0;
				state <= STORE;
			end
		end
		STORE: begin
			mat[r][c] <= data;
			addr <= addr+1;
			
			c <= c+1;
			if(c==COL-1) begin	
				c <= 0;
				r <= r+1;
				addr <= r+1;
			end
			if(r==ROW-1 && c==COL-1) begin
				state <= IDLE;
			end
		end
	endcase
end

endmodule 
