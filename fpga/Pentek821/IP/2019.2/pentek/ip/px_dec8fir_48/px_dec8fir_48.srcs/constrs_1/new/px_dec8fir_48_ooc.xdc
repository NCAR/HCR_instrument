#create_clock -period 2.220 [get_ports aclk]
create_clock -period 4.000 [get_ports s_axi_csr_aclk]
#set_false_path -from [get_clocks {aclk}] -to [get_clocks {s_axi_csr_aclk}]
#set_false_path -from [get_clocks {s_axi_csr_aclk}] -to [get_clocks {aclk}]