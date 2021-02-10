
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/px_sig2pxaxis_v0_01.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  #Adding Group
  set TVALID [ipgui::add_group $IPINST -name "TVALID" -parent ${Page_0}]
  ipgui::add_param $IPINST -name "use_input_tvalid" -parent ${TVALID}
  ipgui::add_static_text $IPINST -name "tv_txt" -parent ${TVALID} -text {When not checked, all output tvalids are a constant '1'.}

  #Adding Group
  set Pentek_AXI4-Stream_PTCTL_Type_Interface [ipgui::add_group $IPINST -name "Pentek AXI4-Stream PTCTL Type Interface" -parent ${Page_0}]
  ipgui::add_param $IPINST -name "has_ptctl_output" -parent ${Pentek_AXI4-Stream_PTCTL_Type_Interface}
  ipgui::add_param $IPINST -name "gate_sig_width" -parent ${Pentek_AXI4-Stream_PTCTL_Type_Interface}

  #Adding Group
  set Pentek_AXI4-Stream_PD_Type_Interface [ipgui::add_group $IPINST -name "Pentek AXI4-Stream PD Type Interface" -parent ${Page_0}]
  ipgui::add_param $IPINST -name "has_pd_output" -parent ${Pentek_AXI4-Stream_PD_Type_Interface}
  ipgui::add_param $IPINST -name "data_byte_width" -parent ${Pentek_AXI4-Stream_PD_Type_Interface}

  #Adding Group
  set Pentek_AXI4-Stream_PTS_Type_Interface [ipgui::add_group $IPINST -name "Pentek AXI4-Stream PTS Type Interface" -parent ${Page_0}]
  ipgui::add_static_text $IPINST -name "pts_txt" -parent ${Pentek_AXI4-Stream_PTS_Type_Interface} -text {When data is sample packed (more than one sample per cycle), the corresponding
Synchronization Signals may have multiple bits corresponding to the data samples.}
  ipgui::add_param $IPINST -name "has_pts_output" -parent ${Pentek_AXI4-Stream_PTS_Type_Interface}

  #Adding Group
  set Pentek_AXI4-Stream_PI_Type_Interface [ipgui::add_group $IPINST -name "Pentek AXI4-Stream PI Type Interface" -parent ${Page_0}]
  ipgui::add_param $IPINST -name "has_pi_output" -parent ${Pentek_AXI4-Stream_PI_Type_Interface}
  ipgui::add_param $IPINST -name "use_info_inputs" -parent ${Pentek_AXI4-Stream_PI_Type_Interface}
  ipgui::add_static_text $IPINST -name "pi_txt" -parent ${Pentek_AXI4-Stream_PI_Type_Interface} -text {When not checked, the below default values are used for the PI Output.}
  ipgui::add_param $IPINST -name "dflt_samples_per_cycle" -parent ${Pentek_AXI4-Stream_PI_Type_Interface}
  ipgui::add_static_text $IPINST -name "df_txt" -parent ${Pentek_AXI4-Stream_PI_Type_Interface} -text {Data Format: 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit}
  ipgui::add_param $IPINST -name "dflt_data_format" -parent ${Pentek_AXI4-Stream_PI_Type_Interface}
  ipgui::add_static_text $IPINST -name "dt_txt" -parent ${Pentek_AXI4-Stream_PI_Type_Interface} -text {Data Type 0 = Real 1 = I/Q}
  ipgui::add_param $IPINST -name "dflt_data_type" -parent ${Pentek_AXI4-Stream_PI_Type_Interface}
  ipgui::add_param $IPINST -name "dflt_channel" -parent ${Pentek_AXI4-Stream_PI_Type_Interface}



}

proc update_PARAM_VALUE.dflt_channel { PARAM_VALUE.dflt_channel PARAM_VALUE.has_pi_output PARAM_VALUE.use_info_inputs } {
	# Procedure called to update dflt_channel when any of the dependent parameters in the arguments change
	
	set dflt_channel ${PARAM_VALUE.dflt_channel}
	set has_pi_output ${PARAM_VALUE.has_pi_output}
	set use_info_inputs ${PARAM_VALUE.use_info_inputs}
	set values(has_pi_output) [get_property value $has_pi_output]
	set values(use_info_inputs) [get_property value $use_info_inputs]
	if { [gen_USERPARAMETER_dflt_channel_ENABLEMENT $values(has_pi_output) $values(use_info_inputs)] } {
		set_property enabled true $dflt_channel
	} else {
		set_property enabled false $dflt_channel
	}
}

proc validate_PARAM_VALUE.dflt_channel { PARAM_VALUE.dflt_channel } {
	# Procedure called to validate dflt_channel
	return true
}

proc update_PARAM_VALUE.dflt_data_format { PARAM_VALUE.dflt_data_format PARAM_VALUE.has_pi_output PARAM_VALUE.use_info_inputs } {
	# Procedure called to update dflt_data_format when any of the dependent parameters in the arguments change
	
	set dflt_data_format ${PARAM_VALUE.dflt_data_format}
	set has_pi_output ${PARAM_VALUE.has_pi_output}
	set use_info_inputs ${PARAM_VALUE.use_info_inputs}
	set values(has_pi_output) [get_property value $has_pi_output]
	set values(use_info_inputs) [get_property value $use_info_inputs]
	if { [gen_USERPARAMETER_dflt_data_format_ENABLEMENT $values(has_pi_output) $values(use_info_inputs)] } {
		set_property enabled true $dflt_data_format
	} else {
		set_property enabled false $dflt_data_format
	}
}

proc validate_PARAM_VALUE.dflt_data_format { PARAM_VALUE.dflt_data_format } {
	# Procedure called to validate dflt_data_format
	return true
}

proc update_PARAM_VALUE.dflt_data_type { PARAM_VALUE.dflt_data_type PARAM_VALUE.has_pi_output PARAM_VALUE.use_info_inputs } {
	# Procedure called to update dflt_data_type when any of the dependent parameters in the arguments change
	
	set dflt_data_type ${PARAM_VALUE.dflt_data_type}
	set has_pi_output ${PARAM_VALUE.has_pi_output}
	set use_info_inputs ${PARAM_VALUE.use_info_inputs}
	set values(has_pi_output) [get_property value $has_pi_output]
	set values(use_info_inputs) [get_property value $use_info_inputs]
	if { [gen_USERPARAMETER_dflt_data_type_ENABLEMENT $values(has_pi_output) $values(use_info_inputs)] } {
		set_property enabled true $dflt_data_type
	} else {
		set_property enabled false $dflt_data_type
	}
}

proc validate_PARAM_VALUE.dflt_data_type { PARAM_VALUE.dflt_data_type } {
	# Procedure called to validate dflt_data_type
	return true
}

proc update_PARAM_VALUE.dflt_samples_per_cycle { PARAM_VALUE.dflt_samples_per_cycle PARAM_VALUE.has_pi_output PARAM_VALUE.use_info_inputs } {
	# Procedure called to update dflt_samples_per_cycle when any of the dependent parameters in the arguments change
	
	set dflt_samples_per_cycle ${PARAM_VALUE.dflt_samples_per_cycle}
	set has_pi_output ${PARAM_VALUE.has_pi_output}
	set use_info_inputs ${PARAM_VALUE.use_info_inputs}
	set values(has_pi_output) [get_property value $has_pi_output]
	set values(use_info_inputs) [get_property value $use_info_inputs]
	if { [gen_USERPARAMETER_dflt_samples_per_cycle_ENABLEMENT $values(has_pi_output) $values(use_info_inputs)] } {
		set_property enabled true $dflt_samples_per_cycle
	} else {
		set_property enabled false $dflt_samples_per_cycle
	}
}

proc validate_PARAM_VALUE.dflt_samples_per_cycle { PARAM_VALUE.dflt_samples_per_cycle } {
	# Procedure called to validate dflt_samples_per_cycle
	return true
}

proc update_PARAM_VALUE.use_info_inputs { PARAM_VALUE.use_info_inputs PARAM_VALUE.has_pi_output } {
	# Procedure called to update use_info_inputs when any of the dependent parameters in the arguments change
	
	set use_info_inputs ${PARAM_VALUE.use_info_inputs}
	set has_pi_output ${PARAM_VALUE.has_pi_output}
	set values(has_pi_output) [get_property value $has_pi_output]
	if { [gen_USERPARAMETER_use_info_inputs_ENABLEMENT $values(has_pi_output)] } {
		set_property enabled true $use_info_inputs
	} else {
		set_property enabled false $use_info_inputs
	}
}

proc validate_PARAM_VALUE.use_info_inputs { PARAM_VALUE.use_info_inputs } {
	# Procedure called to validate use_info_inputs
	return true
}

proc update_PARAM_VALUE.data_byte_width { PARAM_VALUE.data_byte_width } {
	# Procedure called to update data_byte_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_byte_width { PARAM_VALUE.data_byte_width } {
	# Procedure called to validate data_byte_width
	return true
}

proc update_PARAM_VALUE.gate_sig_width { PARAM_VALUE.gate_sig_width } {
	# Procedure called to update gate_sig_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.gate_sig_width { PARAM_VALUE.gate_sig_width } {
	# Procedure called to validate gate_sig_width
	return true
}

proc update_PARAM_VALUE.has_pd_output { PARAM_VALUE.has_pd_output } {
	# Procedure called to update has_pd_output when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_pd_output { PARAM_VALUE.has_pd_output } {
	# Procedure called to validate has_pd_output
	return true
}

proc update_PARAM_VALUE.has_pi_output { PARAM_VALUE.has_pi_output } {
	# Procedure called to update has_pi_output when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_pi_output { PARAM_VALUE.has_pi_output } {
	# Procedure called to validate has_pi_output
	return true
}

proc update_PARAM_VALUE.has_ptctl_output { PARAM_VALUE.has_ptctl_output } {
	# Procedure called to update has_ptctl_output when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_ptctl_output { PARAM_VALUE.has_ptctl_output } {
	# Procedure called to validate has_ptctl_output
	return true
}

proc update_PARAM_VALUE.has_pts_output { PARAM_VALUE.has_pts_output } {
	# Procedure called to update has_pts_output when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_pts_output { PARAM_VALUE.has_pts_output } {
	# Procedure called to validate has_pts_output
	return true
}

proc update_PARAM_VALUE.use_input_tvalid { PARAM_VALUE.use_input_tvalid } {
	# Procedure called to update use_input_tvalid when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.use_input_tvalid { PARAM_VALUE.use_input_tvalid } {
	# Procedure called to validate use_input_tvalid
	return true
}


proc update_MODELPARAM_VALUE.gate_sig_width { MODELPARAM_VALUE.gate_sig_width PARAM_VALUE.gate_sig_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.gate_sig_width}] ${MODELPARAM_VALUE.gate_sig_width}
}

proc update_MODELPARAM_VALUE.data_byte_width { MODELPARAM_VALUE.data_byte_width PARAM_VALUE.data_byte_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_byte_width}] ${MODELPARAM_VALUE.data_byte_width}
}

proc update_MODELPARAM_VALUE.has_ptctl_output { MODELPARAM_VALUE.has_ptctl_output PARAM_VALUE.has_ptctl_output } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_ptctl_output}] ${MODELPARAM_VALUE.has_ptctl_output}
}

proc update_MODELPARAM_VALUE.has_pd_output { MODELPARAM_VALUE.has_pd_output PARAM_VALUE.has_pd_output } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_pd_output}] ${MODELPARAM_VALUE.has_pd_output}
}

proc update_MODELPARAM_VALUE.has_pts_output { MODELPARAM_VALUE.has_pts_output PARAM_VALUE.has_pts_output } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_pts_output}] ${MODELPARAM_VALUE.has_pts_output}
}

proc update_MODELPARAM_VALUE.has_pi_output { MODELPARAM_VALUE.has_pi_output PARAM_VALUE.has_pi_output } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_pi_output}] ${MODELPARAM_VALUE.has_pi_output}
}

proc update_MODELPARAM_VALUE.use_info_inputs { MODELPARAM_VALUE.use_info_inputs PARAM_VALUE.use_info_inputs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.use_info_inputs}] ${MODELPARAM_VALUE.use_info_inputs}
}

proc update_MODELPARAM_VALUE.use_input_tvalid { MODELPARAM_VALUE.use_input_tvalid PARAM_VALUE.use_input_tvalid } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.use_input_tvalid}] ${MODELPARAM_VALUE.use_input_tvalid}
}

proc update_MODELPARAM_VALUE.dflt_samples_per_cycle { MODELPARAM_VALUE.dflt_samples_per_cycle PARAM_VALUE.dflt_samples_per_cycle } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.dflt_samples_per_cycle}] ${MODELPARAM_VALUE.dflt_samples_per_cycle}
}

proc update_MODELPARAM_VALUE.dflt_data_format { MODELPARAM_VALUE.dflt_data_format PARAM_VALUE.dflt_data_format } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.dflt_data_format}] ${MODELPARAM_VALUE.dflt_data_format}
}

proc update_MODELPARAM_VALUE.dflt_data_type { MODELPARAM_VALUE.dflt_data_type PARAM_VALUE.dflt_data_type } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.dflt_data_type}] ${MODELPARAM_VALUE.dflt_data_type}
}

proc update_MODELPARAM_VALUE.dflt_channel { MODELPARAM_VALUE.dflt_channel PARAM_VALUE.dflt_channel } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.dflt_channel}] ${MODELPARAM_VALUE.dflt_channel}
}

