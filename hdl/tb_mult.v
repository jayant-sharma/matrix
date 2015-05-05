`timescale 1ns / 1ps
`define clkperiodby2 10

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2015 02:52:37 PM
// Design Name: 
// Module Name: tb_mult
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


module tb_mult;

// Inputs
reg clk;
reg [15 : 0] A, B;

// Outputs
wire [31 : 0] P;

// Instantiate the Unit Under Test (UUT)
MULT multiplier (
  .clk(clk), // input clk
  .a(A), // input [15 : 0] a
  .b(B), // input [15 : 0] b
  .p(P) // output [31 : 0] p
);

initial begin
    // Initialize Inputs
    clk = 0;
    A = 0;
    B = 0;
    
    #300
    A = -2;
    B = 15;
    #20
    A = 3.1;
    B = 4;
    #20
    A = 6;
    B = 7;
    #20
    A = 4;
    B = 15;
    #20
    A = 8;
    B = 9;
    #20
	 
    #100
    $stop;
end

always
    #`clkperiodby2 clk <= ~clk;

endmodule
