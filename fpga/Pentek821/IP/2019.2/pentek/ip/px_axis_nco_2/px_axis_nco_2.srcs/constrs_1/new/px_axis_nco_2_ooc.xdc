create_clock -period 2.222 -name aclk -waveform {0.000 1.111} [get_ports aclk]
create_clock -period 4.000 -name s_axi_csr_aclk -waveform {0.000 2.000} [get_ports s_axi_csr_aclk]
set_clock_groups -asynchronous -group [get_clocks s_axi_csr_aclk] -group [get_clocks aclk]
