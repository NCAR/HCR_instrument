# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "num_bytes" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "num_gate_bits" -parent ${Page_0} -widget comboBox


}

proc update_PARAM_VALUE.num_bytes { PARAM_VALUE.num_bytes } {
	# Procedure called to update num_bytes when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_bytes { PARAM_VALUE.num_bytes } {
	# Procedure called to validate num_bytes
	return true
}

proc update_PARAM_VALUE.num_gate_bits { PARAM_VALUE.num_gate_bits } {
	# Procedure called to update num_gate_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_gate_bits { PARAM_VALUE.num_gate_bits } {
	# Procedure called to validate num_gate_bits
	return true
}


proc update_MODELPARAM_VALUE.num_bytes { MODELPARAM_VALUE.num_bytes PARAM_VALUE.num_bytes } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_bytes}] ${MODELPARAM_VALUE.num_bytes}
}

proc update_MODELPARAM_VALUE.num_gate_bits { MODELPARAM_VALUE.num_gate_bits PARAM_VALUE.num_gate_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_gate_bits}] ${MODELPARAM_VALUE.num_gate_bits}
}

