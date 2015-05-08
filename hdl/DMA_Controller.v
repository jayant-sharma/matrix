`timescale 1ns / 1ps

module DMA_Controller #(
	parameter N		= 6,
	parameter WIDTH		= 16,
	parameter M_WIDTH	= 2*WIDTH+N-1
)(
	input 					clk,
	input					start,
	// MATRIX MEMORY A
	output			 		A_rd,
	output		[ADDR-1:0] 		A_addr,
	input		[N*WIDTH-1:0] 		A_dout,
	// MATRIX MEMORY B
	output			 		B_rd,
	output		[ADDR-1:0] 		B_addr,
	input		[N*WIDTH-1:0] 		B_dout,
	// MATRIX MEMORY C
	output			 		C_wr,
	output		[ADDR-1:0] 		C_addr,
	output		[N*WIDTH-1:0] 		C_din,
	// MAC BASE INTERFACE
	output					sof,
	output		[N*WIDTH-1:0] 		A,
	output		[WIDTH-1:0] 		B,
	input 		[N*M_WIDTH-1:0] 	C,
	input 		[N-1:0]			valid
);

always@(posedge clk) begin
	case(state)
		IDLE: begin
			A_addr <= 0;
			B_addr <= 0;
			A_rd <= 1'b0;
			B_rd <= 1'b0;
			if(start) begin
				A_addr <= 0;
				B_addr <= 0;
				A_rd <= 1'b1;
				B_rd <= 1'b1;
				state <= FETCH;
			end
		end
		FETCH: begin
			if(B_addr!= N) begin
				B_rd <= 1'b1; 
				B_addr <= B_addr + 1; 
				if(A_addr != N) begin
					A_rd <= 1'b1;
					A_addr <= A_addr + 1;
					A <= A_dout;
					B <= B_dout[WIDTH*(A_addr+1)-1:WIDTH*A_addr];
				end
			end
			else
				state <= IDLE;
		end
	endcase
end

always@(posedge clk) begin
	if(valid == N{1'b1}) begin
		C_wr <= 1'b1;
		C_addr <= C_addr + 1; 
		C_din <= C;
	end
end

/*genvar i;
generate for (i = 0; i < N; i = i + 1) begin
	always@(posedge clk) begin
	if(valid[i]) begin
		C_wr <= 1'b1;
		C_addr <= C_addr + 1; 
		C_din <= C_din && M_WIDTH{1'b1};
	end
end endgenerate
*/	
endmodule 
