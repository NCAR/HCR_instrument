# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "has_in_tready" -parent ${Page_0}
  ipgui::add_param $IPINST -name "channel" -parent ${Page_0}


}

proc update_PARAM_VALUE.channel { PARAM_VALUE.channel } {
	# Procedure called to update channel when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.channel { PARAM_VALUE.channel } {
	# Procedure called to validate channel
	return true
}

proc update_PARAM_VALUE.has_in_tready { PARAM_VALUE.has_in_tready } {
	# Procedure called to update has_in_tready when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_in_tready { PARAM_VALUE.has_in_tready } {
	# Procedure called to validate has_in_tready
	return true
}


proc update_MODELPARAM_VALUE.channel { MODELPARAM_VALUE.channel PARAM_VALUE.channel } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.channel}] ${MODELPARAM_VALUE.channel}
}

proc update_MODELPARAM_VALUE.has_in_tready { MODELPARAM_VALUE.has_in_tready PARAM_VALUE.has_in_tready } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_in_tready}] ${MODELPARAM_VALUE.has_in_tready}
}

