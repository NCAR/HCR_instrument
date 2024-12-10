# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "bytes_per_sample" -parent ${Page_0} -widget comboBox
  ipgui::add_static_text $IPINST -name "txt" -parent ${Page_0} -text {Output Samples Per Cycle Must Be Greater Than Input Sample Per Cycle.}
  ipgui::add_param $IPINST -name "in_samples_per_cycle" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "out_samples_per_cycle" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "has_tready" -parent ${Page_0}


}

proc update_PARAM_VALUE.bytes_per_sample { PARAM_VALUE.bytes_per_sample } {
	# Procedure called to update bytes_per_sample when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.bytes_per_sample { PARAM_VALUE.bytes_per_sample } {
	# Procedure called to validate bytes_per_sample
	return true
}

proc update_PARAM_VALUE.has_tready { PARAM_VALUE.has_tready } {
	# Procedure called to update has_tready when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_tready { PARAM_VALUE.has_tready } {
	# Procedure called to validate has_tready
	return true
}

proc update_PARAM_VALUE.in_samples_per_cycle { PARAM_VALUE.in_samples_per_cycle } {
	# Procedure called to update in_samples_per_cycle when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.in_samples_per_cycle { PARAM_VALUE.in_samples_per_cycle } {
	# Procedure called to validate in_samples_per_cycle
	return true
}

proc update_PARAM_VALUE.out_samples_per_cycle { PARAM_VALUE.out_samples_per_cycle } {
	# Procedure called to update out_samples_per_cycle when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.out_samples_per_cycle { PARAM_VALUE.out_samples_per_cycle } {
	# Procedure called to validate out_samples_per_cycle
	return true
}


proc update_MODELPARAM_VALUE.bytes_per_sample { MODELPARAM_VALUE.bytes_per_sample PARAM_VALUE.bytes_per_sample } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.bytes_per_sample}] ${MODELPARAM_VALUE.bytes_per_sample}
}

proc update_MODELPARAM_VALUE.in_samples_per_cycle { MODELPARAM_VALUE.in_samples_per_cycle PARAM_VALUE.in_samples_per_cycle } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.in_samples_per_cycle}] ${MODELPARAM_VALUE.in_samples_per_cycle}
}

proc update_MODELPARAM_VALUE.out_samples_per_cycle { MODELPARAM_VALUE.out_samples_per_cycle PARAM_VALUE.out_samples_per_cycle } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.out_samples_per_cycle}] ${MODELPARAM_VALUE.out_samples_per_cycle}
}

proc update_MODELPARAM_VALUE.has_tready { MODELPARAM_VALUE.has_tready PARAM_VALUE.has_tready } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tready}] ${MODELPARAM_VALUE.has_tready}
}

