
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/px_syncbus_intrfc1_v0_01.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Input_Buffers [ipgui::add_page $IPINST -name "Input Buffers"]
  ipgui::add_param $IPINST -name "in_iodelay_grp" -parent ${Input_Buffers}
  #Adding Group
  set Differential_Inputs [ipgui::add_group $IPINST -name "Differential Inputs" -parent ${Input_Buffers}]
  ipgui::add_param $IPINST -name "differential_term" -parent ${Differential_Inputs}
  ipgui::add_param $IPINST -name "ibuf_low_pwr" -parent ${Differential_Inputs}
  ipgui::add_param $IPINST -name "idelaycntrl_refclk_freq" -parent ${Differential_Inputs}

  #Adding Group
  set TTL_Inputs [ipgui::add_group $IPINST -name "TTL Inputs" -parent ${Input_Buffers}]
  ipgui::add_param $IPINST -name "is_single_ended_sig_master" -parent ${TTL_Inputs}
  ipgui::add_param $IPINST -name "has_ssmc_gate_input" -parent ${TTL_Inputs}

  #Adding Group
  set Additional_Input_Logic [ipgui::add_group $IPINST -name "Additional Input Logic" -parent ${Input_Buffers}]
  ipgui::add_param $IPINST -name "has_user_gate_drive_in" -parent ${Additional_Input_Logic}
  ipgui::add_param $IPINST -name "has_user_sync_drive_in" -parent ${Additional_Input_Logic}
  ipgui::add_param $IPINST -name "has_user_pps_input" -parent ${Additional_Input_Logic}

  #Adding Group
  set Additional_Output_Logic [ipgui::add_group $IPINST -name "Additional Output Logic" -parent ${Input_Buffers}]
  set_property tooltip {Additional Output Logic} ${Additional_Output_Logic}
  ipgui::add_static_text $IPINST -name "out_txt" -parent ${Additional_Output_Logic} -text {These outputs are only available when TTL Input Signal Master is checked.}
  ipgui::add_param $IPINST -name "has_gate_trig_se_out" -parent ${Additional_Output_Logic}
  ipgui::add_param $IPINST -name "has_sync_pps_se_out" -parent ${Additional_Output_Logic}
  ipgui::add_param $IPINST -name "has_ssmc_gate_se_out" -parent ${Additional_Output_Logic}


  #Adding Page
  set Delays [ipgui::add_page $IPINST -name "Delays"]
  #Adding Group
  set Gates [ipgui::add_group $IPINST -name "Gates" -parent ${Delays} -display_name {Tap Delays}]
  ipgui::add_static_text $IPINST -name "Delay_text" -parent ${Gates} -text {Delay = n * 2.44 ps}
  ipgui::add_param $IPINST -name "initial_gate_tap_delay" -parent ${Gates}
  ipgui::add_param $IPINST -name "initial_sync_tap_delay" -parent ${Gates}
  ipgui::add_param $IPINST -name "initial_ttl_gate_tap_delay" -parent ${Gates}
  ipgui::add_param $IPINST -name "initial_ssmc_gate_tap_delay" -parent ${Gates}
  ipgui::add_param $IPINST -name "initial_ttl_sync_tap_delay" -parent ${Gates}

  #Adding Group
  set Sync/PPS [ipgui::add_group $IPINST -name "Sync/PPS" -parent ${Delays} -display_name {Integer Clock Cycle Delays}]
  ipgui::add_param $IPINST -name "initial_gate_int_delay" -parent ${Sync/PPS}
  ipgui::add_param $IPINST -name "initial_sync_int_delay" -parent ${Sync/PPS}
  ipgui::add_param $IPINST -name "initial_ttl_gate_int_delay" -parent ${Sync/PPS}
  ipgui::add_param $IPINST -name "initial_ttl_sync_int_delay" -parent ${Sync/PPS}


  #Adding Page
  set LED_Control [ipgui::add_page $IPINST -name "LED Control"]
  ipgui::add_param $IPINST -name "led_pulse_stretch" -parent ${LED_Control}
  ipgui::add_param $IPINST -name "initial_led_src" -parent ${LED_Control} -widget comboBox
  ipgui::add_static_text $IPINST -name "led_text" -parent ${LED_Control} -text {LED Drive Source Selection:
0 = Disabled
1 = Selected Gate Input
2 = Selected Sync Input
3 = Selected PPS input
4 = Output Gate
5 = Output SYNC/PPS
6 = User PPS logic signal.}


}

proc update_PARAM_VALUE.has_gate_trig_se_out { PARAM_VALUE.has_gate_trig_se_out PARAM_VALUE.is_single_ended_sig_master } {
	# Procedure called to update has_gate_trig_se_out when any of the dependent parameters in the arguments change
	
	set has_gate_trig_se_out ${PARAM_VALUE.has_gate_trig_se_out}
	set is_single_ended_sig_master ${PARAM_VALUE.is_single_ended_sig_master}
	set values(is_single_ended_sig_master) [get_property value $is_single_ended_sig_master]
	if { [gen_USERPARAMETER_has_gate_trig_se_out_ENABLEMENT $values(is_single_ended_sig_master)] } {
		set_property enabled true $has_gate_trig_se_out
	} else {
		set_property enabled false $has_gate_trig_se_out
	}
}

proc validate_PARAM_VALUE.has_gate_trig_se_out { PARAM_VALUE.has_gate_trig_se_out } {
	# Procedure called to validate has_gate_trig_se_out
	return true
}

proc update_PARAM_VALUE.has_ssmc_gate_se_out { PARAM_VALUE.has_ssmc_gate_se_out PARAM_VALUE.is_single_ended_sig_master } {
	# Procedure called to update has_ssmc_gate_se_out when any of the dependent parameters in the arguments change
	
	set has_ssmc_gate_se_out ${PARAM_VALUE.has_ssmc_gate_se_out}
	set is_single_ended_sig_master ${PARAM_VALUE.is_single_ended_sig_master}
	set values(is_single_ended_sig_master) [get_property value $is_single_ended_sig_master]
	if { [gen_USERPARAMETER_has_ssmc_gate_se_out_ENABLEMENT $values(is_single_ended_sig_master)] } {
		set_property enabled true $has_ssmc_gate_se_out
	} else {
		set_property enabled false $has_ssmc_gate_se_out
	}
}

proc validate_PARAM_VALUE.has_ssmc_gate_se_out { PARAM_VALUE.has_ssmc_gate_se_out } {
	# Procedure called to validate has_ssmc_gate_se_out
	return true
}

proc update_PARAM_VALUE.has_sync_pps_se_out { PARAM_VALUE.has_sync_pps_se_out PARAM_VALUE.is_single_ended_sig_master } {
	# Procedure called to update has_sync_pps_se_out when any of the dependent parameters in the arguments change
	
	set has_sync_pps_se_out ${PARAM_VALUE.has_sync_pps_se_out}
	set is_single_ended_sig_master ${PARAM_VALUE.is_single_ended_sig_master}
	set values(is_single_ended_sig_master) [get_property value $is_single_ended_sig_master]
	if { [gen_USERPARAMETER_has_sync_pps_se_out_ENABLEMENT $values(is_single_ended_sig_master)] } {
		set_property enabled true $has_sync_pps_se_out
	} else {
		set_property enabled false $has_sync_pps_se_out
	}
}

proc validate_PARAM_VALUE.has_sync_pps_se_out { PARAM_VALUE.has_sync_pps_se_out } {
	# Procedure called to validate has_sync_pps_se_out
	return true
}

proc update_PARAM_VALUE.differential_term { PARAM_VALUE.differential_term } {
	# Procedure called to update differential_term when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.differential_term { PARAM_VALUE.differential_term } {
	# Procedure called to validate differential_term
	return true
}

proc update_PARAM_VALUE.has_ssmc_gate_input { PARAM_VALUE.has_ssmc_gate_input } {
	# Procedure called to update has_ssmc_gate_input when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_ssmc_gate_input { PARAM_VALUE.has_ssmc_gate_input } {
	# Procedure called to validate has_ssmc_gate_input
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

proc update_PARAM_VALUE.initial_ssmc_gate_tap_delay { PARAM_VALUE.initial_ssmc_gate_tap_delay } {
	# Procedure called to update initial_ssmc_gate_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_ssmc_gate_tap_delay { PARAM_VALUE.initial_ssmc_gate_tap_delay } {
	# Procedure called to validate initial_ssmc_gate_tap_delay
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

proc update_PARAM_VALUE.initial_ttl_gate_int_delay { PARAM_VALUE.initial_ttl_gate_int_delay } {
	# Procedure called to update initial_ttl_gate_int_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_ttl_gate_int_delay { PARAM_VALUE.initial_ttl_gate_int_delay } {
	# Procedure called to validate initial_ttl_gate_int_delay
	return true
}

proc update_PARAM_VALUE.initial_ttl_gate_tap_delay { PARAM_VALUE.initial_ttl_gate_tap_delay } {
	# Procedure called to update initial_ttl_gate_tap_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.initial_ttl_gate_tap_delay { PARAM_VALUE.initial_ttl_gate_tap_delay } {
	# Procedure called to validate initial_ttl_gate_tap_delay
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

proc update_PARAM_VALUE.is_single_ended_sig_master { PARAM_VALUE.is_single_ended_sig_master } {
	# Procedure called to update is_single_ended_sig_master when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.is_single_ended_sig_master { PARAM_VALUE.is_single_ended_sig_master } {
	# Procedure called to validate is_single_ended_sig_master
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

proc update_MODELPARAM_VALUE.is_single_ended_sig_master { MODELPARAM_VALUE.is_single_ended_sig_master PARAM_VALUE.is_single_ended_sig_master } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.is_single_ended_sig_master}] ${MODELPARAM_VALUE.is_single_ended_sig_master}
}

proc update_MODELPARAM_VALUE.has_ssmc_gate_input { MODELPARAM_VALUE.has_ssmc_gate_input PARAM_VALUE.has_ssmc_gate_input } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_ssmc_gate_input}] ${MODELPARAM_VALUE.has_ssmc_gate_input}
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

proc update_MODELPARAM_VALUE.has_gate_trig_se_out { MODELPARAM_VALUE.has_gate_trig_se_out PARAM_VALUE.has_gate_trig_se_out } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_gate_trig_se_out}] ${MODELPARAM_VALUE.has_gate_trig_se_out}
}

proc update_MODELPARAM_VALUE.has_sync_pps_se_out { MODELPARAM_VALUE.has_sync_pps_se_out PARAM_VALUE.has_sync_pps_se_out } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_sync_pps_se_out}] ${MODELPARAM_VALUE.has_sync_pps_se_out}
}

proc update_MODELPARAM_VALUE.has_ssmc_gate_se_out { MODELPARAM_VALUE.has_ssmc_gate_se_out PARAM_VALUE.has_ssmc_gate_se_out } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_ssmc_gate_se_out}] ${MODELPARAM_VALUE.has_ssmc_gate_se_out}
}

proc update_MODELPARAM_VALUE.initial_gate_tap_delay { MODELPARAM_VALUE.initial_gate_tap_delay PARAM_VALUE.initial_gate_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_gate_tap_delay}] ${MODELPARAM_VALUE.initial_gate_tap_delay}
}

proc update_MODELPARAM_VALUE.initial_sync_tap_delay { MODELPARAM_VALUE.initial_sync_tap_delay PARAM_VALUE.initial_sync_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_sync_tap_delay}] ${MODELPARAM_VALUE.initial_sync_tap_delay}
}

proc update_MODELPARAM_VALUE.initial_ttl_gate_tap_delay { MODELPARAM_VALUE.initial_ttl_gate_tap_delay PARAM_VALUE.initial_ttl_gate_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_ttl_gate_tap_delay}] ${MODELPARAM_VALUE.initial_ttl_gate_tap_delay}
}

proc update_MODELPARAM_VALUE.initial_ttl_sync_tap_delay { MODELPARAM_VALUE.initial_ttl_sync_tap_delay PARAM_VALUE.initial_ttl_sync_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_ttl_sync_tap_delay}] ${MODELPARAM_VALUE.initial_ttl_sync_tap_delay}
}

proc update_MODELPARAM_VALUE.initial_ssmc_gate_tap_delay { MODELPARAM_VALUE.initial_ssmc_gate_tap_delay PARAM_VALUE.initial_ssmc_gate_tap_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_ssmc_gate_tap_delay}] ${MODELPARAM_VALUE.initial_ssmc_gate_tap_delay}
}

proc update_MODELPARAM_VALUE.initial_gate_int_delay { MODELPARAM_VALUE.initial_gate_int_delay PARAM_VALUE.initial_gate_int_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_gate_int_delay}] ${MODELPARAM_VALUE.initial_gate_int_delay}
}

proc update_MODELPARAM_VALUE.initial_sync_int_delay { MODELPARAM_VALUE.initial_sync_int_delay PARAM_VALUE.initial_sync_int_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_sync_int_delay}] ${MODELPARAM_VALUE.initial_sync_int_delay}
}

proc update_MODELPARAM_VALUE.initial_ttl_gate_int_delay { MODELPARAM_VALUE.initial_ttl_gate_int_delay PARAM_VALUE.initial_ttl_gate_int_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.initial_ttl_gate_int_delay}] ${MODELPARAM_VALUE.initial_ttl_gate_int_delay}
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

