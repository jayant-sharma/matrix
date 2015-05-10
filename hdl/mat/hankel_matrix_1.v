`timescale 1ns / 1ps

module hankel_matrix #(
	parameter N 		= 15,
	parameter ROW 		= (N+1)/2,
	parameter COL 		= ROW,
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
reg [7:0] r,c,c_i,r_i;
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
	c_i <= c;
	r_i <= r;
end

always@(posedge clk) begin
	case(state)
		IDLE: begin
			r <= 0;
			c <= 0;
			rd <= 1'b1;
			addr <= 0;
			if(start) begin
				state <= STORE;
			end
		end
		STORE: begin
			mat[r_i][c_i] <= data;
			addr <= addr+1;
			c <= c+1;
			if(c==COL-1) begin	
				c <= 0;
				r <= r+1;
				addr <= r+1;
			end
			if(r_i==ROW-1 && c_i==COL-1) begin
				r <= 0;
				c <= 0;
				rd <= 1'b0;
				addr <= 0;
				state <= IDLE;
			end
		end
	endcase
end

endmodule 
