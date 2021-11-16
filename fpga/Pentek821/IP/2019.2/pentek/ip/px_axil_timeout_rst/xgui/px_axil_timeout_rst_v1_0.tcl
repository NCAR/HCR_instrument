# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set addr_bits [ipgui::add_param $IPINST -name "addr_bits" -parent ${Page_0}]
  set_property tooltip {ANumber of Address Bits} ${addr_bits}
  ipgui::add_param $IPINST -name "timeout_count" -parent ${Page_0}


}

proc update_PARAM_VALUE.addr_bits { PARAM_VALUE.addr_bits } {
	# Procedure called to update addr_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.addr_bits { PARAM_VALUE.addr_bits } {
	# Procedure called to validate addr_bits
	return true
}

proc update_PARAM_VALUE.timeout_count { PARAM_VALUE.timeout_count } {
	# Procedure called to update timeout_count when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.timeout_count { PARAM_VALUE.timeout_count } {
	# Procedure called to validate timeout_count
	return true
}


proc update_MODELPARAM_VALUE.addr_bits { MODELPARAM_VALUE.addr_bits PARAM_VALUE.addr_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.addr_bits}] ${MODELPARAM_VALUE.addr_bits}
}

proc update_MODELPARAM_VALUE.timeout_count { MODELPARAM_VALUE.timeout_count PARAM_VALUE.timeout_count } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.timeout_count}] ${MODELPARAM_VALUE.timeout_count}
}

