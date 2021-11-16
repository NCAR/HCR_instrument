# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set ultrascale_plus [ipgui::add_param $IPINST -name "ultrascale_plus" -parent ${Page_0}]
  set_property tooltip {Is Ultrascale Plus (Set to true if Ultrascale+)} ${ultrascale_plus}


}

proc update_PARAM_VALUE.ultrascale_plus { PARAM_VALUE.ultrascale_plus } {
	# Procedure called to update ultrascale_plus when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ultrascale_plus { PARAM_VALUE.ultrascale_plus } {
	# Procedure called to validate ultrascale_plus
	return true
}


proc update_MODELPARAM_VALUE.ultrascale_plus { MODELPARAM_VALUE.ultrascale_plus PARAM_VALUE.ultrascale_plus } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ultrascale_plus}] ${MODELPARAM_VALUE.ultrascale_plus}
}

