# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_static_text $IPINST -name "txt1" -parent ${Page_0} -text {PCIe IP core must be set for RQ in Data Aligned Mode and 512-bit.}
  ipgui::add_param $IPINST -name "has_fifo_full_led" -parent ${Page_0}


}

proc update_PARAM_VALUE.has_fifo_full_led { PARAM_VALUE.has_fifo_full_led } {
	# Procedure called to update has_fifo_full_led when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_fifo_full_led { PARAM_VALUE.has_fifo_full_led } {
	# Procedure called to validate has_fifo_full_led
	return true
}


proc update_MODELPARAM_VALUE.has_fifo_full_led { MODELPARAM_VALUE.has_fifo_full_led PARAM_VALUE.has_fifo_full_led } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_fifo_full_led}] ${MODELPARAM_VALUE.has_fifo_full_led}
}

