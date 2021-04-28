#create_clock -period 2.000 [get_ports s_axis_aclk]
create_clock -period 4.000 [get_ports s_axi_csr_aclk]
#set_clock_groups -name async_clocks1 -asynchronous -group [get_clocks s_axi_csr_aclk] -group [get_clocks s_axis_aclk]