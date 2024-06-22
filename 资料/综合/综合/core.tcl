set TOP_MODULE   BWN_TOP_ALL

set compile_enable_register_merging    true
# avoid regs to be removed
set compile_seqmap_propagate_constants true
set verilogout_no_tri   "true"
set verilogout_equation "false"
set mv_default_level_shifter_voltage_range_infinity true
set compile_timing_high_effort "true"

source -e -v ./scripts/dc_setup.tcl
file copy -force ./scripts/dc_setup.tcl  ./outputs/$data


set change_names_dont_change_bus_members      true
set compile_disable_hierarchical_inverter_opt true
set auto_insert_level_shifters_on_clocks      all
set auto_insert_level_shifters true


analyze -format verilog ./flist.v  -define DC_SYN
elaborate       $TOP_MODULE
current_design  $TOP_MODULE
link

###
source -e -v ./scripts/constraints.tcl
file copy -force ./scripts/constraints.tcl  ./outputs/$data
source -e -v ./scripts/set_target_library_subset.tcl

report_clock
check_design > ./rpt/check_deisgn.rpt
check_timing  > ./rpt/check_timing.rpt

set_clock_gating_style \
                     -setup 0.3 \
                     -hold 0 \
                     -pos integrated \
                     -neg integrated \
                     -max_fanout 32 \
                     -control_point before \
                     -control_signal scan_enable

#insert_clock_gating



source -e -v ./scripts/set_dont_touch_cell.tcl
#source -e -v ./scripts/set_false_path.tcl
source -e -v ./scripts/set_dont_use.tcl


check_timing
###set_max_area 0
group_path -name INPUT_GROUP -from [all_inputs ]
group_path -name OUTPUT_GROUP -to  [all_outputs]
#
#source -e -v ./scripts/operation_conditions.tcl
#
#
source -e -v ./scripts/kws_disable_timing.tcl
set upf_create_implicit_supply_sets false
load_upf ./nn_system_spi_v3.upf
set_voltage -object_list {VDD_core_net} 0.5
set_voltage -object_list {VDD_top_net} 0.81
set_voltage -object_list {VDD_sram_net} 0.72
set_voltage -object_list VSS_top_net 0

set_fix_multiple_port_nets -all -buffer_constants
set_fix_multiple_port_nets -all -buffer_constants [all_designs]

compile_ultra -no_autoungroup  -no_boundary_optimization  -gate_clock
#compile_ultra -timing_high_effort_script -no_autoungroup  -no_boundary_optimization  -gate_clock
##compile_ultra -timing_high_effort_script -no_autoungroup  -no_boundary_optimization -incremental


set verilogout_no_tri   "true"
set verilogout_equation "false"


#define_name_rules  myrule -type net -allowed "0-9" -first_restricted "_ 0-9 N" -replacement_char "0-9" -prefix "n"
#change_names -rules myrule -verbose



change_names -hier -rules verilog


#write_sdf -version 2.1                   ./outputs/$data/${TOP_MODULE}.sdf
write_sdc                                ./outputs/$data/${TOP_MODULE}.sdc
write -format ddc     -hierarchy -output ./outputs/$data/${TOP_MODULE}.ddc
write -format verilog -hierarchy -output ./outputs/$data/${TOP_MODULE}.v

write_link_library -out                               ./outputs/$data/link_library.txt

####### shiyu ##########################################
save_upf                                               ./outputs/$data/${TOP_MODULE}.upf
report_power_domain [get_power_domains * -hierarchical] > ./rpt/$data/${TOP_MODULE}_final_power_domain.rpt
report_supply_net [get_supply_nets *]                     > ./rpt/$data/${TOP_MODULE}_final_supple_net.rpt
report_level_shifter -domain [get_power_domains * -hierarchical] > ./rpt/$data/${TOP_MODULE}_final_level_shifter.rpt
#report_pst                                                   > ./rpt/$data/${TOP_MODULE}_final_pst.rpt
#########################################################



#############################################################################333333333
report_constraint -all_vio > ./rpt/$data/constrant.rpt
report_area   -hier        > ./rpt/$data/area.rpt
report_constraint  -all_violators                         > ./rpt/$data/${TOP_MODULE}_constraint_all_violators.rpt
check_timing                                              > ./rpt/$data/${TOP_MODULE}_check_timing_final.rpt
report_timing_requirements                                > ./rpt/$data/${TOP_MODULE}_report_timing_requirements.rpt
report_timing -transition_time -nets -attributes -nosplit > ./rpt/$data/${TOP_MODULE}_mapped_timing.rpt
report_area -physical -nosplit -hierarchy                 > ./rpt/$data/${TOP_MODULE}_mapped_area.rpt
report_power                                              > ./rpt/$data/${TOP_MODULE}_power.rpt
report_cell                                               > ./rpt/$data/${TOP_MODULE}_cell.rpt
#report_timing  -delay max -max_paths 50                   > ./rpt/$data/${TOP_MODULE}_timing_max_path.rpt
report_timing  -delay max -path_type full_clock_expanded -sort_by slack -max_paths 50 -nosplit                   > ./rpt/$data/${TOP_MODULE}_timing_max_path.rpt
report_timing  -delay min -path_type full_clock_expanded -sort_by slack -max_paths 50 -nosplit                   > ./rpt/$data/${TOP_MODULE}_timing_min_path.rpt
report_reference                                          > ./rpt/$data/${TOP_MODULE}_ref.rpt

report_power -hierarchy -levels 3                         > ./rpt/$data/${TOP_MODULE}_hie_power.rpt
report_power -verbose                                     > ./rpt/$data/${TOP_MODULE}_total_power.rpt
report_clock_gating -gated -verbose                       > ./rpt/$data/${TOP_MODULE}_clock_gating_gated.rpt
report_clock_gating -ungated -verbose                     > ./rpt/$data/${TOP_MODULE}_clock_gating_ungated.rpt
