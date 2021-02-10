# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  set has_tkeep [ipgui::add_param $IPINST -name "has_tkeep"]
  set_property tooltip {Enable if you would like to specify a tkeep. If not internal tkeep defaults to FF} ${has_tkeep}

}

proc update_PARAM_VALUE.has_tkeep { PARAM_VALUE.has_tkeep } {
	# Procedure called to update has_tkeep when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_tkeep { PARAM_VALUE.has_tkeep } {
	# Procedure called to validate has_tkeep
	return true
}


proc update_MODELPARAM_VALUE.has_tkeep { MODELPARAM_VALUE.has_tkeep PARAM_VALUE.has_tkeep } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tkeep}] ${MODELPARAM_VALUE.has_tkeep}
}

