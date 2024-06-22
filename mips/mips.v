module mips
(
	input clk,
	input rst_n,
	input a,
	output reg b
);

always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		b <= 1'd0;
	else
		b <= a;

end
endmodule