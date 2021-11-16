# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0" -display_name {Control/Status}]
  set_property tooltip {Control/Status} ${Page_0}
  ipgui::add_param $IPINST -name "en_adc01_frz" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc23_frz" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc45_frz" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc67_frz" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc01_rts" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc23_rts" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc45_rts" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc67_rts" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc0_thresh_outputs" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc1_thresh_outputs" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc2_thresh_outputs" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc3_thresh_outputs" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc4_thresh_outputs" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc5_thresh_outputs" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc6_thresh_outputs" -parent ${Page_0}
  ipgui::add_param $IPINST -name "en_adc7_thresh_outputs" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_pl_event_in" -parent ${Page_0}

  #Adding Page
  set ADC_AXI-Stream_Bus [ipgui::add_page $IPINST -name "ADC AXI-Stream Bus"]
  ipgui::add_param $IPINST -name "inv_data" -parent ${ADC_AXI-Stream_Bus}
  ipgui::add_param $IPINST -name "has_adc0" -parent ${ADC_AXI-Stream_Bus}
  ipgui::add_param $IPINST -name "has_adc1" -parent ${ADC_AXI-Stream_Bus}
  ipgui::add_param $IPINST -name "has_adc2" -parent ${ADC_AXI-Stream_Bus}
  ipgui::add_param $IPINST -name "has_adc3" -parent ${ADC_AXI-Stream_Bus}
  ipgui::add_param $IPINST -name "has_adc4" -parent ${ADC_AXI-Stream_Bus}
  ipgui::add_param $IPINST -name "has_adc5" -parent ${ADC_AXI-Stream_Bus}
  ipgui::add_param $IPINST -name "has_adc6" -parent ${ADC_AXI-Stream_Bus}
  ipgui::add_param $IPINST -name "has_adc7" -parent ${ADC_AXI-Stream_Bus}


}

proc update_PARAM_VALUE.en_adc01_frz { PARAM_VALUE.en_adc01_frz } {
	# Procedure called to update en_adc01_frz when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc01_frz { PARAM_VALUE.en_adc01_frz } {
	# Procedure called to validate en_adc01_frz
	return true
}

proc update_PARAM_VALUE.en_adc01_rts { PARAM_VALUE.en_adc01_rts } {
	# Procedure called to update en_adc01_rts when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc01_rts { PARAM_VALUE.en_adc01_rts } {
	# Procedure called to validate en_adc01_rts
	return true
}

proc update_PARAM_VALUE.en_adc0_thresh_outputs { PARAM_VALUE.en_adc0_thresh_outputs } {
	# Procedure called to update en_adc0_thresh_outputs when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc0_thresh_outputs { PARAM_VALUE.en_adc0_thresh_outputs } {
	# Procedure called to validate en_adc0_thresh_outputs
	return true
}

proc update_PARAM_VALUE.en_adc1_thresh_outputs { PARAM_VALUE.en_adc1_thresh_outputs } {
	# Procedure called to update en_adc1_thresh_outputs when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc1_thresh_outputs { PARAM_VALUE.en_adc1_thresh_outputs } {
	# Procedure called to validate en_adc1_thresh_outputs
	return true
}

proc update_PARAM_VALUE.en_adc23_frz { PARAM_VALUE.en_adc23_frz } {
	# Procedure called to update en_adc23_frz when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc23_frz { PARAM_VALUE.en_adc23_frz } {
	# Procedure called to validate en_adc23_frz
	return true
}

proc update_PARAM_VALUE.en_adc23_rts { PARAM_VALUE.en_adc23_rts } {
	# Procedure called to update en_adc23_rts when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc23_rts { PARAM_VALUE.en_adc23_rts } {
	# Procedure called to validate en_adc23_rts
	return true
}

proc update_PARAM_VALUE.en_adc2_thresh_outputs { PARAM_VALUE.en_adc2_thresh_outputs } {
	# Procedure called to update en_adc2_thresh_outputs when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc2_thresh_outputs { PARAM_VALUE.en_adc2_thresh_outputs } {
	# Procedure called to validate en_adc2_thresh_outputs
	return true
}

proc update_PARAM_VALUE.en_adc3_thresh_outputs { PARAM_VALUE.en_adc3_thresh_outputs } {
	# Procedure called to update en_adc3_thresh_outputs when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc3_thresh_outputs { PARAM_VALUE.en_adc3_thresh_outputs } {
	# Procedure called to validate en_adc3_thresh_outputs
	return true
}

proc update_PARAM_VALUE.en_adc45_frz { PARAM_VALUE.en_adc45_frz } {
	# Procedure called to update en_adc45_frz when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc45_frz { PARAM_VALUE.en_adc45_frz } {
	# Procedure called to validate en_adc45_frz
	return true
}

proc update_PARAM_VALUE.en_adc45_rts { PARAM_VALUE.en_adc45_rts } {
	# Procedure called to update en_adc45_rts when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc45_rts { PARAM_VALUE.en_adc45_rts } {
	# Procedure called to validate en_adc45_rts
	return true
}

proc update_PARAM_VALUE.en_adc4_thresh_outputs { PARAM_VALUE.en_adc4_thresh_outputs } {
	# Procedure called to update en_adc4_thresh_outputs when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc4_thresh_outputs { PARAM_VALUE.en_adc4_thresh_outputs } {
	# Procedure called to validate en_adc4_thresh_outputs
	return true
}

proc update_PARAM_VALUE.en_adc5_thresh_outputs { PARAM_VALUE.en_adc5_thresh_outputs } {
	# Procedure called to update en_adc5_thresh_outputs when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc5_thresh_outputs { PARAM_VALUE.en_adc5_thresh_outputs } {
	# Procedure called to validate en_adc5_thresh_outputs
	return true
}

proc update_PARAM_VALUE.en_adc67_frz { PARAM_VALUE.en_adc67_frz } {
	# Procedure called to update en_adc67_frz when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc67_frz { PARAM_VALUE.en_adc67_frz } {
	# Procedure called to validate en_adc67_frz
	return true
}

proc update_PARAM_VALUE.en_adc67_rts { PARAM_VALUE.en_adc67_rts } {
	# Procedure called to update en_adc67_rts when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc67_rts { PARAM_VALUE.en_adc67_rts } {
	# Procedure called to validate en_adc67_rts
	return true
}

proc update_PARAM_VALUE.en_adc6_thresh_outputs { PARAM_VALUE.en_adc6_thresh_outputs } {
	# Procedure called to update en_adc6_thresh_outputs when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc6_thresh_outputs { PARAM_VALUE.en_adc6_thresh_outputs } {
	# Procedure called to validate en_adc6_thresh_outputs
	return true
}

proc update_PARAM_VALUE.en_adc7_thresh_outputs { PARAM_VALUE.en_adc7_thresh_outputs } {
	# Procedure called to update en_adc7_thresh_outputs when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.en_adc7_thresh_outputs { PARAM_VALUE.en_adc7_thresh_outputs } {
	# Procedure called to validate en_adc7_thresh_outputs
	return true
}

proc update_PARAM_VALUE.has_adc0 { PARAM_VALUE.has_adc0 } {
	# Procedure called to update has_adc0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_adc0 { PARAM_VALUE.has_adc0 } {
	# Procedure called to validate has_adc0
	return true
}

proc update_PARAM_VALUE.has_adc1 { PARAM_VALUE.has_adc1 } {
	# Procedure called to update has_adc1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_adc1 { PARAM_VALUE.has_adc1 } {
	# Procedure called to validate has_adc1
	return true
}

proc update_PARAM_VALUE.has_adc2 { PARAM_VALUE.has_adc2 } {
	# Procedure called to update has_adc2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_adc2 { PARAM_VALUE.has_adc2 } {
	# Procedure called to validate has_adc2
	return true
}

proc update_PARAM_VALUE.has_adc3 { PARAM_VALUE.has_adc3 } {
	# Procedure called to update has_adc3 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_adc3 { PARAM_VALUE.has_adc3 } {
	# Procedure called to validate has_adc3
	return true
}

proc update_PARAM_VALUE.has_adc4 { PARAM_VALUE.has_adc4 } {
	# Procedure called to update has_adc4 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_adc4 { PARAM_VALUE.has_adc4 } {
	# Procedure called to validate has_adc4
	return true
}

proc update_PARAM_VALUE.has_adc5 { PARAM_VALUE.has_adc5 } {
	# Procedure called to update has_adc5 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_adc5 { PARAM_VALUE.has_adc5 } {
	# Procedure called to validate has_adc5
	return true
}

proc update_PARAM_VALUE.has_adc6 { PARAM_VALUE.has_adc6 } {
	# Procedure called to update has_adc6 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_adc6 { PARAM_VALUE.has_adc6 } {
	# Procedure called to validate has_adc6
	return true
}

proc update_PARAM_VALUE.has_adc7 { PARAM_VALUE.has_adc7 } {
	# Procedure called to update has_adc7 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_adc7 { PARAM_VALUE.has_adc7 } {
	# Procedure called to validate has_adc7
	return true
}

proc update_PARAM_VALUE.has_pl_event_in { PARAM_VALUE.has_pl_event_in } {
	# Procedure called to update has_pl_event_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_pl_event_in { PARAM_VALUE.has_pl_event_in } {
	# Procedure called to validate has_pl_event_in
	return true
}

proc update_PARAM_VALUE.inv_data { PARAM_VALUE.inv_data } {
	# Procedure called to update inv_data when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.inv_data { PARAM_VALUE.inv_data } {
	# Procedure called to validate inv_data
	return true
}


proc update_MODELPARAM_VALUE.has_pl_event_in { MODELPARAM_VALUE.has_pl_event_in PARAM_VALUE.has_pl_event_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_pl_event_in}] ${MODELPARAM_VALUE.has_pl_event_in}
}

proc update_MODELPARAM_VALUE.en_adc0_thresh_outputs { MODELPARAM_VALUE.en_adc0_thresh_outputs PARAM_VALUE.en_adc0_thresh_outputs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc0_thresh_outputs}] ${MODELPARAM_VALUE.en_adc0_thresh_outputs}
}

proc update_MODELPARAM_VALUE.en_adc1_thresh_outputs { MODELPARAM_VALUE.en_adc1_thresh_outputs PARAM_VALUE.en_adc1_thresh_outputs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc1_thresh_outputs}] ${MODELPARAM_VALUE.en_adc1_thresh_outputs}
}

proc update_MODELPARAM_VALUE.en_adc2_thresh_outputs { MODELPARAM_VALUE.en_adc2_thresh_outputs PARAM_VALUE.en_adc2_thresh_outputs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc2_thresh_outputs}] ${MODELPARAM_VALUE.en_adc2_thresh_outputs}
}

proc update_MODELPARAM_VALUE.en_adc3_thresh_outputs { MODELPARAM_VALUE.en_adc3_thresh_outputs PARAM_VALUE.en_adc3_thresh_outputs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc3_thresh_outputs}] ${MODELPARAM_VALUE.en_adc3_thresh_outputs}
}

proc update_MODELPARAM_VALUE.en_adc4_thresh_outputs { MODELPARAM_VALUE.en_adc4_thresh_outputs PARAM_VALUE.en_adc4_thresh_outputs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc4_thresh_outputs}] ${MODELPARAM_VALUE.en_adc4_thresh_outputs}
}

proc update_MODELPARAM_VALUE.en_adc5_thresh_outputs { MODELPARAM_VALUE.en_adc5_thresh_outputs PARAM_VALUE.en_adc5_thresh_outputs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc5_thresh_outputs}] ${MODELPARAM_VALUE.en_adc5_thresh_outputs}
}

proc update_MODELPARAM_VALUE.en_adc6_thresh_outputs { MODELPARAM_VALUE.en_adc6_thresh_outputs PARAM_VALUE.en_adc6_thresh_outputs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc6_thresh_outputs}] ${MODELPARAM_VALUE.en_adc6_thresh_outputs}
}

proc update_MODELPARAM_VALUE.en_adc7_thresh_outputs { MODELPARAM_VALUE.en_adc7_thresh_outputs PARAM_VALUE.en_adc7_thresh_outputs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc7_thresh_outputs}] ${MODELPARAM_VALUE.en_adc7_thresh_outputs}
}

proc update_MODELPARAM_VALUE.en_adc01_rts { MODELPARAM_VALUE.en_adc01_rts PARAM_VALUE.en_adc01_rts } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc01_rts}] ${MODELPARAM_VALUE.en_adc01_rts}
}

proc update_MODELPARAM_VALUE.en_adc23_rts { MODELPARAM_VALUE.en_adc23_rts PARAM_VALUE.en_adc23_rts } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc23_rts}] ${MODELPARAM_VALUE.en_adc23_rts}
}

proc update_MODELPARAM_VALUE.en_adc45_rts { MODELPARAM_VALUE.en_adc45_rts PARAM_VALUE.en_adc45_rts } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc45_rts}] ${MODELPARAM_VALUE.en_adc45_rts}
}

proc update_MODELPARAM_VALUE.en_adc67_rts { MODELPARAM_VALUE.en_adc67_rts PARAM_VALUE.en_adc67_rts } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc67_rts}] ${MODELPARAM_VALUE.en_adc67_rts}
}

proc update_MODELPARAM_VALUE.en_adc01_frz { MODELPARAM_VALUE.en_adc01_frz PARAM_VALUE.en_adc01_frz } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc01_frz}] ${MODELPARAM_VALUE.en_adc01_frz}
}

proc update_MODELPARAM_VALUE.en_adc23_frz { MODELPARAM_VALUE.en_adc23_frz PARAM_VALUE.en_adc23_frz } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc23_frz}] ${MODELPARAM_VALUE.en_adc23_frz}
}

proc update_MODELPARAM_VALUE.en_adc45_frz { MODELPARAM_VALUE.en_adc45_frz PARAM_VALUE.en_adc45_frz } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc45_frz}] ${MODELPARAM_VALUE.en_adc45_frz}
}

proc update_MODELPARAM_VALUE.en_adc67_frz { MODELPARAM_VALUE.en_adc67_frz PARAM_VALUE.en_adc67_frz } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.en_adc67_frz}] ${MODELPARAM_VALUE.en_adc67_frz}
}

proc update_MODELPARAM_VALUE.has_adc0 { MODELPARAM_VALUE.has_adc0 PARAM_VALUE.has_adc0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_adc0}] ${MODELPARAM_VALUE.has_adc0}
}

proc update_MODELPARAM_VALUE.has_adc1 { MODELPARAM_VALUE.has_adc1 PARAM_VALUE.has_adc1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_adc1}] ${MODELPARAM_VALUE.has_adc1}
}

proc update_MODELPARAM_VALUE.has_adc2 { MODELPARAM_VALUE.has_adc2 PARAM_VALUE.has_adc2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_adc2}] ${MODELPARAM_VALUE.has_adc2}
}

proc update_MODELPARAM_VALUE.has_adc3 { MODELPARAM_VALUE.has_adc3 PARAM_VALUE.has_adc3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_adc3}] ${MODELPARAM_VALUE.has_adc3}
}

proc update_MODELPARAM_VALUE.has_adc4 { MODELPARAM_VALUE.has_adc4 PARAM_VALUE.has_adc4 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_adc4}] ${MODELPARAM_VALUE.has_adc4}
}

proc update_MODELPARAM_VALUE.has_adc5 { MODELPARAM_VALUE.has_adc5 PARAM_VALUE.has_adc5 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_adc5}] ${MODELPARAM_VALUE.has_adc5}
}

proc update_MODELPARAM_VALUE.has_adc6 { MODELPARAM_VALUE.has_adc6 PARAM_VALUE.has_adc6 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_adc6}] ${MODELPARAM_VALUE.has_adc6}
}

proc update_MODELPARAM_VALUE.has_adc7 { MODELPARAM_VALUE.has_adc7 PARAM_VALUE.has_adc7 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_adc7}] ${MODELPARAM_VALUE.has_adc7}
}

proc update_MODELPARAM_VALUE.inv_data { MODELPARAM_VALUE.inv_data PARAM_VALUE.inv_data } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.inv_data}] ${MODELPARAM_VALUE.inv_data}
}

