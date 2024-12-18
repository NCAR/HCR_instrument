#create_clock -period 4.000 -name s_axi_csr_aclk [get_ports s_axi_csr_aclk]
create_clock -period 2.222 -name clk_in_p [get_ports clk_in_p]
#set_clock_groups -name async_clocks1 -asynchronous -group [get_clocks s_axi_csr_aclk] -group [get_clocks clk_in_p]
create_clock -period 4.000 [get_ports s_axi_csr_aclk]


set_property ASYNC_REG true [get_cells t2_count_good_tc_reg]
set_property ASYNC_REG true [get_cells t3_count_good_tc_reg]
create_clock -period 5.000 -name refclk -waveform {0.000 2.500} [get_ports refclk]
create_generated_clock -name I0 -source [get_ports s_axi_csr_aclk] -divide_by 2 [get_pins keep_alive_clock_reg/Q]
set_clock_groups -logically_exclusive -group [get_clocks -include_generated_clocks I0] -group [get_clocks -include_generated_clocks clk_in_p]
set_clock_groups -asynchronous -group [get_clocks refclk] -group [get_clocks I0]
set_clock_groups -asynchronous -group [get_clocks refclk] -group [get_clocks clk_in_p]
set_clock_groups -asynchronous -group [get_clocks s_axi_csr_aclk] -group [get_clocks clk_in_p]
set_clock_groups -asynchronous -group [get_clocks clk_in_p] -group [get_clocks s_axi_csr_aclk]
