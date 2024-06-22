###################### clk
set_dont_touch [get_cells u_nn_system/u_nn_top/u_sys_clk_l]
set_dont_touch [get_cells u_nn_system/u_sram_all/u_sram_clk]

###################### acc latch
set_dont_touch [get_cells u_nn_system/u_nn_top/u_pe_array/u_pe*/u_acc/u_acc*latch*]

###################### acc ICG
set_dont_touch [get_cells u_nn_system/u_nn_top/u_pe_array/u_pe*/u_acc/u_ICG_*]