create_clock -period 4.000 -name s_axi_csr_aclk -waveform {0.000 2.000} [get_ports s_axi_csr_aclk]
create_clock -period 1.563 -name s_axis_aclk -waveform {0.000 0.782} [get_ports s_axis_aclk]
set_clock_groups -asynchronous -group [get_clocks s_axis_aclk] -group [get_clocks s_axi_csr_aclk]
set_clock_groups -asynchronous -group [get_clocks s_axi_csr_aclk] -group [get_clocks s_axis_aclk]
