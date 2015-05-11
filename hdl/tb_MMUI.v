`timescale 1ns / 1ps
`define clkperiodby2 10

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2015 12:23:19 PM
// Design Name: 
// Module Name: tb_MMUI
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

`include "params.vh"

module tb_MMUI #(
	parameter N				= `MAT_SIZE,
	parameter WIDTH		= `DATA_WIDTH,
	parameter M_WIDTH		= 2*WIDTH+N-1,
	parameter ADDR			= `CLOG2(N)
);

//inputs
reg clk;
reg start; 
reg A_USR_wr;
reg B_USR_wr;
reg C_USR_rd;
reg [ADDR-1:0] 		A_USR_addr;
reg [ADDR-1:0] 		B_USR_addr;
reg [ADDR-1:0] 		C_USR_addr;
reg [N*WIDTH-1:0] 	A_USR_din;
reg [N*WIDTH-1:0] 	B_USR_din;

wire [N-1:0] 			valid;
wire [N*M_WIDTH-1:0] 	C_USR_dout;
wire [N*WIDTH-1:0] 	A;
wire [WIDTH-1:0] 		B;
wire [N*M_WIDTH-1:0] C;  

wire A_MAT_rd;
wire B_MAT_rd;
wire C_MAT_wr;
wire [ADDR-1:0] 		A_MAT_addr;
wire [ADDR-1:0] 		B_MAT_addr;
wire [ADDR-1:0] 		C_MAT_addr;
wire [N*WIDTH-1:0] 	A_MAT_dout;
wire [N*WIDTH-1:0] 	B_MAT_dout;;
wire [N*M_WIDTH-1:0] C_MAT_din;

//////////////////////////////////////////////////////////////////////////

multi_MAC_Base MAC_Base (
	.clk        			(clk), 
	.sof        			(sof), 
	.A          			(A), 
	.B          			(B), 
	.C          			(C), 
	.valid      			(valid)
);    
defparam MAC_Base.N			= N;
defparam MAC_Base.WIDTH		= WIDTH;
defparam MAC_Base.M_WIDTH	= M_WIDTH;

DMA_Controller DMAC (
	.clk             		(clk),
	.start           		(start),
	// MATRIX MEMORY A
	.A_rd            		(),
	.A_addr          		(A_MAT_addr),
	.A_dout          		(A_MAT_dout),
	// MATRIX MEMORY B
	.B_rd            		(),
	.B_addr          		(B_MAT_addr),
	.B_dout          		(B_MAT_dout),
	// MATRIX MEMORY C
	.C_wr            		(C_MAT_wr),
	.C_addr          		(C_MAT_addr),
	.C_din           		(C_MAT_din),
	// MAC BASE INTERFACE
	.sof             		(sof),
	.A               		(A),
	.B               		(B),
	.C               		(C),
	.valid           		(valid)
);
defparam DMAC.N			= N;
defparam DMAC.WIDTH		= WIDTH;
defparam DMAC.ADDR		= ADDR;
defparam DMAC.M_WIDTH	= M_WIDTH;

BRAM_Matrix Memory(
	.clk_USR        		(clk),
	.clk_MAT        		(clk),
	// USER MEMORY A
	.A_USR_wr            (A_USR_wr),
	.A_USR_addr          (A_USR_addr),
	.A_USR_din           (A_USR_din),
	// USER MEMORY B
	.B_USR_wr            (B_USR_wr),
	.B_USR_addr          (B_USR_addr),
	.B_USR_din           (B_USR_din),
	// USER MEMORY C
	.C_USR_rd            (C_USR_rd),
	.C_USR_addr          (C_USR_addr),
	.C_USR_dout          (C_USR_dout),
	// MATRIX MEMORY A
	.A_MAT_rd        		(),
	.A_MAT_addr       	(A_MAT_addr),
	.A_MAT_dout          (A_MAT_dout),
	// MATRIX MEMORY B
	.B_MAT_rd            (),
	.B_MAT_addr          (B_MAT_addr),
	.B_MAT_dout          (B_MAT_dout),
	// MATRIX MEMORY C
	.C_MAT_wr         	(C_MAT_wr),
	.C_MAT_addr      		(C_MAT_addr),
	.C_MAT_din      	   (C_MAT_din)
);
defparam Memory.N			= N;
defparam Memory.WIDTH	= WIDTH;
defparam Memory.M_WIDTH	= M_WIDTH;
defparam Memory.ADDR		= ADDR;

//////////////////////////////////////////////////////////////////////////
initial begin
    // Initialize Inputs
    clk = 0; 
    start = 0;
    #310
    
    writemem(1);
          
    #10000
    $stop;
end
//////////////////////////////////////////////////////////////////////////

task writemem;
    input strt;
    reg [8:0] i;
    begin
        if(strt) begin
				 @ (posedge clk);
				for(i = 0; i < N; i = i+1) begin
					 @ (posedge clk);
                A_USR_wr = 1'b1;
                A_USR_addr = i;
                A_USR_din = 96'h000600050004000300020001;//(3*(i+1) << (i+5)*16) || (2*(i+1) << (i+4)*16) || (4*(i+1) << (i+3)*16) || (3*(i+1) << (i+2)*16) || (2*(i+1) << (i+1)*16) || ((i+1) << i*16);
                B_USR_wr = 1'b1;
                B_USR_addr = i;
                B_USR_din = 96'h000600050004000300020001;//(3*(i+1) << (i+5)*16) || (2*(i+1) << (i+4)*16) || (4*(i+1) << (i+3)*16) || (3*(i+1) << (i+2)*16) || (2*(i+1) << (i+1)*16) || ((i+1) << i*16) ;
                // @ (posedge clk);
            end
        end
        start = 1'b1;
        @ (posedge clk);
        @ (posedge clk);
        @ (posedge clk);
        start = 1'b0;
    end
endtask

always
	#`clkperiodby2 clk <= ~clk;
          
endmodule
