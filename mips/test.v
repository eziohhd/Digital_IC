`timescale 1ns/1ps

module tb_mips();
//Reg Declaration
reg clk;
reg rst_n;
wire a;
wire b;
//initial
initial begin
	clk = 0;
   forever #2 clk = ~clk;
end

initial begin
	rst_n = 0;
   #10 rst_n = 1;
end

mips mips_inst(
	.clk(clk),
	.rst_n(rst_n),
	.a(a),
	.b(b)
);
endmodule

