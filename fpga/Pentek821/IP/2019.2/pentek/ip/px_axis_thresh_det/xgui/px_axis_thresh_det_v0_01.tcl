# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set data_width [ipgui::add_param $IPINST -name "data_width" -parent ${Page_0} -widget comboBox]
  set_property tooltip {InputData Width} ${data_width}
  ipgui::add_param $IPINST -name "default_thresh" -parent ${Page_0}
  ipgui::add_param $IPINST -name "default_hyst" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_det_axis" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_irq_out" -parent ${Page_0}


}

proc update_PARAM_VALUE.data_width { PARAM_VALUE.data_width } {
	# Procedure called to update data_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_width { PARAM_VALUE.data_width } {
	# Procedure called to validate data_width
	return true
}

proc update_PARAM_VALUE.default_hyst { PARAM_VALUE.default_hyst } {
	# Procedure called to update default_hyst when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.default_hyst { PARAM_VALUE.default_hyst } {
	# Procedure called to validate default_hyst
	return true
}

proc update_PARAM_VALUE.default_thresh { PARAM_VALUE.default_thresh } {
	# Procedure called to update default_thresh when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.default_thresh { PARAM_VALUE.default_thresh } {
	# Procedure called to validate default_thresh
	return true
}

proc update_PARAM_VALUE.has_det_axis { PARAM_VALUE.has_det_axis } {
	# Procedure called to update has_det_axis when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_det_axis { PARAM_VALUE.has_det_axis } {
	# Procedure called to validate has_det_axis
	return true
}

proc update_PARAM_VALUE.has_irq_out { PARAM_VALUE.has_irq_out } {
	# Procedure called to update has_irq_out when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_irq_out { PARAM_VALUE.has_irq_out } {
	# Procedure called to validate has_irq_out
	return true
}


proc update_MODELPARAM_VALUE.data_width { MODELPARAM_VALUE.data_width PARAM_VALUE.data_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_width}] ${MODELPARAM_VALUE.data_width}
}

proc update_MODELPARAM_VALUE.default_thresh { MODELPARAM_VALUE.default_thresh PARAM_VALUE.default_thresh } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.default_thresh}] ${MODELPARAM_VALUE.default_thresh}
}

proc update_MODELPARAM_VALUE.default_hyst { MODELPARAM_VALUE.default_hyst PARAM_VALUE.default_hyst } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.default_hyst}] ${MODELPARAM_VALUE.default_hyst}
}

proc update_MODELPARAM_VALUE.has_det_axis { MODELPARAM_VALUE.has_det_axis PARAM_VALUE.has_det_axis } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_det_axis}] ${MODELPARAM_VALUE.has_det_axis}
}

proc update_MODELPARAM_VALUE.has_irq_out { MODELPARAM_VALUE.has_irq_out PARAM_VALUE.has_irq_out } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_irq_out}] ${MODELPARAM_VALUE.has_irq_out}
}

