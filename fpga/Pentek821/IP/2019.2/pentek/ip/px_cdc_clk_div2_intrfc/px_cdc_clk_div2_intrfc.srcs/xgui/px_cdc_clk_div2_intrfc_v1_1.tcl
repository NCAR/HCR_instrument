# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "differential_term" -parent ${Page_0} -layout horizontal
  ipgui::add_param $IPINST -name "ibuf_low_pwr" -parent ${Page_0}
  set invert_in_clk [ipgui::add_param $IPINST -name "invert_in_clk" -parent ${Page_0}]
  set_property tooltip {Invert if you want output clock to tansition on falling edges of input clock} ${invert_in_clk}
  ipgui::add_param $IPINST -name "initial_led_mode" -parent ${Page_0} -widget comboBox
  ipgui::add_static_text $IPINST -name "LED_TXT" -parent ${Page_0} -text {

LED Mode:

0 = Clock Good

1 = Clock Good & VCXO OK

2 = Clock Good & VCXO OK & Ref OK & CDC Lock}


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

proc update_PARAM_VALUE.initial_led_mode { PARAM_VALUE.initial_led_mode } {
	# Procedure called to update initial_led_mode when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_led_mode { PARAM_VALUE.initial_led_mode } {
	# Procedure called to validate initial_led_mode
	return true
}

proc update_PARAM_VALUE.invert_in_clk { PARAM_VALUE.invert_in_clk } {
	# Procedure called to update invert_in_clk when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.invert_in_clk { PARAM_VALUE.invert_in_clk } {
	# Procedure called to validate invert_in_clk
	return true
}


proc update_MODELPARAM_VALUE.differential_term { MODELPARAM_VALUE.differential_term PARAM_VALUE.differential_term } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.differential_term}] ${MODELPARAM_VALUE.differential_term}
}

proc update_MODELPARAM_VALUE.ibuf_low_pwr { MODELPARAM_VALUE.ibuf_low_pwr PARAM_VALUE.ibuf_low_pwr } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ibuf_low_pwr}] ${MODELPARAM_VALUE.ibuf_low_pwr}
}

proc update_MODELPARAM_VALUE.initial_led_mode { MODELPARAM_VALUE.initial_led_mode PARAM_VALUE.initial_led_mode } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_led_mode}] ${MODELPARAM_VALUE.initial_led_mode}
}

proc update_MODELPARAM_VALUE.invert_in_clk { MODELPARAM_VALUE.invert_in_clk PARAM_VALUE.invert_in_clk } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.invert_in_clk}] ${MODELPARAM_VALUE.invert_in_clk}
}

