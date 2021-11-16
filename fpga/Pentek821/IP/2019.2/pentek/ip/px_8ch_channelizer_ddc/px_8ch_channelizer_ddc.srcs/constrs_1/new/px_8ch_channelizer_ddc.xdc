set_clock_groups -asynchronous -group [get_clocks s_axi_csr_aclk] -group [get_clocks axis_aclk]
set_clock_groups -asynchronous -group [get_clocks axis_aclk] -group [get_clocks s_axi_csr_aclk]
create_clock -period 4.000 -name s_axi_csr_aclk -waveform {0.000 2.000} [get_ports s_axi_csr_aclk]
create_clock -period 3.300 -name axis_aclk -waveform {0.000 1.65} [get_ports axis_aclk]