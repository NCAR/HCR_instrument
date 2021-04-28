# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "differential_term" -parent ${Page_0} -layout horizontal
  ipgui::add_param $IPINST -name "ibuf_low_pwr" -parent ${Page_0}
  set min_freq_div [ipgui::add_param $IPINST -name "min_freq_div" -parent ${Page_0} -widget comboBox]
  set_property tooltip {REFCLK divided by this number sets miminum good clock frequency} ${min_freq_div}
  ipgui::add_static_text $IPINST -name "txt1" -parent ${Page_0} -text {REFCLK divided by this number sets miminum good clock frequency. (Example: REFCLK=200MHz, Divider = 16, Minimum Freq = 12.MHz)}
  ipgui::add_param $IPINST -name "short_good_clk_eval" -parent ${Page_0}


}

proc update_PARAM_VALUE.differential_term { PARAM_VALUE.differential_term } {
	# Procedure called to update differential_term when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.differential_term { PARAM_VALUE.differential_term } {
	# Procedure called to validate differential_term
	return true
}

proc update_PARAM_VALUE.ibuf_low_pwr { PARAM_VALUE.ibuf_low_pwr } {
	# Procedure called to update ibuf_low_pwr when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ibuf_low_pwr { PARAM_VALUE.ibuf_low_pwr } {
	# Procedure called to validate ibuf_low_pwr
	return true
}

proc update_PARAM_VALUE.min_freq_div { PARAM_VALUE.min_freq_div } {
	# Procedure called to update min_freq_div when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.min_freq_div { PARAM_VALUE.min_freq_div } {
	# Procedure called to validate min_freq_div
	return true
}

proc update_PARAM_VALUE.short_good_clk_eval { PARAM_VALUE.short_good_clk_eval } {
	# Procedure called to update short_good_clk_eval when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.short_good_clk_eval { PARAM_VALUE.short_good_clk_eval } {
	# Procedure called to validate short_good_clk_eval
	return true
}


proc update_MODELPARAM_VALUE.min_freq_div { MODELPARAM_VALUE.min_freq_div PARAM_VALUE.min_freq_div } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.min_freq_div}] ${MODELPARAM_VALUE.min_freq_div}
}

proc update_MODELPARAM_VALUE.differential_term { MODELPARAM_VALUE.differential_term PARAM_VALUE.differential_term } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.differential_term}] ${MODELPARAM_VALUE.differential_term}
}

proc update_MODELPARAM_VALUE.ibuf_low_pwr { MODELPARAM_VALUE.ibuf_low_pwr PARAM_VALUE.ibuf_low_pwr } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ibuf_low_pwr}] ${MODELPARAM_VALUE.ibuf_low_pwr}
}

proc update_MODELPARAM_VALUE.short_good_clk_eval { MODELPARAM_VALUE.short_good_clk_eval PARAM_VALUE.short_good_clk_eval } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.short_good_clk_eval}] ${MODELPARAM_VALUE.short_good_clk_eval}
}

