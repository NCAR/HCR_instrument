#create_clock -period 4.000 -name aclk -waveform {0.000 2.000} [get_ports aclk]
#create_clock -period 4.000 -name s_axi_csr_aclk -waveform {0.000 2.000} [get_ports s_axi_csr_aclk]
create_clock -period 4.000 [get_ports s_axi_csr_aclk]