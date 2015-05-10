module matrix #(
	parameter ROW1 	= 3,
	parameter COL1 	= 3,
	parameter ROW2 	= COL1,
	parameter COL2 	= 3,
	parameter WIDTH	= 16
)(
	input clk,
	input start
);

wire N1 = ROW1*COL1;
wire N2 = ROW2*COL2;
wire N3 = ROW1*COL2;

reg [WIDTH-1:0] 	mat1 [0:N1-1]; 
reg [WIDTH-1:0] 	mat2 [0:N2-1]; 
reg [2*WIDTH-1:0] 	mat3 [0:N3-1];

initial begin
	mat1 <= {	16'h0001, 16'h0002, 16'h0003,
				16'h0004, 16'h0005, 16'h0006,
				16'h0007, 16'h0008, 16'h0009	};
				
	mat2 <= {	16'h0011, 16'h0012, 16'h0013,
				16'h0014, 16'h0015, 16'h0016,
				16'h0017, 16'h0018, 16'h0019	};
end

always@(posedge clk) begin
	case(state)
		2'b00: begin
			if(start) begin
								
				state <= 2'b01;
			end
		end
		2'b01: begin
			if
			
			end
			else
				state <= 2'b00;
		end
	endcase
end

endmodule 