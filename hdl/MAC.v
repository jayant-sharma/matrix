`timescale 1ns / 1ps

module MAC #(
	parameter N	= 5,
	parameter WIDTH	= 16,
	parameter PIPE	= 2
)(
	input 				clk,
	input 				sof,
	input		[WIDTH-1:0] 	A,
	input		[WIDTH-1:0] 	B,
	output reg	[2*WIDTH+N-2:0] C,
	output reg          		valid
);

reg state;
reg [7:0] n,p;
wire [2*WIDTH-1:0] O;

parameter 
	IDLE  = 1'b0,
	MAC   = 1'b1;
	
initial begin
	n <= N;
	p <= PIPE+1;
	C <= 0;
	valid <= 1'b0;
	state <= IDLE;
end

always@(posedge clk) begin
	case(state)
		IDLE: begin
			p <= PIPE+1;
			n <= N;
			C <= 0;
			valid <= 1'b0;
			if(sof) begin
				p <= p-1;
				if(p == 1)
					state <= MAC;
			end	
		end
		MAC: begin
			C <= C + O;
			valid <= 1'b1;
			n <= n-1;
			if(n == 1)
				state <= IDLE;
		end
	endcase
end

MULT mult_16W (
  .CLK(clk), // input clk
  .A(A), // input [15 : 0] a
  .B(B), // input [15 : 0] b
  .P(O) // output [31 : 0] p
);

endmodule 
