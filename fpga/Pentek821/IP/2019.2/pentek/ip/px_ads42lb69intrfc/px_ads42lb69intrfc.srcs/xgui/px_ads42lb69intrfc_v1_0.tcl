# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0" -display_name {Input Buffers}]
  set_property tooltip {Input Buffers} ${Page_0}
  ipgui::add_param $IPINST -name "differential_term" -parent ${Page_0} -layout horizontal
  ipgui::add_param $IPINST -name "ibuf_low_pwr" -parent ${Page_0}
  ipgui::add_param $IPINST -name "idelaycntrl_refclk_freq" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_a01" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_a23" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_a45" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_a67" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_a89" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_a1011" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_a1213" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_a1415" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_b01" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_b23" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_b45" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_b67" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_b89" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_b1011" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_b1213" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_b1415" -parent ${Page_0}

  #Adding Page
  set Input_Delay [ipgui::add_page $IPINST -name "Input Delay"]
  ipgui::add_param $IPINST -name "initial_tap_delay" -parent ${Input_Delay}

  #Adding Page
  set ADC_Control [ipgui::add_page $IPINST -name "ADC Control"]
  ipgui::add_param $IPINST -name "initial_pdwnf_a" -parent ${ADC_Control}
  ipgui::add_param $IPINST -name "initial_pdwnf_b" -parent ${ADC_Control}

  #Adding Page
  set Gain/Offset_Control [ipgui::add_page $IPINST -name "Gain/Offset Control"]
  ipgui::add_param $IPINST -name "initial_a_gain_percent" -parent ${Gain/Offset_Control}
  ipgui::add_param $IPINST -name "initial_a_offset_counts" -parent ${Gain/Offset_Control}
  ipgui::add_param $IPINST -name "initial_b_gain_percent" -parent ${Gain/Offset_Control}
  ipgui::add_param $IPINST -name "initial_b_offset_counts" -parent ${Gain/Offset_Control}

  #Adding Page
  set Overload_Settings [ipgui::add_page $IPINST -name "Overload Settings"]
  ipgui::add_param $IPINST -name "initial_led_select" -parent ${Overload_Settings} -widget comboBox
  ipgui::add_param $IPINST -name "initial_ovld_thresh" -parent ${Overload_Settings}
  ipgui::add_param $IPINST -name "led_pulse_stretch" -parent ${Overload_Settings}
  ipgui::add_param $IPINST -name "has_ext_led_src" -parent ${Overload_Settings}


}

proc update_PARAM_VALUE.differential_term { PARAM_VALUE.differential_term } {
	# Procedure called to update differential_term when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.differential_term { PARAM_VALUE.differential_term } {
	# Procedure called to validate differential_term
	return true
}

proc update_PARAM_VALUE.has_ext_led_src { PARAM_VALUE.has_ext_led_src } {
	# Procedure called to update has_ext_led_src when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_ext_led_src { PARAM_VALUE.has_ext_led_src } {
	# Procedure called to validate has_ext_led_src
	return true
}

proc update_PARAM_VALUE.ibuf_low_pwr { PARAM_VALUE.ibuf_low_pwr } {
	# Procedure called to update ibuf_low_pwr when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ibuf_low_pwr { PARAM_VALUE.ibuf_low_pwr } {
	# Procedure called to validate ibuf_low_pwr
	return true
}

proc update_PARAM_VALUE.idelaycntrl_refclk_freq { PARAM_VALUE.idelaycntrl_refclk_freq } {
	# Procedure called to update idelaycntrl_refclk_freq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.idelaycntrl_refclk_freq { PARAM_VALUE.idelaycntrl_refclk_freq } {
	# Procedure called to validate idelaycntrl_refclk_freq
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

proc update_PARAM_VALUE.initial_pdwnf_a { PARAM_VALUE.initial_pdwnf_a } {
	# Procedure called to update initial_pdwnf_a when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_pdwnf_a { PARAM_VALUE.initial_pdwnf_a } {
	# Procedure called to validate initial_pdwnf_a
	return true
}

proc update_PARAM_VALUE.initial_pdwnf_b { PARAM_VALUE.initial_pdwnf_b } {
	# Procedure called to update initial_pdwnf_b when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_pdwnf_b { PARAM_VALUE.initial_pdwnf_b } {
	# Procedure called to validate initial_pdwnf_b
	return true
}

proc update_PARAM_VALUE.initial_tap_delay { PARAM_VALUE.initial_tap_delay } {
	# Procedure called to update initial_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_tap_delay { PARAM_VALUE.initial_tap_delay } {
	# Procedure called to validate initial_tap_delay
	return true
}

proc update_PARAM_VALUE.iodelay_grp_a01 { PARAM_VALUE.iodelay_grp_a01 } {
	# Procedure called to update iodelay_grp_a01 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_a01 { PARAM_VALUE.iodelay_grp_a01 } {
	# Procedure called to validate iodelay_grp_a01
	return true
}

proc update_PARAM_VALUE.iodelay_grp_a1011 { PARAM_VALUE.iodelay_grp_a1011 } {
	# Procedure called to update iodelay_grp_a1011 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_a1011 { PARAM_VALUE.iodelay_grp_a1011 } {
	# Procedure called to validate iodelay_grp_a1011
	return true
}

proc update_PARAM_VALUE.iodelay_grp_a1213 { PARAM_VALUE.iodelay_grp_a1213 } {
	# Procedure called to update iodelay_grp_a1213 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_a1213 { PARAM_VALUE.iodelay_grp_a1213 } {
	# Procedure called to validate iodelay_grp_a1213
	return true
}

proc update_PARAM_VALUE.iodelay_grp_a1415 { PARAM_VALUE.iodelay_grp_a1415 } {
	# Procedure called to update iodelay_grp_a1415 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_a1415 { PARAM_VALUE.iodelay_grp_a1415 } {
	# Procedure called to validate iodelay_grp_a1415
	return true
}

proc update_PARAM_VALUE.iodelay_grp_a23 { PARAM_VALUE.iodelay_grp_a23 } {
	# Procedure called to update iodelay_grp_a23 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_a23 { PARAM_VALUE.iodelay_grp_a23 } {
	# Procedure called to validate iodelay_grp_a23
	return true
}

proc update_PARAM_VALUE.iodelay_grp_a45 { PARAM_VALUE.iodelay_grp_a45 } {
	# Procedure called to update iodelay_grp_a45 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_a45 { PARAM_VALUE.iodelay_grp_a45 } {
	# Procedure called to validate iodelay_grp_a45
	return true
}

proc update_PARAM_VALUE.iodelay_grp_a67 { PARAM_VALUE.iodelay_grp_a67 } {
	# Procedure called to update iodelay_grp_a67 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_a67 { PARAM_VALUE.iodelay_grp_a67 } {
	# Procedure called to validate iodelay_grp_a67
	return true
}

proc update_PARAM_VALUE.iodelay_grp_a89 { PARAM_VALUE.iodelay_grp_a89 } {
	# Procedure called to update iodelay_grp_a89 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_a89 { PARAM_VALUE.iodelay_grp_a89 } {
	# Procedure called to validate iodelay_grp_a89
	return true
}

proc update_PARAM_VALUE.iodelay_grp_b01 { PARAM_VALUE.iodelay_grp_b01 } {
	# Procedure called to update iodelay_grp_b01 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_b01 { PARAM_VALUE.iodelay_grp_b01 } {
	# Procedure called to validate iodelay_grp_b01
	return true
}

proc update_PARAM_VALUE.iodelay_grp_b1011 { PARAM_VALUE.iodelay_grp_b1011 } {
	# Procedure called to update iodelay_grp_b1011 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_b1011 { PARAM_VALUE.iodelay_grp_b1011 } {
	# Procedure called to validate iodelay_grp_b1011
	return true
}

proc update_PARAM_VALUE.iodelay_grp_b1213 { PARAM_VALUE.iodelay_grp_b1213 } {
	# Procedure called to update iodelay_grp_b1213 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_b1213 { PARAM_VALUE.iodelay_grp_b1213 } {
	# Procedure called to validate iodelay_grp_b1213
	return true
}

proc update_PARAM_VALUE.iodelay_grp_b1415 { PARAM_VALUE.iodelay_grp_b1415 } {
	# Procedure called to update iodelay_grp_b1415 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_b1415 { PARAM_VALUE.iodelay_grp_b1415 } {
	# Procedure called to validate iodelay_grp_b1415
	return true
}

proc update_PARAM_VALUE.iodelay_grp_b23 { PARAM_VALUE.iodelay_grp_b23 } {
	# Procedure called to update iodelay_grp_b23 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_b23 { PARAM_VALUE.iodelay_grp_b23 } {
	# Procedure called to validate iodelay_grp_b23
	return true
}

proc update_PARAM_VALUE.iodelay_grp_b45 { PARAM_VALUE.iodelay_grp_b45 } {
	# Procedure called to update iodelay_grp_b45 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_b45 { PARAM_VALUE.iodelay_grp_b45 } {
	# Procedure called to validate iodelay_grp_b45
	return true
}

proc update_PARAM_VALUE.iodelay_grp_b67 { PARAM_VALUE.iodelay_grp_b67 } {
	# Procedure called to update iodelay_grp_b67 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_b67 { PARAM_VALUE.iodelay_grp_b67 } {
	# Procedure called to validate iodelay_grp_b67
	return true
}

proc update_PARAM_VALUE.iodelay_grp_b89 { PARAM_VALUE.iodelay_grp_b89 } {
	# Procedure called to update iodelay_grp_b89 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_b89 { PARAM_VALUE.iodelay_grp_b89 } {
	# Procedure called to validate iodelay_grp_b89
	return true
}

proc update_PARAM_VALUE.led_pulse_stretch { PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to update led_pulse_stretch when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.led_pulse_stretch { PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to validate led_pulse_stretch
	return true
}


proc update_MODELPARAM_VALUE.iodelay_grp_a01 { MODELPARAM_VALUE.iodelay_grp_a01 PARAM_VALUE.iodelay_grp_a01 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_a01}] ${MODELPARAM_VALUE.iodelay_grp_a01}
}

proc update_MODELPARAM_VALUE.iodelay_grp_a23 { MODELPARAM_VALUE.iodelay_grp_a23 PARAM_VALUE.iodelay_grp_a23 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_a23}] ${MODELPARAM_VALUE.iodelay_grp_a23}
}

proc update_MODELPARAM_VALUE.iodelay_grp_a45 { MODELPARAM_VALUE.iodelay_grp_a45 PARAM_VALUE.iodelay_grp_a45 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_a45}] ${MODELPARAM_VALUE.iodelay_grp_a45}
}

proc update_MODELPARAM_VALUE.iodelay_grp_a67 { MODELPARAM_VALUE.iodelay_grp_a67 PARAM_VALUE.iodelay_grp_a67 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_a67}] ${MODELPARAM_VALUE.iodelay_grp_a67}
}

proc update_MODELPARAM_VALUE.iodelay_grp_a89 { MODELPARAM_VALUE.iodelay_grp_a89 PARAM_VALUE.iodelay_grp_a89 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_a89}] ${MODELPARAM_VALUE.iodelay_grp_a89}
}

proc update_MODELPARAM_VALUE.iodelay_grp_a1011 { MODELPARAM_VALUE.iodelay_grp_a1011 PARAM_VALUE.iodelay_grp_a1011 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_a1011}] ${MODELPARAM_VALUE.iodelay_grp_a1011}
}

proc update_MODELPARAM_VALUE.iodelay_grp_a1213 { MODELPARAM_VALUE.iodelay_grp_a1213 PARAM_VALUE.iodelay_grp_a1213 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_a1213}] ${MODELPARAM_VALUE.iodelay_grp_a1213}
}

proc update_MODELPARAM_VALUE.iodelay_grp_a1415 { MODELPARAM_VALUE.iodelay_grp_a1415 PARAM_VALUE.iodelay_grp_a1415 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_a1415}] ${MODELPARAM_VALUE.iodelay_grp_a1415}
}

proc update_MODELPARAM_VALUE.iodelay_grp_b01 { MODELPARAM_VALUE.iodelay_grp_b01 PARAM_VALUE.iodelay_grp_b01 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_b01}] ${MODELPARAM_VALUE.iodelay_grp_b01}
}

proc update_MODELPARAM_VALUE.iodelay_grp_b23 { MODELPARAM_VALUE.iodelay_grp_b23 PARAM_VALUE.iodelay_grp_b23 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_b23}] ${MODELPARAM_VALUE.iodelay_grp_b23}
}

proc update_MODELPARAM_VALUE.iodelay_grp_b45 { MODELPARAM_VALUE.iodelay_grp_b45 PARAM_VALUE.iodelay_grp_b45 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_b45}] ${MODELPARAM_VALUE.iodelay_grp_b45}
}

proc update_MODELPARAM_VALUE.iodelay_grp_b67 { MODELPARAM_VALUE.iodelay_grp_b67 PARAM_VALUE.iodelay_grp_b67 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_b67}] ${MODELPARAM_VALUE.iodelay_grp_b67}
}

proc update_MODELPARAM_VALUE.iodelay_grp_b89 { MODELPARAM_VALUE.iodelay_grp_b89 PARAM_VALUE.iodelay_grp_b89 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_b89}] ${MODELPARAM_VALUE.iodelay_grp_b89}
}

proc update_MODELPARAM_VALUE.iodelay_grp_b1011 { MODELPARAM_VALUE.iodelay_grp_b1011 PARAM_VALUE.iodelay_grp_b1011 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_b1011}] ${MODELPARAM_VALUE.iodelay_grp_b1011}
}

proc update_MODELPARAM_VALUE.iodelay_grp_b1213 { MODELPARAM_VALUE.iodelay_grp_b1213 PARAM_VALUE.iodelay_grp_b1213 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_b1213}] ${MODELPARAM_VALUE.iodelay_grp_b1213}
}

proc update_MODELPARAM_VALUE.iodelay_grp_b1415 { MODELPARAM_VALUE.iodelay_grp_b1415 PARAM_VALUE.iodelay_grp_b1415 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_b1415}] ${MODELPARAM_VALUE.iodelay_grp_b1415}
}

proc update_MODELPARAM_VALUE.initial_tap_delay { MODELPARAM_VALUE.initial_tap_delay PARAM_VALUE.initial_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_tap_delay}] ${MODELPARAM_VALUE.initial_tap_delay}
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

proc update_MODELPARAM_VALUE.initial_pdwnf_a { MODELPARAM_VALUE.initial_pdwnf_a PARAM_VALUE.initial_pdwnf_a } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_pdwnf_a}] ${MODELPARAM_VALUE.initial_pdwnf_a}
}

proc update_MODELPARAM_VALUE.initial_pdwnf_b { MODELPARAM_VALUE.initial_pdwnf_b PARAM_VALUE.initial_pdwnf_b } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_pdwnf_b}] ${MODELPARAM_VALUE.initial_pdwnf_b}
}

proc update_MODELPARAM_VALUE.initial_led_select { MODELPARAM_VALUE.initial_led_select PARAM_VALUE.initial_led_select } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_led_select}] ${MODELPARAM_VALUE.initial_led_select}
}

proc update_MODELPARAM_VALUE.differential_term { MODELPARAM_VALUE.differential_term PARAM_VALUE.differential_term } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.differential_term}] ${MODELPARAM_VALUE.differential_term}
}

proc update_MODELPARAM_VALUE.ibuf_low_pwr { MODELPARAM_VALUE.ibuf_low_pwr PARAM_VALUE.ibuf_low_pwr } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ibuf_low_pwr}] ${MODELPARAM_VALUE.ibuf_low_pwr}
}

proc update_MODELPARAM_VALUE.has_ext_led_src { MODELPARAM_VALUE.has_ext_led_src PARAM_VALUE.has_ext_led_src } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_ext_led_src}] ${MODELPARAM_VALUE.has_ext_led_src}
}

proc update_MODELPARAM_VALUE.idelaycntrl_refclk_freq { MODELPARAM_VALUE.idelaycntrl_refclk_freq PARAM_VALUE.idelaycntrl_refclk_freq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.idelaycntrl_refclk_freq}] ${MODELPARAM_VALUE.idelaycntrl_refclk_freq}
}

proc update_MODELPARAM_VALUE.initial_ovld_thresh { MODELPARAM_VALUE.initial_ovld_thresh PARAM_VALUE.initial_ovld_thresh } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_ovld_thresh}] ${MODELPARAM_VALUE.initial_ovld_thresh}
}

proc update_MODELPARAM_VALUE.led_pulse_stretch { MODELPARAM_VALUE.led_pulse_stretch PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.led_pulse_stretch}] ${MODELPARAM_VALUE.led_pulse_stretch}
}

