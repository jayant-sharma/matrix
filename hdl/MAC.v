`timescale 1ns / 1ps

module MAC #(
	parameter N				= 5,
	parameter PIPE			= 3,
	parameter WIDTH		= 16,
	parameter M_WIDTH		= 2*WIDTH+N-1
)(
	input 							clk,
	input 							sof,
	input			[WIDTH-1:0] 	A,
	input			[WIDTH-1:0] 	B,
	output reg	[M_WIDTH-1:0] 	C,
	output reg          			valid
);

reg state;
reg [7:0] n,p;
wire [2*WIDTH-1:0] O;

parameter 
	IDLE  = 1'b0,
	MAC   = 1'b1;
	
initial begin
	n <= N;
	p <= PIPE;
	C <= 0;
	valid <= 1'b0;
	state <= IDLE;
end

always@(posedge clk) begin
	case(state)
		IDLE: begin
			p <= PIPE;
			n <= N;
			C <= 0;
			valid <= 1'b0;
			if(sof) begin
				if(p > 1)
					p <= p-1;
				else	begin// if ((p == 1) || (p ==0))
					p <= 0;
					state <= MAC;
				end
			end	
		end
		MAC: begin
			C <= C + O;
			n <= n-1;
			valid <= 1'b0;
			if(n == 1) begin
				valid <= 1'b1;
				if(!sof)
					state <= IDLE;
				else begin
					n <= N;
					//C <= 0;
				end
			end
			if(n == N)
				C <= O;
		end
	endcase
end

MULT mult_16W (
  .clk	(clk), 	// input clk
  .a		(A), 		// input [15 : 0] a
  .b		(B), 		// input [15 : 0] b
  .p		(O) 		// output [31 : 0] p
);

endmodule 
