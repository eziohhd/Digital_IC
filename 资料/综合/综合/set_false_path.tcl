# KWS 
set_false_path -from clk       -to  clk_mfcc
set_false_path -from clk_mfcc  -to  clk 

#AVS
set_false_path  -from fpga_clk  -to      avs_clk
set_false_path -from avs_clk  -to      fpga_clk