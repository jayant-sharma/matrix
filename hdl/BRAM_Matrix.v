`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2015 12:10:35 PM
// Design Name: 
// Module Name: BRAM_Matrix
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


module BRAM_Matrix #(
	parameter N				= 6,
	parameter WIDTH		= 16,
	parameter M_WIDTH		= 2*WIDTH+N-1,
	parameter ADDR			= 12
)(
	// CLOCK
	input         				clk_USR,
	input         				clk_MAT,
	// USER MEMORY A
	input          			A_USR_wr,
	input		[ADDR-1:0]		A_USR_addr,
	input		[N*WIDTH-1:0]	A_USR_din,
	// USER MEMORY B
	input	         			B_USR_wr,
	input		[ADDR-1:0]		B_USR_addr,
	input		[N*WIDTH-1:0]	B_USR_din,
	// USER MEMORY C
	input	          			C_USR_rd,
	input		[ADDR-1:0] 		C_USR_addr,
	output	[N*WIDTH-1:0]	C_USR_dout,
	// MATRIX MEMORY A
	input							A_MAT_rd,
	input		[ADDR-1:0] 		A_MAT_addr,
	output	[N*WIDTH-1:0]	A_MAT_dout,
	// MATRIX MEMORY B
	input							B_MAT_rd,
	input		[ADDR-1:0] 		B_MAT_addr,
	output	[N*WIDTH-1:0] 	B_MAT_dout,
	// MATRIX MEMORY C
	input							C_MAT_wr,
	input		[ADDR-1:0]		C_MAT_addr,
	input		[N*WIDTH-1:0] 	C_MAT_din
);
    
dpram A_MEM (
	.clka     	(clk_USR),    	
	.wea      	(A_USR_wr),
	.addra    	(A_USR_addr),
	.dina     	(A_USR_din),  
	.douta    	(),  

	.clkb     	(clk_MAT),  
	.web      	(1'b0),  
	.addrb    	(A_MAT_addr),  
	.dinb     	(),    
	.doutb    	(A_MAT_dout)
);
defparam A_MEM.DATA	= WIDTH;
defparam A_MEM.ADDR	= ADDR;

dpram B_MEM (
	.clka     	(clk_USR),    	
	.wea      	(B_USR_wr), 
	.addra    	(B_USR_addr), 
	.dina     	(B_USR_din), 
	.douta    	(),  		

	.clkb     	(clk_MAT),   
	.web      	(1'b0),     	
	.addrb    	(B_MAT_addr),  
	.dinb     	(),    
	.doutb    	(B_MAT_dout)  
);
defparam B_MEM.DATA	= WIDTH;
defparam B_MEM.ADDR	= ADDR;

dpram C_MEM (
	.clka    	(clk_USR),   
	.wea      	(1'b0),     
	.addra    	(C_USR_addr),
	.dina     	(),    	
	.douta    	(C_USR_dout),	

	.clkb     	(clk_MAT),   
	.web      	(C_MAT_wr),  
	.addrb    	(C_MAT_addr),  
	.dinb     	(C_MAT_din),    
	.doutb    	() 
);
defparam A_MEM.DATA	= M_WIDTH;
defparam A_MEM.ADDR	= ADDR;
   
endmodule
