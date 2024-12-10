# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "in_clk_rate_mhz" -parent ${Page_0}
  ipgui::add_param $IPINST -name "port_init_rate_khz" -parent ${Page_0}
  ipgui::add_param $IPINST -name "port_has_mga" -parent ${Page_0}


}

proc update_PARAM_VALUE.in_clk_rate_mhz { PARAM_VALUE.in_clk_rate_mhz } {
	# Procedure called to update in_clk_rate_mhz when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.in_clk_rate_mhz { PARAM_VALUE.in_clk_rate_mhz } {
	# Procedure called to validate in_clk_rate_mhz
	return true
}

proc update_PARAM_VALUE.port_has_mga { PARAM_VALUE.port_has_mga } {
	# Procedure called to update port_has_mga when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.port_has_mga { PARAM_VALUE.port_has_mga } {
	# Procedure called to validate port_has_mga
	return true
}

proc update_PARAM_VALUE.port_init_rate_khz { PARAM_VALUE.port_init_rate_khz } {
	# Procedure called to update port_init_rate_khz when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.port_init_rate_khz { PARAM_VALUE.port_init_rate_khz } {
	# Procedure called to validate port_init_rate_khz
	return true
}


proc update_MODELPARAM_VALUE.port_has_mga { MODELPARAM_VALUE.port_has_mga PARAM_VALUE.port_has_mga } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.port_has_mga}] ${MODELPARAM_VALUE.port_has_mga}
}

proc update_MODELPARAM_VALUE.in_clk_rate_mhz { MODELPARAM_VALUE.in_clk_rate_mhz PARAM_VALUE.in_clk_rate_mhz } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.in_clk_rate_mhz}] ${MODELPARAM_VALUE.in_clk_rate_mhz}
}

proc update_MODELPARAM_VALUE.port_init_rate_khz { MODELPARAM_VALUE.port_init_rate_khz PARAM_VALUE.port_init_rate_khz } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.port_init_rate_khz}] ${MODELPARAM_VALUE.port_init_rate_khz}
}

