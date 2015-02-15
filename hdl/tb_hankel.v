`timescale 1ns / 1ps
`define clkperiodby2 10

module tb_hankel;

	// Inputs
	reg clk;
	reg start;
	reg [15:0] data;

	// Outputs
	wire [7:0] addr;
	wire rd;

	// Instantiate the Unit Under Test (UUT)
	hankel_matrix uut (
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
		wr_mat();
		#400
		data = 16'h1122;
		$stop;
	end
   
	always
		#`clkperiodby2 clk <= ~clk;
		
	task wr_mat();
	reg [8:0] i;
		begin
			@ (posedge clk);
			start = 1;
			@ (posedge clk);
			start = 0;
			@ (posedge clk);
			for(i=0;i<64;i=i+1) begin
				if(rd) begin
					data = i;
					@ (posedge clk);
				end
				else
					data = 16'hffff;
			end
		end
	endtask 
	
endmodule

