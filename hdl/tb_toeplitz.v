`timescale 1ns / 1ps
`define clkperiodby2 10
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:21:50 02/14/2015
// Design Name:   toeplitz_mat
// Module Name:   /home/jayant/devel/git_reps/matrix/hdl/tb_toeplitz.v
// Project Name:  mat_toeplitz
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: toeplitz_mat
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_toeplitz;

	// Inputs
	reg clk;
	reg start;
	reg [15:0] data;

	// Outputs
	wire [7:0] addr;
	wire rd;

	// Instantiate the Unit Under Test (UUT)
	toeplitz_mat uut (
		.clk(clk), 
		.start(start), 
		.data(data), 
		.addr(addr), 
		.rd(rd)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		start = 0;
		data = 0;
		#20
		start = 1;
		#20
		wr_mat();
		#40
		data = 16'h1122;
		$stop;
	end
   
	always
		#`clkperiodby2 clk <= ~clk;
		
	task wr_mat();
		begin
			start = 0;
			while(!rd)	begin
				@ (posedge clk);
				data = 16'haabb;
			end
			data = 16'h0000;
		end
	endtask 
	
endmodule

