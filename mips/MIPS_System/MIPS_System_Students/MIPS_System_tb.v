`timescale 1ns/1ns

module MIPS_System_tb();

  reg           clk;
  reg           reset;
  wire   [6:0]  hex7;
  wire   [6:0]  hex6;
  wire   [6:0]  hex5;
  wire   [6:0]  hex4;
  wire   [6:0]  hex3;
  wire   [6:0]  hex2;
  wire   [6:0]  hex1;
  wire   [6:0]  hex0;
  wire   [17:0] ledr;
  wire   [8:0]  ledg;

  // instantiate device to be tested
  MIPS_System    MIPS_System_dut (
        .CLOCK_50  (clk),
        .KEY       ({3'b000,reset}),
        .SW        (18'b0),
        .HEX7      (hex7),
        .HEX6      (hex6),
        .HEX5      (hex5),
        .HEX4      (hex4),
        .HEX3      (hex3),
        .HEX2      (hex2),
        .HEX1      (hex1),
        .HEX0      (hex0),
        .LEDR      (ledr),
        .LEDG      (ledg));

  // Reset
  initial
  begin
      reset <= 0; 
		#530; 
		reset <= 1;
  end

  // Clock 
  initial
  begin
      clk <= 0; 
		forever #10 clk <= ~clk;
  end  
      
endmodule
