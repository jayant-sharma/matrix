`timescale 1ns / 1ps
`define clkperiodby2 10

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   07:55:53 05/09/2015
// Design Name:   multi_MAC_Base
// Module Name:   /home/jayant/devel/ise_projects/mac/tb_mac_base.v
// Project Name:  mac
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: multi_MAC_Base
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_mac_base;

	// Inputs
	reg clk;
	reg sof;
	reg [79:0] A;
	reg [15:0] B;

	// Outputs
	wire [179:0] C;
	wire [4:0] valid;

	// Instantiate the Unit Under Test (UUT)
	multi_MAC_Base uut (
		.clk(clk), 
		.sof(sof), 
		.A(A), 
		.B(B), 
		.C(C), 
		.valid(valid)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		sof = 0;
		A = 0;
		B = 0;
		#310
		
		A = 80'h00020007000900030005; B = 16'h0004;
		#20
		sof = 1'b1;
		#200
		
		#100
		$stop;
	end

	always
		 #`clkperiodby2 clk <= ~clk;
		  
endmodule

