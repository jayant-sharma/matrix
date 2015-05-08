`timescale 1ns / 1ps

module multi_MAC_Base #(
	parameter N		= 6,
	parameter WIDTH		= 16,
	parameter M_WIDTH	= 2*WIDTH+N-1
)(
	input 					clk,
	input					sof,
	input		[N*WIDTH-1:0] 		A,
	input		[WIDTH-1:0] 		B,
	output reg	[N*M_WIDTH-1:0] 	C,
	output reg	[N-1:0]			valid
);

genvar i;
generate for (i = 0; i < N; i = i + 1) begin
	MAC mult_acc (
	    .clk	(clk), 
	    .sof	(sof), 
	    .A		(A[WIDTH*(i+1)-1:WIDTH*i]), 
	    .B		(B), 
	    .C		(C[M_WIDTH*(i+1)-1:M_WIDTH*i]),
	    .valid	(valid[i])
	);
end endgenerate
	
endmodule 
//////////////////////////////////////////////////////////////////////////////////////
/*	
always@(posedge clk) begin
	case(state)
		IDLE: begin
			i <= 0;
			j <= 0;
			if(start) begin
				i <= 0;
				j <= 0;
				state <= FETCH;
			end
		end
		FETCH: begin
			if(j!= N) begin
				j <= j + 1;
				if(i != N) begin
					i <= i + 1;
					
					A_rd <= 1'b1;
					A_addr <= i;
					A <= A_dout;
					
					B_rd <= 1'b1; 
					B_addr <= (N*i)+j; 
					B <= B_dout;
				end
			end
			else
				state <= IDLE;
		end
	endcase
end



if(MAC_valid) begin
	C_wr <= 1'b1;
	C_addr <= C_addr + 1; 
	C_din <= C;
end
*/
