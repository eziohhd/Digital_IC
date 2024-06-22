#############################################
#     Input file                           #
#############################################

set DESIGN_NAME "AVS_BWN_TOP_ALL"

set NETLIST "/home/soc/wucj/2020-11-Graduation/5-BWN_AVS/y-from_backend/0414/AVS_BWN_TOP_ALL_post_icc2.v"
set SDC "/home/soc/wt/21_postgraduate_project_v2_20200706/a-Signoff/sdc/AVS_BWN_TOP_ALL.ud.sdc"
set UPF "/home/soc/lizy/2021-03-Graduation/1-SYN_top_lvl/outputs/AVS_BWN_TOP_ALL_0402_bn_modify_040215/AVS_BWN_TOP_ALL.upf"
set SPEF "/home/soc/wt/21_postgraduate_project_v2_20200706/a-Signoff/spef/AVS_BWN_TOP_ALL_typ_25c.spef"
set LIB_SETUP "/home/soc/wt/21_postgraduate_project_v2_20200706/a-Signoff/scr/lib_setup.tcl"
set LINK_LIB "/home/soc/wt/21_postgraduate_project_v2_20200706/a-Signoff/link/link_library.lp_ptpx.txt"

##################################################
set SAD "../4_Netlist_sim_all_post_sdf/${DESIGN_NAME}.vcd"   

file copy -force ./main.tcl ./rpt/${run_date}
file copy -force $NETLIST ./rpt/${run_date}

#############################################
#     set the power analysis mode           #
#############################################
#set timing_report_unconstrained_paths true
set power_enable_analysis TRUE
set power_analysis_mode time_based
set power_model_preference nlpm
set auto_wire_load_selection false
set power_clock_network_include_register_clock_pin_power false



#############################################
#    link design                            #
#############################################
#source ../5_PT/scripts/pt_setup.tcl
#source -e -v ./ptpx_setup_tt0p81v25c.tcl
#source -e -v ./ptpx_setup_tt0p5v25c.tcl
#source -e -v "../3_syn_spi/outputs/${dc_date}/link_library.txt"

source $LIB_SETUP 
set search_path "$LIB_PATH"
source $LINK_LIB



read_verilog $NETLIST
current_design $DESIGN_NAME
link

set_wire_load_mode top
#set_wire_load_model      -name zero [current_design]
set auto_wire_load_selection true

#load_upf $UPF
read_parasitics -keep_capacitive_coupling -verbose $SPEF
source -e -v $SDC

# --------------------------------------------------------------
#              for pre-layout STA
# --------------------------------------------------------------

#set_clock_uncertainty -hold 0 [all_clocks]

#set_ideal_network [get_pins u_nn_system/u_pll/FOUTPOSTDIV]
#set_ideal_transition 1.0 [get_pins u_nn_system/u_pll/FOUTPOSTDIV]
#set_ideal_latency 0.5 [get_pins u_nn_system/u_pll/FOUTPOSTDIV]
#
#set_ideal_network [get_pins u_nn_system/u_nn_top/u_sys_clk_l/Z]
#set_ideal_transition 1.0 [get_pins u_nn_system/u_nn_top/u_sys_clk_l/Z]
#set_ideal_latency 0.5 [get_pins u_nn_system/u_nn_top/u_sys_clk_l/Z]
#
#set_ideal_network [get_pins u_nn_system/u_sram_all/u_sram_clk/Z]
#set_ideal_transition 1.0 [get_pins u_nn_system/u_sram_all/u_sram_clk/Z]
#set_ideal_latency 0.5 [get_pins u_nn_system/u_sram_all/u_sram_clk/Z]

set_propagated_clock [all_clocks]


# ----------------------------------------------
#                time
# ----------------------------------------------
#read_vcd -time {323923 3615571} $SAD  -strip_path "${DESIGN_NAME}_tb/u_${DESIGN_NAME}"
read_vcd -time {178420220 181711924} $SAD  -strip_path "${DESIGN_NAME}_tb/u_${DESIGN_NAME}"
#read_vcd -time {225505 4031429} $SAD  -strip_path "${DESIGN_NAME}_tb/u_${DESIGN_NAME}"



################################################
#    analyze   power                           #
################################################
check_power
set_power_analysis_options  -waveform_interval 1 -waveform_format fsdb -waveform_output ./rpt/${run_date}/${DESIGN_NAME} -include top 
update_power
report_power -hierarchy -levels 3 > ./rpt/${run_date}/${DESIGN_NAME}_hie.rpt
report_power -verbose > ./rpt/${run_date}/${DESIGN_NAME}_total.rpt

report_power -hierarchy -levels 2 -sort_by total_power  > ./rpt/${run_date}/${DESIGN_NAME}_hie_level2_sort.rpt
report_power -hierarchy -levels 3 -sort_by total_power  > ./rpt/${run_date}/${DESIGN_NAME}_hie_level3_sort.rpt
report_power -hierarchy -levels 4 -sort_by total_power  > ./rpt/${run_date}/${DESIGN_NAME}_hie_level4_sort.rpt
report_power -hierarchy -levels 5 -sort_by total_power  > ./rpt/${run_date}/${DESIGN_NAME}_hie_level5_sort.rpt

report_power -verbose -cell_power {u_weight_sram u_weight_sram2 u_img_sram u_param_sram u_feature_sram_array} > ./rpt/${run_date}/${DESIGN_NAME}_sram_power.rpt

report_clock_gate_savings -hierarchical -sequential > ./rpt/${run_date}/${DESIGN_NAME}_clock_gate_savings.rpt

#file copy -force mlc_${run_date}.out newPower.out
file copy -force ./rpt/${run_date}/${DESIGN_NAME}_hie.rpt new_hie_power.rpt
file copy -force ./rpt/${run_date}/${DESIGN_NAME}_total.rpt new_total_power.rpt



report_power -verbose -cell_power {u_nn_system/u_sram_all/u_weight_sram u_nn_system/u_sram_all/u_weight_sram2 u_nn_system/u_sram_all/u_img_sram u_nn_system/u_sram_all/u_param_sram u_nn_system/u_sram_all/u_feature_sram_array} > ./rpt/${run_date}/sram_power.rpt

report_power -verbose -cell_power {u_nn_system/u_nn_top/u_in_buf u_nn_system/u_nn_top/u_w_buf u_nn_system/u_nn_top/u_param_buf} > ./rpt/${run_date}/buf_power.rpt

report_power -verbose -cell_power {u_nn_system/u_nn_top u_nn_system/u_sram_all} > ./rpt/${run_date}/core_power.rpt

report_power -verbose -cell_power {u_nn_system} > ./rpt/${run_date}/nn_system_power.rpt



#exit