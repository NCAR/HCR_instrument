# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "in_vector_length" -parent ${Page_0}
  ipgui::add_param $IPINST -name "out_end_index" -parent ${Page_0}
  ipgui::add_param $IPINST -name "out_start_index" -parent ${Page_0}


}

proc update_PARAM_VALUE.in_vector_length { PARAM_VALUE.in_vector_length } {
	# Procedure called to update in_vector_length when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.in_vector_length { PARAM_VALUE.in_vector_length } {
	# Procedure called to validate in_vector_length
	return true
}

proc update_PARAM_VALUE.out_end_index { PARAM_VALUE.out_end_index } {
	# Procedure called to update out_end_index when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.out_end_index { PARAM_VALUE.out_end_index } {
	# Procedure called to validate out_end_index
	return true
}

proc update_PARAM_VALUE.out_start_index { PARAM_VALUE.out_start_index } {
	# Procedure called to update out_start_index when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.out_start_index { PARAM_VALUE.out_start_index } {
	# Procedure called to validate out_start_index
	return true
}


proc update_MODELPARAM_VALUE.in_vector_length { MODELPARAM_VALUE.in_vector_length PARAM_VALUE.in_vector_length } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.in_vector_length}] ${MODELPARAM_VALUE.in_vector_length}
}

proc update_MODELPARAM_VALUE.out_start_index { MODELPARAM_VALUE.out_start_index PARAM_VALUE.out_start_index } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.out_start_index}] ${MODELPARAM_VALUE.out_start_index}
}

proc update_MODELPARAM_VALUE.out_end_index { MODELPARAM_VALUE.out_end_index PARAM_VALUE.out_end_index } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.out_end_index}] ${MODELPARAM_VALUE.out_end_index}
}

