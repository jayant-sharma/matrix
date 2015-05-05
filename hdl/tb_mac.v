`timescale 1ns / 1ps
`define clkperiodby2 10
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2015 03:46:05 PM
// Design Name: 
// Module Name: tb_mac
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_mac;

// Inputs
reg clk;
reg [15 : 0] A, B;
reg sof;

// Outputs
wire [35 : 0] C;

// Instantiate the Unit Under Test (UUT)
MAC mult_acc (
    .clk(clk), 
    .sof(sof), 
    .A(A), 
    .B(B), 
    .C(C)
    );
	 
initial begin
    // Initialize Inputs
    clk = 0;
    sof = 0;
    A = 0;
    B = 0;
    #310

	sof = 1;
	A = 1;
	B = 15;
	#20
	A = 2;
	B = 15;
	#20
	A = 3;
	B = 15;
	#20
	A = 4;
	B = 15;
	#20
	A = 5;
	B = 15;
	#20
	sof = 0;
	A = 6;
	B = 15;
	#20
	A = 7;
	B = 15;
	#20
	A = 8;
	B = 15;
	#20
	A = 9;
	B = 15;
	#20
	A = 10;
	B = 15;
	#20   
	A = 11;
	B = 15;
	#20
	A = 12;
	B = 15;
	#20 
	#100
	$stop;
	end

always
    #`clkperiodby2 clk <= ~clk;

endmodule
