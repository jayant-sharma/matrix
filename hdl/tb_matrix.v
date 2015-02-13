`timescale 1ns / 1ps
`define clkperiodby2 10
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:38:56 02/13/2015
// Design Name:   matrix
// Module Name:   /home/jayant/devel/git_reps/matrix/tb_matrix.v
// Project Name:  mat_toeplitz
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: matrix
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_matrix;

	// Inputs
	reg clk;
	reg valid;
	reg [15:0] data;

	// Instantiate the Unit Under Test (UUT)
	matrix uut (
		.clk(clk), 
		.valid(valid), 
		.data(data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		valid = 0;
		data = 0;
		#20
		wr_mat(20);
		#40
		$stop;
	end
   
	always
		#`clkperiodby2 clk <= ~clk;
		
	task wr_mat();
	input [7:0] N;
	reg [7:0] i;
		begin
			for(i=0; i<=N; i=i+1)begin
				@ (posedge clk);
				valid = 1'b1;
				data = i+1;
			end
				valid = 1'b0;
				data = 0;
				@ (posedge clk);
		end
	endtask 
	
endmodule

