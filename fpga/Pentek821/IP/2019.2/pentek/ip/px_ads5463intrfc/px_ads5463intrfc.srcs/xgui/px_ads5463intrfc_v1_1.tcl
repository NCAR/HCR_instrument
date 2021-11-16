# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Input_Buffers [ipgui::add_page $IPINST -name "Input Buffers"]
  ipgui::add_param $IPINST -name "differential_term" -parent ${Input_Buffers} -layout horizontal
  ipgui::add_param $IPINST -name "ibuf_low_pwr" -parent ${Input_Buffers}
  ipgui::add_param $IPINST -name "idelaycntrl_refclk_freq" -parent ${Input_Buffers}

  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0" -display_name {Input Delay}]
  ipgui::add_param $IPINST -name "initial_tap_delay" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_0" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_2" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_3" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_4" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_5" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_13" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_12" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_11" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_10" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_9" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_8" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_7" -parent ${Page_0}
  ipgui::add_param $IPINST -name "iodelay_grp_6" -parent ${Page_0}

  #Adding Page
  set ADC_Control [ipgui::add_page $IPINST -name "ADC Control"]
  ipgui::add_param $IPINST -name "initial_2scomp" -parent ${ADC_Control}
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

proc update_PARAM_VALUE.iodelay_grp_0 { PARAM_VALUE.iodelay_grp_0 } {
	# Procedure called to update iodelay_grp_0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_0 { PARAM_VALUE.iodelay_grp_0 } {
	# Procedure called to validate iodelay_grp_0
	return true
}

proc update_PARAM_VALUE.iodelay_grp_1 { PARAM_VALUE.iodelay_grp_1 } {
	# Procedure called to update iodelay_grp_1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_1 { PARAM_VALUE.iodelay_grp_1 } {
	# Procedure called to validate iodelay_grp_1
	return true
}

proc update_PARAM_VALUE.iodelay_grp_10 { PARAM_VALUE.iodelay_grp_10 } {
	# Procedure called to update iodelay_grp_10 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_10 { PARAM_VALUE.iodelay_grp_10 } {
	# Procedure called to validate iodelay_grp_10
	return true
}

proc update_PARAM_VALUE.iodelay_grp_11 { PARAM_VALUE.iodelay_grp_11 } {
	# Procedure called to update iodelay_grp_11 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_11 { PARAM_VALUE.iodelay_grp_11 } {
	# Procedure called to validate iodelay_grp_11
	return true
}

proc update_PARAM_VALUE.iodelay_grp_12 { PARAM_VALUE.iodelay_grp_12 } {
	# Procedure called to update iodelay_grp_12 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_12 { PARAM_VALUE.iodelay_grp_12 } {
	# Procedure called to validate iodelay_grp_12
	return true
}

proc update_PARAM_VALUE.iodelay_grp_13 { PARAM_VALUE.iodelay_grp_13 } {
	# Procedure called to update iodelay_grp_13 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_13 { PARAM_VALUE.iodelay_grp_13 } {
	# Procedure called to validate iodelay_grp_13
	return true
}

proc update_PARAM_VALUE.iodelay_grp_2 { PARAM_VALUE.iodelay_grp_2 } {
	# Procedure called to update iodelay_grp_2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_2 { PARAM_VALUE.iodelay_grp_2 } {
	# Procedure called to validate iodelay_grp_2
	return true
}

proc update_PARAM_VALUE.iodelay_grp_3 { PARAM_VALUE.iodelay_grp_3 } {
	# Procedure called to update iodelay_grp_3 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_3 { PARAM_VALUE.iodelay_grp_3 } {
	# Procedure called to validate iodelay_grp_3
	return true
}

proc update_PARAM_VALUE.iodelay_grp_4 { PARAM_VALUE.iodelay_grp_4 } {
	# Procedure called to update iodelay_grp_4 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_4 { PARAM_VALUE.iodelay_grp_4 } {
	# Procedure called to validate iodelay_grp_4
	return true
}

proc update_PARAM_VALUE.iodelay_grp_5 { PARAM_VALUE.iodelay_grp_5 } {
	# Procedure called to update iodelay_grp_5 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_5 { PARAM_VALUE.iodelay_grp_5 } {
	# Procedure called to validate iodelay_grp_5
	return true
}

proc update_PARAM_VALUE.iodelay_grp_6 { PARAM_VALUE.iodelay_grp_6 } {
	# Procedure called to update iodelay_grp_6 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_6 { PARAM_VALUE.iodelay_grp_6 } {
	# Procedure called to validate iodelay_grp_6
	return true
}

proc update_PARAM_VALUE.iodelay_grp_7 { PARAM_VALUE.iodelay_grp_7 } {
	# Procedure called to update iodelay_grp_7 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_7 { PARAM_VALUE.iodelay_grp_7 } {
	# Procedure called to validate iodelay_grp_7
	return true
}

proc update_PARAM_VALUE.iodelay_grp_8 { PARAM_VALUE.iodelay_grp_8 } {
	# Procedure called to update iodelay_grp_8 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_8 { PARAM_VALUE.iodelay_grp_8 } {
	# Procedure called to validate iodelay_grp_8
	return true
}

proc update_PARAM_VALUE.iodelay_grp_9 { PARAM_VALUE.iodelay_grp_9 } {
	# Procedure called to update iodelay_grp_9 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp_9 { PARAM_VALUE.iodelay_grp_9 } {
	# Procedure called to validate iodelay_grp_9
	return true
}

proc update_PARAM_VALUE.led_pulse_stretch { PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to update led_pulse_stretch when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.led_pulse_stretch { PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to validate led_pulse_stretch
	return true
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

proc update_MODELPARAM_VALUE.iodelay_grp_0 { MODELPARAM_VALUE.iodelay_grp_0 PARAM_VALUE.iodelay_grp_0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_0}] ${MODELPARAM_VALUE.iodelay_grp_0}
}

proc update_MODELPARAM_VALUE.iodelay_grp_1 { MODELPARAM_VALUE.iodelay_grp_1 PARAM_VALUE.iodelay_grp_1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_1}] ${MODELPARAM_VALUE.iodelay_grp_1}
}

proc update_MODELPARAM_VALUE.iodelay_grp_2 { MODELPARAM_VALUE.iodelay_grp_2 PARAM_VALUE.iodelay_grp_2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_2}] ${MODELPARAM_VALUE.iodelay_grp_2}
}

proc update_MODELPARAM_VALUE.iodelay_grp_3 { MODELPARAM_VALUE.iodelay_grp_3 PARAM_VALUE.iodelay_grp_3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_3}] ${MODELPARAM_VALUE.iodelay_grp_3}
}

proc update_MODELPARAM_VALUE.iodelay_grp_4 { MODELPARAM_VALUE.iodelay_grp_4 PARAM_VALUE.iodelay_grp_4 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_4}] ${MODELPARAM_VALUE.iodelay_grp_4}
}

proc update_MODELPARAM_VALUE.iodelay_grp_5 { MODELPARAM_VALUE.iodelay_grp_5 PARAM_VALUE.iodelay_grp_5 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_5}] ${MODELPARAM_VALUE.iodelay_grp_5}
}

proc update_MODELPARAM_VALUE.iodelay_grp_6 { MODELPARAM_VALUE.iodelay_grp_6 PARAM_VALUE.iodelay_grp_6 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_6}] ${MODELPARAM_VALUE.iodelay_grp_6}
}

proc update_MODELPARAM_VALUE.iodelay_grp_7 { MODELPARAM_VALUE.iodelay_grp_7 PARAM_VALUE.iodelay_grp_7 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_7}] ${MODELPARAM_VALUE.iodelay_grp_7}
}

proc update_MODELPARAM_VALUE.iodelay_grp_8 { MODELPARAM_VALUE.iodelay_grp_8 PARAM_VALUE.iodelay_grp_8 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_8}] ${MODELPARAM_VALUE.iodelay_grp_8}
}

proc update_MODELPARAM_VALUE.iodelay_grp_9 { MODELPARAM_VALUE.iodelay_grp_9 PARAM_VALUE.iodelay_grp_9 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_9}] ${MODELPARAM_VALUE.iodelay_grp_9}
}

proc update_MODELPARAM_VALUE.iodelay_grp_10 { MODELPARAM_VALUE.iodelay_grp_10 PARAM_VALUE.iodelay_grp_10 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_10}] ${MODELPARAM_VALUE.iodelay_grp_10}
}

proc update_MODELPARAM_VALUE.iodelay_grp_11 { MODELPARAM_VALUE.iodelay_grp_11 PARAM_VALUE.iodelay_grp_11 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_11}] ${MODELPARAM_VALUE.iodelay_grp_11}
}

proc update_MODELPARAM_VALUE.iodelay_grp_12 { MODELPARAM_VALUE.iodelay_grp_12 PARAM_VALUE.iodelay_grp_12 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_12}] ${MODELPARAM_VALUE.iodelay_grp_12}
}

proc update_MODELPARAM_VALUE.iodelay_grp_13 { MODELPARAM_VALUE.iodelay_grp_13 PARAM_VALUE.iodelay_grp_13 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp_13}] ${MODELPARAM_VALUE.iodelay_grp_13}
}

