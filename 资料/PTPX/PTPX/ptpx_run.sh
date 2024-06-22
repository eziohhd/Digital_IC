#!/bin/sh
log_date=$(date +%m%d)_$(date +%H)

if [ ! -d "rpt" ];then
	mkdir rpt
fi

mkdir rpt/${log_date}

#/usr/eda/synopsys/pts_M-2017.06-SP1/bin/pt_shell -f main.tcl -x "set run_date ${log_date}" | tee power.log
#/usr/eda/synopsys/pts_K-2015.12-SP3/bin/pt_shell -f main.tcl -x "set run_date ${log_date}" | tee power.log
/usr/eda/synopsys/pts_M-2016.12-SP2/bin/pt_shell -f main.tcl -x "set run_date ${log_date}" | tee power.log