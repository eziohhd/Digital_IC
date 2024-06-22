transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/fiftyfivenm_ver
vmap fiftyfivenm_ver ./verilog_libs/fiftyfivenm_ver
vlog -vlog01compat -work fiftyfivenm_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/fiftyfivenm_atoms.v}
vlog -vlog01compat -work fiftyfivenm_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/mentor/fiftyfivenm_atoms_ncrypt.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students {C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/MIPS_System.v}
vlog -vlog01compat -work work +incdir+C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/MIPS_CPU {C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/MIPS_CPU/mips.v}
vlog -vlog01compat -work work +incdir+C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/MIPS_CPU {C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/MIPS_CPU/mipsparts.v}
vlog -vlog01compat -work work +incdir+C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/Alera_Mem_Dual_Port {C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/Alera_Mem_Dual_Port/ram2port_inst_data.v}
vlog -vlog01compat -work work +incdir+C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/Decoder {C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/Decoder/Addr_Decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/GPIO {C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/GPIO/GPIO.v}
vlog -vlog01compat -work work +incdir+C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/Timer {C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/Timer/TimerCounter.v}
vlog -vlog01compat -work work +incdir+C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/Altera_PLL {C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/Altera_PLL/ALTPLL_clkgen.v}
vlog -vlog01compat -work work +incdir+C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/db {C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/db/altpll_clkgen_altpll.v}

vlog -vlog01compat -work work +incdir+C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students {C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/MIPS_System_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  MIPS_System_tb

add wave *
view structure
view signals
run 1 sec
