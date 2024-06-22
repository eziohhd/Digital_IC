transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {MIPS_System.vo}

vlog -vlog01compat -work work +incdir+C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students {C:/Users/ezioh/Desktop/mips/MIPS_System/MIPS_System_Students/MIPS_System_tb.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L gate_work -L work -voptargs="+acc"  MIPS_System_tb

add wave *
view structure
view signals
run 1 sec
