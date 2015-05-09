`timescale 1ns / 1ps

module multi_MAC_Base #(
	parameter N		= 5,
	parameter WIDTH		= 16,
	parameter M_WIDTH	= 2*WIDTH+N-1
)(
	input 					clk,
	input					sof,
	input		[N*WIDTH-1:0] 		A,
	input		[WIDTH-1:0] 		B,
	output 	[N*M_WIDTH-1:0] 	C,
	output 	[N-1:0]			valid
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