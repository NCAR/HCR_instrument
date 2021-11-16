# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "has_clk" -parent ${Page_0}
  ipgui::add_param $IPINST -name "vctr_width" -parent ${Page_0}


}

proc update_PARAM_VALUE.has_clk { PARAM_VALUE.has_clk } {
	# Procedure called to update has_clk when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_clk { PARAM_VALUE.has_clk } {
	# Procedure called to validate has_clk
	return true
}

proc update_PARAM_VALUE.vctr_width { PARAM_VALUE.vctr_width } {
	# Procedure called to update vctr_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.vctr_width { PARAM_VALUE.vctr_width } {
	# Procedure called to validate vctr_width
	return true
}


proc update_MODELPARAM_VALUE.has_clk { MODELPARAM_VALUE.has_clk PARAM_VALUE.has_clk } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_clk}] ${MODELPARAM_VALUE.has_clk}
}

proc update_MODELPARAM_VALUE.vctr_width { MODELPARAM_VALUE.vctr_width PARAM_VALUE.vctr_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.vctr_width}] ${MODELPARAM_VALUE.vctr_width}
}

