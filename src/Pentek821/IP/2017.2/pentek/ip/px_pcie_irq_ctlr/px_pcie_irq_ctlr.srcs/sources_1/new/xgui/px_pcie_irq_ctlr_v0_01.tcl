
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/px_pcie_irq_ctlr_v0_01.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "num_interrupt_sources" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ku" -parent ${Page_0} -layout horizontal
  ipgui::add_static_text $IPINST -name "txt" -parent ${Page_0} -text {0 = V7, 1 = KU}


}

proc update_PARAM_VALUE.ku { PARAM_VALUE.ku } {
	# Procedure called to update ku when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ku { PARAM_VALUE.ku } {
	# Procedure called to validate ku
	return true
}

proc update_PARAM_VALUE.num_interrupt_sources { PARAM_VALUE.num_interrupt_sources } {
	# Procedure called to update num_interrupt_sources when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_interrupt_sources { PARAM_VALUE.num_interrupt_sources } {
	# Procedure called to validate num_interrupt_sources
	return true
}


proc update_MODELPARAM_VALUE.num_interrupt_sources { MODELPARAM_VALUE.num_interrupt_sources PARAM_VALUE.num_interrupt_sources } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_interrupt_sources}] ${MODELPARAM_VALUE.num_interrupt_sources}
}

proc update_MODELPARAM_VALUE.ku { MODELPARAM_VALUE.ku PARAM_VALUE.ku } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ku}] ${MODELPARAM_VALUE.ku}
}

