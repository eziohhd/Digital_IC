# -----------------------------------------------------------------------
#                           Variables
# -----------------------------------------------------------------------

set ALL_IN_EX_CLK [remove_from_collection [all_inputs] [get_ports pad_BWN_fpga_clk]]

set ALL_EX_OUT          [remove_from_collection [current_design] [all_outputs]]
set ALL_EX_OUT_IN       [remove_from_collection $ALL_EX_OUT [all_inputs]]



set     OUT_LOAD                        0.2

set     MAX_FANOUT                      20
set     MAX_CAP                         0.4
set     MAX_TRAN                        2.0
set     FPGA_CLK_PERIOD                         100
set     SYS_CLK_PERIOD                          50 




# -----------------------------------------------------------------------
#                           Design constraints
# -----------------------------------------------------------------------
#
#clk posedge start at 0, end at 5
create_clock -name pad_BWN_fpga_clk -period $FPGA_CLK_PERIOD [get_ports pad_BWN_fpga_clk]
create_clock -name sys_clk -period $SYS_CLK_PERIOD [get_pins u_nn_system/u_pll/FOUTPOSTDIV]


create_generated_clock -name sys_clk_l [get_pins u_nn_system/u_nn_top/u_sys_clk_l/Z] \
				 -master_clock [get_clocks {sys_clk}]\
				 -source [get_pins u_nn_system/u_pll/FOUTPOSTDIV]\
				 -edges {1 2 3} -combinational -add

set_ideal_network [get_pins u_nn_system/u_nn_top/u_sys_clk_l/Z]
set_ideal_transition 1.0 [get_pins u_nn_system/u_nn_top/u_sys_clk_l/Z]
set_ideal_latency 0.5 [get_pins u_nn_system/u_nn_top/u_sys_clk_l/Z]

create_generated_clock -name sram_clk [get_pins u_nn_system/u_sram_all/u_sram_clk/Z] \
				 -master_clock [get_clocks {sys_clk}]\
				 -source [get_pins u_nn_system/u_pll/FOUTPOSTDIV]\
				 -edges {1 2 3} -combinational -add

set_clock_group -name fpga_sys_group -asynchronous \
 -group [get_clocks {pad_BWN_fpga_clk}] \
 -group [get_clocks {sys_clk sys_clk_l sram_clk}]

set_ideal_network [get_pins u_nn_system/u_sram_all/u_sram_clk/Z]
set_ideal_transition 1.0 [get_pins u_nn_system/u_sram_all/u_sram_clk/Z]
set_ideal_latency 0.5 [get_pins u_nn_system/u_sram_all/u_sram_clk/Z]

set_clock_uncertainty  -setup 5.0       [get_clocks pad_BWN_fpga_clk]
set_clock_uncertainty  -hold 0.5       [get_clocks pad_BWN_fpga_clk]

set_clock_uncertainty  -setup 5.0       [get_clocks sys_clk]
set_clock_uncertainty  -hold 0.5       [get_clocks sys_clk]

set_clock_uncertainty  -setup 5.0       [get_clocks sys_clk_l]
set_clock_uncertainty  -hold 0.5       [get_clocks sys_clk_l]

set_clock_uncertainty  -setup 5.0       [get_clocks sram_clk]
set_clock_uncertainty  -hold 0.5       [get_clocks sram_clk]



set_clock_transition   1.0       [all_clocks]
set_clock_latency -source 1.0    [get_clocks pad_BWN_fpga_clk]
set_clock_latency 1.0            [get_clocks pad_BWN_fpga_clk]


#io

set_input_delay   [expr $FPGA_CLK_PERIOD * 0.4] -clock pad_BWN_fpga_clk $ALL_IN_EX_CLK  -add_delay
set_input_delay   [expr $SYS_CLK_PERIOD * 0.4] -clock sys_clk [get_ports pad_BWN_sys_rstn]  -add_delay
set_output_delay  [expr $FPGA_CLK_PERIOD * 0.6] -clock pad_BWN_fpga_clk [all_outputs] -add_delay
set_input_transition   1.0   $ALL_IN_EX_CLK

# -----------------------------------------------------------------------
#                           Environmental constraints
# -----------------------------------------------------------------------

#set_drive 0 {clk}
#set_driving_cell -lib_cell BUFFD2BWP30P140 -pin Z $ALL_IN_EX_CLK

set_load $OUT_LOAD [all_outputs]


# -----------------------------------------------------------------------
#                                DRC rule
# -----------------------------------------------------------------------

set_max_transition      $MAX_TRAN               $ALL_EX_OUT_IN 
set_max_fanout          $MAX_FANOUT             $ALL_EX_OUT_IN
set_max_capacitance     $MAX_CAP                $ALL_EX_OUT_IN
