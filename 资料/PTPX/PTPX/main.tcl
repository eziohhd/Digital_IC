#############################################
#     Input file                           #
#############################################

set DESIGN_NAME "KWS_system"
set dc_date 1209_17

set NETLIST  "/home/soc/zhulx19/d-graduation/5-KWS/3-SYN/outputs/0305_2140/KWS_system_no_hold.v"
set SDC      "/home/soc/zhulx19/d-graduation/5-KWS/3-SYN/outputs/0305_2140/KWS_system.sdc"
set LINKLIB "/home/soc/zhulx19/d-graduation/5-KWS/3-SYN/outputs/0305_2140/link_library.txt"
# set UPF "../3_syn//outputs/${dc_date}/${DESIGN_NAME}.upf"

##################################################
set SAD "/local/zhulx19/KWS/KWS.vcd"  

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
source -e -v ./ptpx_setup_tt0p5v25c.tcl
source -e -v $LINKLIB

read_verilog $NETLIST
current_design $DESIGN_NAME
link

set_wire_load_mode top
#set_wire_load_model      -name zero [current_design]
set auto_wire_load_selection true

# load_upf $UPF
source -e -v $SDC
# all nn
# read_vcd -time {503437500 535437500} $SAD  -strip_path "NN_tb/u_NN"
# read_vcd -time {6332187500 9212187500} $SAD  -strip_path "KWS_system_tb/U_KWS_SYSTEM_0"
read_vcd -time {3800250000 3815937500} $SAD  -strip_path "KWS_system_tb/U_KWS_SYSTEM_0"
# conv2,20MHz
#read_vcd -time {515679 1186493} $SAD  -strip_path "${DESIGN_NAME}_tb/u_${DESIGN_NAME}"
# conv2,10MHz
#read_vcd -time {1031360 2372968} $SAD  -strip_path "${DESIGN_NAME}_tb/u_${DESIGN_NAME}"



################################################
#    analyze   power                           #
################################################
check_power
# set_power_analysis_options  -waveform_interval 1 -waveform_format fsdb -waveform_output ./rpt/${run_date}/${DESIGN_NAME} -include top 
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


#exit