# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "jesd_interface_type" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "jesd_bus_width" -parent ${Page_0} -widget comboBox


}

proc update_PARAM_VALUE.jesd_bus_width { PARAM_VALUE.jesd_bus_width } {
	# Procedure called to update jesd_bus_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.jesd_bus_width { PARAM_VALUE.jesd_bus_width } {
	# Procedure called to validate jesd_bus_width
	return true
}

proc update_PARAM_VALUE.jesd_interface_type { PARAM_VALUE.jesd_interface_type } {
	# Procedure called to update jesd_interface_type when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.jesd_interface_type { PARAM_VALUE.jesd_interface_type } {
	# Procedure called to validate jesd_interface_type
	return true
}


proc update_MODELPARAM_VALUE.jesd_bus_width { MODELPARAM_VALUE.jesd_bus_width PARAM_VALUE.jesd_bus_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.jesd_bus_width}] ${MODELPARAM_VALUE.jesd_bus_width}
}

proc update_MODELPARAM_VALUE.jesd_interface_type { MODELPARAM_VALUE.jesd_interface_type PARAM_VALUE.jesd_interface_type } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.jesd_interface_type}] ${MODELPARAM_VALUE.jesd_interface_type}
}

