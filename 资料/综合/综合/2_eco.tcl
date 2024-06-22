set data 030413
set top_design BWN_TOP_ALL
source scripts/dc_setup.tcl
read_ddc ./outputs/${data}/${top_design}.ddc
set upf_create_implicit_supply_sets false
load_upf ./outputs/${dc_date}/${top_design}.upf 
link
source ../5_PT_spi/fix_hold_in_dc.tcl
write -format verilog -hierarchy -output ./outputs/${data}/${top_design}_no_hold.v