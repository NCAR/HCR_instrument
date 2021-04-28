create_clock -period 4.000 -name s_axi_csr_aclk [get_ports s_axi_csr_aclk]
create_clock -period 3.125 -name tx_core_clk [get_ports tx_core_clk]
create_clock -period 2.500 -name dac_sample_clk [get_ports dac_sample_clk]

set_clock_groups -name async_clocks1 -asynchronous -group [get_clocks -include_generated_clocks s_axi_csr_aclk] -group [get_clocks -include_generated_clocks tx_core_clk] -group [get_clocks -include_generated_clocks dac_sample_clk] 