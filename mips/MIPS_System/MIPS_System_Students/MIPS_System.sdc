# create a base clock for the input of the PLL
create_clock -period 20 -name clk_sys [get_ports CLOCK_50]
# automatically create generated clocks on the output clocks of the PLL
derive_pll_clocks