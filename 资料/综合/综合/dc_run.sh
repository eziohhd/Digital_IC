#! /bin/sh
log_date=$(date +%m%d%H)
if [ ! -d "outputs" ];then
	mkdir outputs
fi
if [ ! -d "rpt" ];then
	mkdir rpt
fi
if [ ! -d "log" ];then
	mkdir log
fi
mkdir outputs/$log_date
mkdir rpt/$log_date
#/usr/eda/synopsys/syn_J201409SP3/bin/dc_shell-t -f ./scripts/core.tcl -x "set data ${log_date}" | tee ./log/core_${log_date}.log
/usr/eda/synopsys/syn_M-2016.12-SP2/bin/dc_shell-t -f ./scripts/core.tcl -x "set data ${log_date}" | tee ./log/core_${log_date}.log
