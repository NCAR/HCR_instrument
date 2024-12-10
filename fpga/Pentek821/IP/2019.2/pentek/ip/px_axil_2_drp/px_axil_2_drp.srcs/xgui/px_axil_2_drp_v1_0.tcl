# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "axi_addr_bits" -parent ${Page_0}
  ipgui::add_param $IPINST -name "drp_addr_bits" -parent ${Page_0}
  ipgui::add_param $IPINST -name "drp_bytes" -parent ${Page_0} -widget comboBox
  ipgui::add_static_text $IPINST -name "txt" -parent ${Page_0} -text {AXI Address (n-1 downto 2) translates to DRP Address (n-3 downto 0). Any upper excess address bits in AXI address are ignored.}


}

proc update_PARAM_VALUE.axi_addr_bits { PARAM_VALUE.axi_addr_bits } {
	# Procedure called to update axi_addr_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.axi_addr_bits { PARAM_VALUE.axi_addr_bits } {
	# Procedure called to validate axi_addr_bits
	return true
}

proc update_PARAM_VALUE.drp_addr_bits { PARAM_VALUE.drp_addr_bits } {
	# Procedure called to update drp_addr_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.drp_addr_bits { PARAM_VALUE.drp_addr_bits } {
	# Procedure called to validate drp_addr_bits
	return true
}

proc update_PARAM_VALUE.drp_bytes { PARAM_VALUE.drp_bytes } {
	# Procedure called to update drp_bytes when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.drp_bytes { PARAM_VALUE.drp_bytes } {
	# Procedure called to validate drp_bytes
	return true
}


proc update_MODELPARAM_VALUE.axi_addr_bits { MODELPARAM_VALUE.axi_addr_bits PARAM_VALUE.axi_addr_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.axi_addr_bits}] ${MODELPARAM_VALUE.axi_addr_bits}
}

proc update_MODELPARAM_VALUE.drp_bytes { MODELPARAM_VALUE.drp_bytes PARAM_VALUE.drp_bytes } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.drp_bytes}] ${MODELPARAM_VALUE.drp_bytes}
}

proc update_MODELPARAM_VALUE.drp_addr_bits { MODELPARAM_VALUE.drp_addr_bits PARAM_VALUE.drp_addr_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.drp_addr_bits}] ${MODELPARAM_VALUE.drp_addr_bits}
}

