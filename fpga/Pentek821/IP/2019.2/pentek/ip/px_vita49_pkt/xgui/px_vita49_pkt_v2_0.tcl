# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  ipgui::add_param $IPINST -name "Input_Bytes" -widget comboBox

}

proc update_PARAM_VALUE.Input_Bytes { PARAM_VALUE.Input_Bytes } {
	# Procedure called to update Input_Bytes when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Input_Bytes { PARAM_VALUE.Input_Bytes } {
	# Procedure called to validate Input_Bytes
	return true
}


proc update_MODELPARAM_VALUE.Input_Bytes { MODELPARAM_VALUE.Input_Bytes PARAM_VALUE.Input_Bytes } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Input_Bytes}] ${MODELPARAM_VALUE.Input_Bytes}
}

