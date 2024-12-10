#create_clock -period 4.000 -name s_axi_csr_aclk [get_ports s_axi_csr_aclk]
#create_clock -period 4.000 -name clk_in_p [get_ports clk_in_p]
#set_clock_groups -name async_clocks1 -asynchronous -group [get_clocks s_axi_csr_aclk] -group [get_clocks clk_in_p]
create_clock -period 4.000 [get_ports s_axi_csr_aclk]