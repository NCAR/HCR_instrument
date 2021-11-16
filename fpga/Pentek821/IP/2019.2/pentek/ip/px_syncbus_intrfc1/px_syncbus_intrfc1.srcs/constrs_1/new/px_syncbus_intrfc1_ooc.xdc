#create_clock -period 4.000 -name s_axi_csr_aclk [get_ports s_axi_csr_aclk]
#create_clock -period 4.000 -name sample_clk [get_ports sample_clk]
#set_clock_groups -name async_clocks1 -asynchronous -group [get_clocks s_axi_csr_aclk] -group [get_clocks sample_clk]
create_clock -period 4.000 [get_ports s_axi_csr_aclk]