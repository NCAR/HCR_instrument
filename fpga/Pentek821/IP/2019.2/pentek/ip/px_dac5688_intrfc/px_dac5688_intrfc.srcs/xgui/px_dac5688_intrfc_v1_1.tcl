# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "idelaycntrl_refclk_freq" -parent ${Page_0}
  ipgui::add_param $IPINST -name "initial_tap_delay" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp" -parent ${Page_0}


}

proc update_PARAM_VALUE.idelaycntrl_refclk_freq { PARAM_VALUE.idelaycntrl_refclk_freq } {
	# Procedure called to update idelaycntrl_refclk_freq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.idelaycntrl_refclk_freq { PARAM_VALUE.idelaycntrl_refclk_freq } {
	# Procedure called to validate idelaycntrl_refclk_freq
	return true
}

proc update_PARAM_VALUE.initial_tap_delay { PARAM_VALUE.initial_tap_delay } {
	# Procedure called to update initial_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_tap_delay { PARAM_VALUE.initial_tap_delay } {
	# Procedure called to validate initial_tap_delay
	return true
}

proc update_PARAM_VALUE.iodelay_grp { PARAM_VALUE.iodelay_grp } {
	# Procedure called to update iodelay_grp when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp { PARAM_VALUE.iodelay_grp } {
	# Procedure called to validate iodelay_grp
	return true
}


proc update_MODELPARAM_VALUE.iodelay_grp { MODELPARAM_VALUE.iodelay_grp PARAM_VALUE.iodelay_grp } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp}] ${MODELPARAM_VALUE.iodelay_grp}
}

proc update_MODELPARAM_VALUE.initial_tap_delay { MODELPARAM_VALUE.initial_tap_delay PARAM_VALUE.initial_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_tap_delay}] ${MODELPARAM_VALUE.initial_tap_delay}
}

proc update_MODELPARAM_VALUE.idelaycntrl_refclk_freq { MODELPARAM_VALUE.idelaycntrl_refclk_freq PARAM_VALUE.idelaycntrl_refclk_freq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.idelaycntrl_refclk_freq}] ${MODELPARAM_VALUE.idelaycntrl_refclk_freq}
}

