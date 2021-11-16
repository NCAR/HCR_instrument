# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "ddr4_requestor_id" -parent ${Page_0}
  ipgui::add_static_text $IPINST -name "txt1" -parent ${Page_0} -text {Must Be Unique For Each IP Core In A System.}


}

proc update_PARAM_VALUE.ddr4_requestor_id { PARAM_VALUE.ddr4_requestor_id } {
	# Procedure called to update ddr4_requestor_id when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ddr4_requestor_id { PARAM_VALUE.ddr4_requestor_id } {
	# Procedure called to validate ddr4_requestor_id
	return true
}


proc update_MODELPARAM_VALUE.ddr4_requestor_id { MODELPARAM_VALUE.ddr4_requestor_id PARAM_VALUE.ddr4_requestor_id } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ddr4_requestor_id}] ${MODELPARAM_VALUE.ddr4_requestor_id}
}

