# -----------------------------------------------------------------------
#                    ssg0p5v0c
# -----------------------------------------------------------------------

set_target_library_subset -top "\
	tcbn28hpcplusbwp7t35p140ssg0p81v0c_ccs.db   \
	tcbn28hpcplusbwp7t35p140ssg0p5v0p81v0c_ccs.db \
											"

#set_target_library_subset -object_list [remove_from_collection  [get_cells *] {u_pll u_img_sram u_weight_sram u_weight_sram2 u_param_sram}] "tcbn28hpcplusbwp7t35p140ssg0p81v0c_ccs.db"

set_target_library_subset "tcbn28hpcplusbwp7t35p140ssg0p81v0c_ccs.db" -object_list [get_cells {u_nn_system/u_pll_avs_config u_nn_system/u_spi_chip_rx u_nn_system/u_spi_chip_tx u_nn_system/u_cdc_s2f u_nn_system/u_cdc_f2s}] 


set_target_library_subset "tcbn28hpcplusbwp7t35p140ssg0p72v0c_ccs.db tcbn28hpcplusbwp7t35p140ssg0p5v0p72v0c_ccs.db" -object_list [get_cells {u_nn_system/u_sram_all}]

set_target_library_subset "tcbn28hpcplusbwp7t35p140ssg0p5v0c_ccs.db" -object_list [get_cells {u_nn_system/u_nn_top}] 

#EHVT acc_v3
set_target_library_subset "tcbn28hpcplusbwp7t40p140ehvttt0p5v0c_ccs.db" -object_list [get_cells {u_nn_system/u_nn_top/u_pe_array/u_pe_*/u_acc/u_acc_*_latch_*}]


# -----------------------------------------------------------------------
#                    ssg0p81vm40c
# -----------------------------------------------------------------------

#set_target_library_subset -top "\
#	tcbn28hpcplusbwp7t35p140ssg0p81vm40c_ccs.db \
#	tcbn28hpcplusbwp7t35p140ssg0p81v0p81vm40c_ccs.db \
#																"
##EHVT acc_v3
#set_target_library_subset -object_list "u_nn_top/u_pe_array/u_pe_*/u_acc/u_acc_*_latch_*" "tcbn28hpcplusbwp7t40p140ehvtssg0p81vm40c_ccs.db"



#set_target_library_subset -object_list "u_avs_top_all/*" "tcbn28hpcplusbwp7t35p140ssg0p81vm40c_ccs.db"
#set_target_library_subset -object_list [get_cells u_avs_top_all/*] "tcbn28hpcplusbwp7t35p140ssg0p81vm40c_ccs.db"
#set_target_library_subset -object_list [remove_from_collection  [get_cells u_avs_top_all/*] [get_cells u_avs_top_all/u_pll]] "tcbn28hpcplusbwp7t35p140ssg0p81vm40c_ccs.db"
#set_target_library_subset -object_list "u_nn_top/*" "tcbn28hpcplusbwp7t35p140ssg0p5vm40c_ccs_M20.db"


#set_target_library_subset -object_list "u_avs_top_all/u_avs_top_hat" "tcbn28hpcplusbwp7t35p140ssg0p5vm40c_ccs_M20.db"

#EHVT
#set_target_library_subset -object_list "u_nn_top/u_pe_array/u_pe_*/u_acc" "tcbn28hpcplusbwp7t40p140ehvttt0p5vm40c_ccs.db"
#HVT
#set_target_library_subset -object_list "u_nn_top/u_pe_array/u_pe_*/u_acc" "tcbn28hpcplusbwp7t30p140hvtssg0p5vm40c_ccs_M20C.db"
																#
#EHVT acc_v2
#set_target_library_subset -object_list "u_nn_top/u_pe_array/u_pe_*/u_acc/u_acc_*_reg_*" "tcbn28hpcplusbwp7t40p140ehvttt0p5vm40c_ccs.db"

#EHVT acc_v3
#set_target_library_subset -object_list "u_nn_top/u_pe_array/u_pe_*/u_acc" "tcbn28hpcplusbwp7t40p140ehvttt0p5vm40c_ccs.db"
#set_target_library_subset -object_list "u_nn_top/u_pe_array/u_pe_*/u_acc/u_acc_*_latch_*" "tcbn28hpcplusbwp7t40p140ehvttt0p5v0c_ccs.db"
#set_target_library_subset -object_list "u_nn_top/u_pe_array/u_pe_*/u_acc/u_acc_reg" "tcbn28hpcplusbwp7t40p140ehvttt0p5vm40c_ccs.db"
#set_target_library_subset -object_list "u_nn_top/u_pe_array/u_pe_*/u_acc/u_ICG_*" "tcbn28hpcplusbwp7t40p140ehvttt0p5vm40c_ccs.db"
#

# EHVT feature_sram
#set_target_library_subset -object_list "u_feature_sram_array/u_feature_sram_*/*array*" "tcbn28hpcplusbwp7t40p140ehvttt0p5vm40c_ccs.db"
#