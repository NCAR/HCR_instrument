# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Input_Buffers [ipgui::add_page $IPINST -name "Input Buffers"]
  ipgui::add_param $IPINST -name "differential_term" -parent ${Input_Buffers} -layout horizontal
  ipgui::add_param $IPINST -name "ibuf_low_pwr" -parent ${Input_Buffers}
  ipgui::add_param $IPINST -name "idelaycntrl_refclk_freq" -parent ${Input_Buffers}
  ipgui::add_param $IPINST -name "iodelay_grp_01" -parent ${Input_Buffers}
  ipgui::add_param $IPINST -name "iodelay_grp_23" -parent ${Input_Buffers}
  ipgui::add_param $IPINST -name "iodelay_grp_45" -parent ${Input_Buffers}
  ipgui::add_param $IPINST -name "iodelay_grp_67" -parent ${Input_Buffers}
  ipgui::add_param $IPINST -name "iodelay_grp_89" -parent ${Input_Buffers}
  ipgui::add_param $IPINST -name "iodelay_grp_1011" -parent ${Input_Buffers}
  ipgui::add_param $IPINST -name "iodelay_grp_1213" -parent ${Input_Buffers}
  ipgui::add_param $IPINST -name "iodelay_grp_1415" -parent ${Input_Buffers}

  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0" -display_name {Input Delay}]
  ipgui::add_param $IPINST -name "initial_tap_delay" -parent ${Page_0}

  #Adding Page
  set ADC_Control [ipgui::add_page $IPINST -name "ADC Control"]
  ipgui::add_param $IPINST -name "initial_2scomp" -parent ${ADC_Control}
  ipgui::add_param $IPINST -name "initial_dither" -parent ${ADC_Control}
  ipgui::add_param $IPINST -name "initial_pdwnf" -parent ${ADC_Control}

  #Adding Page
  set Gain/Offset_Control [ipgui::add_page $IPINST -name "Gain/Offset Control"]
  set_property tooltip {Gain/Offset Control Initial Settings} ${Gain/Offset_Control}
  ipgui::add_param $IPINST -name "initial_offset_counts" -parent ${Gain/Offset_Control}
  ipgui::add_param $IPINST -name "initial_gain_percent" -parent ${Gain/Offset_Control}

  #Adding Page
  set Overload_Settings [ipgui::add_page $IPINST -name "Overload Settings"]
  ipgui::add_static_text $IPINST -name "ov_txt" -parent ${Overload_Settings} -text {Initial Overload LED Source at Reset

0 = ADC Input Overload

1 = Gain/Offset Trim Overload

2 = External Signal

3 = Disabled}
  ipgui::add_param $IPINST -name "initial_led_select" -parent ${Overload_Settings} -show_range false -widget comboBox
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

proc update_PARAM_VALUE.initial_2scomp { PARAM_VALUE.initial_2scomp } {
	# Procedure called to update initial_2scomp when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_2scomp { PARAM_VALUE.initial_2scomp } {
	# Procedure called to validate initial_2scomp
	return true
}

proc update_PARAM_VALUE.initial_dither { PARAM_VALUE.initial_dither } {
	# Procedure called to update initial_dither when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_dither { PARAM_VALUE.initial_dither } {
	# Procedure called to validate initial_dither
	return true
}

proc update_PARAM_VALUE.initial_gain_percent { PARAM_VALUE.initial_gain_percent } {
	# Procedure called to update initial_gain_percent when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_gain_percent { PARAM_VALUE.initial_gain_percent } {
	# Procedure called to validate initial_gain_percent
	return true
}

proc update_PARAM_VALUE.initial_led_select { PARAM_VALUE.initial_led_select } {
	# Procedure called to update initial_led_select when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_led_select { PARAM_VALUE.initial_led_select } {
	# Procedure called to validate initial_led_select
	return true
}

proc update_PARAM_VALUE.initial_offset_counts { PARAM_VALUE.initial_offset_counts } {
	# Procedure called to update initial_offset_counts when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_offset_counts { PARAM_VALUE.initial_offset_counts } {
	# Procedure called to validate initial_offset_counts
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

proc update_PARAM_VALUE.initial_tap_delay { PARAM_VALUE.initial_tap_delay } {
	# Procedure called to update initial_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_tap_delay { PARAM_VALUE.initial_tap_delay } {
	# Procedure called to validate initial_tap_delay
	return true
}

proc update_PARAM_VALUE.iodelay_grp_01 { PARAM_VALUE.iodelay_grp_01 } {
	# Procedure called to update iodelay_grp_01 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_01 { PARAM_VALUE.iodelay_grp_01 } {
	# Procedure called to validate iodelay_grp_01
	return true
}

proc update_PARAM_VALUE.iodelay_grp_1011 { PARAM_VALUE.iodelay_grp_1011 } {
	# Procedure called to update iodelay_grp_1011 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_1011 { PARAM_VALUE.iodelay_grp_1011 } {
	# Procedure called to validate iodelay_grp_1011
	return true
}

proc update_PARAM_VALUE.iodelay_grp_1213 { PARAM_VALUE.iodelay_grp_1213 } {
	# Procedure called to update iodelay_grp_1213 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_1213 { PARAM_VALUE.iodelay_grp_1213 } {
	# Procedure called to validate iodelay_grp_1213
	return true
}

proc update_PARAM_VALUE.iodelay_grp_1415 { PARAM_VALUE.iodelay_grp_1415 } {
	# Procedure called to update iodelay_grp_1415 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_1415 { PARAM_VALUE.iodelay_grp_1415 } {
	# Procedure called to validate iodelay_grp_1415
	return true
}

proc update_PARAM_VALUE.iodelay_grp_23 { PARAM_VALUE.iodelay_grp_23 } {
	# Procedure called to update iodelay_grp_23 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_23 { PARAM_VALUE.iodelay_grp_23 } {
	# Procedure called to validate iodelay_grp_23
	return true
}

proc update_PARAM_VALUE.iodelay_grp_45 { PARAM_VALUE.iodelay_grp_45 } {
	# Procedure called to update iodelay_grp_45 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_45 { PARAM_VALUE.iodelay_grp_45 } {
	# Procedure called to validate iodelay_grp_45
	return true
}

proc update_PARAM_VALUE.iodelay_grp_67 { PARAM_VALUE.iodelay_grp_67 } {
	# Procedure called to update iodelay_grp_67 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_67 { PARAM_VALUE.iodelay_grp_67 } {
	# Procedure called to validate iodelay_grp_67
	return true
}

proc update_PARAM_VALUE.iodelay_grp_89 { PARAM_VALUE.iodelay_grp_89 } {
	# Procedure called to update iodelay_grp_89 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_89 { PARAM_VALUE.iodelay_grp_89 } {
	# Procedure called to validate iodelay_grp_89
	return true
}

proc update_PARAM_VALUE.led_pulse_stretch { PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to update led_pulse_stretch when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.led_pulse_stretch { PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to validate led_pulse_stretch
	return true
}


proc update_MODELPARAM_VALUE.iodelay_grp_01 { MODELPARAM_VALUE.iodelay_grp_01 PARAM_VALUE.iodelay_grp_01 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_01}] ${MODELPARAM_VALUE.iodelay_grp_01}
}

proc update_MODELPARAM_VALUE.iodelay_grp_23 { MODELPARAM_VALUE.iodelay_grp_23 PARAM_VALUE.iodelay_grp_23 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_23}] ${MODELPARAM_VALUE.iodelay_grp_23}
}

proc update_MODELPARAM_VALUE.iodelay_grp_45 { MODELPARAM_VALUE.iodelay_grp_45 PARAM_VALUE.iodelay_grp_45 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_45}] ${MODELPARAM_VALUE.iodelay_grp_45}
}

proc update_MODELPARAM_VALUE.iodelay_grp_67 { MODELPARAM_VALUE.iodelay_grp_67 PARAM_VALUE.iodelay_grp_67 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_67}] ${MODELPARAM_VALUE.iodelay_grp_67}
}

proc update_MODELPARAM_VALUE.iodelay_grp_89 { MODELPARAM_VALUE.iodelay_grp_89 PARAM_VALUE.iodelay_grp_89 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_89}] ${MODELPARAM_VALUE.iodelay_grp_89}
}

proc update_MODELPARAM_VALUE.iodelay_grp_1011 { MODELPARAM_VALUE.iodelay_grp_1011 PARAM_VALUE.iodelay_grp_1011 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_1011}] ${MODELPARAM_VALUE.iodelay_grp_1011}
}

proc update_MODELPARAM_VALUE.iodelay_grp_1213 { MODELPARAM_VALUE.iodelay_grp_1213 PARAM_VALUE.iodelay_grp_1213 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_1213}] ${MODELPARAM_VALUE.iodelay_grp_1213}
}

proc update_MODELPARAM_VALUE.iodelay_grp_1415 { MODELPARAM_VALUE.iodelay_grp_1415 PARAM_VALUE.iodelay_grp_1415 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_1415}] ${MODELPARAM_VALUE.iodelay_grp_1415}
}

proc update_MODELPARAM_VALUE.initial_tap_delay { MODELPARAM_VALUE.initial_tap_delay PARAM_VALUE.initial_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_tap_delay}] ${MODELPARAM_VALUE.initial_tap_delay}
}

proc update_MODELPARAM_VALUE.initial_gain_percent { MODELPARAM_VALUE.initial_gain_percent PARAM_VALUE.initial_gain_percent } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_gain_percent}] ${MODELPARAM_VALUE.initial_gain_percent}
}

proc update_MODELPARAM_VALUE.initial_offset_counts { MODELPARAM_VALUE.initial_offset_counts PARAM_VALUE.initial_offset_counts } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_offset_counts}] ${MODELPARAM_VALUE.initial_offset_counts}
}

proc update_MODELPARAM_VALUE.initial_2scomp { MODELPARAM_VALUE.initial_2scomp PARAM_VALUE.initial_2scomp } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_2scomp}] ${MODELPARAM_VALUE.initial_2scomp}
}

proc update_MODELPARAM_VALUE.initial_pdwnf { MODELPARAM_VALUE.initial_pdwnf PARAM_VALUE.initial_pdwnf } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_pdwnf}] ${MODELPARAM_VALUE.initial_pdwnf}
}

proc update_MODELPARAM_VALUE.initial_dither { MODELPARAM_VALUE.initial_dither PARAM_VALUE.initial_dither } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_dither}] ${MODELPARAM_VALUE.initial_dither}
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

