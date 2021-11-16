# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Input_Buffers [ipgui::add_page $IPINST -name "Input Buffers"]
  set_property tooltip {Input Buffers} ${Input_Buffers}
  ipgui::add_param $IPINST -name "in_iodelay_grp" -parent ${Input_Buffers}
  #Adding Group
  set Differential_Inputs [ipgui::add_group $IPINST -name "Differential Inputs" -parent ${Input_Buffers}]
  set_property tooltip {Differential Inputs} ${Differential_Inputs}
  ipgui::add_param $IPINST -name "differential_term" -parent ${Differential_Inputs}
  ipgui::add_param $IPINST -name "ibuf_low_pwr" -parent ${Differential_Inputs}
  ipgui::add_param $IPINST -name "idelaycntrl_refclk_freq" -parent ${Differential_Inputs}

  #Adding Group
  set Additional_Input_Logic [ipgui::add_group $IPINST -name "Additional Input Logic" -parent ${Input_Buffers}]
  set_property tooltip {Additional Input Logic} ${Additional_Input_Logic}
  ipgui::add_param $IPINST -name "has_user_gate_drive_in" -parent ${Additional_Input_Logic}
  ipgui::add_param $IPINST -name "has_user_sync_drive_in" -parent ${Additional_Input_Logic}
  ipgui::add_param $IPINST -name "has_user_pps_input" -parent ${Additional_Input_Logic}


  #Adding Page
  set Delays [ipgui::add_page $IPINST -name "Delays"]
  set_property tooltip {Delays} ${Delays}
  #Adding Group
  set Tap_Delays [ipgui::add_group $IPINST -name "Tap Delays" -parent ${Delays}]
  set_property tooltip {Tap Delays} ${Tap_Delays}
  ipgui::add_static_text $IPINST -name "txt1" -parent ${Tap_Delays} -text {Delay = psec}
  ipgui::add_param $IPINST -name "initial_gate_tap_delay" -parent ${Tap_Delays}
  ipgui::add_param $IPINST -name "initial_ttl_sync_tap_delay" -parent ${Tap_Delays}

  #Adding Group
  set Integer_Clock_Delays [ipgui::add_group $IPINST -name "Integer Clock Delays" -parent ${Delays}]
  set_property tooltip {Integer Clock Delays} ${Integer_Clock_Delays}
  ipgui::add_param $IPINST -name "initial_gate_int_delay" -parent ${Integer_Clock_Delays}
  ipgui::add_param $IPINST -name "initial_ttl_sync_int_delay" -parent ${Integer_Clock_Delays}


  #Adding Page
  set LED_Control [ipgui::add_page $IPINST -name "LED Control"]
  set_property tooltip {LED Control} ${LED_Control}
  ipgui::add_param $IPINST -name "led_pulse_stretch" -parent ${LED_Control}
  ipgui::add_param $IPINST -name "initial_led_src" -parent ${LED_Control} -widget comboBox
  ipgui::add_static_text $IPINST -name "txt2" -parent ${LED_Control} -text {LED Drive Source Selection:

0= Disabled

1= Selected Gate Input

2= Selected SYNC Input

3= Selected PPS Input

4=Reserved

5=Reserved

6=User PPS Logic Signal}


}

proc update_PARAM_VALUE.differential_term { PARAM_VALUE.differential_term } {
	# Procedure called to update differential_term when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.differential_term { PARAM_VALUE.differential_term } {
	# Procedure called to validate differential_term
	return true
}

proc update_PARAM_VALUE.has_user_gate_drive_in { PARAM_VALUE.has_user_gate_drive_in } {
	# Procedure called to update has_user_gate_drive_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_user_gate_drive_in { PARAM_VALUE.has_user_gate_drive_in } {
	# Procedure called to validate has_user_gate_drive_in
	return true
}

proc update_PARAM_VALUE.has_user_pps_input { PARAM_VALUE.has_user_pps_input } {
	# Procedure called to update has_user_pps_input when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_user_pps_input { PARAM_VALUE.has_user_pps_input } {
	# Procedure called to validate has_user_pps_input
	return true
}

proc update_PARAM_VALUE.has_user_sync_drive_in { PARAM_VALUE.has_user_sync_drive_in } {
	# Procedure called to update has_user_sync_drive_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_user_sync_drive_in { PARAM_VALUE.has_user_sync_drive_in } {
	# Procedure called to validate has_user_sync_drive_in
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

proc update_PARAM_VALUE.in_iodelay_grp { PARAM_VALUE.in_iodelay_grp } {
	# Procedure called to update in_iodelay_grp when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.in_iodelay_grp { PARAM_VALUE.in_iodelay_grp } {
	# Procedure called to validate in_iodelay_grp
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

proc update_PARAM_VALUE.initial_ttl_sync_int_delay { PARAM_VALUE.initial_ttl_sync_int_delay } {
	# Procedure called to update initial_ttl_sync_int_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_ttl_sync_int_delay { PARAM_VALUE.initial_ttl_sync_int_delay } {
	# Procedure called to validate initial_ttl_sync_int_delay
	return true
}

proc update_PARAM_VALUE.initial_ttl_sync_tap_delay { PARAM_VALUE.initial_ttl_sync_tap_delay } {
	# Procedure called to update initial_ttl_sync_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_ttl_sync_tap_delay { PARAM_VALUE.initial_ttl_sync_tap_delay } {
	# Procedure called to validate initial_ttl_sync_tap_delay
	return true
}

proc update_PARAM_VALUE.led_pulse_stretch { PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to update led_pulse_stretch when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.led_pulse_stretch { PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to validate led_pulse_stretch
	return true
}


proc update_MODELPARAM_VALUE.in_iodelay_grp { MODELPARAM_VALUE.in_iodelay_grp PARAM_VALUE.in_iodelay_grp } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.in_iodelay_grp}] ${MODELPARAM_VALUE.in_iodelay_grp}
}

proc update_MODELPARAM_VALUE.has_user_pps_input { MODELPARAM_VALUE.has_user_pps_input PARAM_VALUE.has_user_pps_input } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_user_pps_input}] ${MODELPARAM_VALUE.has_user_pps_input}
}

proc update_MODELPARAM_VALUE.has_user_sync_drive_in { MODELPARAM_VALUE.has_user_sync_drive_in PARAM_VALUE.has_user_sync_drive_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_user_sync_drive_in}] ${MODELPARAM_VALUE.has_user_sync_drive_in}
}

proc update_MODELPARAM_VALUE.has_user_gate_drive_in { MODELPARAM_VALUE.has_user_gate_drive_in PARAM_VALUE.has_user_gate_drive_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_user_gate_drive_in}] ${MODELPARAM_VALUE.has_user_gate_drive_in}
}

proc update_MODELPARAM_VALUE.initial_gate_tap_delay { MODELPARAM_VALUE.initial_gate_tap_delay PARAM_VALUE.initial_gate_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_gate_tap_delay}] ${MODELPARAM_VALUE.initial_gate_tap_delay}
}

proc update_MODELPARAM_VALUE.initial_sync_tap_delay { MODELPARAM_VALUE.initial_sync_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	# WARNING: There is no corresponding user parameter named "initial_sync_tap_delay". Setting updated value from the model parameter.
set_property value 0 ${MODELPARAM_VALUE.initial_sync_tap_delay}
}

proc update_MODELPARAM_VALUE.initial_ttl_sync_tap_delay { MODELPARAM_VALUE.initial_ttl_sync_tap_delay PARAM_VALUE.initial_ttl_sync_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_ttl_sync_tap_delay}] ${MODELPARAM_VALUE.initial_ttl_sync_tap_delay}
}

proc update_MODELPARAM_VALUE.initial_gate_int_delay { MODELPARAM_VALUE.initial_gate_int_delay PARAM_VALUE.initial_gate_int_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_gate_int_delay}] ${MODELPARAM_VALUE.initial_gate_int_delay}
}

proc update_MODELPARAM_VALUE.initial_sync_int_delay { MODELPARAM_VALUE.initial_sync_int_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	# WARNING: There is no corresponding user parameter named "initial_sync_int_delay". Setting updated value from the model parameter.
set_property value 0 ${MODELPARAM_VALUE.initial_sync_int_delay}
}

proc update_MODELPARAM_VALUE.initial_ttl_sync_int_delay { MODELPARAM_VALUE.initial_ttl_sync_int_delay PARAM_VALUE.initial_ttl_sync_int_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_ttl_sync_int_delay}] ${MODELPARAM_VALUE.initial_ttl_sync_int_delay}
}

proc update_MODELPARAM_VALUE.differential_term { MODELPARAM_VALUE.differential_term PARAM_VALUE.differential_term } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.differential_term}] ${MODELPARAM_VALUE.differential_term}
}

proc update_MODELPARAM_VALUE.ibuf_low_pwr { MODELPARAM_VALUE.ibuf_low_pwr PARAM_VALUE.ibuf_low_pwr } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ibuf_low_pwr}] ${MODELPARAM_VALUE.ibuf_low_pwr}
}

proc update_MODELPARAM_VALUE.idelaycntrl_refclk_freq { MODELPARAM_VALUE.idelaycntrl_refclk_freq PARAM_VALUE.idelaycntrl_refclk_freq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.idelaycntrl_refclk_freq}] ${MODELPARAM_VALUE.idelaycntrl_refclk_freq}
}

proc update_MODELPARAM_VALUE.initial_led_src { MODELPARAM_VALUE.initial_led_src PARAM_VALUE.initial_led_src } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_led_src}] ${MODELPARAM_VALUE.initial_led_src}
}

proc update_MODELPARAM_VALUE.led_pulse_stretch { MODELPARAM_VALUE.led_pulse_stretch PARAM_VALUE.led_pulse_stretch } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.led_pulse_stretch}] ${MODELPARAM_VALUE.led_pulse_stretch}
}

