create_clock -period 4.000 -name aclk [get_ports aclk]
create_clock -period 3.333 -name axis_ddr_aclk [get_ports axis_ddr_aclk]
set_clock_groups -asynchronous -group [get_clocks aclk] -group [get_clocks axis_ddr_aclk]
set_clock_groups -asynchronous -group [get_clocks axis_ddr_aclk] -group [get_clocks aclk]