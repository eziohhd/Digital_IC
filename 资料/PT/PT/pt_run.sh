#!/bin/sh
pro=nn_top
#pvt=ssg0p81v125c
log_date=$(date +%m%d)_$(date +%H)

if [ ! -d "rpt" ];then
	mkdir rpt
fi

if [ ! -d "logs" ];then
	mkdir logs
fi

if [ ! -d "outputs" ];then
	mkdir outputs
fi

#mkdir ./logs/${log_date}
mkdir ./outputs/${log_date}
mkdir ./rpt/${log_date}

#mkdir ./solve_txt/$log_date
/usr/eda/synopsys/pts_M-2017.06-SP1/bin/pt_shell -f ./scripts/pt.tcl -x "set run_date ${log_date}" | tee ./logs/${pro}_${log_date}.log	

