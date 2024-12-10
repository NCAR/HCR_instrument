# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "has_ext_led_src" -parent ${Page_0}
  ipgui::add_param $IPINST -name "initial_a_gain_percent" -parent ${Page_0}
  ipgui::add_param $IPINST -name "initial_a_offset_counts" -parent ${Page_0}
  ipgui::add_param $IPINST -name "initial_b_gain_percent" -parent ${Page_0}
  ipgui::add_param $IPINST -name "initial_b_offset_counts" -parent ${Page_0}
  ipgui::add_param $IPINST -name "initial_led_select" -parent ${Page_0}
  ipgui::add_param $IPINST -name "initial_ovld_thresh" -parent ${Page_0}
  ipgui::add_param $IPINST -name "initial_pdwnf" -parent ${Page_0}
  ipgui::add_param $IPINST -name "led_pulse_stretch" -parent ${Page_0}


}

proc update_PARAM_VALUE.has_ext_led_src { PARAM_VALUE.has_ext_led_src } {
	# Procedure called to update has_ext_led_src when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_ext_led_src { PARAM_VALUE.has_ext_led_src } {
	# Procedure called to validate has_ext_led_src
	return true
}

proc update_PARAM_VALUE.initial_a_gain_percent { PARAM_VALUE.initial_a_gain_percent } {
	# Procedure called to update initial_a_gain_percent when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_a_gain_percent { PARAM_VALUE.initial_a_gain_percent } {
	# Procedure called to validate initial_a_gain_percent
	return true
}

proc update_PARAM_VALUE.initial_a_offset_counts { PARAM_VALUE.initial_a_offset_counts } {
	# Procedure called to update initial_a_offset_counts when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_a_offset_counts { PARAM_VALUE.initial_a_offset_counts } {
	# Procedure called to validate initial_a_offset_counts
	return true
}

proc update_PARAM_VALUE.initial_b_gain_percent { PARAM_VALUE.initial_b_gain_percent } {
	# Procedure called to update initial_b_gain_percent when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_b_gain_percent { PARAM_VALUE.initial_b_gain_percent } {
	# Procedure called to validate initial_b_gain_percent
	return true
}

proc update_PARAM_VALUE.initial_b_offset_counts { PARAM_VALUE.initial_b_offset_counts } {
	# Procedure called to update initial_b_offset_counts when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_b_offset_counts { PARAM_VALUE.initial_b_offset_counts } {
	# Procedure called to validate initial_b_offset_counts
	return true
}

proc update_PARAM_VALUE.initial_led_select { PARAM_VALUE.initial_led_select } {
	# Procedure called to update initial_led_select when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_led_select { PARAM_VALUE.initial_led_select } {
	# Procedure called to validate initial_led_select
	return true
}

proc update_PARAM_VALUE.initial_ovld_thresh { PARAM_VALUE.initial_ovld_thresh } {
	# Procedure called to update initial_ovld_thresh when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_ovld_thresh { PARAM_VALUE.initial_ovld_thresh } {
	# Procedure called to validate initial_ovld_thresh
	return true
}

proc update_PARAM_VALUE.initial_pdwnf { PARAM_VALUE.initial_pdwnf } {
	# Procedure called to update initial_pdwnf when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_pdwnf { PARAM_VALUE.initial_pdwnf } {
	# Procedure called to validate initial_pdwnf
	return true
}

proc update_PARAM_VALUE.led_pulse_stretch { PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to update led_pulse_stretch when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.led_pulse_stretch { PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to validate led_pulse_stretch
	return true
}


proc update_MODELPARAM_VALUE.initial_a_gain_percent { MODELPARAM_VALUE.initial_a_gain_percent PARAM_VALUE.initial_a_gain_percent } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_a_gain_percent}] ${MODELPARAM_VALUE.initial_a_gain_percent}
}

proc update_MODELPARAM_VALUE.initial_a_offset_counts { MODELPARAM_VALUE.initial_a_offset_counts PARAM_VALUE.initial_a_offset_counts } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_a_offset_counts}] ${MODELPARAM_VALUE.initial_a_offset_counts}
}

proc update_MODELPARAM_VALUE.initial_b_gain_percent { MODELPARAM_VALUE.initial_b_gain_percent PARAM_VALUE.initial_b_gain_percent } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_b_gain_percent}] ${MODELPARAM_VALUE.initial_b_gain_percent}
}

proc update_MODELPARAM_VALUE.initial_b_offset_counts { MODELPARAM_VALUE.initial_b_offset_counts PARAM_VALUE.initial_b_offset_counts } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_b_offset_counts}] ${MODELPARAM_VALUE.initial_b_offset_counts}
}

proc update_MODELPARAM_VALUE.initial_pdwnf { MODELPARAM_VALUE.initial_pdwnf PARAM_VALUE.initial_pdwnf } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_pdwnf}] ${MODELPARAM_VALUE.initial_pdwnf}
}

proc update_MODELPARAM_VALUE.initial_led_select { MODELPARAM_VALUE.initial_led_select PARAM_VALUE.initial_led_select } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_led_select}] ${MODELPARAM_VALUE.initial_led_select}
}

proc update_MODELPARAM_VALUE.has_ext_led_src { MODELPARAM_VALUE.has_ext_led_src PARAM_VALUE.has_ext_led_src } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_ext_led_src}] ${MODELPARAM_VALUE.has_ext_led_src}
}

proc update_MODELPARAM_VALUE.initial_ovld_thresh { MODELPARAM_VALUE.initial_ovld_thresh PARAM_VALUE.initial_ovld_thresh } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_ovld_thresh}] ${MODELPARAM_VALUE.initial_ovld_thresh}
}

proc update_MODELPARAM_VALUE.led_pulse_stretch { MODELPARAM_VALUE.led_pulse_stretch PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.led_pulse_stretch}] ${MODELPARAM_VALUE.led_pulse_stretch}
}

