# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "axi_addr_bits" -parent ${Page_0}
  ipgui::add_static_text $IPINST -name "text1" -parent ${Page_0} -text {The AXI Address is in terms of bytes and the CFG MGMT address is in terms of DWORDS.}
  ipgui::add_static_text $IPINST -name "text2" -parent ${Page_0} -text {Any CFG MGMT registers with addresses not reachable by the number of selected address bits will not be accessible. }


}

proc update_PARAM_VALUE.axi_addr_bits { PARAM_VALUE.axi_addr_bits } {
	# Procedure called to update axi_addr_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.axi_addr_bits { PARAM_VALUE.axi_addr_bits } {
	# Procedure called to validate axi_addr_bits
	return true
}


proc update_MODELPARAM_VALUE.axi_addr_bits { MODELPARAM_VALUE.axi_addr_bits PARAM_VALUE.axi_addr_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.axi_addr_bits}] ${MODELPARAM_VALUE.axi_addr_bits}
}

