# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "calc_magnitude" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_axis_mag_out" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_axis_pwr_out" -parent ${Page_0}


}

proc update_PARAM_VALUE.calc_magnitude { PARAM_VALUE.calc_magnitude } {
	# Procedure called to update calc_magnitude when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.calc_magnitude { PARAM_VALUE.calc_magnitude } {
	# Procedure called to validate calc_magnitude
	return true
}

proc update_PARAM_VALUE.has_axis_mag_out { PARAM_VALUE.has_axis_mag_out } {
	# Procedure called to update has_axis_mag_out when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_axis_mag_out { PARAM_VALUE.has_axis_mag_out } {
	# Procedure called to validate has_axis_mag_out
	return true
}

proc update_PARAM_VALUE.has_axis_pwr_out { PARAM_VALUE.has_axis_pwr_out } {
	# Procedure called to update has_axis_pwr_out when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_axis_pwr_out { PARAM_VALUE.has_axis_pwr_out } {
	# Procedure called to validate has_axis_pwr_out
	return true
}


proc update_MODELPARAM_VALUE.calc_magnitude { MODELPARAM_VALUE.calc_magnitude PARAM_VALUE.calc_magnitude } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.calc_magnitude}] ${MODELPARAM_VALUE.calc_magnitude}
}

proc update_MODELPARAM_VALUE.has_axis_pwr_out { MODELPARAM_VALUE.has_axis_pwr_out PARAM_VALUE.has_axis_pwr_out } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_axis_pwr_out}] ${MODELPARAM_VALUE.has_axis_pwr_out}
}

proc update_MODELPARAM_VALUE.has_axis_mag_out { MODELPARAM_VALUE.has_axis_mag_out PARAM_VALUE.has_axis_mag_out } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_axis_mag_out}] ${MODELPARAM_VALUE.has_axis_mag_out}
}

