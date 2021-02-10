# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "data_byte_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "delay_ctl_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_csr" -parent ${Page_0}


}

proc update_PARAM_VALUE.data_byte_width { PARAM_VALUE.data_byte_width } {
	# Procedure called to update data_byte_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_byte_width { PARAM_VALUE.data_byte_width } {
	# Procedure called to validate data_byte_width
	return true
}

proc update_PARAM_VALUE.delay_ctl_width { PARAM_VALUE.delay_ctl_width } {
	# Procedure called to update delay_ctl_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.delay_ctl_width { PARAM_VALUE.delay_ctl_width } {
	# Procedure called to validate delay_ctl_width
	return true
}

proc update_PARAM_VALUE.has_csr { PARAM_VALUE.has_csr } {
	# Procedure called to update has_csr when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_csr { PARAM_VALUE.has_csr } {
	# Procedure called to validate has_csr
	return true
}


proc update_MODELPARAM_VALUE.has_csr { MODELPARAM_VALUE.has_csr PARAM_VALUE.has_csr } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_csr}] ${MODELPARAM_VALUE.has_csr}
}

proc update_MODELPARAM_VALUE.data_byte_width { MODELPARAM_VALUE.data_byte_width PARAM_VALUE.data_byte_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_byte_width}] ${MODELPARAM_VALUE.data_byte_width}
}

proc update_MODELPARAM_VALUE.delay_ctl_width { MODELPARAM_VALUE.delay_ctl_width PARAM_VALUE.delay_ctl_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.delay_ctl_width}] ${MODELPARAM_VALUE.delay_ctl_width}
}

