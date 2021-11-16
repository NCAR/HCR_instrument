# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "clock_division" -parent ${Page_0}
  ipgui::add_param $IPINST -name "default_word0" -parent ${Page_0}
  ipgui::add_param $IPINST -name "default_word1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "default_word2" -parent ${Page_0}
  ipgui::add_param $IPINST -name "default_word3" -parent ${Page_0}
  ipgui::add_param $IPINST -name "load_defaults" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_sync_bus_sig" -parent ${Page_0}


}

proc update_PARAM_VALUE.clock_division { PARAM_VALUE.clock_division } {
	# Procedure called to update clock_division when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.clock_division { PARAM_VALUE.clock_division } {
	# Procedure called to validate clock_division
	return true
}

proc update_PARAM_VALUE.default_word0 { PARAM_VALUE.default_word0 } {
	# Procedure called to update default_word0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.default_word0 { PARAM_VALUE.default_word0 } {
	# Procedure called to validate default_word0
	return true
}

proc update_PARAM_VALUE.default_word1 { PARAM_VALUE.default_word1 } {
	# Procedure called to update default_word1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.default_word1 { PARAM_VALUE.default_word1 } {
	# Procedure called to validate default_word1
	return true
}

proc update_PARAM_VALUE.default_word2 { PARAM_VALUE.default_word2 } {
	# Procedure called to update default_word2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.default_word2 { PARAM_VALUE.default_word2 } {
	# Procedure called to validate default_word2
	return true
}

proc update_PARAM_VALUE.default_word3 { PARAM_VALUE.default_word3 } {
	# Procedure called to update default_word3 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.default_word3 { PARAM_VALUE.default_word3 } {
	# Procedure called to validate default_word3
	return true
}

proc update_PARAM_VALUE.has_sync_bus_sig { PARAM_VALUE.has_sync_bus_sig } {
	# Procedure called to update has_sync_bus_sig when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_sync_bus_sig { PARAM_VALUE.has_sync_bus_sig } {
	# Procedure called to validate has_sync_bus_sig
	return true
}

proc update_PARAM_VALUE.load_defaults { PARAM_VALUE.load_defaults } {
	# Procedure called to update load_defaults when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.load_defaults { PARAM_VALUE.load_defaults } {
	# Procedure called to validate load_defaults
	return true
}


proc update_MODELPARAM_VALUE.clock_division { MODELPARAM_VALUE.clock_division PARAM_VALUE.clock_division } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.clock_division}] ${MODELPARAM_VALUE.clock_division}
}

proc update_MODELPARAM_VALUE.load_defaults { MODELPARAM_VALUE.load_defaults PARAM_VALUE.load_defaults } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.load_defaults}] ${MODELPARAM_VALUE.load_defaults}
}

proc update_MODELPARAM_VALUE.has_sync_bus_sig { MODELPARAM_VALUE.has_sync_bus_sig PARAM_VALUE.has_sync_bus_sig } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_sync_bus_sig}] ${MODELPARAM_VALUE.has_sync_bus_sig}
}

proc update_MODELPARAM_VALUE.default_word0 { MODELPARAM_VALUE.default_word0 PARAM_VALUE.default_word0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.default_word0}] ${MODELPARAM_VALUE.default_word0}
}

proc update_MODELPARAM_VALUE.default_word1 { MODELPARAM_VALUE.default_word1 PARAM_VALUE.default_word1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.default_word1}] ${MODELPARAM_VALUE.default_word1}
}

proc update_MODELPARAM_VALUE.default_word2 { MODELPARAM_VALUE.default_word2 PARAM_VALUE.default_word2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.default_word2}] ${MODELPARAM_VALUE.default_word2}
}

proc update_MODELPARAM_VALUE.default_word3 { MODELPARAM_VALUE.default_word3 PARAM_VALUE.default_word3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.default_word3}] ${MODELPARAM_VALUE.default_word3}
}

