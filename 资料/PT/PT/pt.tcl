set is_si_enabled true


source -e -v ./scripts/pt_setup_ssg0p5v0c.tcl
file copy -force ./scripts/pt_setup_ssg0p5v0c.tcl  ./rpt/${run_date}

set top_design BWN_TOP_ALL
set dc_date 031710

source -e -v "../3_syn_spi/outputs/${dc_date}/link_library.txt"

###################################################################
read_verilog "../3_syn_spi/outputs/${dc_date}/${top_design}.v"
file copy -force ../3_syn_spi/outputs/${dc_date}/${top_design}.v  ./rpt/${run_date}

current_design $top_design
link

source -e -v "../3_syn_spi/scripts/set_dont_use.tcl"

load_upf ../3_syn_spi/outputs/${dc_date}/${top_design}.upf
source -e -v "../3_syn_spi/outputs/${dc_date}/${top_design}.sdc"


# --------------------------------------------------------------
#              for pre-layout STA
# --------------------------------------------------------------

set_clock_uncertainty -hold 0 [all_clocks]

set_ideal_network [get_pins u_nn_system/u_pll/FOUTPOSTDIV]
set_ideal_transition 1.0 [get_pins u_nn_system/u_pll/FOUTPOSTDIV]
set_ideal_latency 0.5 [get_pins u_nn_system/u_pll/FOUTPOSTDIV]

set_ideal_network [get_pins u_nn_system/u_nn_top/u_sys_clk_l/Z]
set_ideal_transition 1.0 [get_pins u_nn_system/u_nn_top/u_sys_clk_l/Z]
set_ideal_latency 0.5 [get_pins u_nn_system/u_nn_top/u_sys_clk_l/Z]

set_ideal_network [get_pins u_nn_system/u_sram_all/u_sram_clk/Z]
set_ideal_transition 1.0 [get_pins u_nn_system/u_sram_all/u_sram_clk/Z]
set_ideal_latency 0.5 [get_pins u_nn_system/u_sram_all/u_sram_clk/Z]

set_propagated_clock [all_clocks]


set timing_disable_clock_gating_checks false
set timing_report_unconstrained_paths true

group_path -name REGOUT -to [all_outputs]
group_path -name REGIN -from [all_inputs]
group_path -name FEEDTHROUGH -from [all_inputs] -to [all_outputs]


update_timing -full
check_timing -verbose > ./rpt/${run_date}/check_timing.report

# -compress gzip 
write_sdf -version 3.0 -context verilog \
          -no_edge -input_port_nets -output_port_nets \
          -include {SETUPHOLD RECREM} -exclude {checkpins no_condelse} \
           ./outputs/${run_date}/${top_design}.sdf


report_timing -delay max -max_paths 10000 -path_type full_clock_expanded -nosplit -slack_lesser_than 100 -voltage -sort_by slack -significant_digits 4    > ./rpt/${run_date}/timing_max_path.rpt
report_timing -delay min -max_paths 10000 -path_type full_clock_expanded -nosplit -slack_lesser_than 100 -voltage -sort_by slack -significant_digits 4    > ./rpt/${run_date}/timing_min_path.rpt
report_timing -delay max -max_paths 10000 -slack_lesser_than 100 -significant_digits 4 -nosplit -path_type end -sort_by slack  > ./rpt/${run_date}/dff_end_max.rpt
report_timing -delay min -max_paths 10000 -slack_lesser_than 100 -significant_digits 4 -nosplit -path_type end -sort_by slack  > ./rpt/${run_date}/dff_end_min.rpt

#write_spice_deck -output ./critical_path_sp/critical_path.sp -header header.sp -sub_circuit_file ../library.sp -logic_zero_name VSS  -logic_one_name VDD [get_timing_paths -max_paths 1 ]

report_constraint -all_vio -significant_digits 4 -nosplit > ./rpt/${run_date}/all_vio.rpt
#save_session  ./${top_design}_${PVT}.session
