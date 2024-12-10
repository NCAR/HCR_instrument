# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "address_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "respond_with_error" -parent ${Page_0}


}

proc update_PARAM_VALUE.address_width { PARAM_VALUE.address_width } {
	# Procedure called to update address_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.address_width { PARAM_VALUE.address_width } {
	# Procedure called to validate address_width
	return true
}

proc update_PARAM_VALUE.respond_with_error { PARAM_VALUE.respond_with_error } {
	# Procedure called to update respond_with_error when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.respond_with_error { PARAM_VALUE.respond_with_error } {
	# Procedure called to validate respond_with_error
	return true
}


proc update_MODELPARAM_VALUE.address_width { MODELPARAM_VALUE.address_width PARAM_VALUE.address_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.address_width}] ${MODELPARAM_VALUE.address_width}
}

proc update_MODELPARAM_VALUE.respond_with_error { MODELPARAM_VALUE.respond_with_error PARAM_VALUE.respond_with_error } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.respond_with_error}] ${MODELPARAM_VALUE.respond_with_error}
}

