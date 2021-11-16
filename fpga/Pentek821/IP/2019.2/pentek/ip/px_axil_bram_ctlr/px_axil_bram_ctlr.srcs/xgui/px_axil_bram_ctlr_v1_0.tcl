# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "num_addr_bits" -parent ${Page_0}
  ipgui::add_param $IPINST -name "read_latency" -parent ${Page_0}


}

proc update_PARAM_VALUE.num_addr_bits { PARAM_VALUE.num_addr_bits } {
	# Procedure called to update num_addr_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_addr_bits { PARAM_VALUE.num_addr_bits } {
	# Procedure called to validate num_addr_bits
	return true
}

proc update_PARAM_VALUE.read_latency { PARAM_VALUE.read_latency } {
	# Procedure called to update read_latency when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.read_latency { PARAM_VALUE.read_latency } {
	# Procedure called to validate read_latency
	return true
}


proc update_MODELPARAM_VALUE.num_addr_bits { MODELPARAM_VALUE.num_addr_bits PARAM_VALUE.num_addr_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_addr_bits}] ${MODELPARAM_VALUE.num_addr_bits}
}

proc update_MODELPARAM_VALUE.read_latency { MODELPARAM_VALUE.read_latency PARAM_VALUE.read_latency } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.read_latency}] ${MODELPARAM_VALUE.read_latency}
}

