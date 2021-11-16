# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_static_text $IPINST -name "Int_txt" -parent ${Page_0} -text {Interrupt Inputs are assumed to be pulses (edge rising).  
The output is the 'OR' of all the enabled inputs.
The Flag Register will latch only enabled inputs.}
  ipgui::add_param $IPINST -name "num_interrupt_sources" -parent ${Page_0}


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

