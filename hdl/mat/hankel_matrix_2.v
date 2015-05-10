`timescale 1ns / 1ps

module hankel_matrixd_d #(
	parameter ROW 	= 4,
	parameter COL 	= 4,
	parameter WIDTH	= 16,
	parameter ADDR		= 8

)(
	input 				clk,
	input 				start,
	input		[WIDTH-1:0] 	data,
	output reg	[ADDR-1:0] 	addr,
	output reg			rd
);

reg [WIDTH-1:0] mat [0:ROW-1] [0:COL-1];
reg [7:0] r,c,r_i,c_i,state;
reg		[WIDTH-1:0] 	data_i;
reg	[ADDR-1:0] 	addr_i;
parameter 
	IDLE = 2'b00,
	INIT = 2'b01,
	COPY = 2'b10,
	WRITE= 2'b11;
	
initial begin
	c <= 0;
	r <= 0;
	addr <=0;
	//addr_i <=0;
	rd<=0;
	state <= IDLE;
end



always@(posedge clk) begin
	case(state)
		IDLE: begin
			if(start) 
				state <= INIT;
				rd <=1;				
				r<=0;
				c<=0;
				addr <=0;
		end
		INIT: begin
			if(r==0) begin
				mat[r][c] <= data;
				c <= c+1;
				addr <= addr+1;
				if(c==COL-1) begin	
					c <= 0;
					state <= COPY;
					
					r <= r+1;
				end
			end
		end
		COPY: begin
			if(r!=0) begin		
				mat[r][c] <= mat[r-1][c+1];
				c <= c+1;
				if(c==COL-2)begin
					state <= WRITE;
					rd <= 1;	
					addr <= addr+1;
				end
			end
		end
		WRITE: begin
			
			mat[r][c]<= data;
			state <= COPY;
			r <= r+1;
			c<=0;
			if(r==ROW-1)
				state <= IDLE;
		end
	endcase
end
endmodule 
