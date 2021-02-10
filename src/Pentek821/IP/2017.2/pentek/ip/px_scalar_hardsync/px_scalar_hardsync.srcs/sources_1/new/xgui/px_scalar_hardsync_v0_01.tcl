# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "INIT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "IS_CLK_INVERTED" -parent ${Page_0}
  set LATENCY [ipgui::add_param $IPINST -name "LATENCY" -parent ${Page_0} -widget comboBox]
  set_property tooltip {Latency (number of resync FF stages)} ${LATENCY}


}

proc update_PARAM_VALUE.INIT { PARAM_VALUE.INIT } {
	# Procedure called to update INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT { PARAM_VALUE.INIT } {
	# Procedure called to validate INIT
	return true
}

proc update_PARAM_VALUE.IS_CLK_INVERTED { PARAM_VALUE.IS_CLK_INVERTED } {
	# Procedure called to update IS_CLK_INVERTED when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IS_CLK_INVERTED { PARAM_VALUE.IS_CLK_INVERTED } {
	# Procedure called to validate IS_CLK_INVERTED
	return true
}

proc update_PARAM_VALUE.LATENCY { PARAM_VALUE.LATENCY } {
	# Procedure called to update LATENCY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LATENCY { PARAM_VALUE.LATENCY } {
	# Procedure called to validate LATENCY
	return true
}


proc update_MODELPARAM_VALUE.INIT { MODELPARAM_VALUE.INIT PARAM_VALUE.INIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT}] ${MODELPARAM_VALUE.INIT}
}

proc update_MODELPARAM_VALUE.IS_CLK_INVERTED { MODELPARAM_VALUE.IS_CLK_INVERTED PARAM_VALUE.IS_CLK_INVERTED } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IS_CLK_INVERTED}] ${MODELPARAM_VALUE.IS_CLK_INVERTED}
}

proc update_MODELPARAM_VALUE.LATENCY { MODELPARAM_VALUE.LATENCY PARAM_VALUE.LATENCY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LATENCY}] ${MODELPARAM_VALUE.LATENCY}
}

