# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "id" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_irq" -parent ${Page_0}


}

proc update_PARAM_VALUE.has_irq { PARAM_VALUE.has_irq } {
	# Procedure called to update has_irq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_irq { PARAM_VALUE.has_irq } {
	# Procedure called to validate has_irq
	return true
}

proc update_PARAM_VALUE.id { PARAM_VALUE.id } {
	# Procedure called to update id when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.id { PARAM_VALUE.id } {
	# Procedure called to validate id
	return true
}


proc update_MODELPARAM_VALUE.id { MODELPARAM_VALUE.id PARAM_VALUE.id } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.id}] ${MODELPARAM_VALUE.id}
}

proc update_MODELPARAM_VALUE.has_irq { MODELPARAM_VALUE.has_irq PARAM_VALUE.has_irq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_irq}] ${MODELPARAM_VALUE.has_irq}
}

