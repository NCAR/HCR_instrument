# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "pts_signal_width" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "has_des_ctl" -parent ${Page_0}


}

proc update_PARAM_VALUE.has_des_ctl { PARAM_VALUE.has_des_ctl } {
	# Procedure called to update has_des_ctl when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_des_ctl { PARAM_VALUE.has_des_ctl } {
	# Procedure called to validate has_des_ctl
	return true
}

proc update_PARAM_VALUE.pts_signal_width { PARAM_VALUE.pts_signal_width } {
	# Procedure called to update pts_signal_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.pts_signal_width { PARAM_VALUE.pts_signal_width } {
	# Procedure called to validate pts_signal_width
	return true
}


proc update_MODELPARAM_VALUE.pts_signal_width { MODELPARAM_VALUE.pts_signal_width PARAM_VALUE.pts_signal_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.pts_signal_width}] ${MODELPARAM_VALUE.pts_signal_width}
}

proc update_MODELPARAM_VALUE.has_des_ctl { MODELPARAM_VALUE.has_des_ctl PARAM_VALUE.has_des_ctl } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_des_ctl}] ${MODELPARAM_VALUE.has_des_ctl}
}
