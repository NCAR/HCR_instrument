#create_clock -period 2.222 [get_ports aclk]
create_clock -period 2.222 -name aclk [get_ports aclk]
create_clock -period 4.000 -name s_axi_csr_aclk [get_ports s_axi_csr_aclk]
set_clock_groups -name async_clocks1 -asynchronous -group [get_clocks s_axi_csr_aclk] -group [get_clocks aclk]