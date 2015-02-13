module matrix #(
	parameter ROW 	= 5,
	parameter COL 	= 4,
	parameter WIDTH	= 16

)(
	input clk,
	input wr,
	input valid,
	input [WIDTH-1:0] data
);

wire N = ROW*COL;
reg [N-1:0] cnt;
reg [WIDTH-1:0] mem [0:N-1]; 

initial begin
	cnt <= 0;				
	state <= 2'b00;
end

always@(posedge clk) begin
	case(state)
		2'b00: begin
			if(wr) begin
				cnt <= N;				
				state <= 2'b01;
			end
		end
		2'b01: begin
			if(cnt != 0) begin
				if(valid) begin
					mem[N-cnt] <= data;
					cnt <= cnt - 1;
				end
			end
			else
				state <= 2'b00;
		end
	endcase
end

endmodule 
