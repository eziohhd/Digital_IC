# set_disable_timing [get_cells u_kws_system/u_kws_top/u_post_top/u*_mem*/memrow*] -from D -to Q

# u_acc_even_latch_3/dout_reg_10_/D (LHQD1BWP7T40P140EHVT)
# u_acc_even_latch_3/dout_reg_10_/Q (LHQD1BWP7T40P140EHVT)
# u_nn_top/u_pe_array/u_pe_*/u_acc/u_ICG_*

set_disable_timing [get_cells u_nn_system/u_nn_top/u_pe_array/u_pe_*/u_acc/u_acc_*_latch_*/u_LHQD*] -from D -to Q
set_disable_timing [get_cells u_nn_system/u_nn_top/u_pe_array/u_pe_*/u_acc/u_acc_*_latch_*/u_LHQD*] -from E -to Q

# array_4__u_LHQD_row_5_
#set_disable_timing [get_cells u_feature_sram_array/u_feature_sram_*/array_*__u_LHQD_row*] -from E -to Q
#set_disable_timing [get_cells u_feature_sram_array/u_feature_sram_*/array_*__u_LHQD_row*] -from D -to Q

#set_disable_timing [get_flat_cells "u_feature_sram_array/u_feature_sram_*/*array*/u_LHQD*"] -from E -to Q
#set_disable_timing [get_flat_cells "u_feature_sram_array/u_feature_sram_*/*array*/u_LHQD*"] -from D -to Q

 