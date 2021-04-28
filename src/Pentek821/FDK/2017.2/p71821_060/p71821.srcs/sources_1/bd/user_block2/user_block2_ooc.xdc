################################################################################

# This XDC is used only for OOC mode of synthesis, implementation
# This constraints file contains default clock frequencies to be used during
# out-of-context flows such as OOC Synthesis and Hierarchical Designs.
# This constraints file is not used in normal top-down synthesis (default flow
# of Vivado)
################################################################################
create_clock -name s_axis_adc_pdti_aclk -period 5 [get_ports s_axis_adc_pdti_aclk]
create_clock -name s_axi_csr_aclk -period 4 [get_ports s_axi_csr_aclk]
create_clock -name s_axis_dac_pdti_aclk -period 4 [get_ports s_axis_dac_pdti_aclk]

################################################################################