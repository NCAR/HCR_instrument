# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "num_bits" -parent ${Page_0}
  ipgui::add_param $IPINST -name "sub_address" -parent ${Page_0}


}

proc update_PARAM_VALUE.num_bits { PARAM_VALUE.num_bits } {
	# Procedure called to update num_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_bits { PARAM_VALUE.num_bits } {
	# Procedure called to validate num_bits
	return true
}

proc update_PARAM_VALUE.sub_address { PARAM_VALUE.sub_address } {
	# Procedure called to update sub_address when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.sub_address { PARAM_VALUE.sub_address } {
	# Procedure called to validate sub_address
	return true
}


proc update_MODELPARAM_VALUE.num_bits { MODELPARAM_VALUE.num_bits PARAM_VALUE.num_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_bits}] ${MODELPARAM_VALUE.num_bits}
}

proc update_MODELPARAM_VALUE.sub_address { MODELPARAM_VALUE.sub_address PARAM_VALUE.sub_address } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.sub_address}] ${MODELPARAM_VALUE.sub_address}
}

