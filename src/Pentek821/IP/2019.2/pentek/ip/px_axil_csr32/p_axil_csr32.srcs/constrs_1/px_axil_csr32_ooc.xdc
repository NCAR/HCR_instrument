#create_clock -period 4.000 -name s_axi_csr_aclk [get_ports s_axi_csr_aclk]
create_clock -period 4.000 [get_ports s_axi_csr_aclk]