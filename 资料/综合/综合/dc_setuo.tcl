define_design_lib work -path ./elab
history keep 500
set enable_page_mode false
set sh_enable_page_mode false
set compile_seqmap_identify_shift_registers false
set compile_seqmap_identify_shift_registers_with_synchronous_logic false
set timing_enable_multiple_clocks_per_reg true
set compile_timing_high_effort true
# avoid regs to be removed
#set compile_seqmap_propagate_constants false

set lib_40lp_path " \
									/projects/soc/TECHLIB/TSMC/28nm/T28/tcbn28hpcplusbwp7t35p140_180b/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcbn28hpcplusbwp7t35p140_180a  \
									/projects/soc/TECHLIB/TSMC/28nm/T28/tcbn28hpcplusbwp7t40p140ehvt_170a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcbn28hpcplusbwp7t40p140ehvt_170a \
									/home/soc/wucj/2020-01-KWS_AVS_v1-Backend/g-PLL/PLLTS28HPMLAINT/db  \
									/projects/soc/TECHLIB/TSMC/28nm/TSMC28HPC+/IO/tphn28hpcpgv18_170a/AN61001_20171009/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tphn28hpcpgv18_170a \
									\
									/home/soc/lumy17/2020-03-29_debug/bcwj/bc_0413/lib_setup_KWS/db/std/wcl_ud \
									/home/soc/wucj/2020-01-KWS_AVS_v1-Backend/lib_setup/db/pmk/wcl_ud \
									\
									/home/soc/wt/21_postgraduate_project_v2_20200706/0_MC/ssg_0p72v_0p72v_0c  \
									/home/soc/wt/21_postgraduate_project_v2_20200706/0_MC/ssg_0p81v_0p81v_m40c   \
									/home/soc/wucj/2020-11-Graduation/0-lib_setup/7t30p_hvt \
									/home/soc/wucj/2020-11-Graduation/0-lib_setup/7t35p_svt \
									/home/soc/wucj/2020-11-Graduation/0-lib_setup/7t40p_ehvt \
									"


set search_path       " . $lib_40lp_path  \
                       "

# -------------------------------------------------------------------
#                        ss0p5v0c,ssg0p72v0c 
# -------------------------------------------------------------------

set target_library   "  \
	tcbn28hpcplusbwp7t35p140ssg0p5v0c_ccs.db \
	tcbn28hpcplusbwp7t40p140ehvttt0p5v0c_ccs.db \
	tcbn28hpcplusbwp7t35p140ssg0p72v0c_ccs.db \
	tcbn28hpcplusbwp7t35p140ssg0p81v0c_ccs.db \
	tcbn28hpcplusbwp7t35p140ssg0p5v0p72v0c_ccs.db  \
	tcbn28hpcplusbwp7t35p140ssg0p5v0p81v0c_ccs.db \
	\
"

# -------------------------------------------------------------------
#                        ss0p81vm40c
# -------------------------------------------------------------------

#set target_library   "  \
#	tcbn28hpcplusbwp7t35p140ssg0p81vm40c_ccs.db \
#	tcbn28hpcplusbwp7t35p140ssg0p81v0p81vm40c_ccs.db \
#	tcbn28hpcplusbwp7t40p140ehvtssg0p81vm40c_ccs.db \
#	"



# -------------------------------------------------------------------
#                        ss0p5vm40c  
# -------------------------------------------------------------------

#set target_library   "  \
#	tcbn28hpcplusbwp7t35p140ssg0p5vm40c_ccs_M20.db \
#	tcbn28hpcplusbwp7t35p140ssg0p5v0p81vm40c_ccs.db \
#	tcbn28hpcplusbwp7t35p140ssg0p81vm40c_ccs.db \
#	tcbn28hpcplusbwp7t40p140ehvttt0p5vm40c_ccs.db \
#	\
#	"
# tcbn28hpcplusbwp7t30p140hvtssg0p5vm40c_ccs_M20C.db \
#	tcbn28hpcplusbwp7t40p140ehvttt0p5vm40c_ccs.db \








# -------------------------------------------------------------------
#                        SRAM:ss0p81vm40c
# -------------------------------------------------------------------


#set synthetic_library "dw_foundation.sldb"
#set link_library      " * \
#	           	$target_library \
#             	$synthetic_library\
#							img_sram_ssg_0p81v_0p81v_m40c.db \
#							param_sram_ssg_0p81v_0p81v_m40c.db \
#							weight_sram_ssg_0p81v_0p81v_m40c.db \
#							weight_sram2_ssg_0p81v_0p81v_m40c.db \
#							feature_sram_ssg_0p81v_0p81v_m40c.db \
#																							"

# -------------------------------------------------------------------
#                        SRAM:ss0p72v0c
# -------------------------------------------------------------------


set synthetic_library "dw_foundation.sldb"
set link_library      " * \
	           	$target_library \
             	$synthetic_library\
							img_sram_ssg_0p72v_0p72v_0c.db \
							param_sram_ssg_0p72v_0p72v_0c.db \
							weight_sram_ssg_0p72v_0p72v_0c.db \
							weight_sram2_ssg_0p72v_0p72v_0c.db \
							feature_sram_ssg_0p72v_0p72v_0c.db \
							PLLTS28HPMLAINT_SS_0P81_0C.db  \
							tphn28hpcpgv18ssg0p81v1p62v0c.db \
																							"
