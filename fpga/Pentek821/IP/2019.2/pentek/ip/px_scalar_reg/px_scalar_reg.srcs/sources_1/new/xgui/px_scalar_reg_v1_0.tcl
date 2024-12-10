# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "has_ce" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_srstn" -parent ${Page_0}


}

proc update_PARAM_VALUE.has_ce { PARAM_VALUE.has_ce } {
	# Procedure called to update has_ce when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_ce { PARAM_VALUE.has_ce } {
	# Procedure called to validate has_ce
	return true
}

proc update_PARAM_VALUE.has_srstn { PARAM_VALUE.has_srstn } {
	# Procedure called to update has_srstn when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_srstn { PARAM_VALUE.has_srstn } {
	# Procedure called to validate has_srstn
	return true
}


proc update_MODELPARAM_VALUE.has_ce { MODELPARAM_VALUE.has_ce PARAM_VALUE.has_ce } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_ce}] ${MODELPARAM_VALUE.has_ce}
}

proc update_MODELPARAM_VALUE.has_srstn { MODELPARAM_VALUE.has_srstn PARAM_VALUE.has_srstn } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_srstn}] ${MODELPARAM_VALUE.has_srstn}
}

