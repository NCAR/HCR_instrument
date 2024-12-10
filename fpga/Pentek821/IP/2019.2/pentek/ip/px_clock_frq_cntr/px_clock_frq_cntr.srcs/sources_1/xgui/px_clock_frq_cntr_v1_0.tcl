# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "ref_freq_hz" -parent ${Page_0}


}

proc update_PARAM_VALUE.ref_freq_hz { PARAM_VALUE.ref_freq_hz } {
	# Procedure called to update ref_freq_hz when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ref_freq_hz { PARAM_VALUE.ref_freq_hz } {
	# Procedure called to validate ref_freq_hz
	return true
}


proc update_MODELPARAM_VALUE.ref_freq_hz { MODELPARAM_VALUE.ref_freq_hz PARAM_VALUE.ref_freq_hz } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ref_freq_hz}] ${MODELPARAM_VALUE.ref_freq_hz}
}

