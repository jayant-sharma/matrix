`timescale 1ns / 1ps


`include "include/vardump.vh"
`include "include/lane.vh"
module	router	#(
	parameter	DATA	=	64,
	parameter	ADDR	=	5,
	parameter	LANES	=	4
	)
	(
	input	wire	clK,	

	// lanes
	input	wire	[LANES-1:0]		WR,
	input	wire	[LANES-1:0][DATA-1:0]	IN,
	input	wire	[LANES-1:0]		RD,
	output	wire	[LANES-1:0][DATA-1:0]	OUT,
	output	wire	[LANES-1:0]		in_BUSY,
	output	wire	[LANES-1:0]		out_BUSY,

	input	wire	rsT
	);

	wire	[LANES-1:0]		L1_WR;
	wire	[LANES-1:0][DATA-1:0]	L1_IN;
	wire	[LANES-1:0]		L1_RD;
	wire	[LANES-1:0][DATA-1:0]	L1_OUT;
	wire	[LANES-1:0]		L1_in_BUSY;
	wire	[LANES-1:0]		L1_out_BUSY;

	genvar i;
	generate for (i = 0; i < LANES; i = i + 1) begin
		lane	a_lane(
		.clK(clK),	

		// lane A
		.a_WR(WR[i]),
		.a_IN(IN[i]),
		.a_RD(RD[i]),
		.a_OUT(OUT[i]),
		.a_in_BUSY(in_BUSY[i]),
		.a_out_BUSY(out_BUSY[i]),

		// lane B 
		.b_WR(L1_WR[i]),
		.b_IN(L1_IN[i]),
		.b_RD(L1_RD[i]),
		.b_OUT(L1_OUT[i]),
		.b_in_BUSY(L1_in_BUSY[i]),
		.b_out_BUSY(L1_out_BUSY[i]),
	
		.rsT(rsT)
		);
		defparam	a_lane.DATA	=	DATA;
		defparam	a_lane.ADDR	=	ADDR;
	end endgenerate

	//#########################################
	wire [3:0][DATA-1:0] L1_out;
	//assign	L1_out[0] = out_BUSY? a_OUT: 0;
	//assign	L1_out[1] = out_BUSY? b_OUT: 0;
	//assign	L1_out[2] = out_BUSY? c_OUT: 0;
	//assign	L1_out[3] = out_BUSY? d_OUT: 0;

	//#########################################
	wire [DATA-1:0] Priority;
	//assign Priority = L1_out[0] | L1_out[1] | L1_out[2] | L1_out[3];

	//wire [3:1][DATA-1:0] L2_out;
	reg [3:1] RoundRobin;

	initial	begin
		RoundRobin	<= 0;
	end
	
	always	@(posedge clK) begin
		if (rsT) begin
			RoundRobin	<= 0;
		end
		RoundRobin	<= RoundRobin + 1;
	end
endmodule
