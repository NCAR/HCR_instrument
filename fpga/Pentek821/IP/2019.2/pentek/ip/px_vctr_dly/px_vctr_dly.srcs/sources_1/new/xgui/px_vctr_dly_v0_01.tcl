# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "delay" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_ce" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_rst" -parent ${Page_0}


}

proc update_PARAM_VALUE.delay { PARAM_VALUE.delay } {
	# Procedure called to update delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.delay { PARAM_VALUE.delay } {
	# Procedure called to validate delay
	return true
}

proc update_PARAM_VALUE.has_ce { PARAM_VALUE.has_ce } {
	# Procedure called to update has_ce when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_ce { PARAM_VALUE.has_ce } {
	# Procedure called to validate has_ce
	return true
}

proc update_PARAM_VALUE.has_rst { PARAM_VALUE.has_rst } {
	# Procedure called to update has_rst when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_rst { PARAM_VALUE.has_rst } {
	# Procedure called to validate has_rst
	return true
}

proc update_PARAM_VALUE.width { PARAM_VALUE.width } {
	# Procedure called to update width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.width { PARAM_VALUE.width } {
	# Procedure called to validate width
	return true
}


proc update_MODELPARAM_VALUE.width { MODELPARAM_VALUE.width PARAM_VALUE.width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.width}] ${MODELPARAM_VALUE.width}
}

proc update_MODELPARAM_VALUE.delay { MODELPARAM_VALUE.delay PARAM_VALUE.delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.delay}] ${MODELPARAM_VALUE.delay}
}

proc update_MODELPARAM_VALUE.has_ce { MODELPARAM_VALUE.has_ce PARAM_VALUE.has_ce } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_ce}] ${MODELPARAM_VALUE.has_ce}
}

proc update_MODELPARAM_VALUE.has_rst { MODELPARAM_VALUE.has_rst PARAM_VALUE.has_rst } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_rst}] ${MODELPARAM_VALUE.has_rst}
}

