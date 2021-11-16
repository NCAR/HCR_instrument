# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "input_a_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "input_b_width" -parent ${Page_0}


}

proc update_PARAM_VALUE.input_a_width { PARAM_VALUE.input_a_width } {
	# Procedure called to update input_a_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.input_a_width { PARAM_VALUE.input_a_width } {
	# Procedure called to validate input_a_width
	return true
}

proc update_PARAM_VALUE.input_b_width { PARAM_VALUE.input_b_width } {
	# Procedure called to update input_b_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.input_b_width { PARAM_VALUE.input_b_width } {
	# Procedure called to validate input_b_width
	return true
}


proc update_MODELPARAM_VALUE.input_a_width { MODELPARAM_VALUE.input_a_width PARAM_VALUE.input_a_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.input_a_width}] ${MODELPARAM_VALUE.input_a_width}
}

proc update_MODELPARAM_VALUE.input_b_width { MODELPARAM_VALUE.input_b_width PARAM_VALUE.input_b_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.input_b_width}] ${MODELPARAM_VALUE.input_b_width}
}

