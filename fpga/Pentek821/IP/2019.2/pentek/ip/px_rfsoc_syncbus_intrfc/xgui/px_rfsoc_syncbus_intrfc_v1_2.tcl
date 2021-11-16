# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  ipgui::add_param $IPINST -name "refclk_freq_int"
  ipgui::add_param $IPINST -name "ext_axiclk_version"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0" -display_name {Gate}]
  set_property tooltip {Gate Configuration} ${Page_0}
  ipgui::add_param $IPINST -name "has_pin_gate_in" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_fabric_gate_in" -parent ${Page_0}
  ipgui::add_param $IPINST -name "use_gate_tap_delay" -parent ${Page_0}
  ipgui::add_param $IPINST -name "initial_gate_tap_delay" -parent ${Page_0}
  ipgui::add_param $IPINST -name "initial_gate_int_delay" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_pin_ttl_trig_in" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_fabric_trig_in" -parent ${Page_0}
  ipgui::add_param $IPINST -name "use_ttl_trig_tap_delay" -parent ${Page_0}
  ipgui::add_param $IPINST -name "initial_ttl_trig_tap_delay" -parent ${Page_0}
  ipgui::add_param $IPINST -name "initial_ttl_trig_int_delay" -parent ${Page_0}

  #Adding Page
  set Sync [ipgui::add_page $IPINST -name "Sync"]
  set_property tooltip {Sync Configuration} ${Sync}
  ipgui::add_param $IPINST -name "has_pin_sync_in" -parent ${Sync}
  ipgui::add_param $IPINST -name "has_fabric_sync_in" -parent ${Sync}
  ipgui::add_param $IPINST -name "use_sync_tap_delay" -parent ${Sync}
  ipgui::add_param $IPINST -name "initial_sync_tap_delay" -parent ${Sync}
  ipgui::add_param $IPINST -name "initial_sync_int_delay" -parent ${Sync}

  #Adding Page
  set PPS [ipgui::add_page $IPINST -name "PPS"]
  set_property tooltip {PPC Configuration} ${PPS}
  ipgui::add_param $IPINST -name "has_pps_in" -parent ${PPS}
  set has_rtc_pps_in [ipgui::add_param $IPINST -name "has_rtc_pps_in" -parent ${PPS}]
  set_property tooltip {From Processor RTC} ${has_rtc_pps_in}
  ipgui::add_param $IPINST -name "has_fabric_pps_in" -parent ${PPS}

  #Adding Page
  set Sysref [ipgui::add_page $IPINST -name "Sysref"]
  set_property tooltip {Sysref Configuration} ${Sysref}
  ipgui::add_param $IPINST -name "has_pin_sysref_in" -parent ${Sysref}
  ipgui::add_param $IPINST -name "has_fabric_sysref_in" -parent ${Sysref}
  ipgui::add_param $IPINST -name "use_sysref_tap_delay" -parent ${Sysref}
  ipgui::add_param $IPINST -name "initial_sysref_tap_delay" -parent ${Sysref}
  ipgui::add_param $IPINST -name "initial_sysref_int_delay" -parent ${Sysref}

  #Adding Page
  set LED [ipgui::add_page $IPINST -name "LED"]
  set_property tooltip {LED Configuration} ${LED}
  ipgui::add_static_text $IPINST -name "txt1" -parent ${LED} -text {0 - Gate
1 - Sync
2 - PPS
3 -  Sysref}
  ipgui::add_param $IPINST -name "initial_led_src" -parent ${LED}
  ipgui::add_param $IPINST -name "led_pulse_stretch" -parent ${LED}


}

proc update_PARAM_VALUE.ext_axiclk_version { PARAM_VALUE.ext_axiclk_version } {
	# Procedure called to update ext_axiclk_version when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ext_axiclk_version { PARAM_VALUE.ext_axiclk_version } {
	# Procedure called to validate ext_axiclk_version
	return true
}

proc update_PARAM_VALUE.has_fabric_gate_in { PARAM_VALUE.has_fabric_gate_in } {
	# Procedure called to update has_fabric_gate_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_fabric_gate_in { PARAM_VALUE.has_fabric_gate_in } {
	# Procedure called to validate has_fabric_gate_in
	return true
}

proc update_PARAM_VALUE.has_fabric_pps_in { PARAM_VALUE.has_fabric_pps_in } {
	# Procedure called to update has_fabric_pps_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_fabric_pps_in { PARAM_VALUE.has_fabric_pps_in } {
	# Procedure called to validate has_fabric_pps_in
	return true
}

proc update_PARAM_VALUE.has_fabric_sync_in { PARAM_VALUE.has_fabric_sync_in } {
	# Procedure called to update has_fabric_sync_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_fabric_sync_in { PARAM_VALUE.has_fabric_sync_in } {
	# Procedure called to validate has_fabric_sync_in
	return true
}

proc update_PARAM_VALUE.has_fabric_sysref_in { PARAM_VALUE.has_fabric_sysref_in } {
	# Procedure called to update has_fabric_sysref_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_fabric_sysref_in { PARAM_VALUE.has_fabric_sysref_in } {
	# Procedure called to validate has_fabric_sysref_in
	return true
}

proc update_PARAM_VALUE.has_fabric_trig_in { PARAM_VALUE.has_fabric_trig_in } {
	# Procedure called to update has_fabric_trig_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_fabric_trig_in { PARAM_VALUE.has_fabric_trig_in } {
	# Procedure called to validate has_fabric_trig_in
	return true
}

proc update_PARAM_VALUE.has_pin_gate_in { PARAM_VALUE.has_pin_gate_in } {
	# Procedure called to update has_pin_gate_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_pin_gate_in { PARAM_VALUE.has_pin_gate_in } {
	# Procedure called to validate has_pin_gate_in
	return true
}

proc update_PARAM_VALUE.has_pin_sync_in { PARAM_VALUE.has_pin_sync_in } {
	# Procedure called to update has_pin_sync_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_pin_sync_in { PARAM_VALUE.has_pin_sync_in } {
	# Procedure called to validate has_pin_sync_in
	return true
}

proc update_PARAM_VALUE.has_pin_sysref_in { PARAM_VALUE.has_pin_sysref_in } {
	# Procedure called to update has_pin_sysref_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_pin_sysref_in { PARAM_VALUE.has_pin_sysref_in } {
	# Procedure called to validate has_pin_sysref_in
	return true
}

proc update_PARAM_VALUE.has_pin_ttl_trig_in { PARAM_VALUE.has_pin_ttl_trig_in } {
	# Procedure called to update has_pin_ttl_trig_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_pin_ttl_trig_in { PARAM_VALUE.has_pin_ttl_trig_in } {
	# Procedure called to validate has_pin_ttl_trig_in
	return true
}

proc update_PARAM_VALUE.has_pps_in { PARAM_VALUE.has_pps_in } {
	# Procedure called to update has_pps_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_pps_in { PARAM_VALUE.has_pps_in } {
	# Procedure called to validate has_pps_in
	return true
}

proc update_PARAM_VALUE.has_rtc_pps_in { PARAM_VALUE.has_rtc_pps_in } {
	# Procedure called to update has_rtc_pps_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_rtc_pps_in { PARAM_VALUE.has_rtc_pps_in } {
	# Procedure called to validate has_rtc_pps_in
	return true
}

proc update_PARAM_VALUE.initial_gate_int_delay { PARAM_VALUE.initial_gate_int_delay } {
	# Procedure called to update initial_gate_int_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_gate_int_delay { PARAM_VALUE.initial_gate_int_delay } {
	# Procedure called to validate initial_gate_int_delay
	return true
}

proc update_PARAM_VALUE.initial_gate_tap_delay { PARAM_VALUE.initial_gate_tap_delay } {
	# Procedure called to update initial_gate_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_gate_tap_delay { PARAM_VALUE.initial_gate_tap_delay } {
	# Procedure called to validate initial_gate_tap_delay
	return true
}

proc update_PARAM_VALUE.initial_led_src { PARAM_VALUE.initial_led_src } {
	# Procedure called to update initial_led_src when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_led_src { PARAM_VALUE.initial_led_src } {
	# Procedure called to validate initial_led_src
	return true
}

proc update_PARAM_VALUE.initial_sync_int_delay { PARAM_VALUE.initial_sync_int_delay } {
	# Procedure called to update initial_sync_int_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_sync_int_delay { PARAM_VALUE.initial_sync_int_delay } {
	# Procedure called to validate initial_sync_int_delay
	return true
}

proc update_PARAM_VALUE.initial_sync_tap_delay { PARAM_VALUE.initial_sync_tap_delay } {
	# Procedure called to update initial_sync_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_sync_tap_delay { PARAM_VALUE.initial_sync_tap_delay } {
	# Procedure called to validate initial_sync_tap_delay
	return true
}

proc update_PARAM_VALUE.initial_sysref_int_delay { PARAM_VALUE.initial_sysref_int_delay } {
	# Procedure called to update initial_sysref_int_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_sysref_int_delay { PARAM_VALUE.initial_sysref_int_delay } {
	# Procedure called to validate initial_sysref_int_delay
	return true
}

proc update_PARAM_VALUE.initial_sysref_tap_delay { PARAM_VALUE.initial_sysref_tap_delay } {
	# Procedure called to update initial_sysref_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_sysref_tap_delay { PARAM_VALUE.initial_sysref_tap_delay } {
	# Procedure called to validate initial_sysref_tap_delay
	return true
}

proc update_PARAM_VALUE.initial_ttl_trig_int_delay { PARAM_VALUE.initial_ttl_trig_int_delay } {
	# Procedure called to update initial_ttl_trig_int_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_ttl_trig_int_delay { PARAM_VALUE.initial_ttl_trig_int_delay } {
	# Procedure called to validate initial_ttl_trig_int_delay
	return true
}

proc update_PARAM_VALUE.initial_ttl_trig_tap_delay { PARAM_VALUE.initial_ttl_trig_tap_delay } {
	# Procedure called to update initial_ttl_trig_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_ttl_trig_tap_delay { PARAM_VALUE.initial_ttl_trig_tap_delay } {
	# Procedure called to validate initial_ttl_trig_tap_delay
	return true
}

proc update_PARAM_VALUE.led_pulse_stretch { PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to update led_pulse_stretch when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.led_pulse_stretch { PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to validate led_pulse_stretch
	return true
}

proc update_PARAM_VALUE.refclk_freq_int { PARAM_VALUE.refclk_freq_int } {
	# Procedure called to update refclk_freq_int when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.refclk_freq_int { PARAM_VALUE.refclk_freq_int } {
	# Procedure called to validate refclk_freq_int
	return true
}

proc update_PARAM_VALUE.use_gate_tap_delay { PARAM_VALUE.use_gate_tap_delay } {
	# Procedure called to update use_gate_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.use_gate_tap_delay { PARAM_VALUE.use_gate_tap_delay } {
	# Procedure called to validate use_gate_tap_delay
	return true
}

proc update_PARAM_VALUE.use_sync_tap_delay { PARAM_VALUE.use_sync_tap_delay } {
	# Procedure called to update use_sync_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.use_sync_tap_delay { PARAM_VALUE.use_sync_tap_delay } {
	# Procedure called to validate use_sync_tap_delay
	return true
}

proc update_PARAM_VALUE.use_sysref_tap_delay { PARAM_VALUE.use_sysref_tap_delay } {
	# Procedure called to update use_sysref_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.use_sysref_tap_delay { PARAM_VALUE.use_sysref_tap_delay } {
	# Procedure called to validate use_sysref_tap_delay
	return true
}

proc update_PARAM_VALUE.use_ttl_trig_tap_delay { PARAM_VALUE.use_ttl_trig_tap_delay } {
	# Procedure called to update use_ttl_trig_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.use_ttl_trig_tap_delay { PARAM_VALUE.use_ttl_trig_tap_delay } {
	# Procedure called to validate use_ttl_trig_tap_delay
	return true
}


proc update_MODELPARAM_VALUE.initial_gate_tap_delay { MODELPARAM_VALUE.initial_gate_tap_delay PARAM_VALUE.initial_gate_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_gate_tap_delay}] ${MODELPARAM_VALUE.initial_gate_tap_delay}
}

proc update_MODELPARAM_VALUE.initial_sync_tap_delay { MODELPARAM_VALUE.initial_sync_tap_delay PARAM_VALUE.initial_sync_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_sync_tap_delay}] ${MODELPARAM_VALUE.initial_sync_tap_delay}
}

proc update_MODELPARAM_VALUE.initial_ttl_trig_tap_delay { MODELPARAM_VALUE.initial_ttl_trig_tap_delay PARAM_VALUE.initial_ttl_trig_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_ttl_trig_tap_delay}] ${MODELPARAM_VALUE.initial_ttl_trig_tap_delay}
}

proc update_MODELPARAM_VALUE.initial_gate_int_delay { MODELPARAM_VALUE.initial_gate_int_delay PARAM_VALUE.initial_gate_int_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_gate_int_delay}] ${MODELPARAM_VALUE.initial_gate_int_delay}
}

proc update_MODELPARAM_VALUE.initial_sync_int_delay { MODELPARAM_VALUE.initial_sync_int_delay PARAM_VALUE.initial_sync_int_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_sync_int_delay}] ${MODELPARAM_VALUE.initial_sync_int_delay}
}

proc update_MODELPARAM_VALUE.initial_ttl_trig_int_delay { MODELPARAM_VALUE.initial_ttl_trig_int_delay PARAM_VALUE.initial_ttl_trig_int_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_ttl_trig_int_delay}] ${MODELPARAM_VALUE.initial_ttl_trig_int_delay}
}

proc update_MODELPARAM_VALUE.initial_led_src { MODELPARAM_VALUE.initial_led_src PARAM_VALUE.initial_led_src } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_led_src}] ${MODELPARAM_VALUE.initial_led_src}
}

proc update_MODELPARAM_VALUE.led_pulse_stretch { MODELPARAM_VALUE.led_pulse_stretch PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.led_pulse_stretch}] ${MODELPARAM_VALUE.led_pulse_stretch}
}

proc update_MODELPARAM_VALUE.has_pin_gate_in { MODELPARAM_VALUE.has_pin_gate_in PARAM_VALUE.has_pin_gate_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_pin_gate_in}] ${MODELPARAM_VALUE.has_pin_gate_in}
}

proc update_MODELPARAM_VALUE.has_pin_sync_in { MODELPARAM_VALUE.has_pin_sync_in PARAM_VALUE.has_pin_sync_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_pin_sync_in}] ${MODELPARAM_VALUE.has_pin_sync_in}
}

proc update_MODELPARAM_VALUE.has_pin_ttl_trig_in { MODELPARAM_VALUE.has_pin_ttl_trig_in PARAM_VALUE.has_pin_ttl_trig_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_pin_ttl_trig_in}] ${MODELPARAM_VALUE.has_pin_ttl_trig_in}
}

proc update_MODELPARAM_VALUE.has_pin_sysref_in { MODELPARAM_VALUE.has_pin_sysref_in PARAM_VALUE.has_pin_sysref_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_pin_sysref_in}] ${MODELPARAM_VALUE.has_pin_sysref_in}
}

proc update_MODELPARAM_VALUE.has_fabric_gate_in { MODELPARAM_VALUE.has_fabric_gate_in PARAM_VALUE.has_fabric_gate_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_fabric_gate_in}] ${MODELPARAM_VALUE.has_fabric_gate_in}
}

proc update_MODELPARAM_VALUE.has_fabric_sync_in { MODELPARAM_VALUE.has_fabric_sync_in PARAM_VALUE.has_fabric_sync_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_fabric_sync_in}] ${MODELPARAM_VALUE.has_fabric_sync_in}
}

proc update_MODELPARAM_VALUE.has_fabric_trig_in { MODELPARAM_VALUE.has_fabric_trig_in PARAM_VALUE.has_fabric_trig_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_fabric_trig_in}] ${MODELPARAM_VALUE.has_fabric_trig_in}
}

proc update_MODELPARAM_VALUE.has_fabric_sysref_in { MODELPARAM_VALUE.has_fabric_sysref_in PARAM_VALUE.has_fabric_sysref_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_fabric_sysref_in}] ${MODELPARAM_VALUE.has_fabric_sysref_in}
}

proc update_MODELPARAM_VALUE.has_pps_in { MODELPARAM_VALUE.has_pps_in PARAM_VALUE.has_pps_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_pps_in}] ${MODELPARAM_VALUE.has_pps_in}
}

proc update_MODELPARAM_VALUE.has_rtc_pps_in { MODELPARAM_VALUE.has_rtc_pps_in PARAM_VALUE.has_rtc_pps_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_rtc_pps_in}] ${MODELPARAM_VALUE.has_rtc_pps_in}
}

proc update_MODELPARAM_VALUE.use_gate_tap_delay { MODELPARAM_VALUE.use_gate_tap_delay PARAM_VALUE.use_gate_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.use_gate_tap_delay}] ${MODELPARAM_VALUE.use_gate_tap_delay}
}

proc update_MODELPARAM_VALUE.use_sync_tap_delay { MODELPARAM_VALUE.use_sync_tap_delay PARAM_VALUE.use_sync_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.use_sync_tap_delay}] ${MODELPARAM_VALUE.use_sync_tap_delay}
}

proc update_MODELPARAM_VALUE.use_ttl_trig_tap_delay { MODELPARAM_VALUE.use_ttl_trig_tap_delay PARAM_VALUE.use_ttl_trig_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.use_ttl_trig_tap_delay}] ${MODELPARAM_VALUE.use_ttl_trig_tap_delay}
}

proc update_MODELPARAM_VALUE.use_sysref_tap_delay { MODELPARAM_VALUE.use_sysref_tap_delay PARAM_VALUE.use_sysref_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.use_sysref_tap_delay}] ${MODELPARAM_VALUE.use_sysref_tap_delay}
}

proc update_MODELPARAM_VALUE.initial_sysref_tap_delay { MODELPARAM_VALUE.initial_sysref_tap_delay PARAM_VALUE.initial_sysref_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_sysref_tap_delay}] ${MODELPARAM_VALUE.initial_sysref_tap_delay}
}

proc update_MODELPARAM_VALUE.initial_sysref_int_delay { MODELPARAM_VALUE.initial_sysref_int_delay PARAM_VALUE.initial_sysref_int_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_sysref_int_delay}] ${MODELPARAM_VALUE.initial_sysref_int_delay}
}

proc update_MODELPARAM_VALUE.has_fabric_pps_in { MODELPARAM_VALUE.has_fabric_pps_in PARAM_VALUE.has_fabric_pps_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_fabric_pps_in}] ${MODELPARAM_VALUE.has_fabric_pps_in}
}

proc update_MODELPARAM_VALUE.refclk_freq_int { MODELPARAM_VALUE.refclk_freq_int PARAM_VALUE.refclk_freq_int } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.refclk_freq_int}] ${MODELPARAM_VALUE.refclk_freq_int}
}

proc update_MODELPARAM_VALUE.ext_axiclk_version { MODELPARAM_VALUE.ext_axiclk_version PARAM_VALUE.ext_axiclk_version } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ext_axiclk_version}] ${MODELPARAM_VALUE.ext_axiclk_version}
}

