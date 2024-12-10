# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Input_Buffers [ipgui::add_page $IPINST -name "Input Buffers"]
  ipgui::add_param $IPINST -name "ibuf_low_pwr" -parent ${Input_Buffers}
  ipgui::add_param $IPINST -name "idelaycntrl_refclk_freq" -parent ${Input_Buffers}
  ipgui::add_param $IPINST -name "iodelay_grp" -parent ${Input_Buffers}

  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0" -display_name {Input Delay}]
  ipgui::add_param $IPINST -name "initial_tap_delay" -parent ${Page_0}

  #Adding Page
  set ADC_Control [ipgui::add_page $IPINST -name "ADC Control"]
  set nondes_iq_swap [ipgui::add_param $IPINST -name "nondes_iq_swap" -parent ${ADC_Control}]
  set_property tooltip {Swap I and Q channels in Non-DES Mode} ${nondes_iq_swap}
  ipgui::add_param $IPINST -name "initial_2scomp" -parent ${ADC_Control}

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

proc update_PARAM_VALUE.initial_tap_delay { PARAM_VALUE.initial_tap_delay } {
	# Procedure called to update initial_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_tap_delay { PARAM_VALUE.initial_tap_delay } {
	# Procedure called to validate initial_tap_delay
	return true
}

proc update_PARAM_VALUE.iodelay_grp { PARAM_VALUE.iodelay_grp } {
	# Procedure called to update iodelay_grp when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.iodelay_grp { PARAM_VALUE.iodelay_grp } {
	# Procedure called to validate iodelay_grp
	return true
}

proc update_PARAM_VALUE.led_pulse_stretch { PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to update led_pulse_stretch when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.led_pulse_stretch { PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to validate led_pulse_stretch
	return true
}

proc update_PARAM_VALUE.nondes_iq_swap { PARAM_VALUE.nondes_iq_swap } {
	# Procedure called to update nondes_iq_swap when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.nondes_iq_swap { PARAM_VALUE.nondes_iq_swap } {
	# Procedure called to validate nondes_iq_swap
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

proc update_MODELPARAM_VALUE.initial_led_select { MODELPARAM_VALUE.initial_led_select PARAM_VALUE.initial_led_select } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_led_select}] ${MODELPARAM_VALUE.initial_led_select}
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

proc update_MODELPARAM_VALUE.iodelay_grp { MODELPARAM_VALUE.iodelay_grp PARAM_VALUE.iodelay_grp } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.iodelay_grp}] ${MODELPARAM_VALUE.iodelay_grp}
}

proc update_MODELPARAM_VALUE.nondes_iq_swap { MODELPARAM_VALUE.nondes_iq_swap PARAM_VALUE.nondes_iq_swap } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.nondes_iq_swap}] ${MODELPARAM_VALUE.nondes_iq_swap}
}

